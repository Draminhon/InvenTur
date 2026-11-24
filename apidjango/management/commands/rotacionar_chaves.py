"""
Troca (rotaciona) as chaves do servidor sem perder dados:
  - FIELD_ENCRYPTION_KEY: re-criptografa todos os campos criptografados do banco com a chave nova;
  - DJANGO_SECRET_KEY: recalcula o índice de busca de e-mails (email_hash) usado no login.

Uso (PARE o servidor e faça BACKUP do banco antes):
  1. Gere as chaves novas e coloque no .env, AO LADO das atuais:
       NOVA_DJANGO_SECRET_KEY=...
       NOVA_FIELD_ENCRYPTION_KEY=...
  2. python manage.py rotacionar_chaves            -> simulação (não grava nada) + relatório
  3. python manage.py rotacionar_chaves --aplicar  -> grava (tudo ou nada, numa transação)
  4. No .env: troque DJANGO_SECRET_KEY e FIELD_ENCRYPTION_KEY pelos valores novos e apague as linhas NOVA_*.
  5. Suba o servidor. Todos os usuários precisarão fazer login de novo (os tokens antigos deixam de valer).

Pode ser executado de novo com segurança: valores já criptografados com a chave nova são reconhecidos e mantidos.
"""
import hashlib
import hmac
import os

from cryptography.fernet import Fernet, InvalidToken
from django.apps import apps
from django.conf import settings
from django.core.management.base import BaseCommand, CommandError
from django.db import connection, transaction

from apidjango.fields import BlindIndexField, EncryptedCharField, EncryptedTextField, EncryptionService


class _Simulacao(Exception):
    pass


class Command(BaseCommand):
    help = 'Re-criptografa o banco com uma nova FIELD_ENCRYPTION_KEY e recalcula os índices com uma nova SECRET_KEY.'

    def add_arguments(self, parser):
        parser.add_argument('--aplicar', action='store_true', help='Grava as alterações (sem isso, apenas simula).')

    def handle(self, *args, **options):
        nova_secret = os.environ.get('NOVA_DJANGO_SECRET_KEY', '').strip()
        nova_fernet = os.environ.get('NOVA_FIELD_ENCRYPTION_KEY', '').strip()
        if not nova_secret and not nova_fernet:
            raise CommandError('Defina NOVA_DJANGO_SECRET_KEY e/ou NOVA_FIELD_ENCRYPTION_KEY no .env.')
        if nova_secret and nova_secret == settings.SECRET_KEY:
            raise CommandError('NOVA_DJANGO_SECRET_KEY é igual à chave atual.')
        if nova_fernet and nova_fernet == settings.FIELD_ENCRYPTION_KEY:
            raise CommandError('NOVA_FIELD_ENCRYPTION_KEY é igual à chave atual.')
        if nova_secret and len(nova_secret) < 50:
            raise CommandError('NOVA_DJANGO_SECRET_KEY muito curta (use pelo menos 50 caracteres).')

        antiga = Fernet(settings.FIELD_ENCRYPTION_KEY.encode())
        try:
            nova = Fernet(nova_fernet.encode()) if nova_fernet else antiga
        except Exception as e:
            raise CommandError(f'NOVA_FIELD_ENCRYPTION_KEY inválida (precisa ser uma chave Fernet): {e}')
        secret_para_indice = nova_secret or settings.SECRET_KEY

        aplicar = options['aplicar']
        self.stdout.write(self.style.WARNING(
            'MODO: APLICAR (grava no banco)' if aplicar else 'MODO: SIMULAÇÃO (nada será gravado)'))
        self.stdout.write(f"Chave de criptografia: {'TROCAR' if nova_fernet else 'manter'} | "
                          f"SECRET_KEY: {'TROCAR' if nova_secret else 'manter'}")

        try:
            with transaction.atomic():
                relatorio = self._rotacionar(antiga, nova, secret_para_indice)
                if not aplicar:
                    raise _Simulacao()
        except _Simulacao:
            pass

        r = relatorio
        self.stdout.write(f"Campos verificados: {r['campos']} em {r['tabelas']} tabelas")
        self.stdout.write(f"Valores re-criptografados: {r['recriptografados']} | já estavam na chave nova: "
                          f"{r['ja_novos']} | texto puro (agora criptografado): {r['texto_puro']}")
        self.stdout.write(f"Índices de e-mail recalculados: {r['indices']}")
        self.stdout.write(f"Conferência com as chaves novas: {r['conferidos']} valores OK")
        if aplicar:
            self.stdout.write(self.style.SUCCESS(
                'Concluído. Agora troque DJANGO_SECRET_KEY e FIELD_ENCRYPTION_KEY no .env pelos valores novos, '
                'apague as linhas NOVA_* e suba o servidor.'))
        else:
            self.stdout.write(self.style.SUCCESS('Simulação OK. Rode de novo com --aplicar para gravar.'))

    # ------------------------------------------------------------------------------------------------

    def _campos_criptografados(self):
        for modelo in apps.get_models():
            for campo in modelo._meta.local_concrete_fields:
                if isinstance(campo, (EncryptedCharField, EncryptedTextField)):
                    yield modelo, campo

    def _rotacionar(self, antiga, nova, secret_para_indice):
        q = connection.ops.quote_name
        r = dict(campos=0, tabelas=set(), recriptografados=0, ja_novos=0, texto_puro=0, indices=0, conferidos=0)

        with connection.cursor() as cur:
            # 1) Re-criptografa (lendo/gravando direto nas colunas, sem a criptografia automática dos campos)
            for modelo, campo in self._campos_criptografados():
                tabela, coluna, pk = q(modelo._meta.db_table), q(campo.column), q(modelo._meta.pk.column)
                r['campos'] += 1
                r['tabelas'].add(tabela)
                cur.execute(f"SELECT {pk}, {coluna} FROM {tabela} WHERE {coluna} IS NOT NULL AND {coluna} <> ''")
                for chave, valor in cur.fetchall():
                    try:
                        texto = antiga.decrypt(valor.encode()).decode()
                    except InvalidToken:
                        try:
                            nova.decrypt(valor.encode())
                            r['ja_novos'] += 1  # já rotacionado numa execução anterior
                            continue
                        except InvalidToken:
                            texto = valor  # texto puro legado (nunca foi criptografado)
                            r['texto_puro'] += 1
                    else:
                        r['recriptografados'] += 1
                    cur.execute(f"UPDATE {tabela} SET {coluna} = %s WHERE {pk} = %s",
                                [nova.encrypt(texto.encode()).decode(), chave])

            # 2) Recalcula os índices de e-mail (blind index) com a SECRET_KEY nova
            Usuario = apps.get_model(settings.AUTH_USER_MODEL)
            tabela_u = q(Usuario._meta.db_table)
            col_email = q(Usuario._meta.get_field('email').column)
            col_hash = q(Usuario._meta.get_field('email_hash').column)
            pk_u = q(Usuario._meta.pk.column)
            cur.execute(f"SELECT {pk_u}, {col_email} FROM {tabela_u}")
            for chave, valor in cur.fetchall():
                if not valor:
                    continue
                email = EncryptionService.normalizar_email(nova.decrypt(valor.encode()).decode())
                indice = hmac.new(secret_para_indice.encode(), email.encode(), hashlib.sha256).hexdigest()
                cur.execute(f"UPDATE {tabela_u} SET {col_hash} = %s WHERE {pk_u} = %s", [indice, chave])
                r['indices'] += 1

            # 3) Conferência: tudo precisa abrir com a chave nova; qualquer falha desfaz a transação
            for modelo, campo in self._campos_criptografados():
                tabela, coluna = q(modelo._meta.db_table), q(campo.column)
                cur.execute(f"SELECT {coluna} FROM {tabela} WHERE {coluna} IS NOT NULL AND {coluna} <> ''")
                for (valor,) in cur.fetchall():
                    try:
                        nova.decrypt(valor.encode())
                    except InvalidToken:
                        raise CommandError(f'Falha na conferência em {tabela}.{coluna}: nada foi gravado.')
                    r['conferidos'] += 1

        # Outros índices além do e-mail exigiriam tratamento próprio
        outros = [(m.__name__, f.name) for m in apps.get_models() for f in m._meta.local_concrete_fields
                  if isinstance(f, BlindIndexField) and not (m is Usuario and f.name == 'email_hash')]
        if outros:
            raise CommandError(f'Há índices não tratados por este comando: {outros}. Nada foi gravado.')

        r['tabelas'] = len(r['tabelas'])
        return r
