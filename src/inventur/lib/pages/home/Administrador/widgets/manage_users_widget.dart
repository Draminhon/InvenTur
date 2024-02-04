import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Administrador/controllers/user_controller.dart';
import 'package:inventur/pages/widgets/divider_text_widget.dart';

class ManageUsers extends StatefulWidget {
  final UserController userControllerNotifier;

  const ManageUsers({super.key, required this.userControllerNotifier});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  late List<String> statusItems;
  String groupValue = '';

  @override
  void initState() {
    super.initState();
    statusItems = widget.userControllerNotifier.statusItems;
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    
    return IconButton(
      tooltip: 'Gerenciar usuários selecionados',
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  height: 420,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: Text(
                          'Ações aplicadas nos usuários selecionados',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: DividerText(text: 'Alterar status dos usuários')
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: statusItems.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(statusItems[index]),
                              leading: Radio(
                                value: statusItems[index], 
                                groupValue: groupValue, 
                                onChanged: (value) {
                                  widget.userControllerNotifier.changeUserStatus(value!);
                                  setState(() {
                                    groupValue = value;
                                  });
                                }
                              ),
                            );
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: DividerText(text: 'Excluir Usuários')
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 14),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                vertical: sizeScreen.height * 0.012
                              )
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.red[700]
                            ),
                            overlayColor: MaterialStateProperty.all(
                              Colors.red[400]
                            )
                          ),
                          onPressed: () {
                            
                          }, 
                          child: const Text(
                            'Excluir Usuários',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                );
              }
            );
          },
        );
        groupValue = '';
      }, 
      icon: const Icon(
        Icons.manage_accounts,
        color: Color.fromARGB(255, 55, 111, 60),
      )
    );
  }
}