"""
Aplica a política de retenção de dados (Política de Privacidade, seção 10). Deve rodar diariamente no servidor:

    python manage.py aplicar_retencao            -> simulação (relatório, não altera nada)
    python manage.py aplicar_retencao --aplicar  -> aplica

Exemplo de agendamento (Linux, cron, todo dia às 3h):
    0 3 * * * cd /caminho/do/projeto && python manage.py aplicar_retencao --aplicar >> retencao.log 2>&1

O que faz:
  1. Contas excluídas há mais de 5 anos: apaga o mínimo que restava (nome nos formulários e a conta);
  2. Contas sem acesso há mais de 2 anos e sem pesquisa em andamento: avisa por e-mail; 30 dias depois do aviso,
     se a pessoa não tiver entrado no app, exclui a conta;
  3. Pesquisas que terminaram há mais de 5 anos: anonimiza os dados pessoais de terceiros dos formulários;
  4. Códigos de recuperação de senha expirados: apaga;
  5. Registros de sessão (tokens) expirados há mais de 6 meses: apaga.
"""
from django.conf import settings
from django.core.mail import send_mail
from django.core.management.base import BaseCommand
from django.db import transaction
from django.utils import timezone

from apidjango.models import CustomUser
from apidjango.retencao import (PRAZO_AVISO_INATIVIDADE, PRAZO_GUARDA_MINIMA, PRAZO_REGISTROS_ACESSO,
                                anonimizar_pesquisa, contas_inativas, excluir_conta, pesquisas_para_anonimizar,
                                purgar_conta)


class _Simulacao(Exception):
    pass


class Command(BaseCommand):
    help = 'Aplica a política de retenção de dados (exclusões, inatividade, anonimização e limpeza).'

    def add_arguments(self, parser):
        parser.add_argument('--aplicar', action='store_true', help='Aplica as alterações (sem isso, apenas simula).')

    def handle(self, *args, **options):
        aplicar = options['aplicar']
        agora = timezone.now()
        r = {}
        self.stdout.write(self.style.WARNING('MODO: APLICAR' if aplicar else 'MODO: SIMULAÇÃO (nada será alterado)'))

        try:
            with transaction.atomic():
                # 1) Fim da guarda mínima de contas excluídas
                antigas = CustomUser.objects.filter(excluido_em__lt=agora - PRAZO_GUARDA_MINIMA)
                r['contas apagadas definitivamente (excluídas há +5 anos)'] = antigas.count()
                for user in antigas:
                    purgar_conta(user)

                # 2) Inatividade: aviso e, 30 dias depois, exclusão
                inativas = list(contas_inativas(agora))
                avisar = [u for u in inativas if not u.aviso_inatividade_em]
                excluir = [u for u in inativas if u.aviso_inatividade_em
                           and u.aviso_inatividade_em < agora - PRAZO_AVISO_INATIVIDADE]
                r['contas inativas avisadas por e-mail'] = len(avisar)
                r['contas inativas excluídas (30 dias após o aviso)'] = len(excluir)
                for user in excluir:
                    excluir_conta(user)
                for user in avisar:
                    if aplicar:
                        self._avisar_inatividade(user)
                    user.aviso_inatividade_em = agora
                    user.save(update_fields=['aviso_inatividade_em'])

                # 3) Inventário: anonimização 5 anos após o término da pesquisa
                pesquisas = list(pesquisas_para_anonimizar())
                r['pesquisas anonimizadas (término há +5 anos)'] = len(pesquisas)
                r['formulários anonimizados'] = sum(anonimizar_pesquisa(p) for p in pesquisas)

                # 4) Códigos de recuperação de senha expirados
                r['códigos de recuperação expirados apagados'] = CustomUser.objects.filter(
                    otp_exp__lt=agora).exclude(otp__isnull=True).update(otp=None, otp_exp=None, otp_verified=False)

                # 5) Registros de sessão antigos
                r['registros de sessão antigos apagados'] = self._limpar_sessoes(agora - PRAZO_REGISTROS_ACESSO)

                if not aplicar:
                    raise _Simulacao()
        except _Simulacao:
            pass

        for descricao, quantidade in r.items():
            self.stdout.write(f'  {descricao}: {quantidade}')
        self.stdout.write(self.style.SUCCESS('Concluído.' if aplicar else 'Simulação concluída. Use --aplicar para aplicar.'))

    def _avisar_inatividade(self, user):
        dias = PRAZO_AVISO_INATIVIDADE.days
        try:
            send_mail(
                'SisTur: sua conta será excluída por inatividade',
                f'Olá, {user.username}.\n\n'
                'Sua conta no SisTur está sem acesso há mais de 2 anos. Conforme a nossa Política de Privacidade, '
                f'ela e os seus dados pessoais serão excluídos em {dias} dias.\n\n'
                'Para manter a conta, basta entrar no aplicativo antes desse prazo.\n\n'
                'Equipe SisTur — IFCE Campus Tianguá',
                settings.DEFAULT_FROM_EMAIL,
                [user.email],
                fail_silently=False,
            )
        except Exception as e:
            self.stderr.write(f'  Falha ao avisar a conta {user.id}: {e}')

    def _limpar_sessoes(self, limite):
        try:
            from rest_framework_simplejwt.token_blacklist.models import OutstandingToken
            return OutstandingToken.objects.filter(expires_at__lt=limite).delete()[0]
        except Exception:
            return 0
