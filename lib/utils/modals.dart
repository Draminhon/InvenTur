import 'package:flutter/material.dart';

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
}