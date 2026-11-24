"""
Versão vigente dos Termos de Uso e da Política de Privacidade.

Ao alterar o texto dos termos no app (lib/legal/termos_texto.dart), aumente TERMOS_VERSAO aqui E lá:
todo usuário que aceitou uma versão anterior precisará aceitar a nova no próximo login.
O registro (versão + data/hora do aceite) é a prova do consentimento exigida pela LGPD (art. 8º, §2º).
"""
from django.utils import timezone

TERMOS_VERSAO = '1.1'


def termos_pendentes(user):
    """True se o usuário ainda não aceitou a versão vigente dos termos."""
    return getattr(user, 'termos_versao', None) != TERMOS_VERSAO


def registrar_aceite_termos(user):
    user.termos_versao = TERMOS_VERSAO
    user.termos_aceitos_em = timezone.now()
    user.save(update_fields=['termos_versao', 'termos_aceitos_em'])
