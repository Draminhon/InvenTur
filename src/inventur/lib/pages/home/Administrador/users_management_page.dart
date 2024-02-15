import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Administrador/controllers/user_controller.dart';
import 'package:inventur/pages/home/Administrador/widgets/popup_menu_widget.dart';
import 'package:inventur/pages/home/Administrador/widgets/user_card_widget.dart';
import 'package:inventur/pages/home/Administrador/widgets/users_property_management_widget.dart';

class UsersManagementPage extends StatefulWidget {
  final UserController userControllerNotifier;

  const UsersManagementPage({super.key, required this.userControllerNotifier});

  @override
  State<UsersManagementPage> createState() => _UsersManagementPageState();
}

class _UsersManagementPageState extends State<UsersManagementPage> {
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = widget.userControllerNotifier;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 13, top: 8, right: 13, bottom: 2),
          height: 40,
          child: SearchBar(
            hintText: 'Pesquisar',
            backgroundColor: MaterialStateProperty.all(Colors.white),
            surfaceTintColor: MaterialStateProperty.all(Colors.white),
            elevation: MaterialStateProperty.all(2),
            trailing: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 55, 111, 60),
                )
              ),
            ],
          )
        ),
        ListenableBuilder(
          listenable: _userController,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 13),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _userController.usersFilteredAccessLevel == 'Pesquisador'
                      ? PopupMenu(
                        popupIcon: Icons.filter_alt,
                        tooltip: 'Filtro selecionado',
                        itens: _userController.statusFilters, 
                        onChanged: _userController.filterUsersByStatus,
                      )
                      : const Row(),
                      PopupMenu(
                        popupIcon: Icons.group,
                        rightIconPosition: false,
                        tooltip: 'Grupo selecionado',
                        itens: _userController.accessLeves, 
                        onChanged: _userController.filterUsersByAccessLevel,
                      )
                    ],
                  ),
                  _userController.countSelectedUsers > 0
                  ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45)
                              ),
                              value: _userController.allSelectedUsers, 
                              visualDensity: VisualDensity.compact,
                              onChanged: (marked) {
                                _userController.setAllSelectedUsers(marked!);
                                marked
                                ? _userController.selectAllUsers()
                                : _userController.unselectAllUsers();
                              },
                            ),
                            Text('${_userController.countSelectedUsers} Usuário(s) selecionado(s)'),
                          ],
                        ),
                        ManageUsers(userControllerNotifier: _userController)
                      ],
                    ),
                  )
                  :Container()
                ],
              ),
            );
          },
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left:10, right: 10),
            child: ListenableBuilder(
              listenable: _userController,
              builder: (context, child) {
                return ListView.builder(
                  itemCount: _userController.filteredUsers.length,
                  itemBuilder: (context, index) {
                    return UserCard(
                      user: _userController.filteredUsers[index],
                      userControllerNotifier: _userController,
                    );
                  }
                );
              },
            )
          ),
        ),
      ],
    );
  }
}