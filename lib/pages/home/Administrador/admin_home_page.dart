import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/controllers/user_controller.dart';
import 'package:inventur/pages/home/Administrador/user_management_page.dart';
import 'package:inventur/pages/pesquisas/pesquisas_page.dart';
import 'package:inventur/pages/widgets/options_drawer_widget.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  static Future<List<User>> getUsers() async {
    var url = Uri.parse(AppConstants.BASE_URI + AppConstants.GET_USERS);
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(utf8.decode(response.bodyBytes));
    return body.map((e) => User.fromJson(e)).toList();
  }
  int currentPageIndex = 0;

  late PageController pageController;

  final UserController _userController = UserController();
  
  

  final Map<int, String> pageTitle = {
    0: 'Andamento das Pesquisas',
    1: 'Pesquisas Cadastradas',
    2: 'Gerenciar Usuários',
  };
  
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> loadUsers() async{
    List<User> users = await getUsers();
    _userController.setUsers(users);
    _userController.populateFilteredUsers();
    }
    loadUsers();
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
            const PesquisasPage(),
            UserManagementPage(userControllerNotifier: _userController),
          ],
        ),
      ),
    );
  }
}