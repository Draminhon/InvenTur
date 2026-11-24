"""
Popula o banco LOCAL com dados fictícios para testar os painéis do administrador (abas "Dados" e "Gestão").

    python manage.py seed_mock            # recria os dados mock (apaga os anteriores antes)
    python manage.py seed_mock --limpar   # apenas remove os dados mock

Cria 1 administrador e 4 pesquisadores fictícios (e-mails @mock.inventur.local), 5 pesquisas em municípios
reais e formulários de todas as categorias distribuídos nos últimos 6 meses, com coordenadas próximas
ao município. Tudo o que é criado aqui fica ligado ao administrador mock, o que permite removê-lo sem
tocar nos dados reais. Não use em produção.
"""
import random
from datetime import date, timedelta

from django.conf import settings
from django.core.management.base import BaseCommand, CommandError
from django.db import transaction
from django.utils import timezone

from apidjango.fields import EncryptionService
from apidjango.models import CustomUser, Pesquisa
from apidjango.services.pesquisa_export import MODEL_SHEET_MAP

DOMINIO = 'mock.inventur.local'
SENHA = 'Mock@12345'

ADMIN = ('Admin Mock', f'admin@{DOMINIO}')
PESQUISADORES = [
    ('Ana Ribeiro', f'ana.ribeiro@{DOMINIO}'),
    ('Bruno Castro', f'bruno.castro@{DOMINIO}'),
    ('Carla Mendes', f'carla.mendes@{DOMINIO}'),
    ('Diego Farias', f'diego.farias@{DOMINIO}'),
]

# (município, UF, código IBGE, latitude, longitude, status, quantidade de formulários, pesquisadores,
#  início há N dias, duração em dias). Prazos variados (no prazo, atenção, atrasada, concluída, início atrasado):
PESQUISAS = [
    ('Tianguá', 'CE', '2313401', -3.7322, -40.9917, 'Em Andamento', 22, [0, 1], 160, 240),        # no prazo
    ('Jijoca de Jericoacoara', 'CE', '2306553', -2.7933, -40.5122, 'Concluído', 18, [1, 2], 175, 200),  # concluída
    ('Bonito', 'MS', '5002209', -21.1261, -56.4836, 'Em Andamento', 15, [2, 3], 170, 195),         # atenção (>80%)
    ('Paraty', 'RJ', '3303807', -23.2178, -44.7131, 'Em Andamento', 12, [0, 3], 200, 185),         # atrasada
    ('Lençóis', 'BA', '2919306', -12.5631, -41.3897, 'Não Iniciado', 0, [1], 20, 180),             # início atrasado
]

# Pesquisador sem cadastros recentes (nenhum cadastro nos últimos 12 dias)
PESQUISADOR_INATIVO = 3
# Chance de cada pendência de qualidade num formulário
CHANCE_SEM_COORDENADAS = 0.12
CHANCE_SEM_NOME = 0.08
CHANCE_SEM_PESQUISADOR = 0.04

NOMES = ['Recanto', 'Mirante', 'Sol Nascente', 'Bela Vista', 'Serra Verde', 'Oásis', 'Ponto Certo', 'Raízes',
         'Horizonte', 'Ventos', 'Cachoeira', 'Lagoa Azul', 'Trilha', 'Encanto', 'Pôr do Sol']

# Campos JSON no Django que o app lê como texto (String?) — recebem '' em vez de lista
_JSON_TEXTO_NO_APP = {
    ('InformacaoBasicaDoMunicipio', 'origemDosVisitantesTuristas'),
    ('OutrosMeiosDeHospedagem', 'areaAcampamento'),
    ('OutrosMeiosDeHospedagem', 'subtipo'),
    ('ServicosParaEventos', 'subtipo'),
    ('EspacoParaEventos', 'subtipo'),
}


def _preencher_vazios(modelo, dados):
    """
    Preenche os campos não informados com o valor "vazio" do tipo, como faz um formulário salvo pelo app sem
    respostas. Os formulários do app abrem em modo edição assumindo esses campos não nulos (ex.: `natureza!`,
    `List<String>.from(json['mesesMaisFrios'])`); com null eles quebrariam ao abrir.
    """
    for campo in modelo._meta.concrete_fields:
        if campo.primary_key or campo.is_relation or campo.name in dados or campo.has_default():
            continue
        if getattr(campo, 'auto_now', False) or getattr(campo, 'auto_now_add', False):
            continue
        tipo = type(campo).__name__
        if tipo == 'JSONField':
            # Campos "tabela*" são mapas no app; os demais JSON são listas de opções marcadas
            if (modelo.__name__, campo.name) in _JSON_TEXTO_NO_APP:
                dados[campo.name] = ''
            else:
                dados[campo.name] = {} if campo.name.lower().startswith('tabel') else []
        elif tipo == 'DecimalField':
            dados[campo.name] = 0
        elif tipo in ('CharField', 'TextField', 'EncryptedCharField'):
            dados[campo.name] = ''


def _telefone(semente):
    return f'(88) 9{random.Random(semente).randint(1000, 9999)}-{random.Random(semente + 1).randint(1000, 9999)}'


class Command(BaseCommand):
    help = 'Cria (ou remove, com --limpar) dados fictícios no banco local para testar os painéis do administrador.'

    def add_arguments(self, parser):
        parser.add_argument('--limpar', action='store_true', help='Apenas remove os dados mock.')

    def handle(self, *args, **options):
        if not settings.DEBUG:
            raise CommandError('seed_mock só pode ser executado com DEBUG=True (banco local).')

        with transaction.atomic():
            removidas = self._limpar()
            if removidas:
                self.stdout.write(f'Removidos dados mock anteriores ({removidas} pesquisas).')
            if options['limpar']:
                self.stdout.write(self.style.SUCCESS('Dados mock removidos.'))
                return
            self._criar()

    def _usuarios_mock(self):
        hashes = [EncryptionService().get_blind_index(email) for _, email in [ADMIN] + PESQUISADORES]
        return CustomUser.objects.filter(email_hash__in=hashes)

    def _limpar(self):
        usuarios = self._usuarios_mock()
        pesquisas = Pesquisa.objects.filter(admin__in=usuarios)
        total = pesquisas.count()
        pesquisas.delete()  # remove também os formulários (CASCADE)
        usuarios.delete()
        return total

    def _criar_usuario(self, nome, email, indice, acesso):
        usuario = CustomUser(
            username=nome,
            first_name=nome.split()[0],
            last_name=nome.split()[-1],
            email=email,
            telefone=_telefone(indice),
            acessLevel=acesso,
        )
        usuario.set_password(SENHA)
        usuario.save()
        return usuario

    def _criar(self):
        rnd = random.Random(42)  # determinístico: sempre os mesmos dados
        admin = self._criar_usuario(*ADMIN, 0, 'Administrador')
        pesquisadores = [self._criar_usuario(nome, email, i + 1, 'Pesquisador')
                         for i, (nome, email) in enumerate(PESQUISADORES)]

        hoje = date.today()
        agora = timezone.now()
        total_formularios = 0

        for municipio, uf, ibge, lat, lng, status, quantidade, equipe_idx, inicio_ha, duracao in PESQUISAS:
            equipe = [pesquisadores[i] for i in equipe_idx]
            inicio = hoje - timedelta(days=inicio_ha)
            pesquisa = Pesquisa.objects.create(
                admin=admin,
                dataInicio=inicio,
                dataTermino=inicio + timedelta(days=duracao),
                codigoIBGE=ibge,
                estado=uf,
                municipio=municipio,
                status=status,
            )
            pesquisa.usuario.set(equipe)
            for pesquisador in equipe:
                pesquisador.pesquisas.add(pesquisa)

            # Cada pesquisa recebe uma "Informações Básicas do Município" e o restante sorteado
            modelos = [MODEL_SHEET_MAP[8]] + [rnd.choice(MODEL_SHEET_MAP) for _ in range(quantidade - 1)]
            for modelo, nome_formulario in modelos[:quantidade]:
                autor = rnd.choice(equipe)
                inativo = autor == pesquisadores[PESQUISADOR_INATIVO]
                sem_pesquisador = rnd.random() < CHANCE_SEM_PESQUISADOR
                campos = {f.name for f in modelo._meta.concrete_fields}
                dados = {
                    'pesquisa': pesquisa,
                    'usuario_criador': None if sem_pesquisador else autor,
                    'tipo_formulario': nome_formulario,
                    'uf': uf,
                    'municipio': municipio,
                    'nome_pesquisador': autor.username,
                    'telefone_pesquisador': autor.telefone,
                    'email_pesquisador': autor.email,
                    'nome_coordenador': admin.username,
                    'telefone_coordenador': admin.telefone,
                    'email_coordenador': admin.email,
                }
                nome = '' if rnd.random() < CHANCE_SEM_NOME else f'{rnd.choice(NOMES)} {municipio}'
                for campo in ('nomeFantasia', 'nomeOficial', 'nome_oficial', 'nomeProduto'):
                    if campo in campos:
                        dados[campo] = nome
                if 'latitude' in campos and rnd.random() >= CHANCE_SEM_COORDENADAS:
                    dados['latitude'] = f'{lat + rnd.uniform(-0.03, 0.03):.6f}'
                    dados['longitude'] = f'{lng + rnd.uniform(-0.03, 0.03):.6f}'

                _preencher_vazios(modelo, dados)
                formulario = modelo.objects.create(**dados)
                # 'criacao' é auto_now_add: ajusta depois para espalhar os cadastros desde o início da pesquisa
                # (o pesquisador inativo não cadastra nada nos últimos 12 dias)
                dias_desde_inicio = max((hoje - inicio).days, 1)
                minimo = min(12, dias_desde_inicio) if inativo else 0
                criacao = agora - timedelta(days=rnd.randint(minimo, dias_desde_inicio), hours=rnd.randint(0, 10))
                modelo.objects.filter(pk=formulario.pk).update(criacao=criacao)
                total_formularios += 1

        self.stdout.write(self.style.SUCCESS(
            f'Criados: {len(PESQUISAS)} pesquisas, {total_formularios} formulários, '
            f'1 administrador e {len(pesquisadores)} pesquisadores (senha: {SENHA}).'
        ))
        self.stdout.write('Login (e-mail / senha):')
        for usuario in [admin] + pesquisadores:
            self.stdout.write(f'  {usuario.acessLevel:<13} {usuario.username:<14} {usuario.email}')
