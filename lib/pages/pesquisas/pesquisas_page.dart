import 'package:flutter/material.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/pesquisas/widgets/pesquisa_card_widget.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PesquisasPage extends StatefulWidget {
  const PesquisasPage({super.key});

  @override
  State<PesquisasPage> createState() => _PesquisasPageState();
}

class _PesquisasPageState extends State<PesquisasPage> {
  final PesquisaController _pesquisaController = PesquisaController();


static Future<List<Pesquisa>> getPesquisas() async{

  final prefs = await SharedPreferences.getInstance();
  String? userDataString = prefs.getString('user_data');
    if (userDataString == null) {
    print("Nenhum dado do usuário encontrado no SharedPreferences.");
    return [];
  }

  Map<String, dynamic> userData = json.decode(userDataString);
  final url = Uri.parse(AppConstants.BASE_URI + AppConstants.GET_PESQUISAS);
  int adminId = userData['id'];

  try{
    final response = await http.get(
      url,
       headers: {"Content-Type": "application/json"}
    );

    final List body = json.decode(utf8.decode(response.bodyBytes));
   final List<Pesquisa> todasAsPesquisas = body.map((e) => Pesquisa.fromJson(e)).toList();
    final List<Pesquisa> pesquisasFiltradas = todasAsPesquisas.where((pesquisa) => pesquisa.adminId == adminId).toList();
    return pesquisasFiltradas;
    
  }catch(e){
    print("Erro: $e");
    return [];
  }




}

Future<void> loadPesquisas() async{
  List<Pesquisa> pesquisas = await getPesquisas();
  _pesquisaController.addPesquisa(pesquisas);
}
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    loadPesquisas()
    ;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListenableBuilder(
              listenable: _pesquisaController,
              builder: (context, child) {
                return _pesquisaController.pesquisas.isNotEmpty
                ? ListView.builder(
                  itemCount: _pesquisaController.pesquisas.length,
                  itemBuilder: (context, index) {
                    return PesquisaCard(
                      pesquisa: _pesquisaController.pesquisas[index],
                      pesquisaController: _pesquisaController,
                    );
                  },
                )
                : const Center(
                  child: Text("Nehuma Pesquisa Cadastrada"),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: screenSize.height * .06,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.012
                    )
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 55, 111, 60)
                  ),
                  overlayColor: WidgetStateProperty.all(
                    Colors.green[600]
                  )
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/RegisterPesquisa');
                }, 
                child: Text(
                  'Cadastrar Nova Pesquisa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenSize.height * .03
                  ),
                )
              )
            ),
          ),
        ],
      ),
    );
  }
}
 