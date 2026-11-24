import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:sistur/services/sync_service.dart';

const _vermelho = Color(0xFFC62828);

/// Confirmação de exclusão da conta (direito de eliminação — LGPD). Retorna true se a conta foi excluída.
Future<bool> confirmarExclusaoDeConta(BuildContext context) async {
  int pendentes = 0;
  try {
    pendentes = await DataSyncService().getPendingCount();
  } catch (_) {}
  if (!context.mounted) return false;
  final excluiu = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (_) => _ExcluirContaDialog(pendentes: pendentes),
  );
  return excluiu ?? false;
}

class _ExcluirContaDialog extends StatefulWidget {
  final int pendentes;

  const _ExcluirContaDialog({required this.pendentes});

  @override
  State<_ExcluirContaDialog> createState() => _ExcluirContaDialogState();
}

class _ExcluirContaDialogState extends State<_ExcluirContaDialog> {
  final _senhaController = TextEditingController();
  bool _ciente = false;
  bool _ocultarSenha = true;
  bool _enviando = false;
  String? _erro;

  @override
  void dispose() {
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _excluir() async {
    setState(() {
      _enviando = true;
      _erro = null;
    });
    try {
      await ApiService().post('user/excluir-conta/', data: {'senha': _senhaController.text});
      if (mounted) Navigator.pop(context, true);
    } on DioException catch (e) {
      final dados = e.response?.data;
      String mensagem = 'Não foi possível excluir a conta. Tente novamente.';
      if (e.response == null) {
        mensagem = 'Sem conexão. É preciso estar conectado para excluir a conta.';
      } else if (dados is Map) {
        final detalhe = dados['detail'] ?? (dados['senha'] is List ? (dados['senha'] as List).first : null);
        if (detalhe != null) mensagem = detalhe.toString();
      }
      if (mounted) setState(() => _erro = mensagem);
    } finally {
      if (mounted) setState(() => _enviando = false);
    }
  }

  Widget _item(IconData icone, String texto) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icone, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Expanded(child: Text(texto, style: TextStyle(fontSize: 13, height: 1.35, color: Colors.grey[850]))),
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final podeExcluir = _ciente && _senhaController.text.isNotEmpty && !_enviando;
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Row(children: [
        Icon(Icons.warning_amber_rounded, color: _vermelho),
        SizedBox(width: 8),
        Expanded(child: Text('Excluir minha conta', style: TextStyle(color: _vermelho, fontWeight: FontWeight.bold))),
      ]),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _item(
              Icons.person_off_outlined,
              'Seu nome, e-mail, telefone e foto serão apagados, e você sairá das equipes '
              'de pesquisa.'),
          _item(
              Icons.description_outlined,
              'Os formulários que você já enviou continuam nas pesquisas (são dados do '
              'inventário). Seu nome fica registrado neles como autor por até 5 anos.'),
          _item(Icons.block, 'Esta ação não pode ser desfeita.'),
          if (widget.pendentes > 0)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFFFFF6DA), borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Atenção: há ${widget.pendentes} formulário(s) neste aparelho que ainda não foram enviados e serão '
                'perdidos. Sincronize antes de excluir a conta.',
                style: TextStyle(fontSize: 13, color: Colors.brown[800]),
              ),
            ),
          const SizedBox(height: 4),
          TextField(
            controller: _senhaController,
            obscureText: _ocultarSenha,
            enabled: !_enviando,
            onChanged: (_) => setState(() => _erro = null),
            decoration: InputDecoration(
              labelText: 'Confirme com sua senha',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(_ocultarSenha ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => _ocultarSenha = !_ocultarSenha),
              ),
              errorText: _erro,
              errorMaxLines: 3,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          CheckboxListTile(
            value: _ciente,
            onChanged: _enviando ? null : (v) => setState(() => _ciente = v ?? false),
            activeColor: _vermelho,
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text('Entendo que a exclusão é definitiva.', style: TextStyle(fontSize: 13)),
          ),
        ]),
      ),
      actions: [
        TextButton(
          onPressed: _enviando ? null : () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _vermelho,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: podeExcluir ? _excluir : null,
          child: _enviando
              ? const SizedBox(
                  width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
              : const Text('Excluir conta'),
        ),
      ],
    );
  }
}
