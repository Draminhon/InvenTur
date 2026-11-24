"""
Escopo de acesso às pesquisas e aos dados ligados a elas (formulários, exportação, painéis).

Regra única, usada por todas as views:
  - superusuário: todas as pesquisas;
  - administrador: apenas as pesquisas que ele criou (Pesquisa.admin == usuário);
  - pesquisador: apenas as pesquisas em que faz parte da equipe (Pesquisa.usuario contém o usuário).

Equipamentos (formulários inventariados):
  - administrador: todos os equipamentos das pesquisas que ele criou;
  - pesquisador: SOMENTE os equipamentos que ele mesmo inventariou (usuario_criador), nas pesquisas da equipe.

Registros fora do escopo respondem 404 (e não 403), para não revelar que existem.
"""
from django.http import Http404
from rest_framework import permissions

from .models import Pesquisa


def eh_administrador(user):
    return bool(
        user and user.is_authenticated and user.is_active
        and (user.is_superuser or getattr(user, 'acessLevel', None) == 'Administrador')
    )


def pesquisas_visiveis(user, apenas_ativas=True):
    """QuerySet das pesquisas que [user] pode ver."""
    qs = Pesquisa.objects.all()
    if apenas_ativas:
        qs = qs.filter(is_active=True)
    if not (user and user.is_authenticated):
        return qs.none()
    if user.is_superuser:
        return qs
    if getattr(user, 'acessLevel', None) == 'Administrador':
        return qs.filter(admin=user)
    return qs.filter(usuario=user).distinct()


def equipamentos_visiveis(qs, user):
    """Restringe um QuerySet de equipamentos (modelos com `pesquisa` e `usuario_criador`) ao que [user] pode
    acessar: o administrador vê os das suas pesquisas; o pesquisador, só os que ele inventariou."""
    qs = qs.filter(pesquisa__in=pesquisas_visiveis(user))
    if eh_administrador(user):
        return qs
    return qs.filter(usuario_criador=user)


def usuarios_visiveis(admin):
    """
    Usuários que um administrador pode ver e gerenciar: os que entraram em alguma pesquisa dele e os que ele
    mesmo cadastrou (superusuário vê todos). O próprio administrador não aparece na lista.
    """
    from django.db.models import Q
    from .models import CustomUser
    qs = CustomUser.objects.filter(is_active=True, is_superuser=False)
    if not eh_administrador(admin):
        return qs.filter(id=getattr(admin, 'id', None))
    if admin.is_superuser:
        return qs
    minhas = Pesquisa.objects.filter(admin=admin, is_active=True)
    return qs.filter(Q(usuario__in=minhas) | Q(criado_por=admin)).exclude(id=admin.id).distinct()


def exigir_pesquisa_visivel(user, pesquisa_id):
    """Garante que a pesquisa existe e está no escopo do usuário; caso contrário, 404."""
    try:
        pesquisa_id = int(pesquisa_id)
    except (TypeError, ValueError):
        raise Http404('Pesquisa não encontrada.')
    if not pesquisas_visiveis(user).filter(id=pesquisa_id).exists():
        raise Http404('Pesquisa não encontrada.')
    return pesquisa_id


class IsAdministrador(permissions.BasePermission):
    """Permite acesso apenas a administradores (acessLevel) ou superusuários."""
    message = 'Acesso restrito a administradores.'

    def has_permission(self, request, view):
        return eh_administrador(request.user)


class EscopoPesquisaMixin:
    """
    Para viewsets de formulários (modelos com FK `pesquisa`): lista/edita/apaga apenas os equipamentos que o usuário
    pode acessar (ver equipamentos_visiveis), e só permite criar ou mover registros para pesquisas do seu escopo.
    """

    def get_queryset(self):
        # Admin: equipamentos das suas pesquisas; pesquisador: só os que ele inventariou (os demais dão 404)
        return equipamentos_visiveis(super().get_queryset(), self.request.user)

    def perform_update(self, serializer):
        # O autor nunca muda numa edição (nem o admin nem o pesquisador podem atribuir o equipamento a outra pessoa)
        serializer.save(usuario_criador=serializer.instance.usuario_criador)

    def _validar_pesquisa_destino(self, request):
        destino = request.data.get('pesquisa')
        if destino not in (None, ''):
            exigir_pesquisa_visivel(request.user, destino)

    def create(self, request, *args, **kwargs):
        self._validar_pesquisa_destino(request)
        return super().create(request, *args, **kwargs)

    def update(self, request, *args, **kwargs):
        self._validar_pesquisa_destino(request)
        return super().update(request, *args, **kwargs)
