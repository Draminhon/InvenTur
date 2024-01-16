import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventur/pages/home/Administrador/widgets/popup_menu_widget.dart';
import 'package:inventur/pages/home/Administrador/widgets/user_card_widget.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentPageIndex = 0;
  String currentTypeUser = 'Pesquisador';
  String selectedFilter = 'Todos';
  int contUsersSelecteds = 0;

  late PageController pageController;
  
  final List<String> typesUsers = ['Pesquisador', 'Administrador'];
  final List<String> filters = ['Todos', 'Ativo', 'Não Ativo', 'Aguardando Aprovação'];

  final List<List<String>> users = [
    ["Tiago Alves de Lima", "000.000.000-00", "teste@teste.com"],
    ["Tiago Alves de Lima", "000.000.000-00", "teste@teste.com"],
    ["Tiago Alves de Lima", "000.000.000-00", "teste@teste.com"],
    ["Tiago Alves de Lima", "000.000.000-00", "teste@teste.com"],
    ["Tiago Alves de Lima", "000.000.000-00", "teste@teste.com"],
    ["Tiago Alves de Lima", "000.000.000-00", "teste@teste.com"],
    ["Tiago Alves de Lima", "000.000.000-00", "teste@teste.com"],
    ["Tiago Alves de Lima", "000.000.000-00", "teste@teste.com"],
    ["Tiago Alves de Lima", "000.000.000-00", "teste@teste.com"],
  ];

  void incrementUsersSelecteds() {
    setState(() {
      contUsersSelecteds++;
    });
  }
  
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPageIndex);
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
              tooltip: currentTypeUser == 'Administrador'
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
                              popupIcon: Icons.filter_alt,
                              tooltip: 'Filtro selecionado',
                            ),
                            PopupMenu(
                              itens: typesUsers, 
                              popupIcon: Icons.group,
                              rightIconPosition: false,
                              tooltip: 'Grupo selecionado',
                            )
                          ],
                        ),
                        contUsersSelecteds > 0
                        ? Row(
                          children: [
                            Text('$contUsersSelecteds Usuário(s) selecionado(s)')
                          ],
                        )
                        : Container()
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
                            callback: incrementUsersSelecteds,
                            nome: users[index][0], 
                            cpf: users[index][1], 
                            email: users[index][2]
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