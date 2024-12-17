import 'package:flutter/material.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_widget.dart';
import 'package:intl/intl.dart';
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
    var response =
        await http.get(url, headers: {
          
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"});

      if(response.statusCode == 401){
        await  refreshToken();

        token = prefs.getString('acess_token');

        response = await http.get(url,  headers: {
                "Authorization": "Bearer $token",
            "Content-Type": "application/json"
        });
      }

      if(response.statusCode == 200){
   final List body = json.decode(utf8.decode(response.bodyBytes));
    
    return body.map((e) => Pesquisa.fromJson(e)).toList();
      }else{
        return [];
      }
 
  }

  Future<List<Pesquisa>> pesquisasFuture = getPesquisas();

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
        drawer: Drawer(
          width: sizeScreen.width * 0.6,
          child: Column(
            // padding:  EdgeInsets.zero,

            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text('Ex'),
                accountEmail: Text(
                  'ex@gmail.com',
                ),
                currentAccountPicture: CircleAvatar(
                  child: Text('Sz'),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Conta'),
                onTap: () {
                  Navigator.pushNamed(context, '/PerfilPesquisador');
                },
              )
            ],
          ),
        ),
        body: Padding(
            padding: EdgeInsets.only(
              top: sizeScreen.height * 0.01,
              left: sizeScreen.height * 0.02,
              right: sizeScreen.height * 0.02,
            ),
            child: FutureBuilder<List<Pesquisa>>(
              future: pesquisasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  final pesquisa = snapshot.data!;
                  if (pesquisa.isEmpty) {
                    return const Text(
                        "Você não está participando de nenhuma pesquisa.");
                  }
                  return showPesquisas(pesquisa);
                } else {
                  return const Text(
                      "Você não está participando de nenhuma pesquisa.");
                }
              },
            )));
  }
}

Widget showPesquisas(List<Pesquisa> posts) {

  return SizedBox(
    child: ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return GestureDetector(
          onTap: () {
        savePesquisaId(post.id);

            Navigator.pushNamed(context, '/Pesquisas', arguments: {'pesquisa_id': post.id});

          },
          child: PesquisaPesquisadorCardWidget(
            pesquisa: post,
          ),
        );
      },
    ),
  );
}
