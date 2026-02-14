import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sistur/models/forms/forms%20B/guiamento_e_conducao_turisttica_model.dart';
import 'package:sistur/ui/widgets/radioButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sistur/ui/widgets/text%20fields/tables.dart';
import 'package:sistur/ui/widgets/widgets/checkBox.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sistur/utils/utils_functions.dart';
import '../../widgets/text fields/customTextField.dart';


class GuiamentoEConducaoTurististica extends StatefulWidget {
  final GuiamentoEConducaoTurististicaModel? infoModel;
  final bool? isAdmin;
  GuiamentoEConducaoTurististica({super.key, this.infoModel, this.isAdmin});

  @override
  State<GuiamentoEConducaoTurististica> createState() =>
      _GuiamentoEConducaoTurististicaState();
}


class _GuiamentoEConducaoTurististicaState
    extends State<GuiamentoEConducaoTurististica> {

  final UtilsFunctions _utils = UtilsFunctions();

  int pesquisadorId = 0;
  bool isTheOwner = false;
  bool isUpdate = false;

  TextEditingController email_coordenador = TextEditingController();
  TextEditingController email_pesquisador = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController nome_coordenador = TextEditingController();
  TextEditingController nome_pesquisador = TextEditingController();
  TextEditingController observacoes = TextEditingController();
  TextEditingController referencias = TextEditingController();
  TextEditingController regiao_turistica = TextEditingController();
  TextEditingController telefone_coordenador = TextEditingController();
  TextEditingController telefone_pesquisador = TextEditingController();
  TextEditingController tipo = TextEditingController();
  final TextEditingController uf = TextEditingController();

   List<TabelaGuiamentoTuristico> sections = [];
  List<TabelaGuiamentoTuristico2> sections2 = [];

  final Map<String, dynamic> valoresjson = {
    'tipo_formulario': 'Guiamento E Condução Turística',
    'uf': null,
    'regiao_turistica': null,
    'municipio': null,
    'tipo': null,
    'observacoes': null,
    'referencias': null,
  };

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    sections.add(TabelaGuiamentoTuristico(key: UniqueKey(),));
    sections2.add(TabelaGuiamentoTuristico2(key: UniqueKey(),));

    _utils.getInfoUsersInPesquisa(valoresjson, widget.isAdmin??false).then((value) {
      if(mounted){
        setState(() {
          pesquisadorId = value;
          if(widget.infoModel != null){
            print("dados: $pesquisadorId, ${widget.infoModel!.usuario_criador}");
            isTheOwner = _utils.isTheOwner(pesquisadorId,
             widget.infoModel?.usuario_criador ?? 0, widget.isAdmin??false, context);
          }
        });
      }
    },);

  }

@override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;
    if(args is Map && args.containsKey('isUpdate')){
      if(isUpdate != args['isUpdate']){
  setState(() {
        isUpdate = args['isUpdate'];
      });
        if(isUpdate){
        autoFillForm();
      }
      }
    }
  }
   void autoFillForm() {
    // Garante que o build terminou antes de manipular controllers e listas
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.infoModel == null) return;

      setState(() {
        // Limpa e repovoa as tabelas
        sections.clear();
        if (widget.infoModel!.contatos != null && widget.infoModel!.contatos!.isNotEmpty) {
          for (var contato in widget.infoModel!.contatos!) {
            var novaSecao = TabelaGuiamentoTuristico(key: UniqueKey());
            novaSecao.fillForm(
              contato.nome_completo ?? '',
              contato.cpf ?? '',
              contato.endereco ?? '',
              contato.email ?? '',
              contato.telefone ?? '',
            );
            sections.add(novaSecao);
          }
        } else {
          sections.add(TabelaGuiamentoTuristico(key: UniqueKey()));
        }

        sections2.clear();
        if (widget.infoModel!.servicosEspecializados != null && widget.infoModel!.servicosEspecializados!.isNotEmpty) {
          for (var servico in widget.infoModel!.servicosEspecializados!) {
            var novaSecao = TabelaGuiamentoTuristico2(key: UniqueKey());
            novaSecao.fillForm(
              servico.escolaridade ?? '',
              servico.servicos_especializados_formulario ?? '',
              servico.numero_cadastur ?? '',
              servico.outros_cadastros ?? '',
              servico.outras_informacoes ?? '',
            );
            sections2.add(novaSecao);
          }
        } else {
          sections2.add(TabelaGuiamentoTuristico2(key: UniqueKey()));
        }

        // Preenche controllers simples
        uf.text = widget.infoModel!.uf ?? '';
        regiao_turistica.text = widget.infoModel!.regiaoTuristica ?? '';
        municipio.text = widget.infoModel!.municipio ?? '';
        tipo.text = widget.infoModel!.tipo ?? '';
        observacoes.text = widget.infoModel!.observacoes ?? '';
        referencias.text = widget.infoModel!.referencias ?? '';
        nome_pesquisador.text = widget.infoModel!.nomePesquisador ?? '';
        telefone_pesquisador.text = widget.infoModel!.telefonePesquisador ?? '';
        email_pesquisador.text = widget.infoModel!.emailPesquisador ?? '';
        nome_coordenador.text = widget.infoModel!.nomeCoordenador ?? '';
        telefone_coordenador.text = widget.infoModel!.telefoneCoordenador ?? '';
        email_coordenador.text = widget.infoModel!.emailCoordenador ?? '';
      });
    });
  }
  @override
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
                        options: ['Guiamento e condução turística'],
                        onSaved: (newValue) {
                          valoresjson['tipo'] = newValue;
                        },
                        initialValue: isUpdate ? widget.infoModel!.tipo : ''),
                    CheckboxGroupFormField(
                        title: 'Subtipos',
                        initialValue:
                            isUpdate ? widget.infoModel!.subtipos : [],
                        onSaved: (newValue) =>
                            valoresjson['subtipos'] = newValue,
                        options: [
                          'Guia de turismo',
                          'Monitor',
                          'Condutor',
                          'outro'
                        ]),
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
                    _buildDynamicButtons(onAdd: () => setState(() => 
                    sections.add(TabelaGuiamentoTuristico(key: UniqueKey(),)),),
                     onRemove:() => setState(() => setState(() => sections.removeLast(),),),
                      listLength: sections.length),
                    Column(
                      children: sections,
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.05,
                    ),
                    _buildDynamicButtons(
                      onAdd: () => setState(() => sections2.add(TabelaGuiamentoTuristico2(key: UniqueKey(),)),),
                       onRemove: () => setState(() => sections2.removeLast(),), listLength: sections2.length),
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
                    SafeArea(
                      child: SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();

                            valoresjson['contatos'] = sections
                                .map((element) => element.getData())
                                .toList();
                            valoresjson['servicos_especializados'] = sections2
                                .map((element) => element.getData())
                                .toList();
      _utils.decideSendingOrUpdating(isUpdate, isTheOwner, context, widget.infoModel?.id??0,
       valoresjson, AppConstants.GUIAMENTO_E_CONDUCAO_TURISTICA);
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
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ))));
  }
      Widget _buildDynamicButtons({required VoidCallback onAdd, required VoidCallback onRemove, required int listLength}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (listLength > 1)
          GestureDetector(
            onTap: onRemove,
            child: _actionButton('Remover', Colors.red, FontAwesomeIcons.circleMinus),
          )
        else
          SizedBox(width: 300.w),
        GestureDetector(
          onTap: onAdd,
          child: _actionButton('Adicionar nova seção', AppConstants.MAIN_GREEN, FontAwesomeIcons.circlePlus, width: 740.w),
        ),
      ],
    );
  }

  Widget _actionButton(String label, Color color, IconData icon, {double? width}) {
    return Container(
      height: 150.w,
      width: width ?? 400.w,
      margin: EdgeInsets.only(top: 50.h),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Icon(icon, color: Colors.white, size: 100.w),
        ],
      ),
    );
  }
}
