import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/controllers/user_controller.dart';

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
  
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = widget.userControllerNotifier;
  }

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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.user.accessLevel == 'Pesquisador'
                ? Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  value: widget.user.isSelected, 
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) {
                    widget.user.isSelected = value!;
                    value
                    ? _userController.selectUser(user: widget.user)
                    : _userController.unselectUser(user: widget.user);
                  },
                )
                : const Padding(padding: EdgeInsets.only(left: 10)),
                IconButton(
                  onPressed: () {}, 
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red[700],
                  )
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: const Color.fromARGB(255, 55, 111, 60),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nome:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          widget.user.nome,
                          textAlign: TextAlign.end,
                          style: const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'CPF:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.user.cpf)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'E-mail:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 200,
                        child: Text(
                          widget.user.email,
                          textAlign: TextAlign.end,
                          style: const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            widget.user.accessLevel == 'Pesquisador'
            ? Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: const Color.fromARGB(255, 55, 111, 60),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: PopupMenuButton(
                enableFeedback: true,
                initialValue: widget.user.status,
                tooltip: 'Status do pesquisador',
                surfaceTintColor: Colors.white,
                itemBuilder: (context) {
                  return _userController.statusItems.map<PopupMenuItem<String>>(
                    (String value) {
                      return PopupMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }
                  ).toList();
                },
                onSelected: (String value) {
                  _userController.setUserStatus(value, widget.user);
                  _userController.populateFilteredUsers();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(
                        color: _userController.statusColor(widget.user.status!),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      widget.user.status!,
                      style: TextStyle(
                        color: _userController.statusColor(widget.user.status!),
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Icon(
                      color: _userController.statusColor(widget.user.status!),
                      Icons.keyboard_arrow_down
                    ),
                  ],
                ),
              ),
            )
            : Container(),
          ],
        ),
      ),
    );
  }
}