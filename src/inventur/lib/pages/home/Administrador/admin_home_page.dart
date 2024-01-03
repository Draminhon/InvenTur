import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentPageIndex = 0;

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
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 55, 111, 60),
            foregroundColor: Colors.white,
            bottom: currentPageIndex == 0
            ? const TabBar(
              indicatorWeight: 0.5,
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              unselectedLabelColor: Colors.white,
              tabs: [
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
            tooltip: 'Adicionar Administrador',
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 55, 111, 60),
            child: const Icon(
              Icons.add,
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
            // selectedItemColor: const Color.fromARGB(255, 55, 111, 60),
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
            Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.brown,
                ),
              ],
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