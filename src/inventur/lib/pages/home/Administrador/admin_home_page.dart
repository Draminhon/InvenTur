import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/controllers/user_controller.dart';
import 'package:inventur/pages/home/Administrador/user_management_page.dart';
import 'package:inventur/pages/pesquisas/pesquisas_page.dart';
import 'package:inventur/pages/widgets/options_drawer_widget.dart';

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

  final Map<int, String> pageTitle = {
    0: 'Andamento das Pesquisas',
    1: 'Pesquisas Cadastradas',
    2: 'Gerenciar Usuários',
  };
  
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPageIndex);
    _userController.setUsers(users);
    _userController.populateFilteredUsers();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        drawer: SafeArea(
          child: OptionsDrawer(userController: _userController,)
        ),
        appBar: AppBar(
          title: Text(pageTitle[currentPageIndex]!),
          foregroundColor: const Color.fromARGB(255, 55, 111, 60),
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(
                  Icons.account_circle,
                  size: 35,
                ),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          useLegacyColorScheme: false,
          currentIndex: currentPageIndex,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          onTap: (page) {
            pageController.animateToPage(
              page, 
              duration: const Duration(milliseconds: 400), 
              curve: Curves.ease
            );
          },
          selectedItemColor: const Color.fromARGB(255, 55, 111, 60),
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              label: 'Andamento'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_search),
              label: 'Pesquisas'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: 'Usuários'
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
            PesquisasPage(),
            UserManagementPage(userControllerNotifier: _userController),
          ],
        ),
      ),
    );
  }
}