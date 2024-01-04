import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentPageIndex = 0;
  int currentManageIndex = 0;

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
          drawer: const Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('accountName'), 
                  accountEmail: Text('accountEmail'),
                  currentAccountPicture: CircleAvatar(
                    child: Icon(
                      Icons.person,
                      size: 65,
                    ),
                  ),
                )
              ],
            ),
          ),
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 55, 111, 60),
            bottom: currentPageIndex == 0
            ? TabBar(
              onTap: (int index) {
                setState(() {
                  currentManageIndex = index;
                });
              },
              indicatorWeight: 0.5,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(
                  text: 'Gerenciar Pesquisadores',
                  icon: Icon(Icons.supervised_user_circle)
                ),
                Tab(
                  text: 'Gerenciar Administradores',
                  icon: Icon(Icons.directions_transit)
                )
              ]
            )
            : null,
          ),
          floatingActionButton: currentPageIndex == 0
          ? FloatingActionButton(
            onPressed: () {},
            shape: const CircleBorder(),
            tooltip: currentManageIndex == 1
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
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            currentIndex: currentPageIndex,
            selectedItemColor: const Color.fromARGB(255, 55, 111, 60),
            items: const <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                icon: Icon(Icons.groups),
                label: 'Gerenciar Usuários'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business'
              ),
            ],
          ),
          body: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    height: 200,
                    color: Colors.red,
                  ),
                ],
              )
            ),
            Container(
              width: 200,
              height: 200,
              color: Colors.green,
            )
          ][currentPageIndex],
        ),
      ),
    );
  }
}