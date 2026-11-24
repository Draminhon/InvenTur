#!/usr/bin/env bash
# =====================================================================================================
# SisTur — implantação/atualização do backend (Linux). Rode na pasta do projeto:
#
#     bash implantar.sh
#
# Pode ser rodado de novo a cada atualização do código (git pull): só aplica o que mudou.
# O que faz:
#   1. cria o ambiente Python (.venv) e instala as dependências;
#   2. na primeira vez, cria o .env com chaves secretas novas e pergunta o domínio e o e-mail;
#   3. cria/atualiza o banco de dados (migrações);
#   4. prepara os arquivos do painel /admin/ (collectstatic);
#   5. confere a configuração.
# Não é preciso configurar o servidor web para fotos/arquivos nem agendar a retenção de dados (LGPD):
# o próprio sistema faz isso (DJANGO_SERVIR_ARQUIVOS e DJANGO_RETENCAO_AUTOMATICA no .env).
# =====================================================================================================
set -euo pipefail
cd "$(dirname "$0")"

# Proteções: só roda na pasta do projeto e só no Linux do servidor (não no Windows de desenvolvimento)
if [ ! -f manage.py ] || [ ! -f api/settings.py ]; then
  echo "Rode este script dentro da pasta do projeto SisTur (onde ficam manage.py e a pasta api/)." >&2
  exit 1
fi
case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*)
    echo "Este script é para o servidor Linux. No Windows, use o ambiente de desenvolvimento normal." >&2
    exit 1 ;;
esac

verde() { printf '\033[32m%s\033[0m\n' "$*"; }
amarelo() { printf '\033[33m%s\033[0m\n' "$*"; }
vermelho() { printf '\033[31m%s\033[0m\n' "$*"; }
passo() { printf '\n\033[1m==> %s\033[0m\n' "$*"; }

PYTHON="${PYTHON:-python3}"

# ------------------------------------------------------------------ 1. Python e dependências
passo "1/5 Ambiente Python e dependências"
if ! command -v "$PYTHON" >/dev/null 2>&1; then
  vermelho "Python 3 não encontrado. Instale o Python 3.10 ou mais novo (ou rode: PYTHON=/caminho/python bash implantar.sh)."
  exit 1
fi
"$PYTHON" - <<'EOF'
import sys
if sys.version_info < (3, 10):
    sys.exit(f"Python {sys.version.split()[0]} é antigo demais: use 3.10 ou mais novo.")
EOF
if [ -e .venv ] && [ ! -x .venv/bin/python ]; then
  # Nunca apaga um ambiente existente (pode ser de outra pessoa/sistema): pede para resolver à mão
  vermelho "A pasta .venv existe mas está incompleta. Renomeie ou apague a pasta .venv e rode o script de novo."
  exit 1
fi
if [ ! -e .venv ]; then
  if ! "$PYTHON" -m venv .venv >/dev/null 2>&1; then
    # Ubuntu/Debian sem o pacote python3-venv: cria o ambiente sem pip e instala o pip direto (sem sudo)
    amarelo "Módulo venv incompleto (falta o pacote python3-venv); instalando o pip no ambiente..."
    rm -rf .venv
    if ! "$PYTHON" -m venv --without-pip .venv; then
      vermelho "Não foi possível criar o ambiente Python. Rode: sudo apt install python3-venv  e tente de novo."
      exit 1
    fi
    if command -v curl >/dev/null 2>&1; then
      curl -fsSL https://bootstrap.pypa.io/get-pip.py | .venv/bin/python - --quiet
    else
      wget -qO- https://bootstrap.pypa.io/get-pip.py | .venv/bin/python - --quiet
    fi
  fi
fi
# shellcheck disable=SC1091
source .venv/bin/activate
python -m pip install --quiet --upgrade pip
python -m pip install --quiet -r requirements.txt
verde "Dependências instaladas."

# ------------------------------------------------------------------ 2. Configuração (.env)
passo "2/5 Configuração (.env)"
if [ ! -f .env ]; then
  cp .env.example .env
  chmod 600 .env
  amarelo "Primeira implantação: criando o .env."

  read -r -p "Domínio do servidor (ex.: nupreds.ifce.edu.br): " DOMINIO
  read -r -p "O servidor fica atrás de nginx/proxy/PythonAnywhere? [S/n]: " PROXY
  read -r -p "Gmail que envia os e-mails (deixe vazio para configurar depois): " EMAIL_USUARIO
  EMAIL_SENHA=""
  if [ -n "$EMAIL_USUARIO" ]; then
    read -r -s -p "Senha de app do Gmail (16 letras, não é a senha normal): " EMAIL_SENHA
    echo
  fi

  DOMINIO="$DOMINIO" PROXY="$PROXY" EMAIL_USUARIO="$EMAIL_USUARIO" EMAIL_SENHA="$EMAIL_SENHA" python - <<'EOF'
import os, re
from cryptography.fernet import Fernet
from django.core.management.utils import get_random_secret_key

dominio = os.environ['DOMINIO'].strip().removeprefix('https://').removeprefix('http://').strip('/')
atras_de_proxy = os.environ['PROXY'].strip().lower() not in ('n', 'nao', 'não')
email = os.environ['EMAIL_USUARIO'].strip()

valores = {
    'DJANGO_SECRET_KEY': get_random_secret_key(),
    'FIELD_ENCRYPTION_KEY': Fernet.generate_key().decode(),
    'DJANGO_DEBUG': 'False',
    'DJANGO_NUM_PROXIES': '1' if atras_de_proxy else '0',
}
if dominio:
    valores['DJANGO_ALLOWED_HOSTS'] = f'{dominio},localhost,127.0.0.1'
    valores['CSRF_TRUSTED_ORIGINS'] = f'https://{dominio}'
    valores['CORS_ALLOWED_ORIGINS'] = f'https://{dominio}'
if email:
    valores['EMAIL_HOST_USER'] = email
    valores['EMAIL_HOST_PASSWORD'] = os.environ['EMAIL_SENHA'].replace(' ', '')
    valores['DEFAULT_FROM_EMAIL'] = f'SisTur <{email}>'

with open('.env', encoding='utf-8') as f:
    texto = f.read()
for chave, valor in valores.items():
    linha = f"{chave}='{valor}'"
    texto, n = re.subn(rf'(?m)^{chave}=.*$', lambda _: linha, texto)
    if not n:
        texto += f'\n{linha}\n'
with open('.env', 'w', encoding='utf-8') as f:
    f.write(texto)
EOF
  verde ".env criado com chaves secretas novas."
  amarelo "IMPORTANTE: faça uma cópia de segurança do .env. Sem a FIELD_ENCRYPTION_KEY os dados criptografados"
  amarelo "do banco não podem ser lidos. Nunca gere uma chave nova com o banco já em uso."
else
  verde ".env já existe: mantido como está."
fi

# ------------------------------------------------------------------ 3. Banco de dados
passo "3/5 Banco de dados"
python manage.py makemigrations apidjango --noinput
python manage.py migrate --noinput
verde "Banco de dados atualizado."

# ------------------------------------------------------------------ 4. Arquivos
passo "4/5 Arquivos do painel e pastas"
mkdir -p media logs
python manage.py collectstatic --noinput --verbosity 0
verde "Arquivos preparados."

# ------------------------------------------------------------------ 5. Conferência
passo "5/5 Conferindo a configuração"
python manage.py check
python - <<'EOF'
import os
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'api.settings')
import django
django.setup()
from django.conf import settings
avisos = []
if settings.DEBUG:
    avisos.append('DJANGO_DEBUG está True: em produção deve ser False.')
if not settings.EMAIL_HOST_USER or not settings.EMAIL_HOST_PASSWORD:
    avisos.append('E-mail não configurado (EMAIL_HOST_USER / EMAIL_HOST_PASSWORD): a recuperação de senha não funciona.')
if set(settings.ALLOWED_HOSTS) <= {'localhost', '127.0.0.1'}:
    avisos.append('DJANGO_ALLOWED_HOSTS só tem localhost: acrescente o domínio do servidor.')
for aviso in avisos:
    print(f'\033[33mATENÇÃO: {aviso}\033[0m')
if not avisos:
    print('\033[32mConfiguração OK.\033[0m')
EOF

passo "Pronto!"
cat <<EOF
Aplicação WSGI: api.wsgi:application   (pasta do projeto: $(pwd))
Ambiente Python: $(pwd)/.venv

Exemplo para iniciar com gunicorn:
  .venv/bin/pip install gunicorn
  .venv/bin/gunicorn api.wsgi:application --bind 127.0.0.1:8000 --workers 3

No app, o endereço da API é: https://SEU-DOMINIO/api/v1/
Fotos (/media/), arquivos do painel (/static/) e a retenção diária de dados já são feitos pelo sistema.
Resultado da retenção: logs/retencao.log
EOF
