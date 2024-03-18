import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Administrador/controllers/user_controller.dart';
import 'package:inventur/pages/widgets/divider_text_widget.dart';

class ManageUsersDialog extends StatefulWidget {
  final UserController userControllerNotifier;

  const ManageUsersDialog({super.key, required this.userControllerNotifier});

  @override
  State<ManageUsersDialog> createState() => _ManageUsersDialogState();
}

class _ManageUsersDialogState extends State<ManageUsersDialog> {
  late List<String> statusItems;
  late UserController _userController;

  String radioGroupValue = '';

  @override
  void initState() {
    super.initState();
    statusItems = widget.userControllerNotifier.statusItems;
    _userController = widget.userControllerNotifier;
  }

  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      tooltip: 'Gerenciar usuários selecionados',
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) => Dialog(
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _userController.unselectAllUsers();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red[700]),
                        shadowColor: const MaterialStatePropertyAll(Colors.white),
                        overlayColor: MaterialStatePropertyAll(Colors.red[500])
                      ),
                      icon: const Icon(
                        Icons.close,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 2,
                        color: const Color.fromARGB(255, 55, 111, 60),
                      ),
                      borderRadius: BorderRadius.circular(20)
                    ),
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
                        ...statusItems.map(
                          (status) => ListTile(
                            title: Text(status),
                            leading: Radio(
                              value: status,
                              groupValue: radioGroupValue,
                              onChanged: (value) {
                                _userController.changeSelectedUsersStatus(value!);
                                setState(() {
                                  radioGroupValue = value;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 10),
                          child: DividerText(text: 'Excluir Usuários')
                        ),
                        SizedBox(
                          height: 40,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              side: const BorderSide(
                                width: 2,
                                color: Colors.red
                              )
                            ),
                            onPressed: () {}, 
                            child: const Text(
                              'Excluir Usuários',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 22
                              ),
                            )
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        radioGroupValue = '';
      },
      icon: const Icon(
        Icons.manage_accounts,
        color: Color.fromARGB(255, 55, 111, 60),
      )
    );
  }
}