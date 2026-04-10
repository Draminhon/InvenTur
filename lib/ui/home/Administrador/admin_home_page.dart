import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sistur/models/user_model.dart';
import 'package:sistur/controllers/user_controller.dart';
import 'package:sistur/ui/home/Administrador/user_management_page.dart';
import 'package:sistur/ui/screens/pesquisa%20screens/pesquisas_page.dart';
import 'package:sistur/ui/widgets/options_drawer_widget.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sistur/services/secure_storage_service.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:sistur/models/user_model.dart';
import 'package:sistur/providers/providers.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  static Future<List<User>> getUsers() async {
    try {
      final response = await ApiService().get(AppConstants.GET_USERS);
      if (response.statusCode == 200) {
        final List body = response.data;
        return body.map((e) => User.fromJson(e)).toList();
      } else {
        print('Falha ao carregar usuários: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Erro ao carregar usuários: $e');
      return [];
    }
  }
  int currentPageIndex = 0;

  late PageController pageController;

  final UserController _userController = UserController();
    int userId = 0;
    String userName = '';
    String userEmail = '';
    String userCPF = '';
    String userTelefone = '';

  final Map<int, String> pageTitle = {
   // 0: 'Andamento das Pesquisas',
    0: 'Pesquisas Cadastradas',
    1: 'Gerenciar Usuários',
  };
  Future<void> getUserInfo() async {
    final secureStorage = SecureStorageService();
    String? userDataString = await secureStorage.read('user_data');
    if (userDataString != null) {
      Map<String, dynamic> userData = json.decode(userDataString);
      setState(() {
        userId = userData['id'];
        userName = userData['name'];
        userEmail = userData['email'];
        userCPF = userData['CPF'];
        userTelefone = userData['telefone'];

        User newUser = User(
          id: userId,
          username: userName,
          email: userEmail,
          CPF: userCPF,
          telefone: userTelefone,
          fotoPerfil: userData['foto_perfil'],
          fotoPerfilBase64: userData['foto_perfil_base64'],
          accessLevel: userData['acessLevel'] ?? 'Administrador',
        );
        Provider.of<UserProvider>(context, listen: false).setUser(newUser);
      });
    }
  }
  @override
  void initState()  {
    super.initState();
    pageController = PageController(initialPage: currentPageIndex);
    getUserInfo();
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
          child: OptionsDrawer(userController: _userController)
        ),
        appBar: AppBar(
          title: Text(pageTitle[currentPageIndex]!),
          foregroundColor: const Color.fromARGB(255, 55, 111, 60),
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    final user = userProvider.user;
                    return GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: user.fotoPerfilBase64 != null
                            ? MemoryImage(base64Decode(user.fotoPerfilBase64!))
                            : (user.fotoPerfil != null
                                ? NetworkImage(user.fullFotoPerfilUrl!)
                                : null) as ImageProvider?,
                        child: (user.fotoPerfil == null &&
                                user.fotoPerfilBase64 == null)
                            ? const Icon(
                                Icons.account_circle,
                                size: 40,
                                color: Color.fromARGB(255, 55, 111, 60),
                              )
                            : null,
                      ),
                    );
                  },
                ),
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
            // Container(
            //   width: 200,
            //   height: 200,
            //   color: Colors.green,
            // ),
            const PesquisasPage(),
            UserManagementPage(userControllerNotifier: _userController),
          ],
        ),
      ),
    );
  }
}