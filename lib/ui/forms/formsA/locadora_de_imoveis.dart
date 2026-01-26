import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sistur/models/forms/forms%20A/locadora_de_imoveis_model.dart';
import 'package:sistur/ui/widgets/radioButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sistur/ui/widgets/text%20fields/tables.dart';
import 'package:sistur/services/form_service.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sistur/utils/utils_functions.dart';
import '../../widgets/text fields/customTextField.dart';

class LocadoraDeImoveis extends StatefulWidget {
  final LocadoraDeImoveisModel? infoModel;
  final bool? isAdmin;
  LocadoraDeImoveis({super.key, this.infoModel, this.isAdmin});

  @override
  State<LocadoraDeImoveis> createState() => _LocadoraDeImoveisState();
}

class _LocadoraDeImoveisState extends State<LocadoraDeImoveis> {
  // Serviços e Utils
  final FormService _formService = FormService();
  final UtilsFunctions _utils = UtilsFunctions();

  // Estados
  int pesquisadorId = 0;
  bool isTheOwner = false;
  bool isUpdate = false;
  // Controllers
  final TextEditingController email_coordenador = TextEditingController();
  final TextEditingController email_pesquisador = TextEditingController();
  final TextEditingController municipio = TextEditingController();
  final TextEditingController nome_coordenador = TextEditingController();
  final TextEditingController nome_pesquisador = TextEditingController();
  final TextEditingController observacoes = TextEditingController();
  final TextEditingController referencias = TextEditingController();
  final TextEditingController regiao_turistica = TextEditingController();
  final TextEditingController telefone_coordenador = TextEditingController();
  final TextEditingController telefone_pesquisador = TextEditingController();
  final TextEditingController tipo = TextEditingController();
  final TextEditingController uf = TextEditingController();

  // Listas Dinâmicas de Widgets (Adicionado UniqueKey para controle de estado)
  List<TabelaInfoGerais> sections = [];
  List<TabelaInfoGerais2> sections2 = [];

  final Map<String, dynamic> valoresjson = {
    'tipo_formulario': 'Locadora de Imóveis',
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
    
    // Inicializa com ao menos uma seção se não for update
    sections.add(TabelaInfoGerais(key: UniqueKey()));
    sections2.add(TabelaInfoGerais2(key: UniqueKey()));

    _utils.getInfoUsersInPesquisa(valoresjson, widget.isAdmin ?? false).then((value) {
      if (mounted) {
        setState(() {
          pesquisadorId = value;
          if (widget.infoModel != null) {
            isTheOwner = _utils.isTheOwner(pesquisadorId, widget.infoModel!.usuario_criador!,widget.isAdmin ?? false,context);
          }
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map && args.containsKey('isUpdate')) {
      if (isUpdate != args['isUpdate']) {
        setState(() {
          isUpdate = args['isUpdate'];
        });
        if (isUpdate) {
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
            var novaSecao = TabelaInfoGerais(key: UniqueKey());
            novaSecao.fillForm(
              contato.razao_social ?? '',
              contato.nome_fantasia ?? '',
              contato.cnpj ?? '',
              contato.endereco ?? '',
              contato.telefone ?? '',
            );
            sections.add(novaSecao);
          }
        } else {
          sections.add(TabelaInfoGerais(key: UniqueKey()));
        }

        sections2.clear();
        if (widget.infoModel!.servicosEspecializados != null && widget.infoModel!.servicosEspecializados!.isNotEmpty) {
          for (var servico in widget.infoModel!.servicosEspecializados!) {
            var novaSecao = TabelaInfoGerais2(key: UniqueKey());
            novaSecao.fillForm(
              servico.email ?? '',
              servico.site ?? '',
              servico.tipoImoveis ?? '',
              servico.outrasInfo ?? '',
            );
            sections2.add(novaSecao);
          }
        } else {
          sections2.add(TabelaInfoGerais2(key: UniqueKey()));
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
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 55, 111, 60),
        title: const Text('Identificação', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // --- Campos de Identificação Geográfica ---
              Padding(
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.05, left: sizeScreen.width * 0.05),
                child: Row(
                  children: [
                    SizedBox(
                      width: sizeScreen.width * 0.3,
                      height: sizeScreen.height * 0.045,
                      child: TextFormField(
                        controller: uf,
                        validator: (v) => (v == null || v.isEmpty) ? 'Preencha' : null,
                        onSaved: (newValue) => valoresjson['uf'] = newValue,
                        decoration: const InputDecoration(hintText: 'UF'),
                      ),
                    ),
                    SizedBox(width: sizeScreen.width * 0.09),
                    SizedBox(
                      width: sizeScreen.width * 0.5,
                      height: sizeScreen.height * 0.045,
                      child: TextFormField(
                        controller: regiao_turistica,
                        validator: (v) => (v == null || v.isEmpty) ? 'Preencha' : null,
                        onSaved: (newValue) => valoresjson['regiao_turistica'] = newValue,
                        decoration: const InputDecoration(hintText: 'Região Turística'),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sizeScreen.width * 0.05, vertical: sizeScreen.height * 0.01),
                child: TextFormField(
                  controller: municipio,
                  validator: (v) => (v == null || v.isEmpty) ? 'Preencha' : null,
                  decoration: const InputDecoration(isDense: true, hintText: 'Municipio'),
                  onSaved: (newValue) => valoresjson['municipio'] = newValue,
                ),
              ),

              RadioFormField(
                title: 'Tipo',
                options: const ['Locadoras de imóveis para temporada'],
                onSaved: (newValue) => valoresjson['tipo'] = newValue,
                initialValue: isUpdate ? widget.infoModel?.tipo : '',
              ),

              // --- SEÇÃO CONTATOS (Informações Gerais) ---
              _buildSectionHeader(sizeScreen, 'Informações Gerais'),
              _buildDynamicButtons(
                onAdd: () => setState(() => sections.add(TabelaInfoGerais(key: UniqueKey()))),
                onRemove: () => setState(() => sections.removeLast()),
                listLength: sections.length,
              ),
              Column(children: sections),

              // --- SEÇÃO SERVIÇOS ---
              _buildSectionHeader(sizeScreen, 'Serviços Especializados'),
              _buildDynamicButtons(
                onAdd: () => setState(() => sections2.add(TabelaInfoGerais2(key: UniqueKey()))),
                onRemove: () => setState(() => sections2.removeLast()),
                listLength: sections2.length,
              ),
              Column(children: sections2),

              // --- OBSERVAÇÕES E REFERÊNCIAS ---
              _buildSectionHeader(sizeScreen, 'Observações'),
              CustomTextField(
                controller: observacoes,
                name: '',
                getValue: (val) => valoresjson['observacoes'] = val,
              ),
              
              _buildSectionHeader(sizeScreen, 'Referências'),
              CustomTextField(
                controller: referencias,
                name: '',
                getValue: (val) => valoresjson['referencias'] = val,
              ),

              const SizedBox(height: 30),
              
              // --- BOTÃO ENVIAR ---
              SafeArea(
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                
                        // COLETA DE DADOS DAS TABELAS DINÂMICAS
                        valoresjson['contatos'] = sections.map((e) => e.getData()).toList();
                        valoresjson['servicos_especializados'] = sections2.map((e) => e.getData()).toList();
                
                        _utils.decideSendingOrUpdating(
                          isUpdate, 
                          isTheOwner, 
                          context, 
                          widget.infoModel?.id ?? 0, 
                          valoresjson, 
                          AppConstants.LOCADORA_IMOVEIS
                        );
                      }
                    },
                    child: const Text('Enviar', style: TextStyle(color: Colors.white, fontSize: 25)),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Helper para criar cabeçalhos de seção
  Widget _buildSectionHeader(Size size, String title) {
    return Container(
      color: const Color.fromARGB(255, 55, 111, 60),
      height: size.height * 0.06,
      width: size.width,
      margin: const EdgeInsets.only(top: 20),
      padding: EdgeInsets.only(top: size.height * 0.008, left: size.width * 0.04),
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: size.height * 0.03)),
    );
  }

  // Helper para os botões Adicionar/Remover
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