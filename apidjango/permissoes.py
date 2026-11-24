"""
Escopo de acesso às pesquisas e aos dados ligados a elas (formulários, exportação, painéis).

Regra única, usada por todas as views:
  - superusuário: todas as pesquisas;
  - administrador: apenas as pesquisas que ele criou (Pesquisa.admin == usuário);
  - pesquisador: apenas as pesquisas em que faz parte da equipe (Pesquisa.usuario contém o usuário).

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
    Para viewsets de formulários (modelos com FK `pesquisa`): lista/edita/apaga apenas registros de pesquisas
    no escopo do usuário, e só permite criar ou mover registros para pesquisas desse escopo.
    """

    def get_queryset(self):
        return super().get_queryset().filter(pesquisa__in=pesquisas_visiveis(self.request.user))

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
