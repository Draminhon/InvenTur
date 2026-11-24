"""
Execução automática da política de retenção (comando aplicar_retencao), uma vez por dia, sem precisar agendar
cron/tarefa no servidor.

Como funciona: a cada requisição o middleware verifica (custo desprezível: lê um arquivo pequeno no máximo uma vez
por hora por processo) se a retenção já rodou hoje. Se não rodou, dispara o comando numa thread em segundo plano —
a requisição não espera. Uma trava em arquivo garante uma única execução por dia mesmo com vários processos
(gunicorn/uwsgi com mais de um worker).

Liga/desliga: DJANGO_RETENCAO_AUTOMATICA no .env (padrão: ligada em produção, desligada com DEBUG=True).
O resultado de cada execução vai para logs/retencao.log.
"""
import io
import os
import threading
import time
from datetime import datetime

from django.conf import settings
from django.utils import timezone

PASTA = settings.BASE_DIR / 'logs'
ARQUIVO_ULTIMA = PASTA / 'retencao_ultima_execucao.txt'
ARQUIVO_TRAVA = PASTA / 'retencao.lock'
ARQUIVO_LOG = PASTA / 'retencao.log'
TRAVA_VENCIDA_SEGUNDOS = 2 * 60 * 60  # trava de uma execução que travou/caiu é descartada depois de 2 h
INTERVALO_VERIFICACAO_SEGUNDOS = 60 * 60

_ultima_verificacao = 0.0
_lock_processo = threading.Lock()


def _hoje():
    return timezone.localdate().isoformat()


def _ja_rodou_hoje():
    try:
        return ARQUIVO_ULTIMA.read_text(encoding='utf-8').strip() == _hoje()
    except OSError:
        return False


def _pegar_trava():
    """Cria a trava de forma atômica (só um processo consegue). Remove travas vencidas."""
    PASTA.mkdir(parents=True, exist_ok=True)
    try:
        if time.time() - ARQUIVO_TRAVA.stat().st_mtime > TRAVA_VENCIDA_SEGUNDOS:
            ARQUIVO_TRAVA.unlink()
    except OSError:
        pass
    try:
        fd = os.open(ARQUIVO_TRAVA, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
        os.write(fd, str(os.getpid()).encode())
        os.close(fd)
        return True
    except FileExistsError:
        return False


def _executar():
    from django.core.management import call_command
    from django.db import connection

    saida = io.StringIO()
    try:
        call_command('aplicar_retencao', aplicar=True, stdout=saida, stderr=saida)
        ARQUIVO_ULTIMA.write_text(_hoje(), encoding='utf-8')
        status = 'OK'
    except Exception as e:  # nunca derruba o servidor; tenta de novo na próxima verificação
        status = f'ERRO: {e!r}'
    finally:
        try:
            with open(ARQUIVO_LOG, 'a', encoding='utf-8') as log:
                log.write(f'\n=== {datetime.now():%Y-%m-%d %H:%M:%S} — {status}\n{saida.getvalue()}')
        except OSError:
            pass
        try:
            ARQUIVO_TRAVA.unlink()
        except OSError:
            pass
        connection.close()


def verificar_e_disparar():
    """Dispara a retenção em segundo plano se ainda não rodou hoje. Retorna True se disparou."""
    global _ultima_verificacao
    agora = time.monotonic()
    with _lock_processo:
        if _ultima_verificacao and agora - _ultima_verificacao < INTERVALO_VERIFICACAO_SEGUNDOS:
            return False
        _ultima_verificacao = agora
    if _ja_rodou_hoje() or not _pegar_trava():
        return False
    threading.Thread(target=_executar, name='retencao-diaria', daemon=True).start()
    return True


class RetencaoDiariaMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        if getattr(settings, 'RETENCAO_AUTOMATICA', False):
            try:
                verificar_e_disparar()
            except Exception:
                pass  # a retenção nunca pode atrapalhar o atendimento
        return self.get_response(request)
