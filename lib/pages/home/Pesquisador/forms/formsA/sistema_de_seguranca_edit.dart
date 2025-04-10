import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/models/sistema_de_seguranca_model.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
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

class SistemaDeSegurancaEdit extends StatefulWidget {
  final SistemaDeSegurancaModel? sistemaModel;
  SistemaDeSegurancaEdit({super.key, this.sistemaModel});

  @override
  State<SistemaDeSegurancaEdit> createState() => _SistemaDeSegurancaEditState();
}

final GlobalKey<CheckCState> checkCKey = GlobalKey<CheckCState>();

Future<void> updateSistemaDeSeguranca(
    int sistemaId, Map<String, dynamic> data) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');

  final url = Uri.parse(
      '${AppConstants.BASE_URI}/api/v1/sistemadeseguranca/update/$sistemaId');

  print('OSIADOAOSD ${token}');

  try {
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $token",
      },
      body: json.encode(data),
    );
    if (response.statusCode == 200) {
      print("Atualização bem-sucedida");
    } else {
      print("Erro na atualização: ${response.statusCode}");
    }
  } catch (e) {
    print('Erro: $e');
  }
}

class _SistemaDeSegurancaEditState extends State<SistemaDeSegurancaEdit> {
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
  int qtdeInfo = 0;
  int qtdeServicosEspecializados = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoFillForm();
    if (widget.sistemaModel!.contatos != null) {
      qtdeInfo = widget.sistemaModel!.contatos!.length;
      qtdeServicosEspecializados = widget.sistemaModel!.contatos!.length;
    }

    if (qtdeInfo >= 0) {
      for (int i = 1; i < qtdeInfo; i++) {
        sections.add(Tables());
      }
      for (int i = 0; i < qtdeInfo; i++) {
        if (i < widget.sistemaModel!.contatos!.length) {
          var contato = widget.sistemaModel!.contatos![i];
          sections[i].fillForm(contato.nome!, contato.endereco!,
              contato.whatsapp!, contato.email!);
        }
      }
    }

    if (qtdeServicosEspecializados >= 0) {
      for (int i = 1; i < qtdeServicosEspecializados; i++) {
        sections2.add(Tables2());
      }

      for (int i = 0; i < qtdeServicosEspecializados; i++) {
        if (i < widget.sistemaModel!.servicosEspecializados!.length) {
          var servicos = widget.sistemaModel!.servicosEspecializados![i];
          sections2[i].fillForm(servicos.email!,
              servicos.servicosEspecializados!, servicos.outrasInformacoes!);
        }
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  void autoFillForm() {
    if (widget.sistemaModel!.uf != null) {
      uf.text = widget.sistemaModel!.uf!;
    } else {
      uf.text = '';
    }

    if (widget.sistemaModel!.regiaoTuristica != null) {
      regiao_turistica.text = widget.sistemaModel!.regiaoTuristica!;
    } else {
      regiao_turistica.text = '';
    }

    if (widget.sistemaModel!.municipio != null) {
      municipio.text = widget.sistemaModel!.municipio!;
    } else {
      municipio.text = '';
    }

    if (widget.sistemaModel!.tipo != null) {
      tipo.text = widget.sistemaModel!.tipo!;
    } else {
      tipo.text = '';
    }

    if (widget.sistemaModel!.observacoes != null) {
      observacoes.text = widget.sistemaModel!.observacoes!;
    } else {
      observacoes.text = '';
    }

    if (widget.sistemaModel!.referencias != null) {
      referencias.text = widget.sistemaModel!.referencias!;
    } else {
      referencias.text = '';
    }

    if (widget.sistemaModel!.nomePesquisador != null) {
      nome_pesquisador.text = widget.sistemaModel!.nomePesquisador!;
    } else {
      nome_pesquisador.text = '';
    }

    if (widget.sistemaModel!.telefonePesquisador != null) {
      telefone_pesquisador.text = widget.sistemaModel!.telefonePesquisador!;
    } else {
      telefone_pesquisador.text = '';
    }

    if (widget.sistemaModel!.emailPesquisador != null) {
      email_pesquisador.text = widget.sistemaModel!.emailPesquisador!;
    } else {
      email_pesquisador.text = '';
    }

    if (widget.sistemaModel!.nomeCoordenador != null) {
      nome_coordenador.text = widget.sistemaModel!.nomeCoordenador!;
    } else {
      nome_coordenador.text = '';
    }

    if (widget.sistemaModel!.telefoneCoordenador != null) {
      telefone_coordenador.text = widget.sistemaModel!.telefoneCoordenador!;
    } else {
      telefone_coordenador.text = '';
    }

    if (widget.sistemaModel!.emailCoordenador != null) {
      email_coordenador.text = widget.sistemaModel!.emailCoordenador!;
    } else {
      email_coordenador.text = '';
    }
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
                      indexModel: widget.sistemaModel!.tipo,
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

                          
   valoresjson['nome_pesquisador']= widget.sistemaModel!.nomePesquisador;
   valoresjson['telefone_pesquisador']= widget.sistemaModel!.telefonePesquisador;
   valoresjson['email_pesquisador']= widget.sistemaModel!.emailPesquisador;
   valoresjson['nome_coordenador']= widget.sistemaModel!.nomeCoordenador;
   valoresjson['telefone_coordenador']= widget.sistemaModel!.telefoneCoordenador;
   valoresjson['email_coordenador']= widget.sistemaModel!.emailCoordenador;


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
                            updateSistemaDeSeguranca(
                                widget.sistemaModel!.id!, valoresjson);
                            Navigator.pushReplacementNamed(
                                context, '/UpdatedForm');
                          }

                          // Navigator.pushReplacementNamed(context, '/SendedForm');
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
