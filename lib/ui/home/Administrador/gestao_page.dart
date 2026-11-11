import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistur/ui/home/Administrador/widgets/painel_comum.dart';
import 'package:sistur/utils/app_constants.dart';

const _verde = verdePainel;

/// Linha agregada vinda da API: total de equipamentos de um pesquisador, num município, num dia.
class _Registro {
  final DateTime? dia;
  final String municipio;
  final String usuario;
  final int total;

  _Registro.fromJson(Map<String, dynamic> json)
      : dia = DateTime.tryParse(json['dia'] ?? ''),
        municipio = json['municipio'] ?? '',
        usuario = json['usuario'] ?? '',
        total = (json['total'] as num?)?.toInt() ?? 0;

  /// Primeiro dia do mês do registro (chave do gráfico mensal).
  DateTime? get mes => dia == null ? null : DateTime(dia!.year, dia!.month);
}

enum _Grafico { dia, mes, municipioUsuario, usuario }

String _rotuloMes(DateTime mes) => '${mesesAbreviados[mes.month - 1]}/${mes.year}';

/// Aba "Gestão" do administrador: produtividade do inventário, como na segunda página do relatório do Power BI.
/// Os dados vêm de GET admin/gestao/ (restrito a administradores) e são atualizados automaticamente.
class GestaoPage extends StatefulWidget {
  const GestaoPage({super.key});

  @override
  State<GestaoPage> createState() => _GestaoPageState();
}

class _GestaoPageState extends State<GestaoPage> with PainelAutoAtualizacao<GestaoPage> {
  List<_Registro>? _registros;
  // Filtros cruzados cumulativos: valores do mesmo gráfico somam (OU); gráficos diferentes se combinam (E)
  final Set<DateTime> _diasSel = {};
  final Set<DateTime> _mesesSel = {};
  final Set<(String, String)> _municipioUsuarioSel = {};
  final Set<String> _usuariosSel = {};
  // Página atual de "Total de Equipamentos Inventariados por Município e Usuário" (ver Paginacao)
  int _paginaMunicipioUsuario = 0;
  // Página atual de "Total por Usuário" quando exibido como barras horizontais (telas estreitas)
  int _paginaUsuarios = 0;

  @override
  String get endpoint => AppConstants.ADMIN_GESTAO;

  @override
  bool get temDados => _registros != null;

  @override
  void receberDados(Map<String, dynamic> json) =>
      _registros = List<Map<String, dynamic>>.from(json['registros'] ?? []).map(_Registro.fromJson).toList();

  @override
  void limparFiltrosCruzados() {
    _diasSel.clear();
    _mesesSel.clear();
    _municipioUsuarioSel.clear();
    _usuariosSel.clear();
    _paginaMunicipioUsuario = 0;
    _paginaUsuarios = 0;
  }

  void _alternar<T>(Set<T> conjunto, T valor) => setState(() {
        alternar(conjunto, valor);
        // Filtros de outros gráficos mudam a lista por município/usuário: volta para a primeira página
        if (!identical(conjunto, _municipioUsuarioSel)) _paginaMunicipioUsuario = 0;
        if (!identical(conjunto, _usuariosSel)) _paginaUsuarios = 0;
      });

  /// Registros que passam pelos filtros dos outros gráficos (cada gráfico ignora o próprio filtro
  /// para continuar mostrando as demais opções, destacando as selecionadas).
  List<_Registro> _filtrados({_Grafico? ignorar}) {
    return _registros!.where((r) {
      if (ignorar != _Grafico.dia && _diasSel.isNotEmpty && !_diasSel.contains(r.dia)) return false;
      if (ignorar != _Grafico.mes && _mesesSel.isNotEmpty && !_mesesSel.contains(r.mes)) return false;
      if (ignorar != _Grafico.municipioUsuario &&
          _municipioUsuarioSel.isNotEmpty &&
          !_municipioUsuarioSel.contains((r.municipio, r.usuario))) {
        return false;
      }
      if (ignorar != _Grafico.usuario && _usuariosSel.isNotEmpty && !_usuariosSel.contains(r.usuario)) return false;
      return true;
    }).toList();
  }

  Map<K, int> _somar<K>(Iterable<_Registro> registros, K? Function(_Registro) chave) {
    final soma = <K, int>{};
    for (final r in registros) {
      final k = chave(r);
      if (k != null) soma[k] = (soma[k] ?? 0) + r.total;
    }
    return soma;
  }

  @override
  Widget build(BuildContext context) {
    final formatoDia = DateFormat('dd/MM/yyyy');
    return construirPainel(
      filtros: [
        for (final d in (_diasSel.toList()..sort()))
          (rotulo: 'Dia ${formatoDia.format(d)}', remover: () => _alternar(_diasSel, d)),
        for (final m in (_mesesSel.toList()..sort()))
          (rotulo: 'Mês ${_rotuloMes(m)}', remover: () => _alternar(_mesesSel, m)),
        for (final mu in _municipioUsuarioSel)
          (rotulo: '${mu.$1} · ${mu.$2}', remover: () => _alternar(_municipioUsuarioSel, mu)),
        for (final u in _usuariosSel) (rotulo: 'Usuário $u', remover: () => _alternar(_usuariosSel, u)),
      ],
      onLimparFiltros: () => setState(limparFiltrosCruzados),
      conteudo: (largura) {
        if (largura >= larguraDesktopPainel) {
          Widget linha(Widget a, Widget b, {double altura = 330}) => Row(children: [
                Expanded(child: SizedBox(height: altura, child: a)),
                const SizedBox(width: 16),
                Expanded(child: SizedBox(height: altura, child: b)),
              ]);
          return [
            linha(_totalPorDia(), _totalPorMunicipioEUsuario(alturaFixa: true), altura: 500),
            const SizedBox(height: 16),
            linha(_totalPorMes(), _totalPorUsuario(horizontal: false)),
          ];
        }
        return [
          SizedBox(height: 300, child: _totalPorDia()),
          const SizedBox(height: 16),
          _totalPorMunicipioEUsuario(alturaFixa: false),
          const SizedBox(height: 16),
          SizedBox(height: 300, child: _totalPorMes()),
          const SizedBox(height: 16),
          _totalPorUsuario(horizontal: true),
        ];
      },
    );
  }

  Widget _totalPorDia() {
    final porDia = _somar<DateTime>(_filtrados(ignorar: _Grafico.dia), (r) => r.dia);
    final dias = porDia.keys.toList()..sort();
    final formato = DateFormat(dias.isNotEmpty && dias.first.year != dias.last.year ? 'dd/MM/yy' : 'dd/MM');
    final formatoCompleto = DateFormat('dd/MM/yyyy');
    return PainelCartao(
      titulo: 'Total por Dia',
      child: dias.isEmpty
          ? const PainelVazio()
          : _BarrasVerticais(
              rotulos: dias.map(formato.format).toList(),
              dicas: dias.map(formatoCompleto.format).toList(),
              valores: dias.map((d) => porDia[d]!).toList(),
              destaques: dias.map((d) => destaqueDe(_diasSel, d)).toList(),
              onTap: (i) => _alternar(_diasSel, dias[i]),
              eixoX: 'Dia',
              eixoY: 'Total',
            ),
    );
  }

  Widget _totalPorMes() {
    final porMes = _somar<DateTime>(_filtrados(ignorar: _Grafico.mes), (r) => r.mes);
    final meses = <DateTime>[];
    if (porMes.isNotEmpty) {
      // Sequência contínua de meses entre o primeiro e o último com cadastros
      final ordenados = porMes.keys.toList()..sort();
      for (var m = ordenados.first; !m.isAfter(ordenados.last); m = DateTime(m.year, m.month + 1)) {
        meses.add(m);
      }
    }
    return PainelCartao(
      titulo: 'Total por Mês',
      child: meses.isEmpty
          ? const PainelVazio()
          : _LinhaTemporal(
              rotulos: meses.map(_rotuloMes).toList(),
              compactos: meses
                  .map((m) => '${mesesAbreviados[m.month - 1]}/${(m.year % 100).toString().padLeft(2, '0')}')
                  .toList(),
              valores: meses.map((m) => porMes[m] ?? 0).toList(),
              destaques: meses.map((m) => destaqueDe(_mesesSel, m)).toList(),
              onTap: (i) => _alternar(_mesesSel, meses[i]),
              eixoX: 'Mês',
              eixoY: 'Total',
            ),
    );
  }

  Widget _totalPorMunicipioEUsuario({required bool alturaFixa}) {
    final porPar =
        _somar<(String, String)>(_filtrados(ignorar: _Grafico.municipioUsuario), (r) => (r.municipio, r.usuario));
    const titulo = 'Total de Equipamentos Inventariados por Município e Usuário';
    if (porPar.isEmpty) {
      return const PainelCartao(titulo: titulo, child: SizedBox(height: 80, child: PainelVazio()));
    }

    // Municípios em ordem decrescente de total; dentro de cada um, pesquisadores em ordem decrescente
    final porMunicipio = <String, List<MapEntry<(String, String), int>>>{};
    for (final e in porPar.entries) {
      porMunicipio.putIfAbsent(e.key.$1, () => []).add(e);
    }
    int totalDe(String m) => porMunicipio[m]!.fold(0, (s, e) => s + e.value);
    final municipios = porMunicipio.keys.toList()..sort((a, b) => totalDe(b).compareTo(totalDe(a)));
    final maximo = porPar.values.reduce(math.max); // escala única para todas as páginas

    // Pagina pelas barras (pesquisadores); o nome do município é repetido no topo de cada página
    final barras = [
      for (final municipio in municipios) ...porMunicipio[municipio]!..sort((a, b) => b.value.compareTo(a.value)),
    ];
    final paginacao = Paginacao(barras.length, _paginaMunicipioUsuario);
    String? municipioAnterior;

    final linhas = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final e in paginacao.fatia(barras)) ...[
          if (e.key.$1 != municipioAnterior)
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 2),
              child: Text((municipioAnterior = e.key.$1).isEmpty ? 'Sem município' : e.key.$1,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600])),
            ),
          PainelSelecionavel(
            destaque: destaqueDe(_municipioUsuarioSel, e.key),
            onTap: () => _alternar(_municipioUsuarioSel, e.key),
            child: PainelBarraHorizontal(rotulo: e.key.$2, valor: e.value, maximo: maximo),
          ),
        ],
      ],
    );

    return PainelCartao(
      titulo: titulo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Altura fixa (desktop): as 10 linhas cabem; a rolagem só entra se houver muitos cabeçalhos de município
          if (alturaFixa) Expanded(child: SingleChildScrollView(child: linhas)) else linhas,
          const SizedBox(height: 6),
          Text('Total de Equipamentos Inventariados',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey[800])),
          PainelPaginacao(
            paginacao: paginacao,
            onPagina: (pagina) => setState(() => _paginaMunicipioUsuario = pagina),
          ),
        ],
      ),
    );
  }

  Widget _totalPorUsuario({required bool horizontal}) {
    final porUsuario = _somar<String>(_filtrados(ignorar: _Grafico.usuario), (r) => r.usuario);
    final usuarios = porUsuario.keys.toList()..sort((a, b) => porUsuario[b]!.compareTo(porUsuario[a]!));
    const titulo = 'Total por Usuário';
    if (usuarios.isEmpty) {
      return const PainelCartao(titulo: titulo, child: SizedBox(height: 80, child: PainelVazio()));
    }

    if (horizontal) {
      // Em telas estreitas, nomes de pessoas não cabem sob colunas: barras horizontais com o nome inteiro
      final maximo = porUsuario.values.reduce(math.max);
      final paginacao = Paginacao(usuarios.length, _paginaUsuarios);
      return PainelCartao(
        titulo: titulo,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final u in paginacao.fatia(usuarios))
              PainelSelecionavel(
                destaque: destaqueDe(_usuariosSel, u),
                onTap: () => _alternar(_usuariosSel, u),
                child: PainelBarraHorizontal(rotulo: u, valor: porUsuario[u]!, maximo: maximo),
              ),
            const SizedBox(height: 6),
            Text('Total',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey[800])),
            PainelPaginacao(paginacao: paginacao, onPagina: (p) => setState(() => _paginaUsuarios = p)),
          ],
        ),
      );
    }

    return PainelCartao(
      titulo: titulo,
      child: _BarrasVerticais(
        rotulos: usuarios,
        compactos: usuarios.map(abreviarNome).toList(),
        valores: usuarios.map((u) => porUsuario[u]!).toList(),
        destaques: usuarios.map((u) => destaqueDe(_usuariosSel, u)).toList(),
        onTap: (i) => _alternar(_usuariosSel, usuarios[i]),
        eixoX: 'Usuário',
        eixoY: 'Total',
      ),
    );
  }
}

/// Teto do eixo Y com folga, para os rótulos não encostarem no topo.
double _tetoEixo(Iterable<int> valores) {
  final maximo = valores.fold<int>(0, math.max);
  return maximo < 4 ? 4 : (maximo * 1.15).ceilToDouble();
}

AxisTitles _eixoEsquerdo(String nome, double teto) {
  final intervalo = math.max(1, (teto / 4).ceil()).toDouble();
  return AxisTitles(
    axisNameWidget: Text(nome, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey[800])),
    axisNameSize: 18,
    sideTitles: SideTitles(
      showTitles: true,
      reservedSize: 30,
      interval: intervalo,
      getTitlesWidget: (valor, meta) => valor == meta.max && valor % intervalo != 0
          ? const SizedBox.shrink()
          : Text(valor.toInt().toString(), style: TextStyle(fontSize: 11, color: Colors.grey[700])),
    ),
  );
}

/// Espaço ocupado pelo eixo Y (nome + números) à esquerda da área do gráfico.
const _larguraEixoY = 48.0;

AxisTitles _eixoInferior(String nome, RotulosEixo rotulos) {
  return AxisTitles(
    axisNameWidget: Text(nome, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[800])),
    axisNameSize: 20,
    sideTitles: SideTitles(
      showTitles: true,
      interval: 1,
      reservedSize: rotulos.altura,
      getTitlesWidget: (valor, meta) {
        final i = valor.round();
        if (valor != i || i < 0 || i >= rotulos.textos.length || !rotulos.visivel(i)) {
          return const SizedBox.shrink();
        }
        final texto = Text(rotulos.textos[i], style: estiloRotuloEixo, maxLines: 1, softWrap: false);
        if (!rotulos.inclinado) return SideTitleWidget(meta: meta, space: 6, child: texto);
        // Inclinado a 45°, terminando sob o ponto/coluna (como no Power BI)
        return SideTitleWidget(
          meta: meta,
          space: 6,
          child: Transform.translate(
            offset: Offset(-rotulos.larguras[i] / 2, 0),
            child: Transform.rotate(angle: -math.pi / 4, alignment: Alignment.topRight, child: texto),
          ),
        );
      },
    ),
  );
}

const _semTitulos = AxisTitles(sideTitles: SideTitles(showTitles: false));

const _grade = FlGridData(drawVerticalLine: false);

Color _corDa(bool? destaque) => destaque == false ? _verde.withValues(alpha: 0.3) : _verde;

/// Gráfico de colunas clicável. Com muitas colunas, rola na horizontal.
class _BarrasVerticais extends StatelessWidget {
  final List<String> rotulos;
  final List<String>? compactos;
  final List<String>? dicas;
  final List<int> valores;
  final List<bool?> destaques;
  final ValueChanged<int> onTap;
  final String eixoX;
  final String eixoY;

  const _BarrasVerticais({
    required this.rotulos,
    this.compactos,
    this.dicas,
    required this.valores,
    required this.destaques,
    required this.onTap,
    required this.eixoX,
    required this.eixoY,
  });

  @override
  Widget build(BuildContext context) {
    final teto = _tetoEixo(valores);
    return LayoutBuilder(builder: (context, constraints) {
      // Rótulos se adaptam ao espaço; só rola na horizontal quando nem as colunas cabem
      const larguraMinima = 12.0;
      final largura = math.max(constraints.maxWidth, rotulos.length * larguraMinima + _larguraEixoY);
      final espacoPorBarra = (largura - _larguraEixoY) / rotulos.length;
      final eixo = ajustarRotulos(context, completos: rotulos, compactos: compactos, espacoPorItem: espacoPorBarra);

      final grafico = SizedBox(
        width: largura,
        child: BarChart(BarChartData(
          maxY: teto,
          alignment: BarChartAlignment.spaceAround,
          gridData: _grade,
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: _semTitulos,
            rightTitles: _semTitulos,
            leftTitles: _eixoEsquerdo(eixoY, teto),
            bottomTitles: _eixoInferior(eixoX, eixo),
          ),
          barTouchData: BarTouchData(
            mouseCursorResolver: (_, resposta) => resposta?.spot == null ? MouseCursor.defer : SystemMouseCursors.click,
            touchCallback: (evento, resposta) {
              final spot = resposta?.spot;
              if (evento is FlTapUpEvent && spot != null) onTap(spot.touchedBarGroupIndex);
            },
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (_) => Colors.black87,
              getTooltipItem: (grupo, _, barra, __) => BarTooltipItem(
                '${(dicas ?? rotulos)[grupo.x]}\n${barra.toY.toInt()}',
                const TextStyle(color: Colors.white),
              ),
            ),
          ),
          barGroups: [
            for (var i = 0; i < valores.length; i++)
              BarChartGroupData(x: i, barRods: [
                BarChartRodData(
                  toY: valores[i].toDouble(),
                  color: _corDa(destaques[i]),
                  width: math.min(espacoPorBarra * 0.6, 120),
                  borderRadius: BorderRadius.zero,
                ),
              ]),
          ],
        )),
      );

      return largura > constraints.maxWidth
          ? Scrollbar(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: grafico))
          : grafico;
    });
  }
}

/// Gráfico de linha clicável (um ponto por período).
class _LinhaTemporal extends StatelessWidget {
  final List<String> rotulos;
  final List<String>? compactos;
  final List<int> valores;
  final List<bool?> destaques;
  final ValueChanged<int> onTap;
  final String eixoX;
  final String eixoY;

  const _LinhaTemporal({
    required this.rotulos,
    this.compactos,
    required this.valores,
    required this.destaques,
    required this.onTap,
    required this.eixoX,
    required this.eixoY,
  });

  @override
  Widget build(BuildContext context) {
    final teto = _tetoEixo(valores);
    final unico = valores.length == 1;
    return LayoutBuilder(builder: (context, constraints) {
      final espacoPorPonto = (constraints.maxWidth - _larguraEixoY) / math.max(valores.length, 1);
      final eixo = ajustarRotulos(context, completos: rotulos, compactos: compactos, espacoPorItem: espacoPorPonto);
      return _grafico(eixo, teto, unico);
    });
  }

  Widget _grafico(RotulosEixo eixo, double teto, bool unico) {
    return LineChart(LineChartData(
      minX: unico ? -1 : 0,
      maxX: unico ? 1 : valores.length - 1.0,
      minY: 0,
      maxY: teto,
      gridData: _grade,
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        topTitles: _semTitulos,
        rightTitles: _semTitulos,
        leftTitles: _eixoEsquerdo(eixoY, teto),
        bottomTitles: _eixoInferior(eixoX, eixo),
      ),
      lineTouchData: LineTouchData(
        mouseCursorResolver: (_, resposta) =>
            (resposta?.lineBarSpots?.isNotEmpty ?? false) ? SystemMouseCursors.click : MouseCursor.defer,
        touchCallback: (evento, resposta) {
          final pontos = resposta?.lineBarSpots;
          if (evento is FlTapUpEvent && pontos != null && pontos.isNotEmpty) onTap(pontos.first.x.toInt());
        },
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => Colors.black87,
          getTooltipItems: (pontos) => pontos
              .map((p) =>
                  LineTooltipItem('${rotulos[p.x.toInt()]}\n${p.y.toInt()}', const TextStyle(color: Colors.white)))
              .toList(),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [for (var i = 0; i < valores.length; i++) FlSpot(i.toDouble(), valores[i].toDouble())],
          color: _verde,
          barWidth: 3,
          belowBarData: BarAreaData(show: !unico, color: _verde.withValues(alpha: 0.12)),
          dotData: FlDotData(
            getDotPainter: (spot, _, __, i) => FlDotCirclePainter(
              radius: destaques[i] == true ? 7 : 5,
              color: _corDa(destaques[i]),
              strokeWidth: 2,
              strokeColor: Colors.white,
            ),
          ),
        ),
      ],
    ));
  }
}
