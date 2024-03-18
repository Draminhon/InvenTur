import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/home/Administrador/controllers/user_controller.dart';
import 'package:inventur/pages/home/Administrador/users_management_page.dart';

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
    UserModel(nome: "Tiago Alves de Lima", cpf: "015.235.444-05", email: "tiago@teste.com", accessLevel: 'Administrador'),
    UserModel(nome: "Fulano de Tal da Silva", cpf: "245.555.48-90", email: "fulano@teste.com", accessLevel: 'Administrador'),
    UserModel(nome: "Fulano Silva da Costa", cpf: "789.214.878-02", email: "fulanosilva@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    UserModel(nome: "Ciclano Fonseca Silva", cpf: "584.978.010-80", email: "ciclano@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Beltrano Alves Oliveira", cpf: "785.441.210-70", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
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
        checkboxTheme: const CheckboxThemeData(
          side: BorderSide(
            color: Color.fromARGB(255, 55, 111, 60),
            width: 1.8
          ),
        )
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
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
              UsersManagementPage(userControllerNotifier: _userController),
            ],
          ),
        ),
      ),
    );
  }
}