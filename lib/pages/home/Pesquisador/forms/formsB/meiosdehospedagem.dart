import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/forms/meios_hospedagem_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/fields.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_widget.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/multi_auto_complete_form_field.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/tables.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/utils/validators.dart';

final Validators _validators = Validators();
final Map<String, dynamic> valoresjson = {
  'tipo_formulario': 'Meios de Hospedagem',
};
bool isUpdate = false;

class MeiosDeHospedagem extends StatefulWidget {
  final MeiosDeHospedagemModel? hospedagemModel;
  const MeiosDeHospedagem({super.key, this.hospedagemModel});

  @override
  State<MeiosDeHospedagem> createState() => _MeiosDeHospedagemState();
}

class _MeiosDeHospedagemState extends State<MeiosDeHospedagem> {
  int currentStep = 0;

  late List<Widget> pages;

  final _formKey = GlobalKey<FormState>();

  final PageController _pageController = PageController();

  Map<String, TextEditingController> _identificacaoControllers = {};
  Map<String, TextEditingController> _funcionamentoControllers = {};

  final List<String> _chavesIdentificacao = const [
    'uf',
    'regiao_turistica',
    'municipio',
    'razaoSocial',
    'nomeFantasia',
    'codigoCNAE',
    'atividadeEconomica',
    'inscricaoMunicipal',
    'nomeDaRede',
    'CNPJ',
    'inicioDaAtividade',
    'qtdeFuncionariosPermanentes',
    'qtdeFuncionariosTemporarios',
    'qtdeFuncionarisComDeficiencia',
    'latitude',
    'longitute',
    'avenidaRuaEtc',
    'bairroLocalidade',
    'distrito',
    'CEP',
    'whatsapp',
    'instagram',
    'email',
    'site',
    'aeroporto',
    'estacaoRodoviaria',
    'estacaoFerroviaria',
    'estacaoMaritima',
    'estacaoMetroviaria',
    'pontoDeOnibus',
    'pontoDeTaxi',
    'distanciasOutrosNome',
    'distanciaOutros',
    'pontosDeReferencia',
  ];
  final List<String> _chavesFuncionamento = const [
    'outrasRegrasEInformacoes',
    'nAnoOcupacao',
    'nOcupacaoAltaTemporada',
    'nTotalDeUH',
    'nTotalDeLeitos',
    'nUhAdaptadasParaPCD',
    'nCapacidadeDeVeiculos',
    'nAutomoveis',
    'nOnibus',
    'capacidadeEmKVA',
    'geradorCapacidadeEmKVA',
    'nCapacidadeInstaladaPorDia',
    'nPessoasAtendidasSentadas',
    'nCapacidadeSimultanea',
    'nPessoasAtendidasSentadasSimultanea',
    'lanchoneteCapacidadeInstaladaPorDia',
    'lanchoneteCapacidadePessoasAtendidasSentadas',
    'lanchoneteCapacidadeSimultanea',
    'lanchoneteCapacidadeSentadasSimultanea',
  ];

  void getInfoUsersInPesquisa() async {
    Map<String, dynamic> info = await getAdminAndPesquisadorInfo();

    valoresjson['nome_pesquisador'] = info['pesquisador']['nome'];
    valoresjson['telefone_pesquisador'] = info['pesquisador']['telefone'];
    valoresjson['email_pesquisador'] = info['pesquisador']['email'];

    valoresjson['nome_coordenador'] = info['coordenador']['nome'];
    valoresjson['telefone_coordenador'] = info['coordenador']['telefone'];
    valoresjson['email_coordenador'] = info['coordenador']['email'];
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
      //_preencherDadosParaTeste();
    }
  }

  // final Map<String, dynamic> valoresjson = {
  //   'tipo_formulario': 'Meios de Hospedagem',
  //   // 'uf': null,
  //   // 'regiao_turistica': null,
  //   // 'municipio': null,
  //   // 'tipo': null,
  //   // 'subtipo': null,

  //   // 'MTur_CADASTUR': null,
  //   // 'MTur_outros': null,
  //   // 'associacoes_e_sindicatos_do_setor_de_hospedagem': null,
  //   // 'associcoes_de_turismo': null,
  //   // 'associacoes_comerciais': null,
  //   // 'guias_turisticos': null,
  //   // 'outros_entidade_guia_turistico': null,
  //   // 'segmentos_ou_tipos_de_turismo_em_que_e_especializado': null,
  //   // 'tipo_de_diária': null,
  //   // 'formas_de_pagamento': null,
  //   // 'reservas': null,
  //   // 'atendimento_em_lingua_estrangeira': null,
  //   // 'informativo impressos': null,
  //   // 'periodo': null,
  //   // 'horario_segunda_feira_abertura': null,
  //   // 'horario_segunda_feira_encerramento': null,
  //   // 'horario_terca_feira_abertura': null,
  //   // 'horario_terca_feira_encerramento': null,
  //   // 'horario_quarta_feira_abertura': null,
  //   // 'horario_quarta_feira_encerramento': null,
  //   // 'horario_quinta_feira_abertura': null,
  //   // 'horario_quinta_feira_encerramento': null,
  //   // 'horario_sexta_feira_abertura': null,
  //   // 'horario_sexta_feira_encerramento': null,
  //   // 'horario_sabado_abertura': null,
  //   // 'horario_sabado_encerramento': null,
  //   // 'horario_domingo_abertura': null,
  //   // 'horario_domingo_encerramento': null,
  //   // 'funcionamento_24_horas': null,
  //   // 'funcionamento_em_feriados': null,
  //   // 'restricoes': null,

  //   // 'area_recreacao_e_lazer_instalacoes': null,
  //   // 'area_recreacao_e_lazer_outros_espacos_equipamentos_e_atividades': null,
  //   // 'area_para_eventos_instalacoes': null,
  //   // 'area_para_eventos_servicos': null,
  //   // 'area_para_eventos_equipamentos': null,
  //   // 'facilidade_e_servicos': null,
  //   // 'facilidade_para_executivos': null,
  //   // 'protecao_qualificacao_do_esquipamento_espaco': null,
  //   // 'protecao_qualificacao_do_esquipamento_espaco_municipal': null,
  //   // 'protecao_qualificacao_do_esquipamento_espaco_estadual_distrital': null,
  //   // 'protecao_qualificacao_do_esquipamento_espaco_federal': null,
  //   // 'protecao_qualificacao_do_esquipamento_espaco_internacional': null,
  //   // 'protecao_qualificacao_do_esquipamento_espaco_outras': null,
  //   // 'protecao_qualificacao_da_area_ou_edificacao': null,
  //   // 'protecao_qualificacao_da_area_ou_edificacao_municipal': null,
  //   // 'protecao_qualificacao_da_area_ou_edificacao_estadual_distrital': null,
  //   // 'protecao_qualificacao_da_area_ou_edificacao_federal': null,
  //   // 'protecao_qualificacao_da_area_ou_edificacao_internacional': null,
  //   // 'protecao_qualificacao_da_area_ou_edificacao_outras': null,
  //   // 'estado_geral_de_conservacao': null,
  //   // 'acessibilidade_possui_alguma_facilidade_para_pcd_ou_mobilidade_reduzida':
  //   //     null,
  //   // 'acessibilidade_possui_pessoal_capacitado_para_receber_pcd': null,
  //   // 'acessibilidade_rota_externa_acessivel': null,
  //   // 'acessibilidade_simbolo_internacional_de_acesso': null,
  //   // 'acessibilidade_local_de_embarque_e_desembarque': null,
  //   // 'acessibilidade_vaga_em_estacionamento': null,
  //   // 'acessibilidade_area_de_circulacao_acesso_interno_para_cadeira_de_rodas':
  //   //     null,
  //   // 'acessibilidade_escada': null,
  //   // 'acessibilidade_rampa': null,
  //   // 'acessibilidade_piso': null,
  //   // 'acessibilidade_elevador': null,
  //   // 'acessibilidade_equipamento_motorizado_para_deslocamento_interno': null,
  //   // 'acessibilidade_sinalizacao_visual': null,
  //   // 'acessibilidade_sinalizacao_tatil': null,
  //   // 'acessibilidade_alarme_de_emergencia': null,
  //   // 'acessibilidade_comunicacao': null,
  //   // 'acessibilidade_balcao_de_atendimento': null,
  //   // 'acessibilidade_mobiliário': null,
  //   // 'acessibilidade_sanitário': null,
  //   // 'acessibilidade_telefone': null,
  //   // 'acessibilidade_sinalizacao_indicaiva_de_atendimento_preferencial_para_pessoas_com_deficiencia_ou_mobilidade_reduzida':
  //   //     null,
  //   // 'acessibilidade_outros': null,
  //   // 'observacoes': null,
  //   // 'referencias': null,
  // };

//Implementar o Map para os controllers

//   void autoFillForm() {
//     // Verifica se o controlador existe no Map antes de preencher

//     void safeFillIfExists(String key, List<String?>? list, int index) {
//       if (list != null &&
//           list.length > index &&
//           list[index] != null &&
//           list[index]!.isNotEmpty) {
//       }
//     }

//     if (widget.hospedagemModel != null) {
//       fillIfExists('uf', widget.hospedagemModel!.uf!);
//       fillIfExists('rg', widget.hospedagemModel!.regiaoTuristica!);
//       fillIfExists('municipio', widget.hospedagemModel!.municipio!);
//       fillIfExists('razao social', widget.hospedagemModel!.razaoSocial!);
//       fillIfExists('nome fantasia', widget.hospedagemModel!.nomeFantasia!);
//       fillIfExists('CNPJ', widget.hospedagemModel!.CNPJ!);
//       fillIfExists('codigo CNAE', widget.hospedagemModel!.codigoCNAE!);

//       safeFillIfExists('estado01', widget.hospedagemModel!.estadosTuristas, 0);
//       safeFillIfExists('estado02', widget.hospedagemModel!.estadosTuristas, 1);
//       safeFillIfExists('estado03', widget.hospedagemModel!.estadosTuristas, 2);
//       safeFillIfExists('estado04', widget.hospedagemModel!.estadosTuristas, 3);
//       safeFillIfExists('estado05', widget.hospedagemModel!.estadosTuristas, 4);

// // Para países
//       safeFillIfExists('pais01', widget.hospedagemModel!.paisesTuristas, 0);
//       safeFillIfExists('pais02', widget.hospedagemModel!.paisesTuristas, 1);
//       safeFillIfExists('pais03', widget.hospedagemModel!.paisesTuristas, 2);
//       safeFillIfExists('pais04', widget.hospedagemModel!.paisesTuristas, 3);
//       safeFillIfExists('pais05', widget.hospedagemModel!.paisesTuristas, 4);

//       fillIfExists(
//           'atividade economica', widget.hospedagemModel!.atividadeEconomica!);
//       fillIfExists(
//           'inscricao municipal', widget.hospedagemModel!.inscricaoMunicipal!);
//       fillIfExists('nome da rede', widget.hospedagemModel!.nomeDaRede!);
//       fillIfExists(
//           'inicio da atividade', widget.hospedagemModel!.inicioDaAtividade!);
//       fillIfExists('funcionarios permanentes',
//           widget.hospedagemModel!.qtdeFuncionariosPermanentes!.toString());
//       fillIfExists('funcionarios temporarios',
//           widget.hospedagemModel!.qtdeFuncionariosTemporarios!.toString());
//       fillIfExists('pessoas com deficiencia',
//           widget.hospedagemModel!.qtdeFuncionarisComDeficiencia!.toString());
//       fillIfExists('latitude', widget.hospedagemModel!.latitude.toString());
//       fillIfExists('longitute', widget.hospedagemModel!.longitute.toString());
//       fillIfExists('avenida rua', widget.hospedagemModel!.avenidaRuaEtc!);
//       fillIfExists(
//           'bairro localidade', widget.hospedagemModel!.bairroLocalidade!);
//       fillIfExists('distrito', widget.hospedagemModel!.distrito!);
//       fillIfExists('CEP', widget.hospedagemModel!.CEP!);
//       fillIfExists('whatsapp', widget.hospedagemModel!.whatsapp!);
//       fillIfExists('instagram', widget.hospedagemModel!.instagram!);
//       fillIfExists('email', widget.hospedagemModel!.email!);
//       fillIfExists('site', widget.hospedagemModel!.site!);
//       fillIfExists(
//           'pontos de referencia', widget.hospedagemModel!.pontosDeReferencia!);
//       fillIfExists('regras e informacoes',
//           widget.hospedagemModel!.outrasRegrasEInformacoes!);
//       fillIfExists('ocupação ano n', widget.hospedagemModel!.nAnoOcupacao!);
//       fillIfExists('ocupacao alta temporada n',
//           widget.hospedagemModel!.nOcupacaoAltaTemporada!);
//       fillIfExists(
//           'total de UH', widget.hospedagemModel!.nTotalDeUH!.toString());
//       fillIfExists('total de leitos',
//           widget.hospedagemModel!.nTotalDeLeitos!.toString());
//       fillIfExists('uh adaptados para pcd',
//           widget.hospedagemModel!.nUhAdaptadasParaPCD!.toString());
//       fillIfExists('capacidade de veiculos',
//           widget.hospedagemModel!.nCapacidadeDeVeiculos!.toString());
//       fillIfExists('capacidade automoveis',
//           widget.hospedagemModel!.nAutomoveis!.toString());
//       fillIfExists('onibus', widget.hospedagemModel!.nOnibus!.toString());
//       fillIfExists('capacidade em KVA',
//           widget.hospedagemModel!.capacidadeEmKVA!.toString());
//       fillIfExists('gerador capacidade em KVA',
//           widget.hospedagemModel!.geradorCapacidadeEmKVA!);
//       fillIfExists('capacidade instalada por dia',
//           widget.hospedagemModel!.nCapacidadeInstaladaPorDia!.toString());
//       fillIfExists('pessoas atendidas sentadas',
//           widget.hospedagemModel!.nPessoasAtendidasSentadas!.toString());
//       fillIfExists('capacidade simultanea',
//           widget.hospedagemModel!.nCapacidadeSimultanea!.toString());
//       fillIfExists(
//           'capacidade simultanea pessoas atendidas sentadas',
//           widget.hospedagemModel!.nPessoasAtendidasSentadasSimultanea!
//               .toString());
//       fillIfExists(
//           'lanchonete capacidade instalada por dia',
//           widget.hospedagemModel!.lanchoneteCapacidadeInstaladaPorDia!
//               .toString());
//       fillIfExists(
//           'lanchonete capacidade pessoas atendidas sentadas',
//           widget.hospedagemModel!.lanchoneteCapacidadePessoasAtendidasSentadas!
//               .toString());
//       fillIfExists('lanchonete capacidade simultanea',
//           widget.hospedagemModel!.lanchoneteCapacidadeSimultanea!.toString());
//       fillIfExists(
//           'lanchonete pessoas atendidas sentadas simultanea',
//           widget.hospedagemModel!.lanchoneteCapacidadeSentadasSimultanea!
//               .toString());
//       fillIfExists('outros', widget.hospedagemModel!.outros!);
//       fillIfExists('observacoes', widget.hospedagemModel!.observacoes!);
//       fillIfExists('referencias', widget.hospedagemModel!.referencias!);
//     }
//   }

  @override
  void initState() {
    super.initState();
    getInfoUsersInPesquisa();

    for (final key in _chavesIdentificacao) {
      _identificacaoControllers[key] = TextEditingController();
    }

    for (final key in _chavesFuncionamento) {
      _funcionamentoControllers[key] = TextEditingController();
    }

    pages = [
      Identificacao(
        controllers: _identificacaoControllers,
        hospedagemModel: widget.hospedagemModel,
      ),
      Funcionamento(
        controllers: _funcionamentoControllers,
        hospedagemModel: widget.hospedagemModel,
      )
    ];

    //_pesquisaController.setEstados();
    //_pesquisaController.setPaises();
  }

  @override
  void dispose() {
    for (final controller in _identificacaoControllers.values) {
      controller.dispose();
    }
    for (final controller in _funcionamentoControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  void _enviarFormulario() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      _identificacaoControllers.forEach((key, controller) {
        valoresjson[key] = controller.text;
      });

      _funcionamentoControllers.forEach(
        (key, value) {
          valoresjson[key] = value.text;
        },
      );

      valoresjson.forEach(
        (key, value) {
          print("$key  - $value");
        },
      );
      if (currentStep < pages.length - 1) {
        // Avança para a próxima página
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        // isUpdate ? FormService().updateForm(widget.infoModel!.id!, valoresJson,AppConstants.INFO_BASICA_CREATE ) :
        // isUpdate
        //     ? FormService().updateForm(widget.infoModel!.id!, valoresJson,
        //         AppConstants.COMERCIO_TURISTICO)
        //     : FormService()
        //         .sendForm(valoresJson, AppConstants.COMERCIO_TURISTICO);
        print("Formulário finalizado e pronto para enviar!");

        // _enviarFormulario(); // Você pode chamar sua função de envio aqui
      }
    } else {
      if (currentStep < pages.length - 1) {
        // Avança para a próxima página
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
      _formKey.currentState!.save();
      _identificacaoControllers.forEach((key, controller) {
        valoresjson[key] = controller.text;
      });
      _funcionamentoControllers.forEach(
        (key, value) {
          valoresjson[key] = value.text;
        },
      );

      valoresjson.forEach(
        (key, value) {
          print("$key  - $value");
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Por favor, corrija os erros no formulário.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 55, 111, 60),
          title: DotsIndicator(
            dotsCount: pages.length,
            position: currentStep.toDouble(),
            decorator: DotsDecorator(
                activeColor: Colors.white, activeSize: Size(18, 9)),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: PageView.builder(
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                currentStep = value;
              });
            },
            controller: _pageController,
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),
        ),
        bottomNavigationBar:
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          // Botão Voltar
          if (currentStep > 0)
            Container(
              margin: EdgeInsets.only(bottom: 35.h),
              child: TextButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: const Text('VOLTAR'),
              ),
            ),
          // Espaçador para alinhar o botão Continuar à direita quando não houver o Voltar
          if (currentStep == 0) const Spacer(),

          // Botão Continuar / Finalizar
          Container(
            height: 160.h,
            width: 550.w,
            margin: currentStep > 0
                ? EdgeInsets.only(bottom: 55.h)
                : EdgeInsets.only(bottom: 55.h, right: 55.w),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60)),
              onPressed: () {
                _enviarFormulario();
              },
              child: Text(
                currentStep < pages.length - 1 ? 'CONTINUAR' : 'FINALIZAR',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ]));
  }
}

class Identificacao extends StatelessWidget {
  final Map<String, TextEditingController> controllers;
  final MeiosDeHospedagemModel? hospedagemModel;

  const Identificacao(
      {super.key, required this.controllers, this.hospedagemModel});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Column(children: [
        ContainerHeader(title: 'Identificação'),
        UfMunicipioRg(controllers: controllers),

        RadioFormField(
          title: 'Tipo',
          options: ['Hotelaria e de Apoio'],
          onSaved: (newValue) {
            valoresjson['tipo'] = newValue;
          },
          initialValue: isUpdate == true ? hospedagemModel!.tipo : "",
        ),

        CheckboxGroupFormField(
          title: 'Subtipos',
          initialValue: isUpdate == true ? hospedagemModel!.subtipo : [],
          options: [
            'Hotel',
            'Hotel Histórico',
            'Pousada',
            'Resort',
            'Hotel Fazenda',
            'Flat/Apart-Hotel',
            'Cama e Café',
            'Albergue',
            'Motel',
            'Pensão',
            'Alojamento de Floresta',
            'Colônia de Férias',
            'Estalagem/Hospedaria',
            'Alojamento Coletivo',
            'Hospedagem Conventual (Mosteiro/Seminário/Convento',
            'Hospedagem Familiar',
            'Hotel de Trânsito',
            'Spa',
            'outro'
          ],
          onSaved: (newValue) {
            valoresjson['subtipo'] = newValue;
          },
        ),

        SizedBox(height: 100.w),

        ContainerHeader(title: 'Informações Gerais'),

        SizedBox(
          height: sizeScreen.height * 0.02,
        ),
        CustomTextField(
          name: 'Razão Social',
          controller: controllers['razaoSocial'],
        ),
        CustomTextField(
          controller: controllers['nomeFantasia'],
          name: 'Nome Fantasia',
        ),
        CustomTextField(
          controller: controllers['codigoCNAE'],
          name: 'Código CNAE',
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          controller: controllers['atividadeEconomica'],
          name: 'Atividade econômica',
        ),
        CustomTextField(
          controller: controllers['inscricaoMunicipal'],
          name: 'Inscrição Municipal',
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          controller: controllers['nomeDaRede'],
          name: 'Nome da rede/holding',
        ),
        CustomTextField(
          name: 'CNPJ',
          controller: controllers['CNPJ'],
          validat: _validators.validarCNPJ,
          formatter: [_validators.cnpjFormatter],
          keyboardType: TextInputType.numberWithOptions(),
        ),

        Column(
          children: [
            RadioFormField(
              title: 'Natureza',
              initialValue: isUpdate == true ? hospedagemModel!.natureza : "",
              options: ['pública', 'privada', 'outro'],
              onSaved: (newValue) {
                valoresjson['natureza'] = newValue;
              },
            ),
          ],
        ),

        CheckboxGroupFormField(
          title: 'Tipo de Organização/Instituição',
          onSaved: (p0) => valoresjson['tipoDeOrganizacao'] = p0,
          initialValue:
              isUpdate == true ? hospedagemModel!.tipoDeOrganizacao : [],
          options: [
            'associação',
            'sindicato',
            'cooperativa',
            'sistema S',
            'empresa',
            'outro'
          ],
        ),
        SizedBox(
          height: 25.w,
        ),
        Row(
          children: [
            textLabel(name: 'Início da Atividade', fontWeight: FontWeight.bold),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
                width: sizeScreen.width * 0.4,
                //height: sizeScreen.height * 0.07,
                child: CustomTextDate(
                  dateController: controllers['inicioDaAtividade'],
                ))
          ],
        ),
        SizedBox(
          height: sizeScreen.height * 0.03,
        ),
        textLabel(
            name: 'Quantidade de Funcionários', fontWeight: FontWeight.bold),
        SizedBox(
          height: sizeScreen.height * 0.02,
        ),
        Column(
          children: [
            Row(
              children: [
                textLabel(
                  name: 'Permanentes',
                ),
                SizedBox(
                  width: sizeScreen.width * 0.026,
                ),
                SizedBox(
                    width: sizeScreen.width * 0.6,
                    //height: sizeScreen.height * 0.07,
                    child: CustomTextField(
                      controller: controllers['qtdeFuncionariosPermanentes'],
                      name: 'n°',
                      keyboardType: TextInputType.numberWithOptions(),
                      formatter: [FilteringTextInputFormatter.digitsOnly],
                    ))
              ],
            ),
            SizedBox(
              height: sizeScreen.height * 0.02,
            ),
            Row(
              children: [
                textLabel(
                  name: 'Temporários',
                ),
                SizedBox(
                  width: sizeScreen.width * 0.038,
                ),
                SizedBox(
                    width: sizeScreen.width * 0.6,
                    //height: sizeScreen.height * 0.07,
                    child: CustomTextField(
                      controller: controllers['qtdeFuncionariosTemporarios'],
                      name: 'n°',
                      keyboardType: TextInputType.numberWithOptions(),
                      formatter: [FilteringTextInputFormatter.digitsOnly],
                    ))
              ],
            ),
            SizedBox(height: sizeScreen.height * 0.02),
            Row(
              children: [
                textLabel(
                  name: 'Pessoas com\ndefiicência (%)',
                ),
                SizedBox(
                    width: sizeScreen.width * 0.6,
                    //height: sizeScreen.height * 0.07,
                    child: CustomTextField(
                      controller: controllers['qtdeFuncionarisComDeficiencia'],
                      name: '%',
                      keyboardType: TextInputType.numberWithOptions(),
                      formatter: [FilteringTextInputFormatter.digitsOnly],
                    ))
              ],
            ),
            SizedBox(
              height: sizeScreen.height * 0.02,
            )
          ],
        ),

        RadioFormField(
          title: 'Localização',
          initialValue: isUpdate == true ? hospedagemModel!.localizacao : "",
          options: ['urbana', 'rural'],
          onSaved: (newValue) {
            valoresjson['localizacao'] = newValue;
          },
        ),
        SizedBox(
          height: 50.w,
        ),
        textLabel(name: 'Coordenadas Geográficas', fontWeight: FontWeight.bold),
        SizedBox(
          height: sizeScreen.height * 0.02,
        ),
        Column(children: [
          Row(
            children: [
              textLabel(
                name: 'Latitude',
              ),
              SizedBox(
                width: sizeScreen.width * 0.032,
              ),
              SizedBox(
                  width: sizeScreen.width * 0.6,
                  //height: sizeScreen.height * 0.07,
                  child: CustomTextField(
                    controller: controllers['latitude'],
                    name: 'valor',
                    keyboardType: TextInputType.numberWithOptions(),
                    formatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))
                    ],
                  ))
            ],
          ),
          SizedBox(
            height: sizeScreen.height * 0.02,
          ),
          Row(
            children: [
              textLabel(
                name: 'Longitude',
              ),
              SizedBox(
                  width: sizeScreen.width * 0.6,
                  //height: sizeScreen.height * 0.07,
                  child: CustomTextField(
                    controller: controllers['longitute'],
                    name: 'valor',
                    formatter: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))
                    ],
                    keyboardType: TextInputType.numberWithOptions(),
                  ))
            ],
          ),
          SizedBox(
            height: sizeScreen.height * 0.02,
          ),
        ]),
        textLabel(name: 'Endereço:', fontWeight: FontWeight.bold),

        CustomTextField(
          controller: controllers['avenidaRuaEtc'],
          name: 'avenida/rua/travessa/caminho/outro',
        ),
        CustomTextField(
          controller: controllers['bairroLocalidade'],
          name: 'bairro/localidade',
        ),
        CustomTextField(
          controller: controllers['distrito'],
          name: 'distrito',
        ),
        CustomTextField(
          controller: controllers['CEP'],
          formatter: [
            FilteringTextInputFormatter.digitsOnly,
            _validators.cepFormatter
          ],
          keyboardType: TextInputType.numberWithOptions(),
          name: 'CEP',
        ),
        SizedBox(
          height: sizeScreen.height * 0.03,
        ),
        Column(children: [
          Row(
            children: [
              textLabel(name: 'Whatsapp', fontWeight: FontWeight.bold),
              SizedBox(
                width: sizeScreen.width * 0.03,
              ),
              SizedBox(
                  width: sizeScreen.width * 0.6,
                  //height: sizeScreen.height * 0.07,
                  child: CustomTextField(
                    controller: controllers['whatsapp'],
                    formatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      _validators.phoneFormatter
                    ],
                    name: '(DD) n°',
                  ))
            ],
          ),
          Row(
            children: [
              textLabel(name: 'Instagram', fontWeight: FontWeight.bold),
              SizedBox(
                width: sizeScreen.width * 0.03,
              ),
              SizedBox(
                  width: sizeScreen.width * 0.6,
                  //height: sizeScreen.height * 0.07,
                  child: CustomTextField(
                    controller: controllers['instagram'],
                    name: '@',
                  ))
            ],
          ),
          SizedBox(
            height: sizeScreen.height * 0.03,
          ),
          Row(
            children: [
              textLabel(name: 'E-mail', fontWeight: FontWeight.bold),
              SizedBox(
                width: sizeScreen.width * 0.03,
              ),
              SizedBox(
                  width: sizeScreen.width * 0.5,
                  //height: sizeScreen.height * 0.07,
                  child: CustomTextField(
                    controller: controllers['email'],
                    keyboardType: TextInputType.emailAddress,
                    name: 'e-mail',
                  ))
            ],
          ),
          SizedBox(
            height: sizeScreen.height * 0.02,
          ),
          Row(
            children: [
              textLabel(name: 'Site', fontWeight: FontWeight.bold),
              SizedBox(
                width: sizeScreen.width * 0.05,
              ),
              SizedBox(
                width: sizeScreen.width * 0.045,
              ),
              SizedBox(
                  width: sizeScreen.width * 0.5,
                  //height: sizeScreen.height * 0.07,
                  child: CustomTextField(
                    controller: controllers['site'],
                    keyboardType: TextInputType.url,
                    name: 'www.endereço.com',
                  ))
            ],
          ),
        ]),
        SizedBox(
          height: sizeScreen.height * 0.06,
        ),
        textLabel(name: 'Sinalização', fontWeight: FontWeight.bold),
        SizedBox(
          height: sizeScreen.height * 0.02,
        ),
        ConditionalFieldsGroup(
            title: 'de acesso ',
            jsonKey: 'sinalizacaoDeAcesso',
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            children: []),
        ConditionalFieldsGroup(
            title: 'turística',
            jsonKey: 'sinalizacaoTuristica',
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            children: []),

        //  RadioD(number: 6, options: options)
        CheckboxGroupFormField(
          title: 'Proximidades',
          onSaved: (p0) => valoresjson['proximidades'] = p0,
          initialValue: isUpdate == true ? hospedagemModel!.proximidades : [],
          options: [
            'Restaurante',
            'Centro de Convenções exposições',
            'Shopping',
            'Bar/Lanchconete',
            'Posto de combustível',
            'Galeria/rua comercial',
            'outro'
          ],
        ),
        textLabel(
          name: 'Distâncias (km)',
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          name: 'Aeroporto',
          controller: controllers['aeroporto'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Estação Rodoviária',
          controller: controllers['estacaoRodoviaria'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Estação Ferroviária',
          controller: controllers['estacaoFerroviaria'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Estação Marítima/Fluvial',
          controller: controllers['estacaoMaritima'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Estação Metroviária',
          controller: controllers['estacaoMetroviaria'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Ponto de Ônibus',
          controller: controllers['pontoDeOnibus'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Ponto de Táxi',
          controller: controllers['pontoDeTaxi'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Outras - nome',
          controller: controllers['distanciasOutrosNome'],
        ),
        CustomTextField(
          name: 'Outras',
          controller: controllers['distanciaOutros'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        SizedBox(
          height: 50.w,
        ),
        textLabel(name: 'Pontos de Referência', fontWeight: FontWeight.bold),
        SizedBox(
          height: 20.w,
        ),
        CustomTextField(
          controller: controllers['pontosDeReferencia'],
          name: 'Ponto de Referência',
        ),
        SizedBox(
          height: 100.w,
        ),
        textLabel(
          name: 'Cadastros, Classificações e Outros',
          fontWeight: FontWeight.bold,
        ),
        TableMtur(
          getValues: isUpdate ? hospedagemModel!.tabelaMTUR : {},
          onChanged: (p0) => valoresjson['tabelaMtur'] = p0,
        ),

        CheckboxGroupFormField(
          options: [
            'Aventura',
            'Ecoturismo',
            'Sol e praia',
            'Rural',
            'Estudos e intercâmbio',
            'Negócios e eventos',
            'Cultural (cívico, étnico, religioso, místico e esotérico)',
            'Náutico',
            'Esporte',
            'Saúde (bem-estar e médico)',
            'Pesca',
            ' Não é especializado em nenhum segmento'
          ],
          isLimitedBy3: true,
          title:
              'Segmentos ou tipos de turismo em que é especializado (assinalar até 3)',
          onSaved: (newValue) =>
              valoresjson['segmentosOuTurismoEspecializado'] = newValue,
          initialValue:
              isUpdate ? hospedagemModel!.segmentosOuTurismoEspecializado : [],
        )
      ]),
    );
  }
}

class Funcionamento extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final MeiosDeHospedagemModel? hospedagemModel;
  const Funcionamento(
      {super.key, this.hospedagemModel, required this.controllers});

  @override
  State<Funcionamento> createState() => _FuncionamentoState();
}

class _FuncionamentoState extends State<Funcionamento> {
  final PesquisaController _pesquisaController = PesquisaController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pesquisaController.setEstados();
    _pesquisaController.setPaises();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
        child: Column(children: [
      ContainerHeader(title: 'Funcionamento'),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Estrutura de funcionamento:',
        fontWeight: FontWeight.bold,
      ),
      RadioFormField(
        title: 'Tipo de Diária',
        options: [
          'Sem Alimentação',
          'Café da manhã',
          'Meia Pensão',
          'Pensão Completa',
          'Tudo incluído'
        ],
        onSaved: (newValue) {
          valoresjson['tipoDeDiaria'] = newValue;
        },
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.tipoDeDiaria : "",
      ),

      CheckboxGroupFormField(
        title: 'Formas de Pagamento',
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.formasDePagamento : [],
        onSaved: (p0) => valoresjson['formasDePagamento'] = p0,
        options: ['Dinheiro', 'Pix', 'Cartão de Crédito', 'Cartão de Débito'],
      ),

      CheckboxGroupFormField(
        title: 'Reservas',
        initialValue: isUpdate == true ? widget.hospedagemModel!.reservas : [],
        onSaved: (p0) => valoresjson['reservas'] = p0,
        options: [
          'Balcão',
          'Whatsapp',
          'Instagram',
          'Site',
          'Agência de turismo',
          'Antecipado'
        ],
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(name: 'Atendimento ao Público', fontWeight: FontWeight.bold),

      CheckboxGroupFormField(
          title: 'Atendimento em Língua Estrangeira',
          initialValue: isUpdate == true
              ? widget.hospedagemModel!.atendimentoEmLinguaEstrangeira
              : [],
          onSaved: (p0) => valoresjson['atendimentoEmLinguaEstrangeira'] = p0,
          options: ['Não', 'Inglês', 'Espanhol', 'outro']),

      CheckboxGroupFormField(
          title: 'Informativos Impressos:',
          initialValue: isUpdate == true
              ? widget.hospedagemModel!.informativosImpressos
              : [],
          onSaved: (p0) => valoresjson['informativosImpressos'] = p0,
          options: ['Não', 'Inglês', 'Espanhol', 'outro']),

      textLabel(
        name: 'Regras de Funcionamento',
        fontWeight: FontWeight.bold,
      ),

      CheckboxGroupFormField(
        title: 'Período',
        initialValue: isUpdate == true ? widget.hospedagemModel!.periodo : [],
        options: [
          'Janeiro',
          'Fevereiro',
          'Março',
          'Abril',
          'Maio',
          'Junho',
          'Julho',
          'Agosto',
          'Setembro',
          'Outubro',
          'Novembro',
          'Dezembro',
          'Ano Inteiro'
        ],
        onSaved: (newValue) {
          valoresjson['periodo'] = newValue;
        },
      ),
      SizedBox(
        height: 30.w,
      ),
      textLabel(name: 'Horário', fontWeight: FontWeight.bold),
      SizedBox(
        height: sizeScreen.height * 0.01,
      ),

      TabelaHorarios(
        getValue:
            isUpdate == true ? widget.hospedagemModel!.tabelasHorario : {},
        onChanged: (p0) {
          valoresjson['tabelasHorario'] = p0;
        },
      ),

      SizedBox(
        height: sizeScreen.height * 0.01,
      ),
      //TabelaT2(),

      ConditionalFieldsGroup(
        title: 'Funcionamento 24 Horas',
        optionModelValue:
            isUpdate == true ? widget.hospedagemModel!.funcionamento24h : "não",
        jsonKey: 'funcionamento24h',
        valoresJson: valoresjson,
        isUpdate: isUpdate,
        children: [],
      ),
      SizedBox(
        height: 50.w,
      ),
      textLabel(
        name: 'Funcionamento em Feriados',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      ConditionalFieldsGroup(
          title: 'Funcionamento em Feriados',
          optionModelValue: isUpdate == true
              ? widget.hospedagemModel!.funcionamentoEmFeriados
              : "não",
          jsonKey: 'funcionamentoEmFeriados',
          children: [],
          isUpdate: isUpdate,
          valoresJson: valoresjson),
      SizedBox(
        height: 25.w,
      ),
      CheckboxGroupFormField(
        title: 'Restrições',
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.restricoes : [],
        onSaved: (p0) => valoresjson['restricoes'] = p0,
        options: ['Crianças', 'Fumantes', 'Animais', 'outro'],
      ),
      SizedBox(
        height: 50.w,
      ),
      textLabel(
        name: 'Outras Regras e Informações',
        fontWeight: FontWeight.bold,
      ),

      CustomTextField(
        controller: widget.controllers['outrasRegrasEInformacoes'],
        name: 'Regras e informações',
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Dados da Visitação',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Ocupação Ano nº',
        fontWeight: FontWeight.bold,
      ),

      CustomTextField(
        controller: widget.controllers['nAnoOcupacao'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'nº',
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Ocupação na Alta Temporada nº',
        fontWeight: FontWeight.bold,
      ),

      CustomTextField(
        controller: widget.controllers['nOcupacaoAltaTemporada'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'nº',
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Meses de Alta Temporada',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.01,
      ),

      CheckboxGroupFormField(
        title: 'Meses de Alta Temporada',
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.mesesAltaTemporada : [],
        onSaved: (p0) => valoresjson['mesesAltaTemporada'] = p0,
        options: [
          'Janeiro',
          'Fevereiro',
          'Março',
          'Abril',
          'Maio',
          'Junho',
          'Julho',
          'Agosto',
          'Setembro',
          'Outubro',
          'Novembro',
          'Dezembro',
          'Ano Inteiro'
        ],
      ),
      SizedBox(
        height: 50.w,
      ),
      textLabel(
        name: 'Origem dos Visitantes/Turistas',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 25.w,
      ),
      CheckboxGroupFormField(
        onSaved: (p0) => valoresjson['origemDosVisitantes'] = p0,
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.origemDosVisitantes : [],
        options: ['Entorno municipal', 'Estadual', 'Nacional', 'Internacional'],
      ),
      SizedBox(
        height: 50.w,
      ),
      textLabel(
        name: 'Origem dos Turistas Nacionais e Internacionais',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      MultiAutocompleteFormField(
        initialValue: isUpdate ? widget.hospedagemModel!.origemNacional : [],
        title: 'Origem dos Turistas Nacionais (até 5 estados)',
        label: 'Selecione um Estado',
        fieldCount: 5,
        optionsBuilder: (textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable.empty();
          }
          return _pesquisaController.estados
              .map((e) => e.nome)
              .where((nome) => nome.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ));
        },
        onSaved: (newValue) {
          valoresjson['origemNacional'] = newValue;
        },
        validator: (values) {
          // Exemplo de validação: exigir pelo menos um estado
          if (values == null || values.isEmpty) {
            return 'Por favor, selecione pelo menos um estado.';
          }
          return null;
        },
      ),
      SizedBox(
        height: 55.h,
      ),
      MultiAutocompleteFormField(
        initialValue:
            isUpdate ? widget.hospedagemModel!.origemInternacional : [],
        title: 'Origem dos Turistas Internacionais (até 5 países)',
        label: 'Selecione um País',
        optionsBuilder: (textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable.empty();
          }
          return _pesquisaController.paises
              .map((e) => e.nome)
              .where((nome) => nome.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ));
        },
        onSaved: (newValue) {
          valoresjson['origemInternacional'] = newValue;
        },
        validator: (values) {
          if (values == null || values.isEmpty) {
            return 'Por favor, selecione pelo menos um pais.';
          }
          return null;
        },
      ),
      SizedBox(
        height: sizeScreen.height * 0.05,
      ),
      ContainerHeader(title: 'Características'),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),

      textLabel(
        name: 'Unidades Habitacionais (UH)',
        fontWeight: FontWeight.bold,
      ),

      CustomTextField(
        controller: widget.controllers['nTotalDeUH'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Total de UH (nº)',
      ),

      CustomTextField(
        controller: widget.controllers['nTotalDeLeitos'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Total de Leitos (nº)',
      ),
      CustomTextField(
        controller: widget.controllers['nUhAdaptadasParaPCD'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'UH Adaptadas para PCD (nº)',
        getValue: (newValue) {
          valoresjson['nUhAdaptadasParaPCD'] = newValue;
        },
      ),
      CheckboxGroupFormField(
          title: 'Produtos de Higiene Pessoal',
          initialValue: isUpdate == true
              ? widget.hospedagemModel!.produtosHigienePessoal
              : [],
          onSaved: (p0) => valoresjson['produtosHigienePessoal'] = p0,
          options: [
            'Shampoo',
            'Toalha',
            'Condicionador',
            'Roupão de banho',
            'Sabonete',
            'Touca',
            'Creme dental',
            'Chinelo',
            'Loção',
            'outro'
          ]),

      CheckboxGroupFormField(
        title: 'Equipamentos e Serviços',
        initialValue: isUpdate == true
            ? widget.hospedagemModel!.equipamentosEServicos
            : [],
        onSaved: (p0) => valoresjson['equipamentosEServicos'] = p0,
        options: [
          'TV',
          'Internet',
          'Ar-Condicionado',
          'Cama King Size',
          'Cama Queen Size',
          'Panelas e louças',
          'Micro-ondas',
          'Forno Elétrico',
          'Cofre',
          'Academia',
          'Hidromassagem',
          'Sauna seca',
          'Room - service',
          'Room service 24h',
          'Controle de Iluminação',
          'Luminária para leitura',
          'outro'
        ],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Instalações',
        fontWeight: FontWeight.bold,
      ),
      CheckboxGroupFormField(
        title: 'Estacionamento',
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.estacionamento : [],
        onSaved: (p0) => valoresjson['estacionamento'] = p0,
        options: ['Pago', 'Gratuito', 'Coberto', 'Descoberto'],
      ),
      CustomTextField(
        controller: widget.controllers['nCapacidadeDeVeiculos'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Capacidade de Veículos (nº)',
      ),
      CustomTextField(
        controller: widget.controllers['nAutomoveis'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Automóveis (nº)',
      ),
      CustomTextField(
        controller: widget.controllers['nOnibus'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Ônibus (nº)',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Outras Instalações e Estruturas',
        fontWeight: FontWeight.bold,
      ),
      RadioFormField(
        title: 'Energia Elétrica',
        options: ['110 volts', '220 volts', '110/220 volts'],
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.energiaEletrica : "",
        onSaved: (newValue) {
          valoresjson['energiaEletrica'] = newValue;
        },
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      CustomTextField(
        controller: widget.controllers['capacidadeEmKVA'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Capacidade em KVA',
      ),
      SizedBox(
        height: sizeScreen.height * 0.032,
      ),
      ConditionalFieldsGroup(
        isUpdate: isUpdate,
        jsonKey: 'geradorDeEmergencia',
        valoresJson: valoresjson,
        title: 'Gerador de Emergência',
        optionModelValue: isUpdate == true
            ? widget.hospedagemModel!.geradorDeEmergencia
            : "não",
        children: [
          CustomTextField(
            controller: widget.controllers['geradorCapacidadeEmKVA'],
            formatter: [FilteringTextInputFormatter.digitsOnly],
            name: 'KVA',
            getValue: (newValue) {
              valoresjson['geradorCapacidadeEmKVA'] = newValue;
            },
          ),
        ],
      ),

      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Área de Alimentação',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Restaurante',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      CheckboxGroupFormField(
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.restaurante : [],
        onSaved: (p0) => valoresjson['restaurante'] = p0,
        options: [
          'Não',
          'Apenas para hóspedes',
          'Aberto ao público',
          'Adaptado para PCD'
        ],
      ),
      SizedBox(
        height: 50.w,
      ),
      textLabel(
        name: 'Capacidade de Atendimento Restaurante',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      CustomTextField(
        controller: widget.controllers['nCapacidadeInstaladaPorDia'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Capacidade Instalada por Dia (nº)',
      ),
      CustomTextField(
        controller: widget.controllers['nPessoasAtendidasSentadas'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Pessoas Atendidas Sentadas (nº)',
      ),
      CustomTextField(
        controller: widget.controllers['nCapacidadeSimultanea'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Capacidade Simultânea (nº)',
      ),
      CustomTextField(
        controller: widget.controllers['nPessoasAtendidasSentadasSimultanea'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Pessoas Atendidas Sentadas (nº)',
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      CheckboxGroupFormField(
        title: 'Lanchonete',
        onSaved: (p0) => valoresjson['lanchonete'] = p0,
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.lanchonete : [],
        options: [
          'Não',
          'Apenas para hóspedes',
          'Aberto ao público',
          'Adaptado para PCD'
        ],
      ),
      SizedBox(
        height: 25.w,
      ),

      textLabel(
        name: 'Capacidade de Atendimento Lanchonete',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['lanchoneteCapacidadeInstaladaPorDia'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Capacidade Instalada por Dia (nº)',
      ),
      CustomTextField(
        controller:
            widget.controllers['lanchoneteCapacidadePessoasAtendidasSentadas'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Capacidade Pessoas Atendidas Sentadas (nº)',
      ),
      CustomTextField(
        controller: widget.controllers['lanchoneteCapacidadeSimultanea'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Capacidade Simultânea (nº)',
      ),
      CustomTextField(
        controller:
            widget.controllers['lanchoneteCapacidadeSentadasSimultanea'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: 'Capacidade Pessoas Sentadas (nº)',
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Área de Recreação e Lazer',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Instalações e Espaços',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      CheckboxGroupFormField(
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.instalacaoEEspacos : [],
        onSaved: (p0) => valoresjson['instalacaoEEspacos'] = p0,
        options: [
          'Piscina',
          'Toboágua',
          'Quadra de tênis',
          'Área verde',
          'Piscina aquecida',
          'Parque infantil',
          'Campo de futebol',
          'Lago paronâmico',
          'Piscina infantil',
          'Clube infantil',
          'Campo de golfe',
          'Bar na piscina',
          'Quadra poliesportiva',
          'Pista de cooper',
          'outro'
        ],
      ),
      SizedBox(
        height: 25.w,
      ),
      CheckboxGroupFormField(
        title: 'Outros Espaços, Equipamentos e\nAtividades',
        initialValue: isUpdate == true
            ? widget.hospedagemModel!.outrosEspacosEAtividades
            : [],
        onSaved: (p0) => valoresjson['outrosEspacosEAtividades'] = p0,
        options: [
          'Observação da fauna',
          'Visita a produção agrícola',
          'Atividades pedagógicas',
          'Atividades Programadas para adultos',
          'Passeios em barcos e lanchas',
          'Realização de cursos, seminários, feiras',
          'Competições de pesca',
          'Equipamento para mergulho',
          'Tirolesa',
          'Cicloturismo / Atividade com bicicleta',
          'Mergulho livre',
          'Banana boat',
          'Mini zoo',
          'Horta',
          'Peregrinação e romarias',
          'Venda de souvenir e produtos típicos',
          'Observação de flora',
          'Degustação gastronômica',
          'Atividades programadas para crianças',
          'atividades equestres',
          'Passeios em embarcações alugadas',
          'Realização de eventos (Esportivos, Sociais, Culturais)',
          'Pesca amadora',
          'Pedalinhos',
          'Arvorismo',
          'Caminhadas / trilha interpretativas',
          'Esqui aquático',
          'Jet ski',
          'Fazendinha',
          'Centro equestre',
          'Retiros espirituais',
          'outro'
        ],
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Área para Eventos',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.04,
      ),
      textLabel(
        name: 'Instalações',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.04,
      ),
      TablesInstalacoes(
        getValue:
            isUpdate == true ? widget.hospedagemModel!.tabelaInstalacoes : {},
        onChanged: (p0) {
          valoresjson['tabelaInstalacoes'] = p0;
        },
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Serviços',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      CheckboxGroupFormField(
        initialValue: isUpdate == true ? widget.hospedagemModel!.servicos : [],
        onSaved: (p0) => valoresjson['servicos'] = p0,
        options: [
          'Realização de eventos próprios',
          'Aluguel de equipamentos',
          'Aluguel de espaço para terceiros',
          'Serviços de alimentação',
          'Organização de eventos',
          'Serviços de som',
          'outro',
        ],
      ),
      SizedBox(
        height: 30.w,
      ),
      textLabel(
        name: 'Equipamentos',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      CheckboxGroupFormField(
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.equipamentos : [],
        onSaved: (p0) => valoresjson['equipamentos'] = p0,
        options: [
          'Internet',
          'Elevador',
          'Poltronas',
          'Tv com canal aberto',
          'Projetor',
          'Computador',
          'Equipamento de tradução simultânea',
          'Parabólica',
          'Ar condicionado central',
          'Palco',
          'outro'
        ],
      ),
      SizedBox(
        height: 30.w,
      ),
      textLabel(
        name: 'Facilidades e Serviços',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      CheckboxGroupFormField(
        initialValue: isUpdate == true
            ? widget.hospedagemModel!.facilidadesEServicos
            : [],
        onSaved: (p0) => valoresjson['facilidadesEServicos'] = p0,
        options: [
          'Adaptador de voltagem',
          'Impressora',
          'Micro - ondas',
          'Adega climatizada',
          'Loja de conveniência',
          'Cofre ',
          'Agência de turismo',
          'Heliponto',
          'Lavanderia',
          'Serviço de babá',
          'Auditório',
          'Sala de imprensa',
          'Salão de beleza',
          'Passeios e guias',
          'Ar condicionado',
          'Centra telefônica',
          'Internet',
          'Circuito interno de TV',
          'Churrasqueira',
          'Barbearia',
          'Farmácia',
          'Guarda - volume',
          'Locadora de veículos',
          'Embarcações',
          'Serviços de copa',
          'Serviço médico',
          'Sala de reuniões',
          'Sala de ginástica',
          'Salão de jogos',
          'Câmbio',
          'Ventilador',
          'Telefone',
          'Internet sem fio',
          'Forno elétrico',
          'Bar',
          'Lojas',
          'Caixa eletrônico',
          'Informações turísticas',
          'Traslados',
          'Manobrista',
          'Serviço bilíngue',
          'Elevador',
          'Sala de convenções',
          'Equipamento de ginástica',
          'Exposição de arte/artesanato',
          'outro'
        ],
      ),
      SizedBox(
        height: 30.w,
      ),
      textLabel(
        name: 'Facilidades para Executivos:',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      CheckboxGroupFormField(
        initialValue: isUpdate == true
            ? widget.hospedagemModel!.facilidadesParaExecutivos
            : [],
        onSaved: (p0) => valoresjson['facilidadesParaExecutivos'] = p0,
        options: [
          'Apartamentos em andares especiais',
          'Café da manhã em ambiente privativo',
          'Jornais diários no apartamento',
          'Acesso á internet sem fio',
          'Acesso a internet em áreas comuns',
          'Impressora',
          'Datashow',
          'Sla de reunião',
          'Serviço de café',
          'Guarda de mala em consignação',
          'Lustro e graxa para os sapatos',
          'Check in e check out expresso em ambiente diferenciado',
          'Early check in e late check out conforme disponibilidade',
          'Acesso á internet banda larga',
          'Acesso a internet na UH',
          'Computador ',
          'fax',
          'Máquina de fotocópia',
          'Serviço de chá',
          'Refrigerante / sucos',
          'Lavagem e passagem de roupa no período noturno',
          'outro'
        ],
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      )
    ]));
  }
}

//           Container(
//             color: const Color.fromARGB(255, 55, 111, 60),
//             height: sizeScreen.height * 0.15,
//             padding: EdgeInsets.only(
//                 top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
//             child: Text(
//               'Proteção, Qualificação, Certificação, Premiação, destaques e outros',
//               style: TextStyle(
//                   color: Colors.white, fontSize: sizeScreen.height * 0.03),
//             ),
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.05,
//           ),
//           Row(children: [
//             textLabel(
//               name: 'Do equipamento/espaço:',
//               fontWeight: FontWeight.bold,
//             ),
//             SizedBox(
//               width: sizeScreen.width * 0.04,
//             ),
//             SizedBox(
//                 // width: sizeScreen.width * 0.5,
//                 //  //height: sizeScreen.height * 0.07,
//                 child: ExpansionTileYoN(
//               optionModel: isUpdate == true
//                   ? widget.hospedagemModel!.doEquipamentoEspaco
//                   : "não",
//               getValue: (newValue) {
//                 valoresjson['doEquipamentoEspaco'] = newValue;
//               },
//             ))
//           ]),
//           SizedBox(
//             height: sizeScreen.height * 0.02,
//           ),
//           TabelsEquipamentoEEspaco(
//             getValue: isUpdate == true
//                 ? widget.hospedagemModel!.tabelaEquipamentoEEspaco
//                 : {},
//             onChanged: (p0) {
//               setState(() {
//                 valoresjson['tabelaEquipamentoEEspaco'] = p0;
//               });
//             },
//           ),
//           SizedBox(
//             height: 100.w,
//           ),
//           Row(children: [
//             textLabel(
//               name:
//                   'Da área ou edificação \nem que está\nlocalizado / Instalado',
//               fontWeight: FontWeight.bold,
//             ),
//             SizedBox(
//               width: sizeScreen.width * 0.04,
//             ),
//             SizedBox(
//                 // width: sizeScreen.width * 0.5,
//                 //  //height: sizeScreen.height * 0.07,
//                 child: ExpansionTileYoN(
//               optionModel: isUpdate == true
//                   ? widget
//                       .hospedagemModel!.daAreaOuEdificacaoEmQueEstaLocalizado
//                   : "não",
//               getValue: (newValue) {
//                 valoresjson['daAreaOuEdificacaoEmQueEstaLocalizado'] = newValue;
//               },
//             ))
//           ]),
//           SizedBox(
//             height: 100.w,
//           ),
//           TabelsEquipamentoEEspaco(
//             getValue: isUpdate == true
//                 ? widget.hospedagemModel!.tabelaEquipamentoEEspaco2
//                 : {},
//             onChanged: (p0) {
//               setState(() {
//                 valoresjson['tabelaEquipamentoEEspaco2'] = p0;
//               });
//             },
//           ),

//           SizedBox(
//             height: sizeScreen.height * 0.05,
//           ),
//           Container(
//             color: const Color.fromARGB(255, 55, 111, 60),
//             height: sizeScreen.height * 0.06,
//             width: sizeScreen.width,
//             padding: EdgeInsets.only(
//                 top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
//             child: Text(
//               'Estado geral de conservação',
//               style: TextStyle(
//                   color: Colors.white, fontSize: sizeScreen.height * 0.03),
//             ),
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.05,
//           ),
//           RadioD(
//             indexModel: isUpdate == true
//                 ? widget.hospedagemModel!.estadoGeralDeConservacao
//                 : "",
//             options: ['Muito bom', 'Bom', 'Ruim'],
//             getValue: (newValue) {
//               valoresjson['estadoGeralDeConservacao'] = newValue;
//             },
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.05,
//           ),
//           Container(
//             color: const Color.fromARGB(255, 55, 111, 60),
//             height: sizeScreen.height * 0.06,
//             width: sizeScreen.width,
//             padding: EdgeInsets.only(
//                 top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
//             child: Text(
//               'Acessibilidade',
//               style: TextStyle(
//                   color: Colors.white, fontSize: sizeScreen.height * 0.03),
//             ),
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.02,
//           ),
//           textLabel(
//             name:
//                 'Possui alguma facilidade para pessoas  com deficiência ou mobilidade reduzida?',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.04,
//           ),
//           ExpansionTileYoN(
//             optionModel: isUpdate == true
//                 ? widget.hospedagemModel!.possuiFacilidade
//                 : "não",
//             getValue: (newValue) {
//               valoresjson['possuiFacilidade'] = newValue;
//             },
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.02,
//           ),
//           textLabel(
//             name: 'obs: caso sim, responder às questões seguintes',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.02,
//           ),
//           textLabel(
//             name: 'Pessoal capacitado para receber PCD:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.02,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true
//                 ? widget.hospedagemModel!.pessoalCapacitadoParaReceberPCD
//                 : [],
//             onChanged: (p0) =>
//                 valoresjson['pessoalCapacitadoParaReceberPCD'] = p0,
//             nomes: [
//               'Não',
//               'Física',
//               'Auditiva',
//               'Visual',
//               'Mental',
//               'Múltipla'
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Rota externa acessível:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.02,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true
//                 ? widget.hospedagemModel!.rotaExternaAcessivel
//                 : [],
//             onChanged: (p0) => valoresjson['rotaExternaAcessivel'] = p0,
//             nomes: [
//               'Não',
//               'Estacionamento',
//               'Calçada rebaixada',
//               'Faixa de pedestre',
//               'Rampa',
//               'Semáforo sonoro',
//               'Piso tátil de alerta',
//               'Piso regular antiderrapante',
//               'Livre de obstáculos',
//               'outro'
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Símbolo internacional de acesso:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.02,
//           ),

//           CheckC(
//             nomesModel: isUpdate == true
//                 ? widget.hospedagemModel!.simboloInternacionalDeAcesso
//                 : [],
//             onChanged: (p0) => valoresjson['simboloInternacionalDeAcesso'] = p0,
//             nomes: [
//               'Não',
//               'Entrada',
//               'Área reservada',
//               'Estacionamento',
//               'Área de embarque e desembarque',
//               'Sanitário',
//               'Saída de emergência',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Local de embarque e desembarque',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.02,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true
//                 ? widget.hospedagemModel!.localDeEmbarqueEDesembarque
//                 : [],
//             onChanged: (p0) => valoresjson['localDeEmbarqueEDesembarque'] = p0,
//             nomes: ['Não', 'Sinalizado', 'Com acesso em nível'],
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.02,
//           ),
//           textLabel(
//             name: 'Vaga em estacionamento:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(height: 50.w),
//           CheckC(
//             nomesModel: isUpdate == true
//                 ? widget.hospedagemModel!.vagaEmEstacionamento
//                 : [],
//             onChanged: (p0) => valoresjson['vagaEmEstacionamento'] = p0,
//             nomes: [
//               'Não',
//               'Sinalizado',
//               'Com acesso em nível',
//               'Alargada para cadeira de rodas',
//               'Rampa de acesso á calçada'
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Área de circulação / acesso interno\npara cadeira de rodas:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true
//                 ? widget.hospedagemModel!.areaDeCirculacaoAcessoInterno
//                 : [],
//             onChanged: (p0) =>
//                 valoresjson['areaDeCirculacaoAcessoInterno'] = p0,
//             nomes: [
//               'Não',
//               'Rampa',
//               'Elevador',
//               'Plataforma elevatória',
//               'Porta larga',
//               'Piso regular / antiderrapante'
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Escada:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true ? widget.hospedagemModel!.escada : [],
//             onChanged: (p0) => valoresjson['escada'] = p0,
//             nomes: [
//               'Não',
//               'Corrimão',
//               'Patamar para descanso',
//               'Sinalização tátil de alerta',
//               'Piso antiderrapante',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Rampa:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true ? widget.hospedagemModel!.rampa : [],
//             onChanged: (p0) => valoresjson['rampa'] = p0,
//             nomes: [
//               'Não',
//               'Corrimão',
//               'Patamar para descanso',
//               'Sinalização tátil de alerta',
//               'Piso antiderrapante',
//               'Inclinação adequada',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Piso:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true ? widget.hospedagemModel!.piso : [],
//             onChanged: (p0) => valoresjson['piso'] = p0,
//             nomes: [
//               'Não',
//               'Tátil',
//               'Sem obstáculos',
//               'Antiderrapante/deslizante',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Elevador:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel:
//                 isUpdate == true ? widget.hospedagemModel!.elevador : [],
//             onChanged: (p0) => valoresjson['elevador'] = p0,
//             nomes: [
//               'Não',
//               'Sinalizado em braile',
//               'Dispositivo sonoro',
//               'Dispositivo luminoso',
//               'Sensor eletrônico (porta)'
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Equipamento motorizado para deslocamento interno:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true
//                 ? widget.hospedagemModel!
//                     .equipamentoMotorizadoParaDeslocamentoInterno
//                 : [],
//             onChanged: (p0) =>
//                 valoresjson['equipamentoMotorizadoParaDeslocamentoInterno'] =
//                     p0,
//             nomes: [
//               'Não',
//               'Cadeira',
//               'Carrinho',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Sinalização visual:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true
//                 ? widget.hospedagemModel!.sinalizacaoVisual
//                 : [],
//             onChanged: (p0) => valoresjson['sinalizacaoVisual'] = p0,
//             nomes: [
//               'Não',
//               'Entrada',
//               'Recepção',
//               'Porta',
//               'Sanitário',
//               'Elevador',
//               'Restaurante',
//               'Área de lazer',
//               'Área de resgate',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Sinalização tátil:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true
//                 ? widget.hospedagemModel!.sinalizacaoTatil
//                 : [],
//             onChanged: (p0) => valoresjson['sinalizacaoTatil'] = p0,
//             nomes: [
//               'Não',
//               'Entrada',
//               'Recepção',
//               'Porta',
//               'Sanitário',
//               'Elevador',
//               'Restaurante',
//               'Área de lazer',
//               'Área de resgate',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Alarme de emergência:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true
//                 ? widget.hospedagemModel!.alarmeDeEmergencia
//                 : [],
//             onChanged: (p0) => valoresjson['alarmeDeEmergencia'] = p0,
//             nomes: [
//               'Não',
//               'Sonoro',
//               'Visual',
//               'Vibratório',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Comunicação:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel:
//                 isUpdate == true ? widget.hospedagemModel!.comunicacao : [],
//             onChanged: (p0) => valoresjson['comunicacao'] = p0,
//             nomes: [
//               'Não',
//               'Texto informativo em braile',
//               'Texto informativo em fonte ampliada',
//               'Intérprete em libras',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Balcão de atendimento:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel: isUpdate == true
//                 ? widget.hospedagemModel!.balcaoDeAtendimento
//                 : [],
//             onChanged: (p0) => valoresjson['balcaoDeAtendimento'] = p0,
//             nomes: [
//               'Não',
//               'Rebaixado',
//               'Preferencial para PCD ou com deficiência ou mobilidade reduzida',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Mobiliário:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             onChanged: (p0) => valoresjson['mobiliario'] = p0,
//             nomesModel:
//                 isUpdate == true ? widget.hospedagemModel!.mobiliario : [],
//             nomes: [
//               'Não',
//               'Altura adequada',
//               'Recuo adequado',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Sanitário:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             onChanged: (p0) => valoresjson['sanitario'] = p0,
//             nomesModel:
//                 isUpdate == true ? widget.hospedagemModel!.sanitario : [],
//             nomes: [
//               'Não',
//               'Porta larga suficiente para entrada de cadeira de rodas ',
//               'Acesso para cadeira de rodas',
//               'Espelho rebaixado ou com ângulo de alcance visual',
//               'Torneira monocomando / alavanca',
//               'Barra de apoio',
//               'Giro para cadeira de rodas',
//               'Pia rebaixada',
//               'Boxe ou banheira daptada',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name: 'Telefone:',
//             fontWeight: FontWeight.bold,
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           CheckC(
//             nomesModel:
//                 isUpdate == true ? widget.hospedagemModel!.telefone : [],
//             onChanged: (p0) => valoresjson['telefone'] = p0,
//             nomes: [
//               'Não',
//               'Altura adequada',
//               'Para surdos (TPS ou TTS)',
//             ],
//           ),
//           SizedBox(
//             height: 50.w,
//           ),
//           textLabel(
//             name:
//                 'Sinalização indicativa de atendimento preferencial para pessoas com deficiência ou mobilidade reduzida:',
//             fontWeight: FontWeight.bold,
//           ),
//           const SizedBox(
//             height: 50,
//           ),

//           ExpansionTileYoN(
//             optionModel: isUpdate == true
//                 ? widget.hospedagemModel!.sinalizacaoIndicativa
//                 : "não",
//             getValue: (newValue) {
//               valoresjson['sinalizacaoIndicativa'] = newValue;
//             },
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.02,
//           ),
//           Row(
//             children: [
//               textLabel(
//                 name: 'Outros',
//                 fontWeight: FontWeight.bold,
//               ),
//               SizedBox(
//                 width: sizeScreen.width * 0.1,
//               ),
//               SizedBox(
//                   width: sizeScreen.width * 0.6,
//                   //eight: sizeScreen.height * 0.07,
//                   child: CustomTextField(
//                     controller: getController('outros'),
//                     name: '',
//                     getValue: (newValue) {
//                       valoresjson['outros'] = newValue;
//                     },
//                   ))
//             ],
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.05,
//           ),
//           Container(
//             color: const Color.fromARGB(255, 55, 111, 60),
//             height: sizeScreen.height * 0.06,
//             width: sizeScreen.width,
//             padding: EdgeInsets.only(
//                 top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
//             child: Text(
//               'Observações',
//               style: TextStyle(
//                   color: Colors.white, fontSize: sizeScreen.height * 0.03),
//             ),
//           ),
//           CustomTextField(
//             controller: getController('observacoes'),
//             name: '',
//             getValue: (newValue) {
//               valoresjson['observacoes'] = newValue;
//             },
//           ),
//           SizedBox(
//             height: sizeScreen.height * 0.05,
//           ),

//           Container(
//             color: const Color.fromARGB(255, 55, 111, 60),
//             height: sizeScreen.height * 0.06,
//             width: sizeScreen.width,
//             padding: EdgeInsets.only(
//                 top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
//             child: Text(
//               'Referências',
//               style: TextStyle(
//                   color: Colors.white, fontSize: sizeScreen.height * 0.03),
//             ),
//           ),
//           CustomTextField(
//             controller: getController('referencias'),
//             name: '',
//             getValue: (newValue) {
//               valoresjson['referencias'] = newValue;
//             },
//           ),

//           SizedBox(
//             height: sizeScreen.height * 0.05,
//           ),

//           SizedBox(
//             height: sizeScreen.height * 0.05,
//           )
//         ],
//       ),
//     );
//   }
// }
