import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/models/forms/forms%20B/guiamento_e_conducao_turisttica_model.dart';
import 'package:inventur/ui/widgets/radioButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/ui/widgets/text%20fields/tables.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/services/form_service.dart';
import 'package:inventur/ui/widgets/widgets/checkBox.dart';
import 'package:inventur/utils/app_constants.dart';
import '../../widgets/text fields/customTextField.dart';
bool isUpdate = false;

class GuiamentoEConducaoTurististica extends StatefulWidget {
  final GuiamentoEConducaoTurististicaModel? infoModel;

  GuiamentoEConducaoTurististica({super.key, this.infoModel});

  @override
  State<GuiamentoEConducaoTurististica> createState() => _GuiamentoEConducaoTurististicaState();
}

FormService _formService = FormService();

class _GuiamentoEConducaoTurististicaState extends State<GuiamentoEConducaoTurististica> {
  String pesquisadorNome = '';
  String pesquisadorTelefone = '';
  String pesquisadorEmail = '';

  String coordenadorNome = '';
  String coordenadorTelefone = '';
  String coordenadorEmail = '';

  void getInfoUsersInPesquisa() async {
    Map<String, dynamic> info = await getAdminAndPesquisadorInfo();

    pesquisadorNome = info['pesquisador']['nome'];
    pesquisadorTelefone = info['pesquisador']['telefone'];
    pesquisadorEmail = info['pesquisador']['email'];

    coordenadorNome = info['coordenador']['nome'];
    coordenadorEmail = info['coordenador']['telefone'];
    coordenadorTelefone = info['coordenador']['email'];
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      final argument = ModalRoute.of(context)!.settings.arguments as Map;
      print("ARGUMENTO: $argument");
      if (argument.containsKey('isUpdate')) {
        isUpdate = argument['isUpdate'];
      }
    } catch (e) {
      isUpdate = false;
    }
    print("VARIAVEL IS UPDATE: $isUpdate");
    if (isUpdate) {
      autoFillForm();

    if (widget.infoModel!.contatos != null) {
      qtdeInfo = widget.infoModel!.contatos!.length;
      qtdeServicosEspecializados = widget.infoModel!.servicosEspecializados!.length;
    }

    if (qtdeInfo >= 0) {
      for (int i = 1; i < qtdeInfo; i++) {
        sections.add(TabelaGuiamentoTuristico());
      }
      for (int i = 0; i < qtdeInfo; i++) {
        if (i < widget.infoModel!.contatos!.length) {
          var contato = widget.infoModel!.contatos![i];
          sections[i].fillForm(contato.nome_completo!, contato.cpf!,
              contato.endereco!, contato.email!, contato.telefone!);
        }
      }
    }

    if (qtdeServicosEspecializados >= 0) {
      for (int i = 1; i < qtdeServicosEspecializados; i++) {
        sections2.add(TabelaGuiamentoTuristico2());
      }

      for (int i = 0; i < qtdeServicosEspecializados; i++) {
        if (i < widget.infoModel!.servicosEspecializados!.length) {
          var servicos = widget.infoModel!.servicosEspecializados![i];
          sections2[i].fillForm(servicos.escolaridade!, servicos.servicos_especializados_formulario!,
              servicos.numero_cadastur!, servicos.outros_cadastros!, servicos.outras_informacoes!);
        }
      }
    }
    }
  }
  TextEditingController email_coordenador = TextEditingController();
  TextEditingController email_pesquisador = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController nome_coordenador = TextEditingController();
  TextEditingController nome_pesquisador = TextEditingController();
  TextEditingController observacoes = TextEditingController();
  TextEditingController referencias = TextEditingController();
  TextEditingController regiao_turistica = TextEditingController();
  List<TabelaGuiamentoTuristico> sections = [TabelaGuiamentoTuristico()];
  List<TabelaGuiamentoTuristico2> sections2 = [TabelaGuiamentoTuristico2()];
  TextEditingController telefone_coordenador = TextEditingController();
  TextEditingController telefone_pesquisador = TextEditingController();
  TextEditingController tipo = TextEditingController();
  final TextEditingController uf = TextEditingController();
  final Map<String, dynamic> valoresjson = {
    'tipo_formulario': 'Guiamento E Condução Turística',
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
  int qtdeInfo = 0;
  int qtdeServicosEspecializados = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  void autoFillForm() {
    if (widget.infoModel!.uf != null) {
      uf.text = widget.infoModel!.uf!;
    } else {
      uf.text = '';
    }

    if (widget.infoModel!.regiaoTuristica != null) {
      regiao_turistica.text = widget.infoModel!.regiaoTuristica!;
    } else {
      regiao_turistica.text = '';
    }

    if (widget.infoModel!.municipio != null) {
      municipio.text = widget.infoModel!.municipio!;
    } else {
      municipio.text = '';
    }

    if (widget.infoModel!.tipo != null) {
      tipo.text = widget.infoModel!.tipo!;
    } else {
      tipo.text = '';
    }

    if (widget.infoModel!.observacoes != null) {
      observacoes.text = widget.infoModel!.observacoes!;
    } else {
      observacoes.text = '';
    }

    if (widget.infoModel!.referencias != null) {
      referencias.text = widget.infoModel!.referencias!;
    } else {
      referencias.text = '';
    }

    if (widget.infoModel!.nomePesquisador != null) {
      nome_pesquisador.text = widget.infoModel!.nomePesquisador!;
    } else {
      nome_pesquisador.text = '';
    }

    if (widget.infoModel!.telefonePesquisador != null) {
      telefone_pesquisador.text = widget.infoModel!.telefonePesquisador!;
    } else {
      telefone_pesquisador.text = '';
    }

    if (widget.infoModel!.emailPesquisador != null) {
      email_pesquisador.text = widget.infoModel!.emailPesquisador!;
    } else {
      email_pesquisador.text = '';
    }

    if (widget.infoModel!.nomeCoordenador != null) {
      nome_coordenador.text = widget.infoModel!.nomeCoordenador!;
    } else {
      nome_coordenador.text = '';
    }

    if (widget.infoModel!.telefoneCoordenador != null) {
      telefone_coordenador.text = widget.infoModel!.telefoneCoordenador!;
    } else {
      telefone_coordenador.text = '';
    }

    if (widget.infoModel!.emailCoordenador != null) {
      email_coordenador.text = widget.infoModel!.emailCoordenador!;
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
    getInfoUsersInPesquisa();
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
                                    if (value == null || value.isEmpty) {
                                      return 'Preencha o campo';
                                    }
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
                                    if (value == null || value.isEmpty) {
                                      return 'Preencha o campo';
                                    }
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          return null;
                        },
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
  
                    RadioFormField(
                      title: 'Tipo',
                      options: [
                         'Guiamento e condução turística'
                      ],
                      onSaved: (newValue) {
                        valoresjson['tipo'] = newValue;
                      },
                      initialValue: isUpdate ? widget.infoModel!.tipo : ''
                    ),

                    CheckboxGroupFormField(
                      title: 'Subtipos',
                      initialValue: isUpdate ? widget.infoModel!.subtipos : [],
                      onSaved: (newValue) => valoresjson['subtipos'] = newValue,
                      options: ['Guia de turismo', 'Monitor', 'Condutor', 'outro']),
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
                              sections.add(TabelaGuiamentoTuristico());
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
                              sections2.add(TabelaGuiamentoTuristico2());
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
                          valoresjson['nome_pesquisador'] = pesquisadorNome;
                          valoresjson['telefone_pesquisador'] =
                              pesquisadorTelefone;
                          valoresjson['email_pesquisador'] = pesquisadorEmail;
                          valoresjson['nome_coordenador'] = coordenadorNome;
                          valoresjson['telefone_coordenador'] =
                              coordenadorTelefone;
                          valoresjson['email_coordenador'] = coordenadorEmail;

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
                          isUpdate ? _formService.updateForm(widget.infoModel!.id!, valoresjson, AppConstants.GUIAMENTO_E_CONDUCAO_TURISTICA) :  _formService.sendForm(valoresjson,
                                AppConstants.GUIAMENTO_E_CONDUCAO_TURISTICA);
      

                          }
                                                     debugPrint(valoresjson.toString(), wrapWidth: 1024);

                            sections2
                                .forEach((element) => print(element.getData()));

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
