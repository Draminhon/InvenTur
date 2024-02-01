import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/home/Administrador/controllers/user_controller.dart';

class UserCard extends StatefulWidget {
  final UserModel user;
  final UserController userControllerNotifier;

  const UserCard({
    super.key,
    required this.user,
    required this.userControllerNotifier,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45)
                            ),
                            value: widget.user.isSelected, 
                            visualDensity: VisualDensity.compact,
                            onChanged: (value) {
                              widget.user.isSelected = value!;
                              value
                              ? widget.userControllerNotifier.selectUser(user: widget.user)
                              : widget.userControllerNotifier.unselectUser(user: widget.user);
                            },
                          ),
                          Text(
                            widget.user.nome,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 14, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.cpf,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18
                            ),
                          ),
                          Text(
                            widget.user.email,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green[700],
                      )
                    ),
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[700],
                      )
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              decoration: BoxDecoration(
                color: widget.userControllerNotifier.statusColor(widget.user.status),
                border: Border.all(
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(5)
              ),
              child: PopupMenuButton(
                enableFeedback: true,
                initialValue: widget.user.status,
                tooltip: 'Status do pesquisador',
                surfaceTintColor: Colors.white,
                itemBuilder: (context) {
                  return widget.userControllerNotifier.statusItems.map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList();
                },
                onSelected: (String value) {
                  widget.userControllerNotifier.setUserStatus(value, widget.user);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Status:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                    ),
                    Text(
                      widget.user.status,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}