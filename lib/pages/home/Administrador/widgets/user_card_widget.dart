import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/controllers/user_controller.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:http/http.dart' as http;



class UserCard extends StatelessWidget {
  final User user;
  final UserController userControllerNotifier;

  const UserCard({
    super.key,
    required this.user,
    required this.userControllerNotifier,
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                user.accessLevel == 'Pesquisador'
                    ? Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        value: user.isSelected,
                        visualDensity: VisualDensity.compact,
                        onChanged: (value) {
                          user.isSelected = value!;
                          value
                              ? userControllerNotifier.selectUser(user: user)
                              : userControllerNotifier.unselectUser(user: user);
                        },
                      )
                    : const Padding(padding: EdgeInsets.only(left: 10)),
                IconButton(
                  onPressed: ()async {

                         userControllerNotifier.removeUser(false, user);
                          userControllerNotifier.populateFilteredUsers();


                  }, 
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red[700],
                  ),
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
                          user.username,
                          textAlign: TextAlign.end,
                          style: const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'CPF:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(user.CPF),
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
                          user.email,
                          textAlign: TextAlign.end,
                          style: const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            user.accessLevel == 'Pesquisador'
                ? Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: const Color.fromARGB(255, 55, 111, 60),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: PopupMenuButton(
                      enableFeedback: true,
                      color: Colors.white,
                      initialValue: user.status,
                      tooltip: 'Status do Pesquisador',
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      itemBuilder: (context) {
                        return userControllerNotifier.statusItems
                            .map<PopupMenuItem<String>>(
                          (String value) {
                            return PopupMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList();
                      },
                      onSelected: (String value) {
                        userControllerNotifier.setUserStatus(value, user);
                        userControllerNotifier.populateFilteredUsers();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(
                                color:
                                    userControllerNotifier.statusColor(user.status),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              user.status,
                              style: TextStyle(
                                  color:
                                      userControllerNotifier.statusColor(user.status),
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: userControllerNotifier.statusColor(user.status),
                            ),
                          ],
                        ),
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
