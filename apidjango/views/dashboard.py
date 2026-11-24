from django.db.models import Count
from django.utils import timezone
from rest_framework import permissions, views
from rest_framework.exceptions import ValidationError as ParametroInvalido
from rest_framework.response import Response
from rest_framework.throttling import UserRateThrottle
from rest_framework_simplejwt.authentication import JWTAuthentication
from ..models import *
from ..permissoes import IsAdministrador, exigir_pesquisa_visivel, pesquisas_visiveis
from ..services.pesquisa_export import MODEL_SHEET_MAP

# Agrupamento dos equipamentos nas categorias A, B e C (mesma divisão dos formulários do app)
CATEGORIAS = {
    'A': [InformacaoBasicaDoMunicipio, Rodovia, SistemaDeSeguranca, ComercioTuristico, LocadorasDeImoveis],
    'B': [AlimentosEBebidas, MeioDeHospedagem, OutrosMeiosDeHospedagem, AgenciaDeTurismo, TransporteTuristico,
          EspacoParaEventos, ServicosParaEventos, Parques, EspacosDeDiversaoECultura, InformacoesTuristicas,
          EntidadesAssociativas, GuiamentoEConducaoTuristica, InstalacoesEsportivas],
    'C': [UnidadesDeConservacao, EventosProgramados, GastronomiaArtesanato],
}


def _coordenadas_de(lat, lng):
    """Converte coordenadas salvas como texto ("-3,73" ou "-3.73"); (None, None) se ausentes ou inválidas."""
    if lat in (None, '') or lng in (None, ''):
        return None, None
    try:
        return float(str(lat).replace(',', '.')), float(str(lng).replace(',', '.'))
    except (TypeError, ValueError):
        return None, None


def _coordenadas(equipamento):
    lat = getattr(equipamento, 'latitude', None) or getattr(equipamento, 'latitudePrefeitura', None)
    lng = getattr(equipamento, 'longitude', None) or getattr(equipamento, 'longitudePrefeitura', None)
    return _coordenadas_de(lat, lng)


# Campos de nome verificados na qualidade dos formulários (o primeiro existente no modelo)
_CAMPOS_NOME = ('nomeFantasia', 'nomeOficial', 'nome_oficial', 'nomeProduto')


def _situacao_pesquisa(pesquisa, hoje):
    """Situação da pesquisa em relação ao prazo e fração do prazo já consumida (0 a 1)."""
    duracao = max((pesquisa.dataTermino - pesquisa.dataInicio).days, 1)
    progresso = min(max((hoje - pesquisa.dataInicio).days / duracao, 0), 1)
    if pesquisa.status == 'Concluído':
        situacao = 'concluida'
    elif hoje > pesquisa.dataTermino:
        situacao = 'atrasada'
    elif pesquisa.status == 'Não Iniciado':
        situacao = 'inicio_atrasado' if hoje > pesquisa.dataInicio else 'agendada'
    elif progresso >= 0.8:
        situacao = 'atencao'
    else:
        situacao = 'no_prazo'
    return situacao, round(progresso, 3)


class PesquisadorDashboardView(views.APIView):
    """
    GET /pesquisador/dashboard/
    "Meu Painel" do pesquisador autenticado:
      - pesquisas: as dele, com situação do prazo (calculada com a data do servidor) e o total da equipe;
      - equipamentos: os que ele inventariou, com o nome do tipo, coordenadas e pendências de qualidade;
      - tipos: todos os tipos de equipamento (para a cobertura do inventário).
    A agregação (por categoria, tipo, dia, mês) é feita no app, que guarda a última resposta para uso offline.
    """
    authentication_classes = [JWTAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        user = request.user
        hoje = timezone.localdate()

        pesquisas = list(Pesquisa.objects.filter(usuario=user, is_active=True).order_by('municipio'))
        ids = [p.id for p in pesquisas]
        categoria_do_modelo = {modelo: cat for cat, modelos in CATEGORIAS.items() for modelo in modelos}

        total_equipe = {pid: 0 for pid in ids}
        equipamentos = []
        for modelo, nome_tipo in MODEL_SHEET_MAP:
            categoria = categoria_do_modelo.get(modelo)
            if categoria is None:
                continue
            ativos = modelo.objects.filter(is_active=True, pesquisa__is_active=True)
            for linha in ativos.filter(pesquisa_id__in=ids).values('pesquisa_id').annotate(total=Count('id')):
                total_equipe[linha['pesquisa_id']] += linha['total']

            campos = {f.name for f in modelo._meta.concrete_fields}
            campo_nome = next((c for c in _CAMPOS_NOME if c in campos), None)
            tem_coordenada = 'latitude' in campos and 'longitude' in campos
            for equipamento in ativos.filter(usuario_criador=user).select_related('pesquisa'):
                lat, lng = _coordenadas(equipamento)
                if lat is not None and not _ponto_valido(lat, lng):
                    lat = lng = None
                problemas = []
                if tem_coordenada and lat is None:
                    problemas.append('sem_coordenadas')
                if campo_nome and not (getattr(equipamento, campo_nome) or '').strip():
                    problemas.append('sem_nome')
                equipamentos.append({
                    'id': equipamento.id,
                    'tipo': nome_tipo,
                    'categoria': categoria,
                    'pesquisa_id': equipamento.pesquisa_id,
                    'municipio': equipamento.pesquisa.municipio,
                    'criacao': equipamento.criacao,
                    'latitude': lat,
                    'longitude': lng,
                    'problemas': problemas,
                })

        pesquisas_data = []
        for p in pesquisas:
            situacao, progresso = _situacao_pesquisa(p, hoje)
            pesquisas_data.append({
                'id': p.id,
                'municipio': p.municipio,
                'estado': p.estado,
                'status': p.status,
                'dataInicio': p.dataInicio,
                'dataTermino': p.dataTermino,
                'situacao': situacao,
                'progresso_prazo': progresso,
                'dias_restantes': (p.dataTermino - hoje).days,
                'total_equipe': total_equipe[p.id],
            })

        response = Response({
            'atualizado_em': timezone.now(),
            'pesquisas': pesquisas_data,
            'equipamentos': equipamentos,
            'tipos': [{'nome': nome, 'categoria': categoria_do_modelo[modelo]}
                      for modelo, nome in MODEL_SHEET_MAP if modelo in categoria_do_modelo],
        })
        response['Cache-Control'] = 'no-store'
        return response


def _escopo_admin(request):
    """
    Pesquisas que o administrador pode ver (só as que ele criou; superusuário vê todas) e o filtro dos
    formulários correspondente. Com ?pesquisa_id=, restringe a essa pesquisa (404 se não for dele).
    """
    pesquisas = pesquisas_visiveis(request.user).order_by('municipio')
    filtro = {'is_active': True, 'pesquisa__in': pesquisas}
    pesquisa_id = request.query_params.get('pesquisa_id')
    if pesquisa_id:
        try:
            pesquisa_id = int(pesquisa_id)
        except (TypeError, ValueError):
            raise ParametroInvalido({'pesquisa_id': 'Deve ser um número inteiro.'})
        exigir_pesquisa_visivel(request.user, pesquisa_id)
        filtro['pesquisa_id'] = pesquisa_id
    return pesquisas, filtro, pesquisa_id or None


class AdminDashboardThrottle(UserRateThrottle):
    # O app atualiza o painel automaticamente a cada 30s; o limite folgado cobre o pull-to-refresh manual.
    scope = 'admin_dashboard'
    rate = '30/min'


def _ponto_valido(lat, lng):
    return lat is not None and lng is not None and -90 <= lat <= 90 and -180 <= lng <= 180 and (lat, lng) != (0, 0)


class AdminDashboardView(views.APIView):
    """
    GET /admin/dashboard/?pesquisa_id=<id opcional>
    Painel de dados do administrador: os mesmos indicadores do relatório do Power BI
    (totais, equipamentos por categoria, ranking por equipamento e mapa).
    Fonte: as mesmas tabelas e nomes de equipamento usados na exportação (MODEL_SHEET_MAP),
    considerando apenas registros ativos de pesquisas ativas.
    Retorna apenas dados agregados e coordenadas; nenhum dado pessoal é exposto.
    """
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAdministrador]
    throttle_classes = [AdminDashboardThrottle]

    def get(self, request):
        pesquisas, filtro, pesquisa_id = _escopo_admin(request)

        categoria_do_modelo = {modelo: cat for cat, modelos in CATEGORIAS.items() for modelo in modelos}
        por_categoria = {'A': 0, 'B': 0, 'C': 0}
        por_equipamento = []
        pontos = []

        for modelo, nome in MODEL_SHEET_MAP:
            categoria = categoria_do_modelo.get(modelo)
            if categoria is None:
                continue
            queryset = modelo.objects.filter(**filtro)
            # Por pesquisa, para o app cruzar com o status da pesquisa sem novas consultas
            for linha in queryset.values('pesquisa_id').annotate(quantidade=Count('id')):
                por_categoria[categoria] += linha['quantidade']
                por_equipamento.append({'nome': nome, 'categoria': categoria, 'pesquisa_id': linha['pesquisa_id'],
                                        'quantidade': linha['quantidade']})

            campos = {f.name for f in modelo._meta.get_fields()}
            for lat_campo, lng_campo in (('latitude', 'longitude'), ('latitudePrefeitura', 'longitudePrefeitura')):
                if lat_campo in campos and lng_campo in campos:
                    break
            else:
                continue
            for pid, lat, lng in queryset.values_list('pesquisa_id', lat_campo, lng_campo):
                lat, lng = _coordenadas_de(lat, lng)
                if lat is not None and _ponto_valido(lat, lng):
                    pontos.append({'latitude': lat, 'longitude': lng, 'equipamento': nome, 'categoria': categoria,
                                   'pesquisa_id': pid})

        por_equipamento.sort(key=lambda e: (-e['quantidade'], e['nome']))
        total_pesquisas = 1 if pesquisa_id else pesquisas.count()

        response = Response({
            'atualizado_em': timezone.now(),
            'pesquisas': [{'id': p.id, 'municipio': p.municipio, 'estado': p.estado, 'status': p.status}
                          for p in pesquisas],
            'totais': {
                'pesquisas': total_pesquisas,
                'equipamentos': sum(por_categoria.values()),
                **{f'categoria_{c.lower()}': v for c, v in por_categoria.items()},
            },
            'por_categoria': por_categoria,
            'por_equipamento': por_equipamento,
            'pontos': pontos,
        })
        # Dados administrativos: não devem ser armazenados em caches intermediários
        response['Cache-Control'] = 'no-store'
        return response


class AdminGestaoView(views.APIView):
    """
    GET /admin/gestao/?pesquisa_id=<id opcional>
    Aba "Gestão" do administrador: produtividade do inventário (equipamentos por dia, mês, município e pesquisador),
    as mesmas visões da segunda página do relatório do Power BI.
    Retorna linhas agregadas por (dia, município, pesquisador) para o app cruzar os filtros sem novas consultas.
    Do pesquisador é exposto apenas o nome de usuário.
    """
    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAdministrador]
    throttle_classes = [AdminDashboardThrottle]

    def get(self, request):
        from collections import Counter
        from django.db.models import Count
        from django.db.models.functions import TruncDate

        pesquisas, filtro, _ = _escopo_admin(request)

        contagem = Counter()
        for modelo, _ in MODEL_SHEET_MAP:
            linhas = (
                modelo.objects.filter(**filtro)
                .annotate(dia=TruncDate('criacao', tzinfo=timezone.get_current_timezone()))
                .values('dia', 'pesquisa__municipio', 'usuario_criador')
                .annotate(total=Count('id'))
            )
            for linha in linhas:
                contagem[(linha['dia'], linha['pesquisa__municipio'] or '', linha['usuario_criador'])] += linha['total']

        ids = {usuario for (_, _, usuario) in contagem if usuario is not None}
        nomes = dict(CustomUser.objects.filter(id__in=ids).values_list('id', 'username'))

        registros = [
            {
                'dia': dia.isoformat() if dia else None,
                'municipio': municipio,
                'usuario': nomes.get(usuario) or 'Sem pesquisador',
                'total': total,
            }
            for (dia, municipio, usuario), total in contagem.items()
        ]
        registros.sort(key=lambda r: (r['dia'] or '', r['municipio'], r['usuario']))

        response = Response({
            'atualizado_em': timezone.now(),
            'pesquisas': [{'id': p.id, 'municipio': p.municipio, 'estado': p.estado} for p in pesquisas],
            'registros': registros,
        })
        response['Cache-Control'] = 'no-store'
        return response
