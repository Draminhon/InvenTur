import 'package:flutter/material.dart';
import 'package:inventur/pages/controllers/user_controller.dart';
import 'package:inventur/pages/home/Administrador/dialogs/admin_register_dialog.dart';
import 'package:inventur/pages/home/Administrador/widgets/popup_menu_widget.dart';
import 'package:inventur/pages/home/Administrador/widgets/user_card_widget.dart';
import 'package:inventur/pages/home/Administrador/dialogs/user_management_dialog.dart';

class UserManagementPage extends StatefulWidget {
  final UserController userControllerNotifier;

  const UserManagementPage({super.key, required this.userControllerNotifier});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final TextEditingController _searchController = TextEditingController();

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
            controller: _searchController,
            backgroundColor: WidgetStateProperty.all(Colors.white),
            surfaceTintColor: WidgetStateProperty.all(Colors.white),
            elevation: WidgetStateProperty.all(2),
            trailing: [
              IconButton(
                onPressed: () {
                  _userController.searchUsers(_searchController.text);
                },
                icon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 55, 111, 60),
                )
              ),
            ],
            onChanged: (value) {
              if (value == '') _userController.populateFilteredUsers();
            },
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
                        tooltip: 'Status filtrado',
                        itens: _userController.statusFilters, 
                        onChanged: _userController.filterUsersByStatus,
                        selectedItem: _userController.usersFilteredStatus,
                      )
                      : AdminRegisterDialogButton(userControllerNotifier: _userController),
                      PopupMenu(
                        popupIcon: Icons.group,
                        rightIconPosition: false,
                        tooltip: 'Grupo filtrado',
                        itens: _userController.accessLeves, 
                        onChanged: _userController.filterUsersByAccessLevel,
                        selectedItem: _userController.usersFilteredAccessLevel,
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
                        UserManagementDialogButton(userControllerNotifier: _userController)
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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListenableBuilder(
              listenable: _userController,
              builder: (context, child) {
                return _userController.filteredUsers.isNotEmpty
                  ? ListView.builder(
                  itemCount: _userController.filteredUsers.length,
                  itemBuilder: (context, index) {
                    return UserCard(
                      user: _userController.filteredUsers[index],
                      userControllerNotifier: _userController,
                    );
                  }
                )
                : const Center(
                  child: Text('Nenhum Usuário Cadastrado'),
                );
              },
            )
          ),
        ),
      ],
    );
  }
}