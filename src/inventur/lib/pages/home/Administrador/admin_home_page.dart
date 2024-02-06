import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/home/Administrador/controllers/user_controller.dart';
import 'package:inventur/pages/home/Administrador/widgets/manage_users_widget.dart';
import 'package:inventur/pages/home/Administrador/widgets/popup_menu_widget.dart';
import 'package:inventur/pages/home/Administrador/widgets/user_card_widget.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentPageIndex = 0;

  late PageController pageController;

  final UserController _userController = UserController();
  
  final List<UserModel> users = [
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", accessLevel: 'Administrador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
  ];
  
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPageIndex);
    _userController.setUsers(users);
    _userController.populateFilteredUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        fontFamily: GoogleFonts.aBeeZee().fontFamily,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
          drawer: const Drawer(
            backgroundColor: Color.fromARGB(255, 245, 245, 245),
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('accountName'), 
                  accountEmail: Text('accountEmail'),
                  currentAccountPicture: CircleAvatar(
                    child: Icon(
                      Icons.admin_panel_settings,
                      size: 65,
                    ),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            foregroundColor: const Color.fromARGB(255, 55, 111, 60),
            backgroundColor: Colors.white,
          ),
          floatingActionButton: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: currentPageIndex == 1
            ? FloatingActionButton(
              onPressed: () {},
              shape: const CircleBorder(),
              tooltip: _userController.usersFilteredAccessLevel == 'Administrador'
                ? 'Adicionar Administrador'
                : 'Adicionar Pesquisador',
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 55, 111, 60),
              child: const Icon(
                Icons.person_add_alt_1_rounded,
                size: 35,
              ),
            )
            : null,
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (page) {
              pageController.animateToPage(
                page, 
                duration: const Duration(milliseconds: 400), 
                curve: Curves.linear
              );
            },
            currentIndex: currentPageIndex,
            selectedItemColor: const Color.fromARGB(255, 55, 111, 60),
            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart),
                label: 'Business'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups),
                label: 'Gerenciar Usuários'
              ),
            ],
          ),
          body: PageView(
            controller: pageController,
            onPageChanged: (page) {
              setState(() {
                currentPageIndex = page;
              });
            },
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.green,
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 13, top: 8, right: 13, bottom: 2),
                    height: 40,
                    child: SearchBar(
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
                        )
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
                                  onChanged: _userController.filterUsersStatus,
                                )
                                : const Row(),
                                PopupMenu(
                                  popupIcon: Icons.group,
                                  rightIconPosition: false,
                                  tooltip: 'Grupo selecionado',
                                  itens: _userController.accessLeves, 
                                  onChanged: _userController.filterUsersAccessLevel,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}