import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:sistur/ui/screens/password%20recover%20screens/changepassword_page.dart';
import 'package:sistur/ui/screens/password%20recover%20screens/recuperacao_layout.dart';

/// Etapa 2 de 3 da recuperação de senha: digitar o código recebido por e-mail.
class PasswordotpPage extends StatefulWidget {
  const PasswordotpPage({super.key, required this.email});
  final String email;

  @override
  State<PasswordotpPage> createState() => _PasswordotpPageState();
}

class _PasswordotpPageState extends State<PasswordotpPage> {
  static const _tamanhoCodigo = 6;
  static const _esperaReenvio = 60; // segundos

  final _codigoController = TextEditingController();
  bool _carregando = false;
  bool _reenviando = false;
  int _segundosParaReenviar = _esperaReenvio;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _iniciarContagem();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _codigoController.dispose();
    super.dispose();
  }

  void _iniciarContagem() {
    _timer?.cancel();
    setState(() => _segundosParaReenviar = _esperaReenvio);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return t.cancel();
      setState(() => _segundosParaReenviar--);
      if (_segundosParaReenviar <= 0) t.cancel();
    });
  }

  Future<void> _verificar() async {
    final codigo = _codigoController.text.trim();
    if (codigo.length != _tamanhoCodigo) {
      mostrarErroRecuperacao(context, 'Digite os $_tamanhoCodigo dígitos do código.');
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() => _carregando = true);
    try {
      await ApiService().post('password-reset/verify-otp/', data: {'email': widget.email, 'otp': codigo});
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MudarSenha(email: widget.email)));
    } catch (e) {
      if (mounted) mostrarErroRecuperacao(context, mensagemDeErro(e, 'Não foi possível validar o código.'));
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  Future<void> _reenviar() async {
    setState(() => _reenviando = true);
    try {
      await ApiService().post('password-reset/request/', data: {'email': widget.email});
      if (!mounted) return;
      _codigoController.clear();
      _iniciarContagem();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Enviamos um novo código. Lembre-se de verificar também a caixa de Spam.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: verdeRecuperacao,
        margin: EdgeInsets.all(16),
      ));
    } catch (e) {
      if (mounted) mostrarErroRecuperacao(context, mensagemDeErro(e, 'Não foi possível reenviar o código.'));
    } finally {
      if (mounted) setState(() => _reenviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final podeReenviar = _segundosParaReenviar <= 0 && !_reenviando;
    return RecuperacaoLayout(
      etapa: 2,
      icone: Icons.mark_email_read_outlined,
      titulo: 'Verifique seu e-mail',
      descricao: Text.rich(TextSpan(children: [
        const TextSpan(text: 'Enviamos um código de 6 dígitos para\n'),
        TextSpan(
            text: widget.email, style: const TextStyle(fontWeight: FontWeight.w600, color: verdeRecuperacao)),
        const TextSpan(text: '.\nO código vale por 10 minutos.'),
      ])),
      conteudo: [
        TextField(
          controller: _codigoController,
          autofocus: true,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: _tamanhoCodigo,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 12),
          decoration: InputDecoration(
            counterText: '',
            hintText: '••••••',
            hintStyle: TextStyle(color: Colors.grey[350], letterSpacing: 12),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: verdeRecuperacao, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: verdeRecuperacao, width: 2),
            ),
          ),
          // Ao completar os 6 dígitos, já verifica
          onChanged: (valor) {
            if (valor.length == _tamanhoCodigo && !_carregando) _verificar();
          },
        ),
        const SizedBox(height: 16),
        const AvisoRecuperacao(
          icone: Icons.report_gmailerrorred_outlined,
          texto: Text.rich(TextSpan(children: [
            TextSpan(text: 'Não encontrou o e-mail? ', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: 'Ele pode ter ido para a caixa de Spam (Lixo eletrônico) ou Promoções. Procure pelo assunto '
                    '"Código para recuperar sua senha".'),
          ])),
        ),
        const SizedBox(height: 8),
        Center(
          child: TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: verdeRecuperacao),
            onPressed: podeReenviar ? _reenviar : null,
            icon: _reenviando
                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.refresh_rounded, size: 18),
            label: Text(_segundosParaReenviar > 0
                ? 'Reenviar código em ${_segundosParaReenviar}s'
                : 'Reenviar código'),
          ),
        ),
      ],
      textoBotao: 'Verificar código',
      onConfirmar: _verificar,
      carregando: _carregando,
      onCancelar: () => Navigator.pop(context),
    );
  }
}
