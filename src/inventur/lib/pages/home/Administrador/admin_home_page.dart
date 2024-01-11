import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventur/pages/widgets/user_card_widget.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentPageIndex = 0;
  String currentTypeUser = 'Pesquisador';

  final List<String> typesUsers = ['Pesquisador', 'Administrador'];

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
          floatingActionButton: currentPageIndex == 0
          ? FloatingActionButton(
            onPressed: () {},
            shape: const CircleBorder(),
            tooltip: currentTypeUser == 'Pesquisador'
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
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  height: 40,
                  child: SearchBar(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {}, 
                      child: const Row(
                        children: [
                          Icon(Icons.filter_alt),
                          Text(
                            "Filtro",
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 13),
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: DropdownButton(
                        isDense: true,
                        underline: Container(),
                        value: currentTypeUser,
                        items: typesUsers.map<DropdownMenuItem<String>>((String type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(type)
                          );
                        }).toList(), 
                        onChanged: (value) {
                          setState(() {
                            currentTypeUser = value!;
                          });
                        }
                      ),
                    )
                  ],
                ),
                Container(
                  height: 477,
                  padding: const EdgeInsets.only(left:10, top: 5, right: 10, bottom: 10),
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return UserCard(
                        nome: users[index][0], 
                        cpf: users[index][1], 
                        email: users[index][2]
                      );
                    }
                  )
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