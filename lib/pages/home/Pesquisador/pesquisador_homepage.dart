import 'package:flutter/material.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/pages/controllers/user_controller.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_widget.dart';
import 'package:intl/intl.dart';
import 'package:inventur/pages/widgets/options_drawer_widget.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/services/offline_login.dart';
import 'package:inventur/services/sync_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/utils/check_connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

// Future<void> refreshToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   String? refresh = prefs.getString('refresh_token');

//   if (refresh != null) {
//     var url = Uri.parse('${AppConstants.BASE_URI}api/token/refresh/');
//     var response = await http.post(
//       url,
//       headers: {
//         "Content-Type": "application/json",
//       },
//       body: json.encode({"refresh": refresh}),
//     );

//     if (response.statusCode == 200) {
//       var body = json.decode(response.body);
//       prefs.setString('access_token', body['access']);
//       print('Token atualizado com sucesso.');
//     } else {
//       print('Erro ao atualizar token: ${response.body}');
//     }
//   }
// }

class PesquisadorHome extends StatefulWidget {
  const PesquisadorHome({super.key});

  @override
  State<PesquisadorHome> createState() => _PesquisadorHomeState();
}

class _PesquisadorHomeState extends State<PesquisadorHome> {
  static Future<List<Pesquisa>> getPesquisas() async {
    try {
      // Obtém a instância das preferências e o token de acesso
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');
      if (token == null) {
        print("Token de acesso não encontrado.");
        return [];
      }

      // Define a URL da API
      final url = Uri.parse('${AppConstants.BASE_URI}pesquisas/usuario/');

      // Realiza a requisição GET com o token atual
      http.Response response = await _getWithToken(url, token);

      // Se o token expirou, tenta atualizar e refazer a requisição
      if (response.statusCode == 401) {
      //  await refreshToken();
        token = prefs.getString('access_token');
        if (token == null) {
          print("Falha ao atualizar o token de acesso.");
          return [];
        }
        print('Novo token fornecido: $token');
        response = await _getWithToken(url, token);
      }

      // Se a resposta for bem-sucedida, decodifica o JSON e retorna a lista de pesquisas
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return data.map((item) => Pesquisa.fromJson(item)).toList();
      } else {
        // Em caso de erro, loga os detalhes e retorna lista vazia
        print("Falha ao carregar pesquisas. Status: ${response.statusCode}");
        print("Resposta: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Ocorreu um erro ao buscar as pesquisas: $e");
      return [];
    }
  }

  /// Realiza uma requisição GET com o token de autorização informado.
  static Future<http.Response> _getWithToken(Uri url, String token) async {
    return await http.get(url, headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    });
  }

  Future<List<Pesquisa>> pesquisasFuture = getPesquisas();
  final UserController _userController = UserController();

  int userId = 0;
  String userName = '';
  String userEmail = '';
  String userCPF = '';
  String userStatus = '';
  String userTelefone = '';
  Future<void> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      Map<String, dynamic> userData = json.decode(userDataString);
      setState(() {
        userName = userData['name'];
        userEmail = userData['email'];
        userCPF = userData['CPF'];
        userStatus = userData['status'];
        userId = userData['id'];
        userTelefone = userData['telefone'];
      });
    }
  }
  late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
  bool isConnected = false;
  int qtdeBanco = 0;
  List<Pesquisa> pesquisasOff = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
    checar();
    getPesquisasOff();
    getQtdeBanco();
    initConnectivity();
    connectivitySubscription = Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  pesquisasFuture = getPesquisas();
  }
 Future<void> getQtdeBanco() async {
    int getqtd = await DataSyncService().getPendingCount();
    if (mounted) {
      setState(() {
        qtdeBanco = getqtd;
      });
    }
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getUserInfo();
  }

      @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }
    Future<void> initConnectivity() async {
    final results = await Connectivity().checkConnectivity();
    return _updateConnectionStatus(results);
  }
    Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    final newConnectionStatus = !results.contains(ConnectivityResult.none);
    
    if (newConnectionStatus != isConnected) {
      setState(() {
        isConnected = newConnectionStatus;
        print("Status da conexão alterado para: $isConnected");
      });
    }
  }

  CheckConnectivity connection = new CheckConnectivity();

  Future<void> getPesquisasOff() async {
    List<Pesquisa> pesquisas = await getPesquisasOffline();

    setState(() {
      pesquisasOff = pesquisas;
    });
  }

  Future<void> checar() async {
    bool online = await connection.checarConexaoUmaVez();
    print('Conexão: $online');
    setState(() {
      isConnected = online;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    DateTime now = DateTime.now();
    var inputFormat = DateFormat('dd/MM/yyyy');

    var outputFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          foregroundColor: const Color.fromARGB(255, 55, 111, 60),
          backgroundColor: Colors.white,
          title: Text(
            'Minhas Pesquisas',
            style: TextStyle(
                color: const Color.fromARGB(255, 55, 111, 60),
                fontSize: sizeScreen.width * 0.06),
          ),
          centerTitle: true,
        ),
        drawer: SafeArea(
            child: OptionsDrawer(
          userId: userId,
          userController: _userController,
          userName: userName,
          userEmail: userEmail,
          cpf: userCPF,
          telefone: userTelefone,
        )),
        body: Padding(
            padding: EdgeInsets.only(
              left: sizeScreen.height * 0.02,
              right: sizeScreen.height * 0.02,
            ),
            child: FutureBuilder<List<Pesquisa>>(
              future: pesquisasFuture,
              builder: (context, snapshot) {
                if (userStatus == 'Aguardando Aprovação') {
                  return Container(
                      margin: EdgeInsets.only(top: 1000.h),
                      padding: EdgeInsets.only(left: 100.w),
                      height: 350.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromARGB(255, 55, 111, 60),
                            width: 10.h,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: const Text(
                          "Você não possui permissão para acessar as pesquisas, contate um administrador.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ));
                } else {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: const CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final pesquisa = snapshot.data!;
                    if (pesquisa.isEmpty) {
                      return showPesquisas(pesquisasOff);
                    }
                    return showPesquisas(pesquisa);
                  } else {
                    return Container(
                        margin: EdgeInsets.only(top: 1000.h),
                        padding: EdgeInsets.only(left: 50.w),
                        height: 350.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 55, 111, 60),
                              width: 10.h,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: const Text(
                            "Você não está participando de nenhuma pesquisa. Aguarde até que você seja designado para alguma pesquisa.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ));
                  }
                }
              },
            )),
            bottomNavigationBar: (isConnected && qtdeBanco >= 1)
            ? Container(
                height: 250.w,
                margin: EdgeInsets.only(left: 55.w, right: 55.w, bottom: 150.w),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                        vertical: 34.904.h,
                      )),
                      backgroundColor: WidgetStateProperty.all(
                          const Color.fromARGB(255, 55, 111, 60)),
                      overlayColor: WidgetStateProperty.all(
                          const Color.fromARGB(255, 55, 111, 60))),
                  onPressed: () async {
                    await DataSyncService().syncPending();
                    // Após sincronizar, atualiza a contagem de itens pendentes
                    await getQtdeBanco();
                  },
                  child: Text(
                    'Sincronizar agora',
                    style: TextStyle(color: Colors.white, fontSize: 65.76.w),
                  ),
                ),
              )
            : const SizedBox.shrink(), // Se não estiver conectado ou não houver dados, não mostra nada
        );
  }
}

Widget showPesquisas(List<Pesquisa> posts) {
  print("a funcao foi chamadaaa");
  final filteredPosts =
      posts.where((post) => post.status != "Não Iniciado").toList();

  if (filteredPosts.isEmpty) {
    return Container(
        margin: EdgeInsets.only(top: 1000.h),
        height: 350.h,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(255, 55, 111, 60),
              width: 10.h,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: const Text(
            "Não há pesquisas disponíveis no momento.",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }

  return SizedBox(
    child: ListView.builder(
      itemCount: filteredPosts.length,
      itemBuilder: (context, index) {
        final post = filteredPosts[index];
        final post2 = getPesquisasOffline();
        return GestureDetector(
          onTap: () async {
            try {
              final prefs = await SharedPreferences.getInstance();

              if (post.adminEmail != null && post.adminTelefone != null) {
                Future<void> obterNomeAdmin() async {
                  final adminUsername =
                      await AdminService.getAdminName(post.adminId!);
                  prefs.setString('adminName', adminUsername.toString());
                }

                obterNomeAdmin();

                prefs.setString('adminEmail', post.adminEmail!);
                prefs.setString('adminTelefone', post.adminTelefone!);
              }
            } catch (e) {
              print('Erro ao adicionar email ou telefone do administrador');
            }

            savePesquisaId(post.id!);

            Navigator.pushNamed(context, '/Pesquisas',
                arguments: {'pesquisa_id': post.id});
          },
          child: PesquisaPesquisadorCardWidget(
            pesquisa: post,
          ),
        );
      },
    ),
  );
}
