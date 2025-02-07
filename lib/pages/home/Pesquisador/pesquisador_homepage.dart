import 'package:flutter/material.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/pages/controllers/user_controller.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_widget.dart';
import 'package:intl/intl.dart';
import 'package:inventur/pages/widgets/options_drawer_widget.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> refreshToken() async {
  final prefs = await SharedPreferences.getInstance();
  String? refresh = prefs.getString('refresh_token');

  if (refresh != null) {
    var url = Uri.parse('${AppConstants.BASE_URI}/api/v1/api/token/refresh/');
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({"refresh": refresh}),
    );

    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      prefs.setString('acess_token', body['access']);
      print('Token atualizado com sucesso.');
    } else {
      print('Erro ao atualizar token: ${response.body}');
    }
  }
}

class PesquisadorHome extends StatefulWidget {
  const PesquisadorHome({super.key});

  @override
  State<PesquisadorHome> createState() => _PesquisadorHomeState();
}

class _PesquisadorHomeState extends State<PesquisadorHome> {





  static Future<List<Pesquisa>> getPesquisas() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = await prefs.getString('acess_token');
    var url = Uri.parse('${AppConstants.BASE_URI}/api/v1/pesquisas/usuario/');
    var response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    });

    if (response.statusCode == 401) {
      await refreshToken();

      token = prefs.getString('acess_token');

      response = await http.get(url, headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      });
    }

    if (response.statusCode == 200) {
      final List body = json.decode(utf8.decode(response.bodyBytes));

      return body.map((e) => Pesquisa.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<Pesquisa>> pesquisasFuture = getPesquisas();
  final UserController _userController = UserController();

  String userName = '';
  String userEmail = '';
  String userCPF = '';
  String userStatus = '';
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
        print(userStatus);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo();
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
          userController: _userController,
          userName: userName,
          userEmail: userEmail,
          cpf: userCPF,
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
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    final pesquisa = snapshot.data!;
                    if (pesquisa.isEmpty) {
                     return Container(
                    margin: EdgeInsets.only(top: 1000.h),
                    padding: EdgeInsets.only(left: 50.w,),
                    height: 450.h,
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
            )));
  }
}

Widget showPesquisas(List<Pesquisa> posts) {

  final filteredPosts = posts.where((post) => post.status != "Não Iniciado").toList();

  if(filteredPosts.isEmpty){
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
        return GestureDetector(
          onTap: () {

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
