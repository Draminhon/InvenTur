import 'package:flutter/material.dart';
import 'package:sistur/models/pesquisa_model.dart';
import 'package:sistur/controllers/pesquisa_controller.dart';
import 'package:sistur/ui/widgets/cards/pesquisa_card_widget.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PesquisasPage extends StatefulWidget {
  const PesquisasPage({super.key});

  @override
  State<PesquisasPage> createState() => _PesquisasPageState();
}

class _PesquisasPageState extends State<PesquisasPage> {
  final bool _isLoading = false;

  final PesquisaController _pesquisaController = PesquisaController();

  static Future<List<Pesquisa>> getPesquisas() async {
    final prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('user_data');
    if (userDataString == null) {
      print("Nenhum dado do usuário encontrado no SharedPreferences.");
      return [];
    }

    Map<String, dynamic> userData = json.decode(userDataString);
    final url = Uri.parse(AppConstants.BASE_URI + AppConstants.GET_PESQUISAS);
    int adminId = userData['id'];

    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('access_token');
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });

      final List body = json.decode(utf8.decode(response.bodyBytes));
      final List<Pesquisa> todasAsPesquisas =
          body.map((e) => Pesquisa.fromJson(e)).toList();
      final List<Pesquisa> pesquisasFiltradas = todasAsPesquisas
          .where((pesquisa) =>
              pesquisa.adminId != null && pesquisa.adminId == adminId)
          .toList();
      return pesquisasFiltradas;
    } catch (e) {
      print("Erro: $e");
      return [];
    }
  }

  Future<void> loadPesquisas() async {
    List<Pesquisa> pesquisas = await getPesquisas();
    _pesquisaController.addPesquisa(pesquisas);
  }

  @override
  void initState() {
    super.initState();
    loadPesquisas();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                final pesquisas = _pesquisaController.pesquisas;
                if (_isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (pesquisas.isEmpty) {
                  return Center(
                    child: Center(child: Text("Não há pesquisas cadastradas"))
                  );
                }
                return ListView.builder(
                    itemCount: pesquisas.length,
                    itemBuilder: (context, index) {
                      return PesquisaCard(
                        pesquisa: pesquisas[index],
                        pesquisaController: _pesquisaController,
                      );
                    });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 5.w),
            child: SizedBox(
                height: 180.w,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(vertical: 10.w)),
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 55, 111, 60)),
                        overlayColor:
                            WidgetStateProperty.all(Colors.green[600])),
                    onPressed: () {
                      Navigator.pushNamed(context, '/RegisterPesquisa')
                          .then((result) {
                        if (result == true) {
                          loadPesquisas();
                        }
                      });
                    },
                    child: Text(
                      'Cadastrar Nova Pesquisa',
                      style: TextStyle(color: Colors.white, fontSize: 80.w),
                    ))),
          ),
        ],
      ),
    );
  }
}
