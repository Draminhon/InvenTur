import 'package:flutter/material.dart';
import 'package:sistur/models/user_model.dart';
import 'package:sistur/controllers/pesquisa_controller.dart';

class UserPesquisaCardList extends StatelessWidget {
  final User user;
  final bool isSelected;
  final bool xIsVisible;
  final void Function(User)? onRemove;

  const UserPesquisaCardList({
    super.key,
    required this.user,
    this.isSelected = false,
    this.xIsVisible = false,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
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
                      const Text("Nome:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(user.username)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Email:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(user.email)
                    ],
                  ),
                ],
              ),
            ),
            if (xIsVisible && onRemove != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  onPressed: () => onRemove!(user),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Color.fromARGB(255, 232, 0, 0),
                    size: 36,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

 



