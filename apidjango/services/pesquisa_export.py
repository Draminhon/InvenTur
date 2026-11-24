"""
Exportação de uma pesquisa para Excel (.xlsx).

Planilha gerada:
  - "Resumo": dados da pesquisa e quantidade de equipamentos por tipo;
  - uma aba por tipo de equipamento inventariado (só os que têm registros), com cabeçalho legível,
    primeira linha e primeira coluna congeladas, filtro automático e largura de coluna ajustada.

Cuidados:
  - textos digitados no app que começam com "=", "+", "-" ou "@" são gravados como texto, nunca como fórmula
    (evita "injeção de fórmula" ao abrir a planilha no Excel/LibreOffice);
  - caracteres de controle (que o formato .xlsx não aceita) são removidos em vez de derrubar a exportação.
"""
import json
import re
from datetime import date, datetime
from decimal import Decimal
from urllib.parse import quote

import openpyxl
from django.db.models import Model
from django.http import HttpResponse
from django.utils import timezone
from django.utils.text import slugify
from openpyxl.cell.cell import ILLEGAL_CHARACTERS_RE
from openpyxl.styles import Alignment, Font, PatternFill
from openpyxl.utils import get_column_letter
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.authentication import JWTAuthentication

from ..models import *
from ..permissoes import pesquisas_visiveis

# services/__init__.py faz "import *": expõe só o que é desta exportação, sem vazar módulos auxiliares
__all__ = ['MODEL_SHEET_MAP', 'export_pesquisa_to_excel', 'gerar_planilha', 'nome_do_arquivo']

# Equipamentos exportados (uma aba por modelo). Também usado pelo painel de dados do administrador,
# para que o app e o relatório do Power BI usem os mesmos nomes de equipamento.
MODEL_SHEET_MAP = [
    (AlimentosEBebidas, "Alimentos e Bebidas"),
    (SistemaDeSeguranca, "Sistemas de Segurança"),
    (Rodovia, "Rodovia"),
    (MeioDeHospedagem, "Meios de Hospedagem"),
    (LocadorasDeImoveis, "Locadoras de Imóveis"),
    (GuiamentoEConducaoTuristica, "Guiamento e Condução Turística"),
    (GastronomiaArtesanato, "Gastronomia e Artesanato"),
    (OutrosMeiosDeHospedagem, "Outros Meios de Hospedagem"),
    (InformacaoBasicaDoMunicipio, "Informações Básicas do Município"),
    (ComercioTuristico, "Comércio Turístico"),
    (AgenciaDeTurismo, "Agência de Turismo"),
    (TransporteTuristico, "Transporte Turístico"),
    (EspacoParaEventos, "Espaço para Eventos"),
    (ServicosParaEventos, "Serviços para Eventos"),
    (Parques, "Parques"),
    (EspacosDeDiversaoECultura, "Espaços de Diversão e Cultura"),
    (InformacoesTuristicas, "Informações Turísticas"),
    (EntidadesAssociativas, "Entidades Associativas"),
    (InstalacoesEsportivas, "Instalações Esportivas"),
    (UnidadesDeConservacao, "Unidades de Conservação"),
    (EventosProgramados, "Eventos Programados"),
]

# Campos internos que não interessam a quem lê a planilha
CAMPOS_OCULTOS = {'is_active', 'base_ptr', 'pesquisa'}

# Nomes amigáveis para campos comuns (os demais vêm do verbose_name ou do nome do campo)
ROTULOS = {
    'id': 'ID',
    'tipo_formulario': 'Tipo de formulário',
    'criacao': 'Data de cadastro',
    'uf': 'UF',
    'regiao_turistica': 'Região turística',
    'municipio': 'Município',
    'usuario_criador': 'Cadastrado por',
    'observacoes': 'Observações',
    'referencias': 'Referências',
    'nome_pesquisador': 'Pesquisador',
    'telefone_pesquisador': 'Telefone do pesquisador',
    'email_pesquisador': 'E-mail do pesquisador',
    'nome_coordenador': 'Coordenador',
    'telefone_coordenador': 'Telefone do coordenador',
    'email_coordenador': 'E-mail do coordenador',
    'contatos': 'Contatos',
    'servicos_especializados': 'Serviços especializados',
}

LIMITE_CELULA = 32767  # máximo de caracteres numa célula do Excel
LARGURA_MAXIMA = 60
COR_CABECALHO = '376F3C'  # verde do app

_FONTE_CABECALHO = Font(bold=True, color='FFFFFF')
_FUNDO_CABECALHO = PatternFill('solid', fgColor=COR_CABECALHO)
_FONTE_TITULO = Font(bold=True, size=14, color=COR_CABECALHO)
_FONTE_NEGRITO = Font(bold=True)
_ALINHAMENTO_CABECALHO = Alignment(vertical='center', wrap_text=True)
_ALINHAMENTO_CELULA = Alignment(vertical='top')


# ---------------------------------------------------------------- valores

def _texto_de_estrutura(valor):
    """Listas/dicionários (campos JSON e contatos) em texto legível, em vez de JSON cru."""
    if isinstance(valor, dict):
        partes = [f'{_rotulo_de_nome(k)}: {_texto_de_estrutura(v)}' for k, v in valor.items()
                  if v not in (None, '', [], {})]
        return '; '.join(partes)
    if isinstance(valor, (list, tuple)):
        itens = [_texto_de_estrutura(v) for v in valor if v not in (None, '', [], {})]
        separador = ' | ' if any(isinstance(v, dict) for v in valor) else ', '
        return separador.join(i for i in itens if i)
    if isinstance(valor, bool):
        return 'Sim' if valor else 'Não'
    return '' if valor is None else str(valor)


def valor_para_celula(valor):
    """Converte um valor do banco num valor aceito pelo openpyxl e legível na planilha."""
    if callable(valor):
        valor = valor()
    if valor is None:
        return None
    if isinstance(valor, bool):
        return 'Sim' if valor else 'Não'
    if isinstance(valor, datetime):
        # Datas com fuso: converte para o horário local (o Excel não aceita fuso)
        if timezone.is_aware(valor):
            valor = timezone.localtime(valor)
        return valor.replace(tzinfo=None)
    if isinstance(valor, (date, int, float, Decimal)):
        return valor
    if isinstance(valor, Model):
        return str(valor)
    if isinstance(valor, (list, tuple, dict)):
        valor = _texto_de_estrutura(valor)
    elif isinstance(valor, str):
        # Campos JSON às vezes chegam como texto JSON: mostra o conteúdo
        texto = valor.strip()
        if texto[:1] in ('[', '{'):
            try:
                return valor_para_celula(json.loads(texto))
            except ValueError:
                pass
    texto = ILLEGAL_CHARACTERS_RE.sub('', str(valor))
    return texto[:LIMITE_CELULA] or None


def _escrever(ws, linha, coluna, valor, fonte=None):
    celula = ws.cell(row=linha, column=coluna, value=valor_para_celula(valor))
    # Nunca grava fórmula: texto que começa com "=" vira texto literal
    if isinstance(celula.value, str) and celula.value.startswith('='):
        celula.data_type = 's'
    if fonte:
        celula.font = fonte
    return celula


# ---------------------------------------------------------------- cabeçalhos

def _rotulo_de_nome(nome):
    """'avenidaRuaEtc' -> 'Avenida rua etc'; 'distancia_ponto' -> 'Distancia ponto'; siglas são mantidas."""
    nome = str(nome)
    if nome in ROTULOS:
        return ROTULOS[nome]
    palavras = re.findall(r'[A-Z]{2,}(?=[A-Z][a-z]|\d|\b|_)|[A-Z]?[a-z]+|[A-Z]+|\d+', nome.replace('_', ' '))
    if not palavras:
        return nome
    palavras = [p if p.isupper() and len(p) > 1 else p.lower() for p in palavras]
    primeira = palavras[0]
    palavras[0] = primeira if primeira.isupper() else primeira.capitalize()
    return ' '.join(palavras)


def rotulo_do_campo(campo):
    if campo.name in ROTULOS:
        return ROTULOS[campo.name]
    verbose = str(getattr(campo, 'verbose_name', '') or '')
    # verbose_name explícito (diferente do gerado automaticamente a partir do nome)
    if verbose and verbose != campo.name.replace('_', ' '):
        return verbose[:1].upper() + verbose[1:]
    return _rotulo_de_nome(campo.name)


# ---------------------------------------------------------------- formatação

def _formatar_tabela(ws, linha_cabecalho, ultima_linha, colunas, larguras):
    for coluna in range(1, colunas + 1):
        celula = ws.cell(row=linha_cabecalho, column=coluna)
        celula.font = _FONTE_CABECALHO
        celula.fill = _FUNDO_CABECALHO
        celula.alignment = _ALINHAMENTO_CABECALHO
        ws.column_dimensions[get_column_letter(coluna)].width = min(max(larguras.get(coluna, 10), 10) + 2,
                                                                  LARGURA_MAXIMA)
    if ultima_linha > linha_cabecalho:
        ws.auto_filter.ref = f'A{linha_cabecalho}:{get_column_letter(colunas)}{ultima_linha}'


def _largura(valor):
    if valor is None:
        return 0
    if isinstance(valor, datetime):
        return 16
    if isinstance(valor, date):
        return 10
    return max((len(parte) for parte in str(valor).split('\n')), default=0)


# ---------------------------------------------------------------- abas

def _aba_resumo(wb, pesquisa, contagens):
    ws = wb.active
    ws.title = 'Resumo'
    _escrever(ws, 1, 1, f'Pesquisa {pesquisa.municipio} - {pesquisa.estado}', _FONTE_TITULO)
    _escrever(ws, 2, 1, f'Exportado em {timezone.localtime().strftime("%d/%m/%Y %H:%M")} pelo SisTur')

    pesquisadores = ', '.join(sorted(u.username for u in pesquisa.usuario.all()))
    dados = [
        ('Município', pesquisa.municipio),
        ('Estado', pesquisa.estado),
        ('Código IBGE', pesquisa.codigoIBGE),
        ('Situação', pesquisa.status),
        ('Data de início', pesquisa.dataInicio),
        ('Data de término', pesquisa.dataTermino),
        ('Administrador', pesquisa.admin.username if pesquisa.admin else ''),
        ('Pesquisadores', pesquisadores),
        ('Quantidade de pesquisadores', pesquisa.usuario.count()),
        ('Quantidade de equipamentos', sum(contagens.values())),
    ]
    linha = 4
    for rotulo, valor in dados:
        _escrever(ws, linha, 1, rotulo, _FONTE_NEGRITO)
        celula = _escrever(ws, linha, 2, valor)
        if isinstance(celula.value, date):
            celula.number_format = 'DD/MM/YYYY'
        celula.alignment = Alignment(horizontal='left', wrap_text=True)
        linha += 1

    linha += 1
    cabecalho = linha
    _escrever(ws, linha, 1, 'Tipo de equipamento')
    _escrever(ws, linha, 2, 'Quantidade')
    for nome, quantidade in contagens.items():
        linha += 1
        _escrever(ws, linha, 1, nome)
        _escrever(ws, linha, 2, quantidade)
    if not contagens:
        linha += 1
        _escrever(ws, linha, 1, 'Nenhum equipamento inventariado nesta pesquisa.')
    _formatar_tabela(ws, cabecalho, cabecalho, 2, {})
    ws.column_dimensions['A'].width = 34
    ws.column_dimensions['B'].width = 50


def _aba_equipamentos(wb, titulo, modelo, registros):
    ws = wb.create_sheet(title=titulo[:31])  # o Excel limita o nome da aba a 31 caracteres
    campos = [c for c in modelo._meta.fields if c.name not in CAMPOS_OCULTOS]
    campos_m2m = [c for c in modelo._meta.many_to_many if c.name not in CAMPOS_OCULTOS]
    larguras = {}

    for coluna, campo in enumerate(campos + campos_m2m, start=1):
        rotulo = rotulo_do_campo(campo)
        _escrever(ws, 1, coluna, rotulo)
        larguras[coluna] = min(len(rotulo), 30)

    for linha, registro in enumerate(registros, start=2):
        coluna = 0
        for coluna, campo in enumerate(campos, start=1):
            valor = getattr(registro, campo.name)
            if campo.name == 'usuario_criador' and valor is not None:
                valor = valor.username
            celula = _escrever(ws, linha, coluna, valor)
            celula.alignment = _ALINHAMENTO_CELULA
            if isinstance(celula.value, datetime):
                celula.number_format = 'DD/MM/YYYY HH:MM'
            elif isinstance(celula.value, date):
                celula.number_format = 'DD/MM/YYYY'
            larguras[coluna] = max(larguras.get(coluna, 0), _largura(celula.value))
        for deslocamento, campo in enumerate(campos_m2m, start=1):
            relacionados = [
                {c.name: getattr(obj, c.name) for c in obj._meta.fields if c.name not in CAMPOS_OCULTOS | {'id'}}
                for obj in getattr(registro, campo.name).all()
            ]
            celula = _escrever(ws, linha, coluna + deslocamento, relacionados)
            celula.alignment = _ALINHAMENTO_CELULA
            larguras[coluna + deslocamento] = max(larguras.get(coluna + deslocamento, 0), _largura(celula.value))

    _formatar_tabela(ws, 1, len(registros) + 1, len(campos) + len(campos_m2m), larguras)
    ws.freeze_panes = 'B2'  # cabeçalho e coluna de ID sempre visíveis


def gerar_planilha(pesquisa):
    """Monta a planilha da pesquisa. Separado da view para poder ser testado/reaproveitado."""
    wb = openpyxl.Workbook()
    abas = []
    for modelo, titulo in MODEL_SHEET_MAP:
        registros = list(
            modelo.objects.filter(pesquisa=pesquisa, is_active=True)
            .select_related('usuario_criador')
            .prefetch_related(*[c.name for c in modelo._meta.many_to_many])
            .order_by('id')
        )
        if registros:
            abas.append((titulo, modelo, registros))

    _aba_resumo(wb, pesquisa, {titulo: len(registros) for titulo, _, registros in abas})
    for titulo, modelo, registros in abas:
        _aba_equipamentos(wb, titulo, modelo, registros)
    return wb


def nome_do_arquivo(pesquisa):
    municipio = slugify(pesquisa.municipio or '') or f'pesquisa-{pesquisa.id}'
    estado = slugify(pesquisa.estado or '')
    partes = ['SisTur', municipio + (f'-{estado}' if estado else ''), timezone.localdate().strftime('%Y-%m-%d')]
    return '_'.join(partes) + '.xlsx'


@api_view(['GET'])
@authentication_classes([JWTAuthentication])
@permission_classes([IsAuthenticated])
def export_pesquisa_to_excel(request, pesquisa_id):
    # Exige login e só exporta pesquisas no escopo do usuário (admin: as que criou; pesquisador: as da equipe)
    pesquisa = pesquisas_visiveis(request.user).filter(id=pesquisa_id, is_active=True) \
        .select_related('admin').prefetch_related('usuario').first()
    if pesquisa is None:
        return HttpResponse('Pesquisa não encontrada', status=404)

    wb = gerar_planilha(pesquisa)
    nome = nome_do_arquivo(pesquisa)
    response = HttpResponse(content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
    response['Content-Disposition'] = f'attachment; filename="{nome}"; filename*=UTF-8\'\'{quote(nome)}'
    # O app lê o nome do arquivo deste cabeçalho
    response['Access-Control-Expose-Headers'] = 'Content-Disposition'
    response['Cache-Control'] = 'no-store'  # contém dados pessoais
    wb.save(response)
    return response
