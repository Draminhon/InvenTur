import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:sistur/utils/app_constants.dart';

const _verde = AppConstants.MAIN_GREEN;
const _tamanhoCodigo = 8;

/// Abre o modal "Vincular-se a pesquisa". Quando o vínculo é concluído o modal fecha sozinho e a função
/// retorna a mensagem de sucesso (para a tela de origem exibir e recarregar a lista); caso contrário, null.
Future<String?> mostrarVincularPesquisa(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (_) => const _VincularPesquisaDialog(),
  );
}

enum _Estado { digitando, enviando, sucesso, erro }

class _VincularPesquisaDialog extends StatefulWidget {
  const _VincularPesquisaDialog();

  @override
  State<_VincularPesquisaDialog> createState() => _VincularPesquisaDialogState();
}

class _VincularPesquisaDialogState extends State<_VincularPesquisaDialog> {
  final _controller = TextEditingController();
  _Estado _estado = _Estado.digitando;
  String? _mensagem;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Código sem espaços e hífens, em maiúsculas (o servidor normaliza do mesmo jeito).
  String get _codigo => _controller.text.toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]'), '');

  Future<void> _vincular() async {
    if (_codigo.length != _tamanhoCodigo) {
      setState(() {
        _estado = _Estado.erro;
        _mensagem = 'O código deve ter $_tamanhoCodigo caracteres.';
      });
      return;
    }
    setState(() {
      _estado = _Estado.enviando;
      _mensagem = null;
    });

    try {
      final resposta = await ApiService().post('pesquisa/vincular/', data: {'codigo': _codigo});
      final dados = Map<String, dynamic>.from(resposta.data);
      final pesquisa = Map<String, dynamic>.from(dados['pesquisa'] ?? {});
      final jaVinculado = dados['ja_vinculado'] == true;
      var mensagem = dados['detail'] ?? 'Vínculo realizado com sucesso.';
      // A lista do pesquisador só mostra pesquisas já iniciadas
      if (!jaVinculado && pesquisa['status'] == 'Não Iniciado') {
        mensagem += ' Ela aparecerá na sua lista quando for iniciada pelo administrador.';
      }
      if (!mounted) return;
      if (!jaVinculado) {
        // Vínculo concluído: fecha o modal e devolve a mensagem para a tela de origem
        Navigator.pop(context, mensagem);
        return;
      }
      setState(() {
        _estado = _Estado.sucesso;
        _mensagem = mensagem;
      });
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final detalhe = e.response?.data is Map ? (e.response!.data as Map)['detail'] : null;
      final mensagem = switch (status) {
        null => 'Sem conexão. Conecte-se à internet para se vincular a uma pesquisa.',
        429 => 'Muitas tentativas seguidas. Aguarde um minuto e tente novamente.',
        _ => detalhe?.toString() ?? 'Não foi possível se vincular. Tente novamente.',
      };
      if (!mounted) return;
      setState(() {
        _estado = _Estado.erro;
        _mensagem = mensagem;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _estado = _Estado.erro;
        _mensagem = 'Não foi possível se vincular. Tente novamente.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final enviando = _estado == _Estado.enviando;
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(children: [
                Icon(Icons.link_rounded, color: _verde, size: 28),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Vincular-se a pesquisa',
                      style: TextStyle(color: _verde, fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ]),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _verde.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Cada pesquisa tem um código único de $_tamanhoCodigo caracteres, que nunca se repete. '
                  'Peça esse código ao administrador responsável pela pesquisa e digite-o abaixo: '
                  'você passará a fazer parte da equipe, a pesquisa aparecerá na sua lista e você '
                  'poderá inventariar equipamentos nela.',
                  style: TextStyle(fontSize: 13, color: Colors.grey[800], height: 1.35),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                enabled: !enviando,
                autofocus: true,
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.characters,
                maxLength: _tamanhoCodigo + 1, // permite um hífen no meio (ex.: K7MQ-2XRP)
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9\- ]')),
                  _Maiusculas(),
                ],
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 4),
                decoration: InputDecoration(
                  hintText: 'EX: K7MQ2XRP',
                  hintStyle: TextStyle(color: Colors.grey[400], letterSpacing: 2, fontSize: 18),
                  labelText: 'Código da pesquisa',
                  counterText: '',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: _verde, width: 2),
                  ),
                ),
                onChanged: (_) {
                  if (_estado == _Estado.erro || _estado == _Estado.sucesso) {
                    setState(() {
                      _estado = _Estado.digitando;
                      _mensagem = null;
                    });
                  }
                },
                onSubmitted: (_) => enviando ? null : _vincular(),
              ),
              if (_mensagem != null) ...[
                const SizedBox(height: 12),
                _Resultado(sucesso: _estado == _Estado.sucesso, mensagem: _mensagem!),
              ],
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.grey[800]),
                    onPressed: enviando ? null : () => Navigator.pop(context),
                    child: const Text('Cancelar'),
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
                    onPressed: enviando ? null : _vincular,
                    child: enviando
                        ? const SizedBox(
                            width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text('Vincular'),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mensagem de sucesso (verde) ou falha (vermelha) dentro do modal.
class _Resultado extends StatelessWidget {
  final bool sucesso;
  final String mensagem;

  const _Resultado({required this.sucesso, required this.mensagem});

  @override
  Widget build(BuildContext context) {
    final cor = sucesso ? _verde : const Color(0xFFC62828);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cor.withValues(alpha: 0.4)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(sucesso ? Icons.check_circle_rounded : Icons.error_rounded, color: cor),
        const SizedBox(width: 8),
        Expanded(child: Text(mensagem, style: TextStyle(color: cor, fontSize: 13, height: 1.35))),
      ]),
    );
  }
}

class _Maiusculas extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) =>
      newValue.copyWith(text: newValue.text.toUpperCase());
}
