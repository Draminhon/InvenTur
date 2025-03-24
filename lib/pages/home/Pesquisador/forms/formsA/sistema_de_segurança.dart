import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/tables.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/customOutro.dart';
import '../../widgets/customTextField.dart';
import '../formsB/widgets/sendButton.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SistemaDeSeguranca extends StatefulWidget {
  SistemaDeSeguranca({super.key});

  @override
  State<SistemaDeSeguranca> createState() => _SistemaDeSegurancaState();
}

Future<void> sendForm(Map<String, dynamic> valoresjson) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');
  print('token sendo fornecido no equipamento: $token');
  final url =
      Uri.parse(AppConstants.BASE_URI + '/api/v1/sistemaseguranca/create/');
  int? pesquisa_id = await getPesquisaId();

  try {
    valoresjson['pesquisa'] = pesquisa_id;
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "Bearer $token",

        },
        body: json.encode(valoresjson));
    if (response.statusCode == 201) {
      debugPrint("Formulário enviado com sucesso!");
    } else {
      debugPrint("ERRO AO ENVIAR O FORMULÁRIO: ${response.body}");
    }
  } catch (e) {
    print('Erro: $e');
  }
}

class _SistemaDeSegurancaState extends State<SistemaDeSeguranca> {
  TextEditingController email_coordenador = TextEditingController();
  TextEditingController email_pesquisador = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController nome_coordenador = TextEditingController();
  TextEditingController nome_pesquisador = TextEditingController();
  TextEditingController observacoes = TextEditingController();
  TextEditingController referencias = TextEditingController();
  TextEditingController regiao_turistica = TextEditingController();
  List<Tables> sections = [Tables()];
  List<Tables2> sections2 = [Tables2()];
  TextEditingController telefone_coordenador = TextEditingController();
  TextEditingController telefone_pesquisador = TextEditingController();
  TextEditingController tipo = TextEditingController();
  final TextEditingController uf = TextEditingController();
  final Map<String, dynamic> valoresjson = {
    'tipo_formulario': 'Sistema de Segurança',
    'uf': null,
    'regiao_turistica': null,
    'municipio': null,
    'tipo': null,
    'observacoes': null,
    'referencias': null,
    'nome_pesquisador': 'jose',
    'telefone_pesquisador': '12453',
    'email_pesquisador': 'jose@gmail.com',
    'nome_coordenador': 'oihaioo',
    'telefone_coordenador': '4444',
    'email_coordenador': 'ogaio@gmail.com',
  };

  final _formKey = GlobalKey<FormState>();

  void autoFillForm() {
    uf.text = 'CE';
    regiao_turistica.text = 'Flores e Mel';
    municipio.text = 'Viçosa do Ceará';
    tipo.text = 'Rodovia';
    observacoes.text = 'ABCDEFGHIJKLMNOPQRSTUVWXZ';
    referencias.text = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    nome_pesquisador.text = 'Murilo';
    telefone_pesquisador.text = '40028922';
    email_pesquisador.text = 'murilo@gmail.com';
    nome_coordenador.text = 'Raquel';
    telefone_coordenador.text = '202115599';
    email_coordenador.text = 'raquelsilveira@gmail.com';
  }

  void dispose() {
    uf.dispose();
    regiao_turistica.dispose();
    municipio.dispose();
    tipo.dispose();
    observacoes.dispose();
    referencias.dispose();
    nome_pesquisador.dispose();
    telefone_pesquisador.dispose();
    email_pesquisador.dispose();
    nome_coordenador.dispose();
    telefone_coordenador.dispose();
    email_coordenador.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Color.fromARGB(255, 55, 111, 60),
          title: Text(
            'Identificação',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: sizeScreen.height * 0.05,
                            left: sizeScreen.width * 0.05),
                        child: Row(
                          children: [
                            SizedBox(
                                width: sizeScreen.width * 0.3,
                                height: sizeScreen.height * 0.045,
                                child: TextFormField(
                                  controller: uf,
                                  validator: (value) {
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    valoresjson['uf'] = newValue;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'UF',
                                  ),
                                )),
                            SizedBox(
                              width: sizeScreen.width * 0.09,
                            ),
                            SizedBox(
                                width: sizeScreen.width * 0.5,
                                height: sizeScreen.height * 0.045,
                                child: TextFormField(
                                  controller: regiao_turistica,
                                  validator: (value) {
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    valoresjson['regiao_turistica'] = newValue;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Região Turística'),
                                ))
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeScreen.width * 0.05,
                          right: sizeScreen.width * 0.1,
                          top: sizeScreen.height * 0.01),
                      child: TextFormField(
                        controller: municipio,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Municipio',
                        ),
                        onSaved: (newValue) {
                          valoresjson['municipio'] = newValue;
                        },
                      ),
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.05,
                    ),
                    textLabel(
                      name: 'Tipo:',
                      fontWeight: FontWeight.bold,
                    ),
                    RadioD(
                      options: [
                        'Polícia Civil',
                        'Polícia Militar',
                        'Polícia Rodoviária',
                        'Corpo de Bombeiros',
                        'Serviços de busca e salvamento',
                        'Serviços de Polícia',
                        'Marítima/Aérea/de Fronteiras',
                        'Guarda Municipal',
                        'Defesa Civil',
                        'outro'
                      ],
                      getValue: (newValue) {
                        valoresjson['tipo'] = newValue;
                      },
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.03,
                    ),
                    Container(
                      color: Color.fromARGB(255, 55, 111, 60),
                      height: sizeScreen.height * 0.06,
                      width: sizeScreen.width,
                      padding: EdgeInsets.only(
                          top: sizeScreen.height * 0.008,
                          left: sizeScreen.width * 0.04),
                      child: Text(
                        'Informações Gerais',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: sizeScreen.height * 0.03),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        sections.length > 1
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sections.removeLast();
                                  });
                                },
                                child: Container(
                                  height: 150.w,
                                  width: 400.w,
                                  margin: EdgeInsets.only(
                                    top: 50.h,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Remover',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.circleMinus,
                                        color: Colors.white,
                                        size: 100.w,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 300.w,
                              ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sections.add(Tables());
                            });
                          },
                          child: Container(
                            height: 150.w,
                            width: 740.w,
                            margin: EdgeInsets.only(top: 50.h),
                            decoration: BoxDecoration(
                                color: AppConstants.MAIN_GREEN,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Adicionar nova seção',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  FontAwesomeIcons.circlePlus,
                                  color: Colors.white,
                                  size: 100.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: sections,
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        sections2.length > 1
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    sections2.removeLast();
                                  });
                                },
                                child: Container(
                                  height: 150.w,
                                  width: 400.w,
                                  margin: EdgeInsets.only(
                                    top: 50.h,
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Remover',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.circleMinus,
                                        color: Colors.white,
                                        size: 100.w,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: 300.w,
                              ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              sections2.add(Tables2());
                            });
                          },
                          child: Container(
                            height: 150.w,
                            width: 740.w,
                            margin: EdgeInsets.only(top: 50.h),
                            decoration: BoxDecoration(
                                color: AppConstants.MAIN_GREEN,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Adicionar nova seção',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  FontAwesomeIcons.circlePlus,
                                  color: Colors.white,
                                  size: 100.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: sections2,
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.05,
                    ),
                    Container(
                      color: Color.fromARGB(255, 55, 111, 60),
                      height: sizeScreen.height * 0.06,
                      width: sizeScreen.width,
                      padding: EdgeInsets.only(
                          top: sizeScreen.height * 0.008,
                          left: sizeScreen.width * 0.04),
                      child: Text(
                        'Observações',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: sizeScreen.height * 0.03),
                      ),
                    ),
                    CustomTextField(
                      controller: observacoes,
                      validat: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      name: '',
                      getValue: (newValue) {
                        valoresjson['observacoes'] = newValue;
                      },
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.05,
                    ),
                    Container(
                      color: Color.fromARGB(255, 55, 111, 60),
                      height: sizeScreen.height * 0.06,
                      width: sizeScreen.width,
                      padding: EdgeInsets.only(
                          top: sizeScreen.height * 0.008,
                          left: sizeScreen.width * 0.04),
                      child: Text(
                        'Referências',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: sizeScreen.height * 0.03),
                      ),
                    ),
                    CustomTextField(
                      controller: referencias,
                      validat: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      name: '',
                      getValue: (newValue) {
                        valoresjson['referencias'] = newValue;
                      },
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.05,
                    ),
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          valoresjson['contatos'] = sections
                              .map((element) => element.getData())
                              .toList();
                          valoresjson['servicos_especializados'] = sections2
                              .map((element) => element.getData())
                              .toList();
                          if (_formKey.currentState!.validate()) {
                            //  ScaffoldMessenger.of(context).showSnackBar(
                            //      SnackBar(content: Text('processing data')));

                            _formKey.currentState!.save();
                            debugPrint(valoresjson.toString(), wrapWidth: 1024);
                            sendForm(valoresjson);
                            sections2
                                .forEach((element) => print(element.getData()));


                          Navigator.pushReplacementNamed(
                              context, '/SendedForm');
                          }

                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.green[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text(
                          'Enviar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25), // Use um fontSize fixo
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ))));
  }
}
