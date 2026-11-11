import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:sistur/services/secure_storage_service.dart';
import 'package:sistur/services/sync_service.dart';
import 'package:sistur/ui/forms/abrir_formulario.dart';
import 'package:sistur/ui/home/Administrador/widgets/painel_comum.dart';
import 'package:sistur/ui/widgets/maps/map.dart' show accessToken;

const _verde = verdePainel;
const _fundo = Color.fromARGB(255, 245, 245, 245);
const _vermelho = Color(0xFFC62828);
const _ambar = Color(0xFFB26A00);
const _cinza = Color(0xFF616161);
const _coresCategoria = {
  'A': Color(0xFF376F3C),
  'B': Color(0xFF6FBF73),
  'C': Color(0xFFC9A227),
};
const _nomesCategoria = {
  'A': 'Infraestrutura de apoio',
  'B': 'Serviços e equipamentos',
  'C': 'Atrativos turísticos',
};
const _situacoes = {
  'no_prazo': ('No prazo', _verde),
  'atencao': ('Prazo acabando', _ambar),
  'atrasada': ('Atrasada', _vermelho),
  'inicio_atrasado': ('Início atrasado', _vermelho),
  'agendada': ('Agendada', _cinza),
  'concluida': ('Concluída', Color(0xFF2E7D32)),
};
const _problemas = {'sem_coordenadas': 'Sem coordenadas', 'sem_nome': 'Sem nome'};
const _zoomLocal = 17.0;

class _Pesquisa {
  final int id;
  final String municipio, estado, status, situacao;
  final DateTime? inicio, termino;
  final double progresso;
  final int totalEquipe;

  _Pesquisa.fromJson(Map<String, dynamic> j)
      : id = j['id'],
        municipio = j['municipio'] ?? '',
        estado = j['estado'] ?? '',
        status = j['status'] ?? '',
        situacao = j['situacao'] ?? '',
        inicio = DateTime.tryParse(j['dataInicio'] ?? ''),
        termino = DateTime.tryParse(j['dataTermino'] ?? ''),
        progresso = (j['progresso_prazo'] as num?)?.toDouble() ?? 0,
        totalEquipe = (j['total_equipe'] as num?)?.toInt() ?? 0;

  String get nome => '$municipio - $estado';

  /// Dias até o fim do prazo, pela data do aparelho (continua correto com dados em cache).
  int? get diasRestantes => termino?.difference(DateUtils.dateOnly(DateTime.now())).inDays;
}

class _Equipamento {
  final int id;
  final String tipo;
  final String categoria;
  final int? pesquisaId;
  final String municipio;
  final DateTime? criacao;
  final double? latitude;
  final double? longitude;
  final List<String> problemas;

  _Equipamento.fromJson(Map<String, dynamic> json)
      : id = (json['id'] as num?)?.toInt() ?? 0,
        tipo = json['tipo'] ?? 'Outros',
        categoria = json['categoria'] ?? '',
        pesquisaId = json['pesquisa_id'],
        municipio = json['municipio'] ?? '',
        criacao = DateTime.tryParse(json['criacao'] ?? '')?.toLocal(),
        latitude = (json['latitude'] as num?)?.toDouble(),
        longitude = (json['longitude'] as num?)?.toDouble(),
        problemas = List<String>.from(json['problemas'] ?? []);

  DateTime? get dia => criacao == null ? null : DateUtils.dateOnly(criacao!);
  DateTime? get mes => criacao == null ? null : DateTime(criacao!.year, criacao!.month);
  LatLng? get posicao => latitude == null || longitude == null ? null : LatLng(latitude!, longitude!);
}

/// Dimensões de filtro cruzado: cada gráfico ignora a própria ao calcular o que exibe
/// (para continuar mostrando as demais opções, com a selecionada em destaque).
enum _Filtro { pesquisa, categoria, tipo, dia, mes, recentes, pendencias }

/// "Meu Painel" do pesquisador: prazos das suas pesquisas, seu ritmo de cadastros, a cobertura do inventário
/// e os formulários que precisam de correção. Todos os gráficos filtram uns aos outros (filtros cumulativos).
/// Funciona offline com a última resposta recebida.
class PainelPesquisador extends StatefulWidget {
  const PainelPesquisador({super.key});

  @override
  State<PainelPesquisador> createState() => _PainelPesquisadorState();
}

class _PainelPesquisadorState extends State<PainelPesquisador> with SingleTickerProviderStateMixin {
  static const _cacheKey = 'painel_pesquisador_cache';

  final _mapController = MapController();
  // Criado no initState: criá-lo sob demanda dentro do dispose quebraria (elemento já desativado)
  late final AnimationController _animacaoMapa;

  bool _carregando = true;
  bool _offline = false;
  DateTime? _atualizadoEm;
  List<_Pesquisa> _pesquisas = [];
  List<_Equipamento> _equipamentos = [];
  List<({String nome, String categoria})> _tipos = [];
  int _pendentesEnvio = 0;
  int _paginaPendencias = 0;

  // Filtros cruzados cumulativos: valores do mesmo gráfico somam (OU); gráficos diferentes se combinam (E)
  final Set<int> _pesquisasSel = {};
  final Set<String> _categoriasSel = {};
  final Set<String> _tiposSel = {};
  final Set<DateTime> _diasSel = {};
  final Set<DateTime> _mesesSel = {};
  bool _somenteRecentes = false;
  bool _somentePendencias = false;

  @override
  void initState() {
    super.initState();
    _animacaoMapa = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _carregar();
  }

  @override
  void dispose() {
    _animacaoMapa.dispose();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _carregar() async {
    final storage = SecureStorageService();
    Map<String, dynamic>? dados;
    bool offline = false;
    try {
      final response = await ApiService().get('pesquisador/dashboard/');
      if (response.statusCode == 200) {
        dados = Map<String, dynamic>.from(response.data);
        await storage.write(_cacheKey, json.encode(dados));
      }
    } catch (e) {
      debugPrint('Erro ao carregar painel: $e');
    }
    if (dados == null) {
      // Sem conexão: usa os últimos dados recebidos
      offline = true;
      final cache = await storage.read(_cacheKey);
      if (cache != null) dados = json.decode(cache);
    }
    int pendentes = 0;
    try {
      pendentes = await DataSyncService().getPendingCount();
    } catch (_) {}

    if (!mounted) return;
    setState(() {
      _offline = offline;
      _pendentesEnvio = pendentes;
      _atualizadoEm = DateTime.tryParse(dados?['atualizado_em'] ?? '')?.toLocal();
      _pesquisas = List<Map<String, dynamic>>.from(dados?['pesquisas'] ?? []).map(_Pesquisa.fromJson).toList();
      _equipamentos = List<Map<String, dynamic>>.from(dados?['equipamentos'] ?? []).map(_Equipamento.fromJson).toList();
      _tipos = [
        for (final t in List<Map<String, dynamic>>.from(dados?['tipos'] ?? []))
          (nome: t['nome'] as String, categoria: t['categoria'] as String),
      ];
      _pesquisasSel.removeWhere((id) => !_pesquisas.any((p) => p.id == id));
      _carregando = false;
    });
  }

  // ---------- filtros cruzados ----------

  bool get _temFiltro =>
      _pesquisasSel.isNotEmpty ||
      _categoriasSel.isNotEmpty ||
      _tiposSel.isNotEmpty ||
      _diasSel.isNotEmpty ||
      _mesesSel.isNotEmpty ||
      _somenteRecentes ||
      _somentePendencias;

  bool _passa(_Equipamento e, {_Filtro? ignorar}) {
    final limiteRecentes = DateTime.now().subtract(const Duration(days: 7));
    return (ignorar == _Filtro.pesquisa || _pesquisasSel.isEmpty || _pesquisasSel.contains(e.pesquisaId)) &&
        (ignorar == _Filtro.categoria || _categoriasSel.isEmpty || _categoriasSel.contains(e.categoria)) &&
        (ignorar == _Filtro.tipo || _tiposSel.isEmpty || _tiposSel.contains(e.tipo)) &&
        (ignorar == _Filtro.dia || _diasSel.isEmpty || _diasSel.contains(e.dia)) &&
        (ignorar == _Filtro.mes || _mesesSel.isEmpty || _mesesSel.contains(e.mes)) &&
        (ignorar == _Filtro.recentes || !_somenteRecentes || (e.criacao?.isAfter(limiteRecentes) ?? false)) &&
        (ignorar == _Filtro.pendencias || !_somentePendencias || e.problemas.isNotEmpty);
  }

  List<_Equipamento> _filtrados({_Filtro? ignorar}) => _equipamentos.where((e) => _passa(e, ignorar: ignorar)).toList();

  /// Aplica uma mudança de filtro, volta a lista de pendências para a 1ª página e reenquadra o mapa.
  void _filtrar(VoidCallback mudanca) {
    setState(() {
      mudanca();
      _paginaPendencias = 0;
    });
    _enquadrarMapa();
  }

  void _limparFiltros() => _filtrar(() {
        _pesquisasSel.clear();
        _categoriasSel.clear();
        _tiposSel.clear();
        _diasSel.clear();
        _mesesSel.clear();
        _somenteRecentes = false;
        _somentePendencias = false;
      });

  List<FiltroAtivo> get _filtrosAtivos {
    final nomePesquisa = {for (final p in _pesquisas) p.id: p.municipio};
    final formatoDia = DateFormat('dd/MM');
    return [
      for (final id in _pesquisasSel)
        (rotulo: nomePesquisa[id] ?? 'Pesquisa', remover: () => _filtrar(() => _pesquisasSel.remove(id))),
      for (final c in (_categoriasSel.toList()..sort()))
        (rotulo: 'Categoria $c', remover: () => _filtrar(() => _categoriasSel.remove(c))),
      for (final t in _tiposSel) (rotulo: t, remover: () => _filtrar(() => _tiposSel.remove(t))),
      for (final d in (_diasSel.toList()..sort()))
        (rotulo: 'Dia ${formatoDia.format(d)}', remover: () => _filtrar(() => _diasSel.remove(d))),
      for (final m in (_mesesSel.toList()..sort()))
        (
          rotulo: '${mesesAbreviados[m.month - 1]}/${m.year}',
          remover: () => _filtrar(() => _mesesSel.remove(m)),
        ),
      if (_somenteRecentes) (rotulo: 'Últimos 7 dias', remover: () => _filtrar(() => _somenteRecentes = false)),
      if (_somentePendencias) (rotulo: 'Com pendências', remover: () => _filtrar(() => _somentePendencias = false)),
    ];
  }

  // ---------- mapa ----------

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

  /// Leva o mapa até os equipamentos filtrados.
  void _enquadrarMapa() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final pontos = _filtrados().map((e) => e.posicao).whereType<LatLng>().toList();
      if (pontos.isEmpty) return;
      try {
        final destino = CameraFit.coordinates(coordinates: pontos, padding: const EdgeInsets.all(40), maxZoom: 15)
            .fit(_mapController.camera);
        _voarPara(destino.center, destino.zoom);
      } catch (_) {
        // Mapa ainda não exibido
      }
    });
  }

  // ---------- utilidades ----------

  Map<K, int> _contar<K>(Iterable<K?> chaves) {
    final contagem = <K, int>{};
    for (final chave in chaves) {
      if (chave != null) contagem[chave] = (contagem[chave] ?? 0) + 1;
    }
    return contagem;
  }

  String _haDias(DateTime? data) {
    if (data == null) return 'nenhum cadastro ainda';
    final dias = DateUtils.dateOnly(DateTime.now()).difference(DateUtils.dateOnly(data)).inDays;
    return switch (dias) { <= 0 => 'hoje', 1 => 'ontem', _ => 'há $dias dias' };
  }

  Color _corDestaque(Color cor, bool? destaque) => destaque == false ? cor.withValues(alpha: 0.3) : cor;

  Widget _selo(String texto, Color cor) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(color: cor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
        child: Text(texto, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: cor)),
      );

  // ---------- tela ----------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _fundo,
      appBar: AppBar(
        foregroundColor: _verde,
        backgroundColor: Colors.white,
        title: const Text('Meu Painel', style: TextStyle(color: _verde)),
        centerTitle: true,
      ),
      // SafeArea: o ListView tem padding próprio, então não recua sozinho da barra de navegação/gestos
      // do sistema nem do notch; sem isso o mapa (último bloco) ficava por baixo deles. O topo já é da AppBar.
      body: SafeArea(
        top: false,
        child: _carregando
            ? const Center(child: CircularProgressIndicator(color: _verde))
            : RefreshIndicator(
                color: _verde,
                onRefresh: _carregar,
                child: LayoutBuilder(builder: (context, constraints) {
                  final largura = constraints.maxWidth;
                  final desktop = largura >= larguraDesktopPainel;
                  Widget par(Widget a, Widget b) => desktop
                      ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Expanded(child: a),
                          const SizedBox(width: 16),
                          Expanded(child: b),
                        ])
                      : Column(children: [a, const SizedBox(height: 16), b]);

                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (_offline) _avisoOffline(),
                      _cabecalho(),
                      const SizedBox(height: 12),
                      _indicadores(largura),
                      const SizedBox(height: 16),
                      if (_pesquisas.isEmpty)
                        const PainelCartao(
                          titulo: 'Nenhuma pesquisa',
                          child: Text('Quando você for adicionado a uma pesquisa, ela aparecerá aqui.'),
                        )
                      else ...[
                        par(_minhasPesquisas(), _meuRitmo()),
                        const SizedBox(height: 16),
                        par(_cobertura(), _pendencias()),
                        if (_equipamentos.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          par(SizedBox(height: 300, child: _graficoCategorias()),
                              SizedBox(height: 300, child: _mapa())),
                        ],
                      ],
                    ],
                  );
                }),
              ),
      ),
    );
  }

  Widget _avisoOffline() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.amber[100], borderRadius: BorderRadius.circular(10)),
      child: const Row(children: [
        Icon(Icons.cloud_off, color: Colors.brown),
        SizedBox(width: 8),
        Expanded(child: Text('Sem conexão. Exibindo os últimos dados sincronizados.')),
      ]),
    );
  }

  Widget _cabecalho() {
    final horario = _atualizadoEm == null ? null : DateFormat('dd/MM HH:mm').format(_atualizadoEm!);
    final filtros = _filtrosAtivos;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _verde.withValues(alpha: 0.3)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int?>(
            isExpanded: true,
            value: _pesquisasSel.length == 1 ? _pesquisasSel.first : null,
            icon: const Icon(Icons.filter_list, color: _verde),
            items: [
              DropdownMenuItem(
                value: null,
                child: Text(_pesquisasSel.length > 1
                    ? '${_pesquisasSel.length} pesquisas selecionadas'
                    : 'Todas as minhas pesquisas'),
              ),
              ..._pesquisas.map((p) => DropdownMenuItem(
                    value: p.id,
                    child: Text(p.nome, overflow: TextOverflow.ellipsis),
                  )),
            ],
            onChanged: (id) => _filtrar(() {
              _pesquisasSel.clear();
              if (id != null) _pesquisasSel.add(id);
            }),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 12,
        runSpacing: 8,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (filtros.isNotEmpty) PainelFiltrosAtivos(filtros: filtros, onLimpar: _limparFiltros),
          if (horario != null) Text('Atualizado em $horario', style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        ],
      ),
    ]);
  }

  Widget _indicadores(double largura) {
    final total = _filtrados().length;
    final recentes = _filtrados(ignorar: _Filtro.recentes)
        .where((e) => e.criacao?.isAfter(DateTime.now().subtract(const Duration(days: 7))) ?? false)
        .length;
    final comPendencias = _filtrados(ignorar: _Filtro.pendencias).where((e) => e.problemas.isNotEmpty).length;
    final itens = <(String, int, IconData, bool, VoidCallback?, String?)>[
      ('Equipamentos', total, Icons.place_outlined, false, null, null),
      (
        'Últimos 7 dias',
        recentes,
        Icons.trending_up,
        _somenteRecentes,
        () => _filtrar(() => _somenteRecentes = !_somenteRecentes),
        'Mostrar só os cadastros dos últimos 7 dias',
      ),
      (
        'Com pendências',
        comPendencias,
        Icons.report_problem_outlined,
        _somentePendencias,
        () => _filtrar(() => _somentePendencias = !_somentePendencias),
        'Mostrar só formulários com pendências',
      ),
      (
        'Aguardando envio',
        _pendentesEnvio,
        Icons.sync_problem_outlined,
        false,
        () => Navigator.pushNamed(context, '/SyncPage').then((_) => _carregar()),
        'Abrir a sincronização',
      ),
    ];
    final colunas = largura >= 560 ? 4 : 2;
    const espaco = 12.0;
    final larguraCartao = (largura - 32 - espaco * (colunas - 1)) / colunas;
    final algumSelecionado = _somenteRecentes || _somentePendencias;
    return Wrap(spacing: espaco, runSpacing: espaco, children: [
      for (final item in itens)
        SizedBox(
          width: larguraCartao,
          child: PainelSelecionavel(
            destaque: algumSelecionado && item.$5 != null && item.$1 != 'Aguardando envio' ? item.$4 : null,
            dica: item.$6,
            onTap: item.$5,
            child: PainelIndicador(titulo: item.$1, valor: item.$2, icone: item.$3, selecionado: item.$4),
          ),
        ),
    ]);
  }

  /// Prazo de cada pesquisa e quanto o pesquisador contribuiu (com os demais filtros aplicados).
  Widget _minhasPesquisas() {
    final porPesquisa = _contar(_filtrados(ignorar: _Filtro.pesquisa).map((e) => e.pesquisaId));
    final formato = DateFormat('dd/MM/yyyy');
    return PainelCartao(
      titulo: 'Minhas Pesquisas',
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        for (final p in _pesquisas)
          PainelSelecionavel(
            destaque: destaqueDe(_pesquisasSel, p.id),
            dica: 'Filtrar por ${p.municipio}',
            onTap: () => _filtrar(() => alternar(_pesquisasSel, p.id)),
            child: _linhaPesquisa(p, porPesquisa[p.id] ?? 0, formato),
          ),
      ]),
    );
  }

  Widget _linhaPesquisa(_Pesquisa p, int meus, DateFormat formato) {
    final (rotulo, cor) = _situacoes[p.situacao] ?? (p.status, _cinza);
    final dias = p.diasRestantes;
    final prazo = switch (dias) {
      _ when p.situacao == 'concluida' => 'concluída',
      null => '',
      < 0 => 'venceu há ${-dias} dias',
      0 => 'vence hoje',
      _ => 'faltam $dias dias',
    };
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: _pesquisasSel.contains(p.id) ? _verde.withValues(alpha: 0.06) : null,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Expanded(
            child: Text(p.nome,
                overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ),
          _selo(rotulo, cor),
        ]),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
              value: p.progresso, minHeight: 8, color: cor, backgroundColor: cor.withValues(alpha: 0.12)),
        ),
        const SizedBox(height: 4),
        Wrap(spacing: 12, runSpacing: 2, children: [
          if (p.termino != null)
            Text('Prazo: ${formato.format(p.termino!)} ($prazo)',
                style: TextStyle(fontSize: 12, color: Colors.grey[700])),
          Text('Você: $meus · Equipe: ${p.totalEquipe} formulários',
              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
        ]),
      ]),
    );
  }

  /// Cadastros dos últimos 14 dias (barras) e dos últimos 6 meses (linha); tocar filtra pelo dia/mês.
  Widget _meuRitmo() {
    final ultimo = _filtrados()
        .map((e) => e.criacao)
        .whereType<DateTime>()
        .fold<DateTime?>(null, (a, b) => a == null || b.isAfter(a) ? b : a);

    final hoje = DateUtils.dateOnly(DateTime.now());
    final dias = List.generate(14, (i) => hoje.subtract(Duration(days: 13 - i)));
    final porDia = _contar(_filtrados(ignorar: _Filtro.dia).map((e) => e.dia));
    final valoresDia = dias.map((d) => (porDia[d] ?? 0).toDouble()).toList();

    final agora = DateTime.now();
    final meses = List.generate(6, (i) => DateTime(agora.year, agora.month - 5 + i));
    final porMes = _contar(_filtrados(ignorar: _Filtro.mes).map((e) => e.mes));
    final valoresMes = meses.map((m) => (porMes[m] ?? 0).toDouble()).toList();
    final formato = DateFormat('dd/MM');

    return PainelCartao(
      titulo: 'Meu Ritmo',
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          Icon(Icons.schedule, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Expanded(
            child: Text('Último cadastro: ${_haDias(ultimo)}', style: TextStyle(fontSize: 13, color: Colors.grey[800])),
          ),
        ]),
        const SizedBox(height: 12),
        Text('Últimos 14 dias · toque numa barra para filtrar',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[800])),
        const SizedBox(height: 4),
        SizedBox(
          height: 150,
          child: BarChart(BarChartData(
            maxY: _tetoEixo(valoresDia),
            gridData: const FlGridData(drawVerticalLine: false),
            borderData: FlBorderData(show: false),
            barTouchData: BarTouchData(
              mouseCursorResolver: (_, r) => r?.spot == null ? MouseCursor.defer : SystemMouseCursors.click,
              touchCallback: (evento, resposta) {
                final spot = resposta?.spot;
                if (evento is FlTapUpEvent && spot != null) {
                  _filtrar(() => alternar(_diasSel, dias[spot.touchedBarGroupIndex]));
                }
              },
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (_) => Colors.black87,
                getTooltipItem: (group, _, rod, __) => BarTooltipItem(
                  '${formato.format(dias[group.x])}\n${rod.toY.toInt()}',
                  const TextStyle(color: Colors.white),
                ),
              ),
            ),
            titlesData: _titulos((i) => i % 3 == 1 ? formato.format(dias[i]) : ''),
            barGroups: [
              for (var i = 0; i < dias.length; i++)
                BarChartGroupData(x: i, barRods: [
                  BarChartRodData(
                    toY: valoresDia[i],
                    color: _corDestaque(_verde, destaqueDe(_diasSel, dias[i])),
                    width: 10,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
                  ),
                ]),
            ],
          )),
        ),
        const SizedBox(height: 12),
        Text('Últimos 6 meses · toque num ponto para filtrar',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[800])),
        const SizedBox(height: 4),
        SizedBox(
          height: 150,
          child: LineChart(LineChartData(
            minY: 0,
            maxY: _tetoEixo(valoresMes),
            gridData: const FlGridData(drawVerticalLine: false),
            borderData: FlBorderData(show: false),
            lineTouchData: LineTouchData(
              mouseCursorResolver: (_, r) =>
                  (r?.lineBarSpots?.isNotEmpty ?? false) ? SystemMouseCursors.click : MouseCursor.defer,
              touchCallback: (evento, resposta) {
                final pontos = resposta?.lineBarSpots;
                if (evento is FlTapUpEvent && pontos != null && pontos.isNotEmpty) {
                  _filtrar(() => alternar(_mesesSel, meses[pontos.first.x.toInt()]));
                }
              },
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (_) => Colors.black87,
                getTooltipItems: (pontos) => pontos
                    .map((p) => LineTooltipItem(
                        '${mesesAbreviados[meses[p.x.toInt()].month - 1]}/${meses[p.x.toInt()].year}\n${p.y.toInt()}',
                        const TextStyle(color: Colors.white)))
                    .toList(),
              ),
            ),
            titlesData: _titulos((i) => mesesAbreviados[meses[i].month - 1]),
            lineBarsData: [
              LineChartBarData(
                spots: [for (var i = 0; i < valoresMes.length; i++) FlSpot(i.toDouble(), valoresMes[i])],
                color: _verde,
                barWidth: 3,
                belowBarData: BarAreaData(show: true, color: _verde.withValues(alpha: 0.15)),
                dotData: FlDotData(
                  getDotPainter: (spot, _, __, i) {
                    final destaque = destaqueDe(_mesesSel, meses[i]);
                    return FlDotCirclePainter(
                      radius: destaque == true ? 7 : 4,
                      color: _corDestaque(_verde, destaque),
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  },
                ),
              ),
            ],
          )),
        ),
      ]),
    );
  }

  double _tetoEixo(List<double> valores) {
    final maximo = valores.fold<double>(0, (a, b) => a > b ? a : b);
    return maximo < 4 ? 4 : (maximo * 1.2).ceilToDouble();
  }

  FlTitlesData _titulos(String Function(int) rotulo) {
    const semTitulos = AxisTitles(sideTitles: SideTitles(showTitles: false));
    return FlTitlesData(
      topTitles: semTitulos,
      rightTitles: semTitulos,
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          getTitlesWidget: (valor, meta) => valor % 1 == 0 && valor != meta.max
              ? Text(valor.toInt().toString(), style: const TextStyle(fontSize: 11, color: Colors.grey))
              : const SizedBox.shrink(),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          reservedSize: 24,
          getTitlesWidget: (valor, meta) => Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(rotulo(valor.toInt()), style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ),
        ),
      ),
    );
  }

  /// Quais tipos de equipamento já foram inventariados (por você) e quais ainda faltam; tocar filtra pelo tipo.
  Widget _cobertura() {
    final porTipo = _contar(_filtrados(ignorar: _Filtro.tipo).map((e) => e.tipo));
    final feitos = _tipos.where((t) => (porTipo[t.nome] ?? 0) > 0).length;
    return PainelCartao(
      titulo: 'Cobertura do Inventário',
      child: _tipos.isEmpty
          ? Text('Atualize o painel com conexão para ver a cobertura.', style: TextStyle(color: Colors.grey[700]))
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Text('$feitos de ${_tipos.length} tipos de equipamento inventariados',
                  style: TextStyle(fontSize: 13, color: Colors.grey[800])),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: feitos / _tipos.length,
                  minHeight: 8,
                  color: _verde,
                  backgroundColor: _verde.withValues(alpha: 0.12),
                ),
              ),
              for (final categoria in ['A', 'B', 'C']) ...[
                const SizedBox(height: 12),
                PainelLegenda(
                    cor: _coresCategoria[categoria]!, texto: 'Categoria $categoria · ${_nomesCategoria[categoria]}'),
                const SizedBox(height: 6),
                Wrap(spacing: 6, runSpacing: 6, children: [
                  for (final t in _tipos.where((t) => t.categoria == categoria))
                    PainelSelecionavel(
                      destaque: destaqueDe(_tiposSel, t.nome),
                      dica: 'Filtrar por ${t.nome}',
                      onTap: () => _filtrar(() => alternar(_tiposSel, t.nome)),
                      child: _chipTipo(t.nome, porTipo[t.nome] ?? 0, _tiposSel.contains(t.nome)),
                    ),
                ]),
              ],
              const SizedBox(height: 8),
              Text('Tipos em cinza ainda não têm nenhum cadastro seu. Toque num tipo para filtrar.',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            ]),
    );
  }

  Widget _chipTipo(String nome, int quantidade, bool selecionado) {
    final feito = quantidade > 0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: selecionado
            ? _verde
            : feito
                ? _verde.withValues(alpha: 0.12)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: feito || selecionado ? _verde.withValues(alpha: 0.5) : Colors.grey.shade400),
      ),
      child: Text(
        feito ? '$nome · $quantidade' : nome,
        style: TextStyle(
          fontSize: 12,
          color: selecionado
              ? Colors.white
              : feito
                  ? _verde
                  : Colors.grey[600],
          fontWeight: feito || selecionado ? FontWeight.w600 : null,
        ),
      ),
    );
  }

  /// Formulários do pesquisador com dados faltando (respeitando os filtros); tocar abre o formulário.
  Widget _pendencias() {
    final pendencias = _filtrados().where((e) => e.problemas.isNotEmpty).toList()
      ..sort((a, b) => (b.criacao ?? DateTime(0)).compareTo(a.criacao ?? DateTime(0)));
    final paginacao = Paginacao(pendencias.length, _paginaPendencias);
    final formato = DateFormat('dd/MM/yyyy');
    return PainelCartao(
      titulo: 'Formulários para Corrigir',
      child: pendencias.isEmpty
          ? Row(children: [
              const Icon(Icons.check_circle_outline, color: _verde),
              const SizedBox(width: 8),
              Expanded(
                child: Text(_temFiltro ? 'Nenhuma pendência neste filtro.' : 'Nenhuma pendência. Bom trabalho!',
                    style: TextStyle(color: Colors.grey[800])),
              ),
            ])
          : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              for (final e in paginacao.fatia(pendencias))
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => _abrirFormulario(e),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(children: [
                      const Icon(Icons.warning_amber_rounded, size: 20, color: _ambar),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(e.tipo,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                          Text('${e.municipio}${e.criacao == null ? '' : ' · ${formato.format(e.criacao!)}'}',
                              style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                          const SizedBox(height: 4),
                          Wrap(spacing: 4, runSpacing: 4, children: [
                            for (final p in e.problemas) _selo(_problemas[p] ?? p, _ambar),
                          ]),
                        ]),
                      ),
                      Icon(Icons.chevron_right, color: Colors.grey[500]),
                    ]),
                  ),
                ),
              PainelPaginacao(paginacao: paginacao, onPagina: (n) => setState(() => _paginaPendencias = n)),
            ]),
    );
  }

  /// Busca o formulário completo e abre a tela de edição; ao voltar, atualiza o painel.
  Future<void> _abrirFormulario(_Equipamento equipamento) async {
    final navegador = Navigator.of(context);
    final mensagens = ScaffoldMessenger.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator(color: _verde)),
    );

    Widget? tela;
    String? falha;
    try {
      final resposta =
          await ApiService().get('equipamentos/', queryParameters: {'pesquisa_id': equipamento.pesquisaId});
      final registro = List<Map<String, dynamic>>.from(resposta.data)
          .where((r) => (r['dados'] as Map?)?['id'] == equipamento.id)
          .firstOrNull;
      if (registro == null) {
        falha = 'Este formulário não foi encontrado. Ele pode ter sido removido.';
      } else {
        tela = construirFormulario(registro['tipo'], registro['dados'], isAdmin: false);
        if (tela == null) falha = 'Tipo de formulário não suportado (${registro['tipo']}).';
      }
    } catch (_) {
      falha = 'Não foi possível abrir o formulário. É preciso estar conectado.';
    }

    if (!mounted) return;
    navegador.pop(); // fecha o indicador de carregamento
    if (tela == null) {
      mensagens.showSnackBar(SnackBar(content: Text(falha!)));
      return;
    }
    await navegador.push(MaterialPageRoute(
      builder: (_) => tela!,
      // Os formulários leem estes argumentos para entrar em modo edição
      settings: const RouteSettings(arguments: {'isUpdate': true, 'isAdmin': false}),
    ));
    if (mounted) _carregar();
  }

  /// Rosca por categoria; tocar numa fatia ou na legenda filtra pela categoria.
  Widget _graficoCategorias() {
    final porCategoria = _contar(_filtrados(ignorar: _Filtro.categoria).map((e) => e.categoria));
    final total = porCategoria.values.fold(0, (a, b) => a + b);
    final categorias = ['A', 'B', 'C'].where((c) => (porCategoria[c] ?? 0) > 0).toList();
    return PainelCartao(
      titulo: 'Equipamentos por Categoria',
      child: categorias.isEmpty
          ? const PainelVazio(mensagem: 'Nenhum equipamento neste filtro.')
          : Row(children: [
              Expanded(
                child: PieChart(PieChartData(
                  centerSpaceRadius: 36,
                  sectionsSpace: 2,
                  pieTouchData: PieTouchData(
                    mouseCursorResolver: (_, r) =>
                        r?.touchedSection?.touchedSection == null ? MouseCursor.defer : SystemMouseCursors.click,
                    touchCallback: (evento, resposta) {
                      final i = resposta?.touchedSection?.touchedSectionIndex ?? -1;
                      if (evento is FlTapUpEvent && i >= 0 && i < categorias.length) {
                        _filtrar(() => alternar(_categoriasSel, categorias[i]));
                      }
                    },
                  ),
                  sections: [
                    for (final c in categorias)
                      PieChartSectionData(
                        value: porCategoria[c]!.toDouble(),
                        color: _corDestaque(_coresCategoria[c]!, destaqueDe(_categoriasSel, c)),
                        radius: _categoriasSel.contains(c) ? 34 : 28,
                        showTitle: false,
                      ),
                  ],
                )),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final c in ['A', 'B', 'C'])
                      PainelSelecionavel(
                        destaque: destaqueDe(_categoriasSel, c),
                        dica: 'Filtrar pela Categoria $c',
                        onTap: () => _filtrar(() => alternar(_categoriasSel, c)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: PainelLegenda(
                            cor: _coresCategoria[c]!,
                            texto: '$c · ${porCategoria[c] ?? 0} '
                                '(${total == 0 ? 0 : ((porCategoria[c] ?? 0) * 100 / total).round()}%)',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ]),
    );
  }

  /// Mapa dos equipamentos filtrados; tocar num pino aproxima o local, "Ver todos" reenquadra.
  Widget _mapa() {
    final todos = _equipamentos.map((e) => e.posicao).whereType<LatLng>().toList();
    final pontos = _filtrados().where((e) => e.posicao != null).toList();

    return PainelCartao(
      titulo: 'Localização dos Equipamentos',
      child: todos.isEmpty
          ? const PainelVazio(mensagem: 'Nenhum equipamento com coordenadas registradas.')
          : Column(children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCameraFit:
                          CameraFit.coordinates(coordinates: todos, padding: const EdgeInsets.all(40), maxZoom: 15),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                        additionalOptions: const {'accessToken': accessToken, 'id': 'mapbox/streets-v11'},
                        userAgentPackageName: 'br.com.murilo.gps',
                      ),
                      MarkerLayer(
                        markers: [
                          for (final e in pontos)
                            Marker(
                              point: e.posicao!,
                              width: 32,
                              height: 32,
                              alignment: Alignment.topCenter,
                              child: Tooltip(
                                message: e.tipo,
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () => _voarPara(e.posicao!, _zoomLocal),
                                    child: Icon(Icons.location_on,
                                        color: _coresCategoria[e.categoria] ?? _verde, size: 32),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(children: [
                Expanded(
                  child: Text('${pontos.length} no mapa · toque num pino para aproximar',
                      style: TextStyle(fontSize: 11, color: Colors.grey[700])),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: _verde),
                  onPressed: _enquadrarMapa,
                  icon: const Icon(Icons.zoom_out_map, size: 18),
                  label: const Text('Ver todos'),
                ),
              ]),
            ]),
    );
  }
}
