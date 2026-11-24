import 'package:flutter/material.dart';
import 'package:sistur/legal/termos_texto.dart';
import 'package:sistur/utils/app_constants.dart';

const _verde = AppConstants.MAIN_GREEN;

/// Termos de Uso e Política de Privacidade.
///
/// - Modo leitura (padrão): apenas exibe os documentos.
/// - [exigirAceite]: mostra o checkbox de aceite e os botões "Recusar" / "Aceitar e continuar";
///   a rota retorna `true` se o usuário aceitou e `false`/null se recusou ou voltou.
class TermosPage extends StatefulWidget {
  final bool exigirAceite;

  /// 0 = Termos de Uso, 1 = Política de Privacidade.
  final int abaInicial;

  const TermosPage({super.key, this.exigirAceite = false, this.abaInicial = 0});

  @override
  State<TermosPage> createState() => _TermosPageState();
}

class _TermosPageState extends State<TermosPage> {
  bool _aceito = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.abaInicial,
      child: PopScope(
        // No aceite obrigatório, voltar equivale a recusar
        canPop: !widget.exigirAceite,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop && widget.exigirAceite) Navigator.of(context).pop(false);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            foregroundColor: _verde,
            backgroundColor: Colors.white,
            centerTitle: true,
            automaticallyImplyLeading: !widget.exigirAceite,
            title: Text(widget.exigirAceite ? 'Atualização dos Termos' : 'Termos e Privacidade'),
            bottom: const TabBar(
              labelColor: _verde,
              indicatorColor: _verde,
              tabs: [Tab(text: 'Termos de Uso'), Tab(text: 'Privacidade')],
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                if (widget.exigirAceite)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _verde.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Para continuar usando o SisTur, leia e aceite os Termos de Uso e a Política de Privacidade.',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                const Expanded(
                  child: TabBarView(children: [
                    _Documento(titulo: 'Termos de Uso', secoes: termosDeUso),
                    _Documento(titulo: 'Política de Privacidade', secoes: politicaDePrivacidade),
                  ]),
                ),
                if (widget.exigirAceite) _barraDeAceite(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _barraDeAceite() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, -2))],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        CheckboxListTile(
          value: _aceito,
          onChanged: (v) => setState(() => _aceito = v ?? false),
          activeColor: _verde,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          title: const Text('Li e aceito os Termos de Uso e a Política de Privacidade.', style: TextStyle(fontSize: 14)),
        ),
        Row(children: [
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.grey[800]),
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Recusar e sair'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _verde,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _aceito ? () => Navigator.pop(context, true) : null,
              child: const Text('Aceitar e continuar'),
            ),
          ),
        ]),
      ]),
    );
  }
}

class _Documento extends StatelessWidget {
  final String titulo;
  final List<SecaoLegal> secoes;

  const _Documento({required this.titulo, required this.secoes});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        children: [
          Text(titulo, style: const TextStyle(color: _verde, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text('Versão $termosVersao · Vigente a partir de $termosVigencia',
              style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          for (final secao in secoes) ...[
            const SizedBox(height: 18),
            Text(secao.titulo, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            for (final paragrafo in secao.paragrafos)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(paragrafo, style: TextStyle(fontSize: 14, height: 1.45, color: Colors.grey[850])),
              ),
          ],
        ],
      ),
    );
  }
}
