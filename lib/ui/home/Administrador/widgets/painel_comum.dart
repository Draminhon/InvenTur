import 'dart:math' as math;
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:sistur/services/interceptor_service.dart';
import 'package:sistur/utils/app_constants.dart';

/// Componentes compartilhados pelas abas de painel do administrador ("Dados" e "Gestão"),
/// que reproduzem o relatório do Power BI no app.

const verdePainel = AppConstants.MAIN_GREEN;
const larguraDesktopPainel = 900.0;
const _intervaloAtualizacao = Duration(seconds: 30);
const mesesAbreviados = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];

/// Um filtro cruzado ativo, exibido como chip removível no cabeçalho.
typedef FiltroAtivo = ({String rotulo, VoidCallback remover});

/// Busca os dados do painel no [endpoint], atualiza automaticamente a cada 30s (pausando com o app em
/// segundo plano ou fora da aba), mantém o filtro de pesquisa e monta o esqueleto da tela.
mixin PainelAutoAtualizacao<W extends StatefulWidget> on State<W> {
  String get endpoint;

  /// Recebe a resposta da API (chamado dentro de setState).
  void receberDados(Map<String, dynamic> json);

  /// Limpa os filtros cruzados dos gráficos (chamado dentro de setState ao trocar de pesquisa).
  void limparFiltrosCruzados();

  bool get temDados;

  String? erro;
  bool atualizando = false;
  int? pesquisaSelecionada;
  DateTime? atualizadoEm;
  List<Map<String, dynamic>> pesquisas = [];

  int _requisicao = 0;
  Timer? _timer;
  late final AppLifecycleListener _ciclo;

  @override
  void initState() {
    super.initState();
    // Não consulta a API com o app em segundo plano
    _ciclo = AppLifecycleListener(
      onResume: () {
        carregar();
        _iniciarAtualizacaoAutomatica();
      },
      onHide: () => _timer?.cancel(),
    );
    carregar();
    _iniciarAtualizacaoAutomatica();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ciclo.dispose();
    super.dispose();
  }

  void _iniciarAtualizacaoAutomatica() {
    _timer?.cancel();
    _timer = Timer.periodic(_intervaloAtualizacao, (_) => carregar());
  }

  Future<void> carregar() async {
    if (atualizando) return;
    final requisicao = ++_requisicao;
    final filtro = pesquisaSelecionada;
    setState(() => atualizando = true);

    String? falha;
    Map<String, dynamic>? json;
    try {
      final response = await ApiService().get(
        endpoint,
        queryParameters: filtro == null ? null : {'pesquisa_id': filtro},
      );
      json = Map<String, dynamic>.from(response.data);
    } on DioException catch (e) {
      falha = switch (e.response?.statusCode) {
        401 || 403 => 'Acesso restrito a administradores.',
        429 => 'Muitas atualizações em pouco tempo. Tentando novamente em instantes.',
        _ => 'Não foi possível atualizar os dados. Exibindo a última leitura.',
      };
    } catch (e) {
      falha = 'Não foi possível atualizar os dados. Exibindo a última leitura.';
    }

    // Ignora respostas de um filtro de pesquisa que já foi trocado
    if (!mounted || requisicao != _requisicao) return;
    setState(() {
      atualizando = false;
      erro = falha;
      if (json != null) {
        atualizadoEm = DateTime.tryParse(json['atualizado_em'] ?? '')?.toLocal();
        pesquisas = List<Map<String, dynamic>>.from(json['pesquisas'] ?? []);
        receberDados(json);
      }
    });
  }

  void selecionarPesquisa(int? id) {
    setState(() {
      pesquisaSelecionada = id;
      limparFiltrosCruzados();
    });
    atualizando = false;
    carregar();
    _iniciarAtualizacaoAutomatica();
  }

  /// Esqueleto comum: carregamento, erro, pull-to-refresh, cabeçalho (filtro de pesquisa, chips e horário).
  Widget construirPainel({
    required List<FiltroAtivo> filtros,
    required VoidCallback onLimparFiltros,
    required List<Widget> Function(double largura) conteudo,
  }) {
    if (!temDados) {
      return Center(
        child: erro == null
            ? const CircularProgressIndicator(color: verdePainel)
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.cloud_off, color: Colors.grey, size: 48),
                  const SizedBox(height: 12),
                  Text(erro!, textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  TextButton(onPressed: carregar, child: const Text('Tentar novamente')),
                ]),
              ),
      );
    }

    return RefreshIndicator(
      color: verdePainel,
      onRefresh: carregar,
      child: LayoutBuilder(
        builder: (context, constraints) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          children: [
            _cabecalho(filtros, onLimparFiltros),
            const SizedBox(height: 12),
            if (erro != null) _aviso(erro!),
            ...conteudo(constraints.maxWidth),
          ],
        ),
      ),
    );
  }

  Widget _cabecalho(List<FiltroAtivo> filtros, VoidCallback onLimparFiltros) {
    final ids = pesquisas.map((p) => p['id']).toSet();
    final selecionada = ids.contains(pesquisaSelecionada) ? pesquisaSelecionada : null;
    final horario = atualizadoEm == null ? '--' : DateFormat('HH:mm:ss').format(atualizadoEm!);

    // Seletor de pesquisa em linha própria, ocupando toda a largura (a margem lateral vem do padding da página)
    final seletor = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: verdePainel.withValues(alpha: 0.3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int?>(
          isExpanded: true,
          value: selecionada,
          icon: const Icon(Icons.filter_list, color: verdePainel),
          items: [
            const DropdownMenuItem(value: null, child: Text('Todas as pesquisas')),
            ...pesquisas.map((p) => DropdownMenuItem(
                  value: p['id'] as int,
                  child: Text('${p['municipio']} - ${p['estado']}', overflow: TextOverflow.ellipsis),
                )),
          ],
          onChanged: selecionarPesquisa,
        ),
      ),
    );

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      seletor,
      const SizedBox(height: 8),
      Wrap(
        spacing: 12,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          if (filtros.isNotEmpty) PainelFiltrosAtivos(filtros: filtros, onLimpar: onLimparFiltros),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              atualizando
                  ? const SizedBox(
                      width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, color: verdePainel))
                  : Icon(Icons.circle, size: 10, color: erro == null ? Colors.green : Colors.orange),
              const SizedBox(width: 6),
              Text('Atualizado às $horario', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
            ],
          ),
        ],
      ),
    ]);
  }

  Widget _aviso(String mensagem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.amber[100], borderRadius: BorderRadius.circular(10)),
      child: Row(children: [
        const Icon(Icons.warning_amber_rounded, color: Colors.brown),
        const SizedBox(width: 8),
        Expanded(child: Text(mensagem)),
      ]),
    );
  }
}

/// Chips dos filtros cruzados ativos (cada um removível) e "Limpar tudo" quando houver mais de um.
class PainelFiltrosAtivos extends StatelessWidget {
  final List<FiltroAtivo> filtros;
  final VoidCallback onLimpar;

  const PainelFiltrosAtivos({super.key, required this.filtros, required this.onLimpar});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Icon(Icons.filter_alt, size: 18, color: verdePainel),
        for (final filtro in filtros)
          InputChip(
            label: Text(filtro.rotulo, overflow: TextOverflow.ellipsis),
            backgroundColor: verdePainel.withValues(alpha: 0.08),
            side: BorderSide(color: verdePainel.withValues(alpha: 0.4)),
            deleteIcon: const Icon(Icons.close, size: 16),
            deleteButtonTooltipMessage: 'Remover filtro',
            onDeleted: filtro.remover,
            visualDensity: VisualDensity.compact,
          ),
        if (filtros.length > 1)
          TextButton(
            style: TextButton.styleFrom(foregroundColor: verdePainel),
            onPressed: onLimpar,
            child: const Text('Limpar tudo'),
          ),
      ],
    );
  }
}

/// Alterna [valor] no conjunto (seleção cumulativa).
void alternar<T>(Set<T> conjunto, T valor) {
  if (!conjunto.remove(valor)) conjunto.add(valor);
}

/// Estado visual de um item num filtro cruzado: null = nada selecionado, true = selecionado, false = apagado.
bool? destaqueDe<T>(Set<T> selecionados, T valor) => selecionados.isEmpty ? null : selecionados.contains(valor);

class PainelCartao extends StatelessWidget {
  final String? titulo;
  final Widget child;
  final EdgeInsets padding;
  final Color? borda;

  const PainelCartao(
      {super.key, this.titulo, required this.child, this.padding = const EdgeInsets.all(12), this.borda});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borda ?? Colors.grey.shade300, width: borda == null ? 1 : 2),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: titulo == null
          ? child
          : LayoutBuilder(
              // Com altura fixa o conteúdo ocupa o espaço restante; em lista rolável usa a própria altura
              builder: (context, constraints) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo!, style: const TextStyle(color: verdePainel, fontSize: 17, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  if (constraints.hasBoundedHeight) Expanded(child: child) else child,
                ],
              ),
            ),
    );
  }
}

/// Torna um elemento de gráfico clicável. [destaque]: null = sem seleção, true = selecionado, false = apagado.
class PainelSelecionavel extends StatelessWidget {
  final bool? destaque;
  final VoidCallback? onTap;
  final String? dica;
  final Widget child;

  const PainelSelecionavel({super.key, required this.destaque, required this.onTap, required this.child, this.dica});

  @override
  Widget build(BuildContext context) {
    Widget conteudo = AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: destaque == false ? 0.35 : 1,
      child: child,
    );
    if (onTap == null) return conteudo;
    conteudo = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: onTap, child: conteudo),
    );
    return dica == null ? conteudo : Tooltip(message: dica!, child: conteudo);
  }
}

/// Barra horizontal com rótulo e valor. O rótulo tem largura própria (não encolhe junto com a barra) e,
/// em espaços estreitos, passa para cima da barra, que então usa a largura toda.
class PainelBarraHorizontal extends StatelessWidget {
  final String rotulo;
  final int valor;
  final int maximo;

  static const _larguraEmpilhada = 360.0;
  static const _larguraMaximaRotulo = 180.0;

  const PainelBarraHorizontal({super.key, required this.rotulo, required this.valor, required this.maximo});

  @override
  Widget build(BuildContext context) {
    final estiloRotulo = TextStyle(fontSize: 12, color: Colors.grey[800]);
    Widget barra(double larguraDisponivel) => Row(
          children: [
            Container(
              height: 18,
              width: ((larguraDisponivel - 32) * valor / (maximo == 0 ? 1 : maximo)).clamp(2.0, double.infinity),
              color: verdePainel,
            ),
            const SizedBox(width: 4),
            Text('$valor', style: const TextStyle(fontSize: 12)),
          ],
        );

    return Tooltip(
      message: '$rotulo: $valor',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth < _larguraEmpilhada) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rotulo, maxLines: 1, overflow: TextOverflow.ellipsis, style: estiloRotulo),
                const SizedBox(height: 2),
                barra(constraints.maxWidth),
              ],
            );
          }
          final larguraRotulo = math.min(constraints.maxWidth * 0.38, _larguraMaximaRotulo);
          return Row(
            children: [
              SizedBox(
                width: larguraRotulo,
                child: Text(rotulo,
                    textAlign: TextAlign.right, maxLines: 1, overflow: TextOverflow.ellipsis, style: estiloRotulo),
              ),
              const SizedBox(width: 8),
              Expanded(child: LayoutBuilder(builder: (context, c) => barra(c.maxWidth))),
            ],
          );
        }),
      ),
    );
  }
}

/// "Francisco Sousa" -> "Francisco S." (rótulos compactos de nomes de pessoas).
String abreviarNome(String nome) {
  final partes = nome.trim().split(RegExp(r'\s+'));
  return partes.length < 2 ? nome : '${partes.first} ${partes.last[0].toUpperCase()}.';
}

const estiloRotuloEixo = TextStyle(fontSize: 11, color: Color(0xFF424242));

/// Como desenhar os rótulos de um eixo X no espaço que cada item tem.
class RotulosEixo {
  final List<String> textos;
  final List<double> larguras;

  /// Exibe 1 a cada [passo] rótulos (o tooltip continua mostrando todos).
  final int passo;

  /// Rótulos inclinados a 45°.
  final bool inclinado;

  /// Altura a reservar abaixo do eixo.
  final double altura;

  const RotulosEixo(this.textos, this.larguras, this.passo, this.inclinado, this.altura);

  bool visivel(int i) => i % passo == 0;
}

/// Escolhe a forma mais legível de mostrar os rótulos, nesta ordem:
///  1. completos e retos, se couberem;
///  2. compactos e retos (ex.: "Francisco S.", "Mai/26");
///  3. inclinados a 45°, se assim couberem todos (bom para poucas categorias com nomes longos);
///  4. retos, mostrando 1 a cada N (bom para séries longas, como dias).
/// As medidas consideram o tamanho de fonte configurado no aparelho.
RotulosEixo ajustarRotulos(BuildContext context,
    {required List<String> completos, List<String>? compactos, required double espacoPorItem}) {
  final escala = MediaQuery.textScalerOf(context);
  final painter = TextPainter(textDirection: TextDirection.ltr, textScaler: escala, maxLines: 1);
  double medir(String texto) {
    painter
      ..text = TextSpan(text: texto, style: estiloRotuloEixo)
      ..layout();
    return painter.width;
  }

  final alturaLinha = (painter
        ..text = const TextSpan(text: 'Hg', style: estiloRotuloEixo)
        ..layout())
      .height;
  const folga = 8.0;
  final alturaReta = alturaLinha + 10;

  for (final opcao in [completos, if (compactos != null) compactos]) {
    final larguras = opcao.map(medir).toList();
    if (larguras.fold<double>(0, math.max) + folga <= espacoPorItem) {
      return RotulosEixo(opcao, larguras, 1, false, alturaReta);
    }
  }

  final curtos = (compactos ?? completos).map((t) => t.length > 14 ? '${t.substring(0, 13)}…' : t).toList();
  final larguras = curtos.map(medir).toList();
  final maior = larguras.fold<double>(0, math.max);

  // Inclinado, cada rótulo ocupa ~1,4× a altura da linha na horizontal
  if (alturaLinha * 1.42 + 4 <= espacoPorItem) {
    return RotulosEixo(curtos, larguras, 1, true, (maior + alturaLinha) * 0.71 + 10);
  }
  final passo = math.max(1, ((maior + folga) / espacoPorItem).ceil());
  return RotulosEixo(curtos, larguras, passo, false, alturaReta);
}

/// Cartão de indicador no mesmo estilo do "Meu Painel" do pesquisador: fundo verde, ícone e rótulo
/// no topo e o número em destaque embaixo. [selecionado] desenha um contorno escuro (filtro ativo).
class PainelIndicador extends StatelessWidget {
  final String titulo;
  final int valor;
  final IconData icone;
  final bool selecionado;

  static const altura = 96.0;

  const PainelIndicador(
      {super.key, required this.titulo, required this.valor, required this.icone, this.selecionado = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: altura,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: verdePainel,
        borderRadius: BorderRadius.circular(10),
        border: selecionado ? Border.all(color: const Color(0xFF1B3D1F), width: 3) : null,
        boxShadow: selecionado
            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 8, offset: const Offset(0, 3))]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icone, color: Colors.white70, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(titulo,
                    style: const TextStyle(color: Colors.white70, fontSize: 13), overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child:
                Text('$valor', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class PainelLegenda extends StatelessWidget {
  final Color cor;
  final String texto;

  const PainelLegenda({super.key, required this.cor, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: cor, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        // Flexível: em espaços estreitos o texto quebra com reticências em vez de estourar a linha
        Flexible(
          child: Text(texto,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: Colors.grey[800])),
        ),
      ]),
    );
  }
}

class PainelVazio extends StatelessWidget {
  final String mensagem;

  const PainelVazio({super.key, this.mensagem = 'Nenhum equipamento inventariado.'});

  @override
  Widget build(BuildContext context) {
    // textAlign: quando a mensagem quebra em mais de uma linha, cada linha também fica centralizada
    return Center(child: Text(mensagem, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[700])));
  }
}

/// Fatia de uma lista paginada (até [linhasPorPagina] itens por página).
class Paginacao {
  static const linhasPorPagina = 10;

  final int total;
  final int pagina;
  final int paginas;

  Paginacao(this.total, int paginaDesejada)
      : paginas = math.max(1, (total / linhasPorPagina).ceil()),
        pagina = paginaDesejada.clamp(0, math.max(1, (total / linhasPorPagina).ceil()) - 1);

  int get inicio => pagina * linhasPorPagina;
  int get fim => math.min(inicio + linhasPorPagina, total);
  List<T> fatia<T>(List<T> itens) => itens.sublist(inicio, fim);
}

/// Controles "‹ 1–10 de 21 · Página 1 de 3 ›". Não aparece quando tudo cabe em uma página.
class PainelPaginacao extends StatelessWidget {
  final Paginacao paginacao;
  final ValueChanged<int> onPagina;

  const PainelPaginacao({super.key, required this.paginacao, required this.onPagina});

  @override
  Widget build(BuildContext context) {
    final p = paginacao;
    if (p.paginas <= 1) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: 'Página anterior',
          color: verdePainel,
          icon: const Icon(Icons.chevron_left),
          onPressed: p.pagina > 0 ? () => onPagina(p.pagina - 1) : null,
        ),
        Flexible(
          child: Text('${p.inicio + 1}–${p.fim} de ${p.total}  ·  Página ${p.pagina + 1} de ${p.paginas}',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey[800])),
        ),
        IconButton(
          tooltip: 'Próxima página',
          color: verdePainel,
          icon: const Icon(Icons.chevron_right),
          onPressed: p.pagina < p.paginas - 1 ? () => onPagina(p.pagina + 1) : null,
        ),
      ],
    );
  }
}
