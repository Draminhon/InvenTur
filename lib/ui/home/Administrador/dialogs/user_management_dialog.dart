import 'package:flutter/material.dart';
import 'package:sistur/controllers/user_controller.dart';
import 'package:sistur/ui/widgets/text%20fields/divider_text_widget.dart';

class UserManagementDialogButton extends StatelessWidget {
  final UserController userControllerNotifier;

  const UserManagementDialogButton({super.key, required this.userControllerNotifier});

  @override
  Widget build(BuildContext context) {
    
    return IconButton(
      tooltip: 'Gerenciar usuários selecionados',
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => UserManagementDialog(
            userControllerNotifier: userControllerNotifier
          ),
        );
      },
      icon: const Icon(
        Icons.manage_accounts,
        color: Color.fromARGB(255, 55, 111, 60),
      )
    );
  }
}

class UserManagementDialog extends StatefulWidget {
  final UserController userControllerNotifier;

  const UserManagementDialog({super.key, required this.userControllerNotifier});

  @override
  State<UserManagementDialog> createState() => _UserManagementDialogState();
}

class _UserManagementDialogState extends State<UserManagementDialog> with SingleTickerProviderStateMixin {
  late List<String> statusItems;
  late UserController _userController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  String radioGroupValue = '';

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();

    statusItems = widget.userControllerNotifier.statusItems;
    _userController = widget.userControllerNotifier;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  Row(
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.comfortable,
                        onPressed: () {
                          _animationController.reverse();
                          Navigator.of(context).pop();
                          _userController.unselectAllUsers();
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.red[700]),
                          shadowColor: const WidgetStatePropertyAll(Colors.white),
                          overlayColor: WidgetStatePropertyAll(Colors.red[500]),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap
                        ),
                        icon: const Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Ações aplicadas nos usuários\nselecionados',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                      const Spacer(),
                    ],
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
                          _animationController.reverse();
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
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        side: const WidgetStatePropertyAll(
                          BorderSide(
                            width: 2,
                            color: Colors.red
                          )
                        ),
                        overlayColor: WidgetStatePropertyAll(
                          Colors.red[100]
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
    );
  }
}