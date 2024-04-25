import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inventur/models/user_model.dart';

class UserPesquisaCard extends StatelessWidget {
  final UserModel user;
  const UserPesquisaCard({super.key, required this.user});

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
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.close_rounded,
                color: Color.fromARGB(255, 232, 0, 0),
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}