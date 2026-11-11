import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sistur/ui/home/Administrador/widgets/painel_comum.dart';
import 'package:sistur/ui/widgets/maps/map.dart' show accessToken;
import 'package:sistur/utils/app_constants.dart';

/// Paleta do relatório do Power BI
const _verde = verdePainel;
const _coresCategoria = {
  'A': Color(0xFF376F3C),
  'B': Color(0xFF4C9A52),
  'C': Color(0xFF2E7D32),
};
// Enquadramento inicial do mapa: território brasileiro
final _brasil = LatLngBounds(const LatLng(-33.75, -73.99), const LatLng(5.27, -34.79));
const _zoomLocal = 17.0;

class _Equipamento {
  final String nome;
  final String categoria;
  final int quantidade;
  final int? pesquisaId;

  // Total já somado de um equipamento (sem pesquisa específica)
  const _Equipamento(this.nome, this.categoria, this.quantidade) : pesquisaId = null;

  _Equipamento.fromJson(Map<String, dynamic> json)
      : nome = json['nome'] ?? '',
        categoria = json['categoria'] ?? '',
        quantidade = (json['quantidade'] as num?)?.toInt() ?? 0,
        pesquisaId = (json['pesquisa_id'] as num?)?.toInt();
}

class _Ponto {
  final LatLng posicao;
  final String equipamento;
  final String categoria;
  final int? pesquisaId;

  _Ponto.fromJson(Map<String, dynamic> json)
      : posicao = LatLng((json['latitude'] as num).toDouble(), (json['longitude'] as num).toDouble()),
        equipamento = json['equipamento'] ?? '',
        categoria = json['categoria'] ?? '',
        pesquisaId = (json['pesquisa_id'] as num?)?.toInt();
}

class _Dados {
  final Map<String, int> totais;
  final List<_Equipamento> porEquipamento;
  final List<_Ponto> pontos;

  /// Status de cada pesquisa (id -> "Não Iniciado" | "Em Andamento" | "Concluído")
  final Map<int, String> statusDe;

  _Dados.fromJson(Map<String, dynamic> json)
      : totais = Map<String, dynamic>.from(json['totais'] ?? {}).map((k, v) => MapEntry(k, (v as num).toInt())),
        statusDe = {
          for (final p in List<Map<String, dynamic>>.from(json['pesquisas'] ?? []))
            (p['id'] as num).toInt(): p['status'] ?? '',
        },
        porEquipamento =
            List<Map<String, dynamic>>.from(json['por_equipamento'] ?? []).map(_Equipamento.fromJson).toList(),
        pontos = List<Map<String, dynamic>>.from(json['pontos'] ?? []).map(_Ponto.fromJson).toList();
}

/// Aba "Dados" do administrador: versão no app do relatório do Power BI.
/// Os dados vêm de GET admin/dashboard/ (restrito a administradores) e são atualizados automaticamente.
class DadosPage extends StatefulWidget {
  const DadosPage({super.key});

  @override
  State<DadosPage> createState() => _DadosPageState();
}

class _DadosPageState extends State<DadosPage> with SingleTickerProviderStateMixin, PainelAutoAtualizacao<DadosPage> {
  final _mapController = MapController();
  // Criado no initState (e não de forma preguiçosa): se fosse criado só no dispose, o ticker consultaria
  // o TickerMode de um elemento já desativado e lançaria FlutterError.
  late final AnimationController _animacaoMapa;
  _Dados? _dados;
  // Filtros cruzados (como no Power BI): clicar num gráfico filtra os demais.
  // Cumulativos: valores do mesmo gráfico somam (OU); gráficos diferentes se combinam (E)
  final Set<String> _categoriasSel = {};
  final Set<String> _equipamentosSel = {};
  final Set<String> _statusSel = {};
  // Página atual de "Equipamentos Inventariados" (ver Paginacao)
  int _paginaEquipamentos = 0;

  @override
  void initState() {
    super.initState();
    _animacaoMapa = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
  }

  @override
  String get endpoint => AppConstants.ADMIN_DASHBOARD;

  @override
  bool get temDados => _dados != null;

  @override
  void receberDados(Map<String, dynamic> json) => _dados = _Dados.fromJson(json);

  @override
  void limparFiltrosCruzados() {
    _categoriasSel.clear();
    _equipamentosSel.clear();
    _statusSel.clear();
    _paginaEquipamentos = 0;
  }

  @override
  void dispose() {
    _animacaoMapa.dispose();
    _mapController.dispose();
    super.dispose();
  }

  /// Move o mapa suavemente até [destino] com o [zoom] indicado.
  void _voarPara(LatLng destino, double zoom) {
    final camera = _mapController.camera;
    final lat = Tween(begin: camera.center.latitude, end: destino.latitude);
    final lng = Tween(begin: camera.center.longitude, end: destino.longitude);
    final z = Tween(begin: camera.zoom, end: zoom);
    final curva = CurvedAnimation(parent: _animacaoMapa, curve: Curves.easeInOutCubic);

    void mover() => _mapController.move(LatLng(lat.evaluate(curva), lng.evaluate(curva)), z.evaluate(curva));
    _animacaoMapa
      ..stop()
      ..reset();
    curva.addListener(mover);
    _animacaoMapa.forward().whenCompleteOrCancel(() => curva.removeListener(mover));
  }

  void _voltarParaBrasil() {
    final destino = CameraFit.bounds(bounds: _brasil, padding: const EdgeInsets.all(8)).fit(_mapController.camera);
    _voarPara(destino.center, destino.zoom);
  }

  bool get _temFiltro => _categoriasSel.isNotEmpty || _equipamentosSel.isNotEmpty || _statusSel.isNotEmpty;

  bool _statusPassa(_Dados dados, int? pesquisaId) =>
      _statusSel.isEmpty || _statusSel.contains(dados.statusDe[pesquisaId]);

  /// Equipamentos que passam pelos filtros cruzados. Cada gráfico ignora o próprio filtro
  /// para continuar mostrando as demais opções (destacando a selecionada).
  /// O servidor envia uma linha por (equipamento, pesquisa); o resultado vem somado por equipamento,
  /// do maior para o menor.
  List<_Equipamento> _equipamentosFiltrados(_Dados dados,
      {bool porCategoria = true, bool porEquipamento = true, bool porStatus = true}) {
    final soma = <String, _Equipamento>{};
    for (final e
        in _linhasFiltradas(dados, porCategoria: porCategoria, porEquipamento: porEquipamento, porStatus: porStatus)) {
      final atual = soma[e.nome];
      soma[e.nome] = _Equipamento(e.nome, e.categoria, (atual?.quantidade ?? 0) + e.quantidade);
    }
    return soma.values.toList()
      ..sort((a, b) => b.quantidade != a.quantidade ? b.quantidade.compareTo(a.quantidade) : a.nome.compareTo(b.nome));
  }

  Iterable<_Equipamento> _linhasFiltradas(_Dados dados,
          {bool porCategoria = true, bool porEquipamento = true, bool porStatus = true}) =>
      dados.porEquipamento.where((e) =>
          (!porCategoria || _categoriasSel.isEmpty || _categoriasSel.contains(e.categoria)) &&
          (!porEquipamento || _equipamentosSel.isEmpty || _equipamentosSel.contains(e.nome)) &&
          (!porStatus || _statusPassa(dados, e.pesquisaId)));

  Map<String, int> _somarCategorias(List<_Equipamento> equipamentos) {
    final soma = {'A': 0, 'B': 0, 'C': 0};
    for (final e in equipamentos) {
      soma[e.categoria] = (soma[e.categoria] ?? 0) + e.quantidade;
    }
    return soma;
  }

  List<_Ponto> _pontosFiltrados(_Dados dados) => dados.pontos
      .where((p) =>
          (_categoriasSel.isEmpty || _categoriasSel.contains(p.categoria)) &&
          (_equipamentosSel.isEmpty || _equipamentosSel.contains(p.equipamento)) &&
          _statusPassa(dados, p.pesquisaId))
      .toList();

  void _selecionarCategoria(String categoria) {
    setState(() {
      alternar(_categoriasSel, categoria);
      // A lista de equipamentos muda com a categoria: volta para a primeira página
      _paginaEquipamentos = 0;
      // Equipamentos de categorias fora do filtro deixam de aparecer no gráfico de barras; remove-os da seleção
      if (_categoriasSel.isNotEmpty) {
        final categoriaDe = {for (final e in _dados?.porEquipamento ?? <_Equipamento>[]) e.nome: e.categoria};
        _equipamentosSel.removeWhere((nome) => !_categoriasSel.contains(categoriaDe[nome]));
      }
    });
    _enquadrarFiltro();
  }

  void _selecionarStatus(String status) {
    setState(() {
      alternar(_statusSel, status);
      _paginaEquipamentos = 0;
    });
    _enquadrarFiltro();
  }

  void _selecionarEquipamento(String nome) {
    setState(() => alternar(_equipamentosSel, nome));
    _enquadrarFiltro();
  }

  void _limparFiltros() {
    setState(limparFiltrosCruzados);
    _enquadrarFiltro();
  }

  /// Leva o mapa até os equipamentos filtrados (ou de volta ao Brasil sem filtro).
  void _enquadrarFiltro() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dados = _dados;
      if (!mounted || dados == null) return;
      try {
        final pontos = _pontosFiltrados(dados);
        if (!_temFiltro || pontos.isEmpty) {
          _voltarParaBrasil();
          return;
        }
        final destino = CameraFit.coordinates(
          coordinates: pontos.map((p) => p.posicao).toList(),
          padding: const EdgeInsets.all(48),
          maxZoom: 15,
        ).fit(_mapController.camera);
        _voarPara(destino.center, destino.zoom);
      } catch (_) {
        // Mapa ainda não exibido (sem coordenadas): nada a enquadrar
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return construirPainel(
      filtros: [
        for (final c in (_categoriasSel.toList()..sort()))
          (rotulo: 'Categoria $c', remover: () => _selecionarCategoria(c)),
        for (final nome in _equipamentosSel) (rotulo: nome, remover: () => _selecionarEquipamento(nome)),
        for (final status in _statusSel) (rotulo: 'Status: $status', remover: () => _selecionarStatus(status)),
      ],
      onLimparFiltros: _limparFiltros,
      conteudo: (largura) {
        final dados = _dados!;
        final desktop = largura >= larguraDesktopPainel;
        return [
          _indicadores(dados, largura),
          const SizedBox(height: 12),
          _statusPesquisas(dados),
          const SizedBox(height: 16),
          if (desktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(children: [
                    SizedBox(height: 340, child: _graficoCategorias(dados)),
                    const SizedBox(height: 16),
                    SizedBox(height: 420, child: _rankingEquipamentos(dados, alturaFixa: true)),
                  ]),
                ),
                const SizedBox(width: 16),
                Expanded(child: SizedBox(height: 776, child: _mapa(dados))),
              ],
            )
          else ...[
            SizedBox(height: 300, child: _graficoCategorias(dados)),
            const SizedBox(height: 16),
            _rankingEquipamentos(dados, alturaFixa: false),
            const SizedBox(height: 16),
            SizedBox(height: 360, child: _mapa(dados)),
          ],
        ];
      },
    );
  }

  Widget _indicadores(_Dados dados, double largura) {
    final filtrados = _equipamentosFiltrados(dados);
    final porCategoria = _somarCategorias(filtrados);
    // Mesmos ícones do "Meu Painel" do pesquisador
    const icones = {
      'A': Icons.account_balance_outlined,
      'B': Icons.storefront_outlined,
      'C': Icons.park_outlined,
    };
    final itens = <(String, int, String?, IconData)>[
      ('Total Equipamentos', filtrados.fold(0, (soma, e) => soma + e.quantidade), null, Icons.place_outlined),
      for (final c in ['A', 'B', 'C']) ('Total Categoria $c', porCategoria[c] ?? 0, c, icones[c]!),
    ];
    // 4 cartões: uma linha a partir de tablet, 2×2 no celular
    final colunas = largura >= 560 ? 4 : 2;
    const espaco = 12.0;
    final larguraCartao = (largura - 32 - espaco * (colunas - 1)) / colunas;

    return Wrap(
      spacing: espaco,
      runSpacing: espaco,
      children: itens
          .map((item) => SizedBox(
                width: larguraCartao,
                child: PainelSelecionavel(
                  destaque: item.$3 == null ? null : destaqueDe(_categoriasSel, item.$3!),
                  dica: item.$3 == null ? null : 'Filtrar pela Categoria ${item.$3}',
                  onTap: item.$3 == null ? null : () => _selecionarCategoria(item.$3!),
                  child: PainelIndicador(
                    titulo: item.$1,
                    valor: item.$2,
                    icone: item.$4,
                    selecionado: _categoriasSel.contains(item.$3),
                  ),
                ),
              ))
          .toList(),
    );
  }

  /// Distribuição das pesquisas por status (barra empilhada + legenda), clicável como filtro cruzado.
  /// Sem filtros de categoria/equipamento conta todas as pesquisas; com eles, só as que têm equipamentos
  /// que passam por esses filtros (como o Power BI faz).
  Widget _statusPesquisas(_Dados dados) {
    const cores = {
      'Não Iniciado': Color(0xFF9E9E9E),
      'Em Andamento': Color(0xFF4C9A52),
      'Concluído': Color(0xFF376F3C),
    };
    var pesquisasNoEscopo = dados.statusDe.keys.where((id) => pesquisaSelecionada == null || id == pesquisaSelecionada);
    if (_categoriasSel.isNotEmpty || _equipamentosSel.isNotEmpty) {
      final comEquipamento = _linhasFiltradas(dados, porStatus: false).map((e) => e.pesquisaId).toSet();
      pesquisasNoEscopo = pesquisasNoEscopo.where(comEquipamento.contains);
    }
    final porStatus = {for (final status in cores.keys) status: 0};
    for (final id in pesquisasNoEscopo) {
      final status = dados.statusDe[id];
      if (porStatus.containsKey(status)) porStatus[status!] = porStatus[status]! + 1;
    }
    final total = porStatus.values.fold(0, (a, b) => a + b);
    Color corDe(String status) =>
        destaqueDe(_statusSel, status) == false ? cores[status]!.withValues(alpha: 0.3) : cores[status]!;

    return PainelCartao(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('Status das Pesquisas', style: TextStyle(color: _verde, fontSize: 15, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        if (total == 0)
          Text('Nenhuma pesquisa neste filtro.', style: TextStyle(color: Colors.grey[700]))
        else ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 18,
              child: Row(children: [
                for (final status in cores.keys)
                  if (porStatus[status]! > 0)
                    Expanded(
                      flex: porStatus[status]!,
                      child: Tooltip(
                        message: '$status: ${porStatus[status]} — toque para filtrar',
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => _selecionarStatus(status),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: corDe(status),
                                border: _statusSel.contains(status)
                                    ? Border.all(color: const Color(0xFF1B3D1F), width: 2)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              ]),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(spacing: 16, runSpacing: 4, children: [
            for (final status in cores.keys)
              PainelSelecionavel(
                destaque: destaqueDe(_statusSel, status),
                dica: 'Filtrar por pesquisas "$status"',
                onTap: () => _selecionarStatus(status),
                child: PainelLegenda(
                  cor: cores[status]!,
                  texto: '$status · ${porStatus[status]} (${(porStatus[status]! * 100 / total).round()}%)',
                ),
              ),
          ]),
        ],
      ]),
    );
  }

  Widget _graficoCategorias(_Dados dados) {
    final porCategoria = _somarCategorias(_equipamentosFiltrados(dados, porCategoria: false));
    final categorias = ['A', 'B', 'C'].where((c) => (porCategoria[c] ?? 0) > 0).toList();
    final total = porCategoria.values.fold(0, (a, b) => a + b);

    // A legenda sempre traz os números ("A · 16 (52%)"), então os rótulos ao redor da rosca são opcionais
    Widget legenda(String c) {
      final qtd = porCategoria[c] ?? 0;
      final pct = total == 0 ? 0 : (qtd * 100 / total).round();
      return PainelSelecionavel(
        destaque: destaqueDe(_categoriasSel, c),
        onTap: () => _selecionarCategoria(c),
        child: PainelLegenda(cor: _coresCategoria[c]!, texto: '$c · $qtd ($pct%)'),
      );
    }

    Widget rosca({required double raio, required bool comRotulos}) => PieChart(PieChartData(
          startDegreeOffset: -90,
          centerSpaceRadius: raio * 0.55,
          sectionsSpace: 0,
          pieTouchData: PieTouchData(
            mouseCursorResolver: (_, resposta) =>
                resposta?.touchedSection?.touchedSection == null ? MouseCursor.defer : SystemMouseCursors.click,
            touchCallback: (evento, resposta) {
              final indice = resposta?.touchedSection?.touchedSectionIndex ?? -1;
              if (evento is FlTapUpEvent && indice >= 0 && indice < categorias.length) {
                _selecionarCategoria(categorias[indice]);
              }
            },
          ),
          sections: categorias.map((c) {
            final apagada = destaqueDe(_categoriasSel, c) == false;
            final espessura = raio * 0.45;
            return PieChartSectionData(
              value: porCategoria[c]!.toDouble(),
              color: apagada ? _coresCategoria[c]!.withValues(alpha: 0.25) : _coresCategoria[c],
              radius: _categoriasSel.contains(c) ? espessura + 6 : espessura,
              showTitle: comRotulos,
              title: '$c ${porCategoria[c]}',
              titlePositionPercentageOffset: 1.5,
              titleStyle: TextStyle(color: Colors.grey[800], fontSize: 13),
            );
          }).toList(),
        ));

    return PainelCartao(
      titulo: 'Total de Equipamentos por Categoria',
      child: categorias.isEmpty
          ? const PainelVazio()
          : LayoutBuilder(builder: (context, constraints) {
              // Estreito: sem rótulos externos (eles se sobrepõem) e legenda embaixo, ocupando a largura toda
              if (constraints.maxWidth < 440) {
                const alturaLegenda = 30.0;
                final raio = math.min(constraints.maxWidth, constraints.maxHeight - alturaLegenda) / 2 - 8;
                return Column(children: [
                  Expanded(child: rosca(raio: raio, comRotulos: false)),
                  Wrap(spacing: 16, alignment: WrapAlignment.center, children: categorias.map(legenda).toList()),
                ]);
              }
              const larguraLegenda = 140.0;
              // Reserva espaço em volta para os rótulos "A 16" fora da rosca
              final raio = math.min(constraints.maxWidth - larguraLegenda, constraints.maxHeight) / 2 - 30;
              return Row(children: [
                Expanded(child: rosca(raio: raio, comRotulos: true)),
                SizedBox(
                  width: larguraLegenda,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Categoria', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800])),
                      const SizedBox(height: 4),
                      ...categorias.map(legenda),
                    ],
                  ),
                ),
              ]);
            }),
    );
  }

  Widget _rankingEquipamentos(_Dados dados, {required bool alturaFixa}) {
    final itens = _equipamentosFiltrados(dados, porEquipamento: false);
    if (itens.isEmpty) {
      return const PainelCartao(
          titulo: 'Equipamentos Inventariados', child: SizedBox(height: 80, child: PainelVazio()));
    }
    // Escala única para todas as páginas, para as barras continuarem comparáveis entre si
    final maximo = itens.map((e) => e.quantidade).reduce((a, b) => a > b ? a : b);
    final paginacao = Paginacao(itens.length, _paginaEquipamentos);

    final linhas = Column(
      children: paginacao
          .fatia(itens)
          .map((e) => PainelSelecionavel(
                destaque: destaqueDe(_equipamentosSel, e.nome),
                onTap: () => _selecionarEquipamento(e.nome),
                child: PainelBarraHorizontal(rotulo: e.nome, valor: e.quantidade, maximo: maximo),
              ))
          .toList(),
    );

    return PainelCartao(
      titulo: 'Equipamentos Inventariados',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          linhas,
          if (alturaFixa) const Spacer() else const SizedBox(height: 6),
          Text('Quantidade',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey[800])),
          PainelPaginacao(
            paginacao: paginacao,
            onPagina: (pagina) => setState(() => _paginaEquipamentos = pagina),
          ),
        ],
      ),
    );
  }

  Widget _mapa(_Dados dados) {
    final pontos = _pontosFiltrados(dados);
    return PainelCartao(
      titulo: 'Localização dos Equipamentos',
      child: dados.pontos.isEmpty
          ? const PainelVazio(mensagem: 'Nenhum equipamento com coordenadas registradas.')
          : Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCameraFit: CameraFit.bounds(bounds: _brasil, padding: const EdgeInsets.all(8)),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                          additionalOptions: const {'accessToken': accessToken, 'id': 'mapbox/streets-v11'},
                          userAgentPackageName: 'br.com.murilo.gps',
                        ),
                        MarkerLayer(
                          markers: pontos
                              .map((p) => Marker(
                                    point: p.posicao,
                                    width: 32,
                                    height: 32,
                                    alignment: Alignment.topCenter,
                                    child: Tooltip(
                                      message: '${p.equipamento} (Categoria ${p.categoria})',
                                      child: MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: GestureDetector(
                                          onTap: () => _voarPara(p.posicao, _zoomLocal),
                                          child: Icon(Icons.location_on,
                                              color: _coresCategoria[p.categoria] ?? _verde, size: 32),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Wrap(
                        spacing: 16,
                        children: [
                          for (final c in ['A', 'B', 'C'])
                            PainelLegenda(cor: _coresCategoria[c]!, texto: 'Categoria $c'),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(foregroundColor: _verde),
                      onPressed: _voltarParaBrasil,
                      icon: const Icon(Icons.public, size: 18),
                      label: const Text('Ver Brasil'),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
