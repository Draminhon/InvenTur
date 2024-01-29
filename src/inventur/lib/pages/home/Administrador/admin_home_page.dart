import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/home/Administrador/controllers/user_controller.dart';
import 'package:inventur/pages/home/Administrador/widgets/popup_menu_widget.dart';
import 'package:inventur/pages/home/Administrador/widgets/user_card_widget.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentPageIndex = 0;
  String currentUserGroup = 'Pesquisador';
  String selectedFilter = 'Todos';

  late PageController pageController;

  final UserController _userController = UserController();
  
  final List<String> typesUsers = ['Pesquisador', 'Administrador'];
  final List<String> filters = ['Todos', 'Ativo', 'Não Ativo', 'Aguardando Aprovação'];
  
  final List<UserModel> users = [
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Ativo"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Não Ativo"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Ativo"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Não Ativo"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação"),
    UserModel(nome: "Tiago Alves de Lima", cpf: "000.000.000-00", email: "teste@teste.com", status: "Aguardando Aprovação"),
  ];
  
  void insertFilter(value) {
    selectedFilter = value;
    setState(() {});
  }

  void setUserGroup(value) {
    currentUserGroup = value;
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPageIndex);
    _userController.setUsers(users);
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
              tooltip: currentUserGroup == 'Administrador'
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
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 13),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PopupMenu(
                              itens: filters, 
                              onChanged: insertFilter,
                              popupIcon: Icons.filter_alt,
                              tooltip: 'Filtro selecionado',
                            ),
                            PopupMenu(
                              itens: typesUsers, 
                              popupIcon: Icons.group,
                              onChanged: setUserGroup,
                              rightIconPosition: false,
                              tooltip: 'Grupo selecionado',
                            )
                          ],
                        ),
                        ListenableBuilder(
                          listenable: _userController, 
                          builder: (context, child) {
                            // if (_userController.countSelecedUsers > 0) {
                              return Padding(
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
                                        Text('${_userController.countSelecedUsers} Usuário(s) selecionado(s)'),
                                      ],
                                    ),
                                    IconButton(
                                      tooltip: 'Excluir selecionados',
                                      onPressed: () {}, 
                                      icon: Icon(
                                        Icons.delete, 
                                        color: Colors.red[700],
                                      )
                                    )
                                  ],
                                ),
                              );
                            // } else {
                            //   _userController.setAllSelectedUsers(false);
                            //   return Container();
                            // }
                          }
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left:10, right: 10),
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return UserCard(
                            user: users[index],
                            userControllerNotifier: _userController,
                          );
                        }
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