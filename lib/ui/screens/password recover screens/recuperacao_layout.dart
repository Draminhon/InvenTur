import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sistur/utils/app_constants.dart';

const verdeRecuperacao = AppConstants.MAIN_GREEN;
const _totalEtapas = 3;

/// Layout comum das telas de recuperação de senha: voltar, indicador de etapa, ícone, título,
/// descrição, conteúdo e botão principal. [etapa] = null oculta o indicador (tela de sucesso).
class RecuperacaoLayout extends StatelessWidget {
  final int? etapa;
  final IconData icone;
  final String titulo;
  final Widget descricao;
  final List<Widget> conteudo;
  final String textoBotao;
  final VoidCallback? onConfirmar;
  final bool carregando;
  final VoidCallback? onCancelar;
  final Color corIcone;

  const RecuperacaoLayout({
    super.key,
    this.etapa,
    required this.icone,
    required this.titulo,
    required this.descricao,
    this.conteudo = const [],
    required this.textoBotao,
    required this.onConfirmar,
    this.carregando = false,
    this.onCancelar,
    this.corIcone = verdeRecuperacao,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: verdeRecuperacao,
        elevation: 0,
        automaticallyImplyLeading: etapa != null,
        title: etapa == null ? null : _IndicadorEtapa(etapa: etapa!),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(color: corIcone.withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: Icon(icone, size: 44, color: corIcone),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    titulo,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: verdeRecuperacao),
                  ),
                  const SizedBox(height: 10),
                  DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, height: 1.45, color: Colors.grey[700]),
                    child: descricao,
                  ),
                  const SizedBox(height: 28),
                  ...conteudo,
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: verdeRecuperacao,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: verdeRecuperacao.withValues(alpha: 0.5),
                        disabledForegroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: carregando ? null : onConfirmar,
                      child: carregando
                          ? const SizedBox(
                              width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                          : Text(textoBotao, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  if (onCancelar != null) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
                      onPressed: carregando ? null : onCancelar,
                      child: const Text('Cancelar', style: TextStyle(fontSize: 15)),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IndicadorEtapa extends StatelessWidget {
  final int etapa;

  const _IndicadorEtapa({required this.etapa});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Text('Etapa $etapa de $_totalEtapas', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
      const SizedBox(height: 6),
      Row(mainAxisSize: MainAxisSize.min, children: [
        for (var i = 1; i <= _totalEtapas; i++)
          Container(
            width: 28,
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: i <= etapa ? verdeRecuperacao : verdeRecuperacao.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ]),
    ]);
  }
}

/// Aviso em destaque (ex.: e-mail pode cair no Spam).
class AvisoRecuperacao extends StatelessWidget {
  final IconData icone;
  final Widget texto;
  final Color cor;

  const AvisoRecuperacao({super.key, required this.icone, required this.texto, this.cor = const Color(0xFF8A6100)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6DA),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF1D58A)),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icone, color: cor, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 13, height: 1.4, color: Colors.brown[800]),
            child: texto,
          ),
        ),
      ]),
    );
  }
}

/// Mensagem de erro legível a partir da resposta do servidor (o Dio lança exceção em respostas 4xx/5xx).
String mensagemDeErro(Object erro, String padrao) {
  if (erro is DioException) {
    final status = erro.response?.statusCode;
    if (erro.response == null) return 'Sem conexão com a internet. Verifique e tente novamente.';
    if (status == 429) return 'Muitas tentativas seguidas. Aguarde um minuto e tente novamente.';
    final dados = erro.response?.data;
    if (dados is Map) {
      final erros = dados['errors'] is Map ? dados['errors'] as Map : dados;
      for (final valor in erros.values) {
        if (valor is List && valor.isNotEmpty) return _traduzir(valor.first.toString(), padrao);
        if (valor is String && valor.isNotEmpty) return _traduzir(valor, padrao);
      }
    }
  }
  return padrao;
}

String _traduzir(String mensagem, String padrao) {
  final m = mensagem.toLowerCase();
  // O servidor não diferencia código errado de expirado (nem diz se o e-mail tem conta)
  if (m.contains('inválido ou expirado') || m.contains('invalido ou expirado')) {
    return 'Código incorreto ou expirado. Confira o código ou toque em "Reenviar código".';
  }
  if (m.contains('otp invalido') || m.contains('otp inválido')) return 'Código incorreto. Confira e tente novamente.';
  if (m.contains('expirado')) return 'O código expirou. Toque em "Reenviar código" para receber outro.';
  if (m.contains('verificação por otp')) return 'Valide o código antes de criar a nova senha.';
  if (m.contains('nenhum usuário') || m.contains('não encontrado')) {
    return 'Não encontramos uma conta com este e-mail.';
  }
  return mensagem.isEmpty ? padrao : mensagem;
}

void mostrarErroRecuperacao(BuildContext context, String mensagem) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(mensagem),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red[700],
      margin: const EdgeInsets.all(16),
    ));
}
