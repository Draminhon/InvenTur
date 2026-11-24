"""
Política de retenção de dados do SisTur (Política de Privacidade, seção 10).

  - excluir_conta: exclusão da conta (pelo próprio usuário ou por inatividade). Elimina na hora os dados
    pessoais da conta e as cópias de e-mail/telefone gravadas nos formulários; mantém apenas o mínimo para
    comprovar autoria e o aceite dos termos (id, nome nos formulários, versão/data do aceite);
  - purgar_conta: 5 anos após a exclusão, apaga também esse mínimo;
  - anonimizar_pesquisa: 5 anos após o término da pesquisa, elimina os dados pessoais de terceiros;
  - contas_inativas: contas sem acesso há mais de 2 anos e sem pesquisa em andamento.

O comando `python manage.py aplicar_retencao` aplica tudo isso e deve rodar diariamente no servidor.
"""
from datetime import timedelta

from django.db import transaction
from django.db.models import Q
from django.utils import timezone

from .fields import EncryptedCharField, EncryptedTextField, EncryptionService
from .models import Base, CustomUser, Pesquisa

PRAZO_GUARDA_MINIMA = timedelta(days=5 * 365)      # conta excluída: mínimo para comprovação
PRAZO_INVENTARIO = timedelta(days=5 * 365)         # após o término da pesquisa
PRAZO_INATIVIDADE = timedelta(days=2 * 365)        # sem acesso
PRAZO_AVISO_INATIVIDADE = timedelta(days=30)       # entre o aviso por e-mail e a exclusão
PRAZO_REGISTROS_ACESSO = timedelta(days=183)       # ~6 meses

NOME_REMOVIDO = 'Usuário removido'

# Campos que identificam o estabelecimento (pessoa jurídica) e são mantidos na anonimização do inventário
_CAMPOS_DE_EMPRESA = {'CNPJ', 'cnpj', 'cnpjRealizador', 'cnpjPrefeitura'}
# Campos com nomes de PESSOAS (não de estabelecimentos) nos formulários e tabelas de contato
_CAMPOS_NOME_PESSOA = {'nome', 'nome_completo', 'nomeDoPrefeito', 'nomeDoDirigente'}


# ------------------------------------------------------------------------------------------------- contas

def _invalidar_sessoes(user):
    try:
        from rest_framework_simplejwt.token_blacklist.models import BlacklistedToken, OutstandingToken
        for token in OutstandingToken.objects.filter(user=user):
            BlacklistedToken.objects.get_or_create(token=token)
    except Exception:
        pass


@transaction.atomic
def excluir_conta(user):
    """Exclui a conta: dados pessoais eliminados na hora; fica só o mínimo para comprovar autoria e aceite."""
    if user.excluido_em:
        return
    _invalidar_sessoes(user)

    # Sai das equipes de pesquisa
    for pesquisa in Pesquisa.objects.filter(usuario=user):
        pesquisa.usuario.remove(user)
    user.pesquisas.clear()

    # Cópias de contato do usuário gravadas nos formulários (o nome fica como prova de autoria)
    Base.objects.filter(usuario_criador=user).update(email_pesquisador='', telefone_pesquisador='')
    Base.objects.filter(pesquisa__admin=user).update(email_coordenador='', telefone_coordenador='')

    if user.foto_perfil:
        user.foto_perfil.delete(save=False)
        user.foto_perfil = None

    user.username = NOME_REMOVIDO
    user.first_name = ''
    user.last_name = ''
    # E-mail fictício único: libera o e-mail real para um novo cadastro e mantém o índice único
    user.email = f'removido-{user.id}@sistur.invalid'
    user.telefone = ''
    user.otp = None
    user.otp_exp = None
    user.otp_verified = False
    user.set_unusable_password()
    user.is_active = False
    user.status = 'Excluído'
    user.aviso_inatividade_em = None
    user.excluido_em = timezone.now()
    user.save()


@transaction.atomic
def purgar_conta(user):
    """Fim da guarda mínima (5 anos após a exclusão): remove também o nome nos formulários e a conta."""
    Base.objects.filter(usuario_criador=user).update(nome_pesquisador=NOME_REMOVIDO)
    Base.objects.filter(pesquisa__admin=user).update(nome_coordenador=NOME_REMOVIDO)
    user.delete()  # formulários e pesquisas ficam sem autor (SET_NULL)


def pesquisas_ativas_do_admin(user):
    return Pesquisa.objects.filter(admin=user, is_active=True)


def contas_inativas(agora=None):
    """Contas sem acesso há mais de 2 anos que não participam nem administram pesquisa em andamento."""
    agora = agora or timezone.now()
    limite = agora - PRAZO_INATIVIDADE
    em_andamento = Pesquisa.objects.filter(is_active=True).exclude(status='Concluído')
    return (CustomUser.objects
            .filter(is_active=True, is_superuser=False, excluido_em__isnull=True)
            .filter(Q(last_login__lt=limite) | Q(last_login__isnull=True, date_joined__lt=limite))
            .exclude(usuario__in=em_andamento)
            .exclude(pesquisas_criadas__in=em_andamento)
            .distinct())


# ------------------------------------------------------------------------------------------------ inventário

def _campos_pessoais(modelo):
    """Campos de dados pessoais de um modelo: criptografados (exceto CNPJ) e nomes de pessoas."""
    campos = []
    for campo in modelo._meta.local_concrete_fields:
        if campo.name in _CAMPOS_DE_EMPRESA:
            continue
        if isinstance(campo, (EncryptedCharField, EncryptedTextField)) or campo.name in _CAMPOS_NOME_PESSOA:
            campos.append(campo.name)
    return campos


def _tabelas_de_contato():
    """Tabelas auxiliares dos formulários que guardam dados pessoais (contatos, guias, endereços...)."""
    from django.apps import apps
    return [m for m in apps.get_app_config('apidjango').get_models()
            if not issubclass(m, (Base, CustomUser, Pesquisa)) and _campos_pessoais(m)]


def _valor_vazio(modelo, nome):
    campo = modelo._meta.get_field(nome)
    return None if campo.null and not isinstance(campo, (EncryptedCharField, EncryptedTextField)) else ''


@transaction.atomic
def anonimizar_pesquisa(pesquisa):
    """Elimina os dados pessoais de terceiros dos formulários da pesquisa (5 anos após o término)."""
    from .services.pesquisa_export import MODEL_SHEET_MAP

    total = 0
    for modelo, _ in MODEL_SHEET_MAP:
        formularios = modelo.objects.filter(pesquisa=pesquisa)
        if not formularios.exists():
            continue
        dados = {nome: _valor_vazio(modelo, nome) for nome in _campos_pessoais(modelo)}
        if 'telefone' in {f.name for f in modelo._meta.local_concrete_fields}:
            dados['telefone'] = []  # telefones de contato (lista)
        dados.update(email_pesquisador='', telefone_pesquisador='', email_coordenador='', telefone_coordenador='')
        total += formularios.update(**{k: v for k, v in dados.items()
                                       if k in {f.name for f in modelo._meta.concrete_fields}})

        # Tabelas de contato ligadas aos formulários (contatos, guias, endereços...), nos dois sentidos da relação
        for relacionado in _tabelas_de_contato():
            campos = _campos_pessoais(relacionado)
            for relacao in relacionado._meta.get_fields():
                if relacao.many_to_many and relacao.related_model is modelo:
                    relacionado.objects.filter(**{f'{relacao.name}__in': formularios}).update(
                        **{nome: _valor_vazio(relacionado, nome) for nome in campos})

    pesquisa.anonimizada_em = timezone.now()
    pesquisa.save(update_fields=['anonimizada_em'])
    return total


def pesquisas_para_anonimizar(hoje=None):
    hoje = hoje or timezone.localdate()
    return Pesquisa.objects.filter(anonimizada_em__isnull=True, dataTermino__lt=hoje - PRAZO_INVENTARIO)


def normalizar(email):
    return EncryptionService.normalizar_email(email)
