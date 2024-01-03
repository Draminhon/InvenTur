import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 55, 111, 60),
        foregroundColor: Colors.white,
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
        Container(
          width: 200,
          height: 200,
          color: Colors.brown,
        ),
        Container(
          width: 200,
          height: 200,
          color: Colors.green,
        )
      ][currentPageIndex],
    );
  }
}