import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';

class UserPesquisaCard extends StatelessWidget {
  final UserModel user;
  final PesquisaController pesquisaController;
  
  const UserPesquisaCard({
    super.key,
    required this.user,
    required this.pesquisaController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Nome:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(user.nome)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("CPF:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(user.cpf)
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  pesquisaController.removeUserPesquisa(user);
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Color.fromARGB(255, 232, 0, 0),
                  size: 36,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}