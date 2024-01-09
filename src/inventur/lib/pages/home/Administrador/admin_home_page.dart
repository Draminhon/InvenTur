import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<String> statusItems = ['Pendente', 'Ativo', 'Não Ativo'];

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int currentPageIndex = 0;
  int currentManageIndex = 0;

  String dropValue = statusItems.first;

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
              color: const Color.fromARGB(255, 245, 245, 245),
              child: currentManageIndex == 0
              ? ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Container(
                  //   height: 200,
                  //   color: Colors.red,
                  // ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 12,
                        top: 5,
                        right: 2,
                        bottom: 5
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: false, 
                                    onChanged: (selected) {}
                                  ),
                                  Text('Nome')
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Status: '),
                                  
                                  // DropdownButton(
                                  //   isDense: true,
                                  //   value: dropValue,
                                  //   dropdownColor: Colors.green[100],
                                  //   alignment: AlignmentDirectional.center,
                                  //   borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  //   items: statusItems.map<DropdownMenuItem<String>>((String status) {
                                  //     return DropdownMenuItem<String>(
                                  //       value: status,
                                  //       child: Text(status),
                                  //     );
                                  //   }).toList(), 
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       dropValue = value!;
                                  //     });
                                  //   }
                                  // ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {}, 
                                icon: Icon(Icons.edit)
                              ),
                              IconButton(
                                onPressed: () {}, 
                                icon: Icon(Icons.delete)
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ),
                ],
              )
              : Container(
                width: 200,
                height: 200,
                color: Colors.blue,
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