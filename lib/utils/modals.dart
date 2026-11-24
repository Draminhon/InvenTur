import 'package:flutter/material.dart';
import 'package:sistur/services/sync_service.dart';

class Modals {
  void showNoPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Acesso Negado", style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w500
        ),),
        content: const Text("Você não tem permissão para alterar esse equipamento.",style: TextStyle(fontWeight: FontWeight.w500),),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
          ),
        ],
      );
    },
  );
}

 void showNoAcessPermissionnDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Atenção!", style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w500
        ),),
        content: const Text("Você não tem permissão para alterar esse equipamento.",style: TextStyle(fontWeight: FontWeight.w500),),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
          ),
        ],
      );
    },
  );
}


 /// Mostra o resultado real da sincronização (antes dizia "sucesso" mesmo sem enviar nada).
 void showSyncDialog(BuildContext context, [ResultadoSync? resultado]) {
  final r = resultado ?? const ResultadoSync(interrompida: true);
  final String titulo;
  final Color cor;
  final partes = <String>[];
  if (r.enviados == 0 && r.recusados == 0 && r.interrompida) {
    titulo = 'Não foi possível sincronizar';
    cor = Colors.red;
    partes.add('Verifique sua conexão e tente novamente. Os formulários continuam salvos no aparelho.');
  } else {
    final completa = r.recusados == 0 && !r.interrompida;
    titulo = completa ? 'Sincronização concluída!' : 'Sincronização parcial';
    cor = completa ? Colors.green : Colors.orange;
    partes.add('${r.enviados} formulário(s) enviado(s).');
    if (r.recusados > 0) {
      partes.add('${r.recusados} formulário(s) foram recusados pelo servidor (por exemplo, você não faz mais parte '
          'da pesquisa, ela foi excluída ou faltam dados). Eles continuam salvos no aparelho.');
    }
    if (r.interrompida) {
      partes.add('A conexão caiu antes do fim: os demais serão enviados na próxima sincronização.');
    }
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo, style: TextStyle(
          color: cor,
          fontWeight: FontWeight.w500
        ),),
        content: Text(partes.join('\n\n'),style: const TextStyle(fontWeight: FontWeight.w500),),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
          ),
        ],
      );
    },
  );
}
}