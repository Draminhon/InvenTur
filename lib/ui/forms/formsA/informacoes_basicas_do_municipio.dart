import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/forms/forms%20A/informacoes_basicas_model.dart';
import 'package:inventur/controllers/pesquisa_controller.dart';
import 'package:inventur/ui/widgets/widgets/checkBox.dart';
import 'package:inventur/ui/widgets/widgets/fields.dart';
import 'package:inventur/ui/widgets/container_widget.dart';
import 'package:inventur/ui/widgets/text%20fields/customOutro.dart';
import 'package:inventur/ui/widgets/maps/mapa_widget.dart';
import 'package:inventur/ui/widgets/text%20fields/multi_auto_complete_form_field.dart';
import 'package:inventur/ui/widgets/radioButton.dart';
import 'package:inventur/ui/widgets/text%20fields/customTextField.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/services/form_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/utils/utils_functions.dart';
import 'package:inventur/validators/validators.dart';
import 'package:dots_indicator/dots_indicator.dart';

final Validators _validators = Validators();
final Map<String, dynamic> valoresJson = {
  'tipo_formulario': 'Informações Básicas do Município',
};
bool isUpdate = false;
double mapHeight = 950.h;

class InformacoesBasicasDoMunicipio extends StatefulWidget {
  final InformacoesBasicasModel? infoModel;
  const InformacoesBasicasDoMunicipio({super.key, this.infoModel});

  @override
  State<InformacoesBasicasDoMunicipio> createState() =>
      _InformacoesBasicasDoMunicipioState();
}

class _InformacoesBasicasDoMunicipioState
    extends State<InformacoesBasicasDoMunicipio> {

          int pesquisadorId = 0;
  bool isTheOwner = false;
  final UtilsFunctions _utils = UtilsFunctions();

  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  Map<String, TextEditingController> _infoGeraisControllers = {};

  Map<String, TextEditingController> _caracteristicasControllers = {};

  Map<String, TextEditingController> _legislacaoControllers = {};

  final List<String> _chavesInfoGerais = const [
    'uf',
    'regiao_turistica',
    'municipio',
    'enderecoPrefeitura',
    'bairroPrefeitura',
    'cepPrefeitura',
    'numeroPrefeitura',
    'instagramPrefeitura',
    'emailPrefeitura',
    'sitePrefeitura',
    'cnpjPrefeitura',
    'latitudePrefeitura',
    'longitudePrefeitura',
    'municipiosLimitrofes',
    'distanciaDaCapital',
    'totalFuncionariosPrefeitura',
    'pessoasComDeficienciaPrefeitura',
    'nomeDoPrefeito',
    'nomeDasSecretariasEtc',
    'nomeOrgaoOficialTurismo',
    'enderecoOrgaoOfcTurismo',
    'avenidaRuaOfcTurismo',
    'distritoOrgaoOfcTurismo',
    'cepOrgaoOfcTurismo',
    'numeroOrgaoOfcTurismo',
    'instagramOrgaoOfcTurismo',
    'siteOrgaoOfcTurismo',
    'emailOrgaoOfcTurismo',
    'qtdeFuncionariosOrgaoOfcTurismo',
    'qtdeFormacaoSuperiorEmTurismoOrgaoOfcturismo',
    'instanciaGovernancaMunicipal',
    'instanciaGovernancaEstadual',
    'instanciaGovernancaRegional',
    'instanciaGovernancaNacional',
    'instanciaGovernancaInternacional',
    'instanciaGovernancaOutras',
    'aniversarioMunicipio',
    'santoPadroeiro',
    'diaDoSantoPadroeiro',
    'feriadoMunicipal01',
    'dataFeriadoMunicipal01',
    'dataFeriadoMunicipal02',
    'dataFeriadoMunicipal03',
    'feriadoMunicipal02',
    'feriadoMunicipal03',
    'origemDoNome',
    'dataFundacao',
    'dataEmancipacao',
    'fundadores',
    'outrosFatosDeImportanciaHistorica'
  ];
  late List<Widget> pages;

  final List<String> _chavesCaracteristicas = const [
    'areaTotalMunicipio',
    'areaUrbana',
    'areaRural',
    'anoBase',
    'populacaoTotal',
    'populacaoUrbana',
    'populacaoRural',
    'anoBasePopulacao',
    'temperaturaMedia',
    'temperaturaMinima',
    'temperaturaMaxima',
    'altitudeMedia',
    'qtdeDomiciliosAtendidos',
    'empresaResponsavel',
    'esgotoTotalAtendidos',
    'esgotoDomiciliosAtendidos',
    'esgotoRuraisAtendidos',
    'esgotoEntidadeResponsavel',
    'fossaSepticaTotalAtendidos',
    'fossaSepticaDomiciliosAtendidos',
    'fossaSepticaRuraisAtendidos',
    'fossaSepticaEntidadeResponsavel',
    'fossaRudimentarTotalAtendidos',
    'fossaRudimentarDomiciliosAtendidos',
    'fossaRudimentarRuraisAtendidos',
    'fossaRudimentarEntidadeResponsavel',
    'valaTotalAtendidos',
    'valaDomiciliosAtendidos',
    'valaRuraisAtendidos',
    'valaEntidadeResponsavel',
    'estacaoDeTratamentoTotalAtendidos',
    'estacaoDeTratamentoDomiciliosAtendidos',
    'estacaoDeTratamentoRuraisAtendidos',
    'estacaoDeTratamentoEntidadeResponsavel',
    'esgotoTratadoTotalAtendidos',
    'esgotoTratadoDomiciliosAtendidos',
    'esgotoTratadoRuraisAtendidos',
    'esgotoTratadoEntidadeResponsavel',
    'servicoDeEsgotoOutroTotalNome',
    'servicoDeEsgotoOutroTotalAtendidos',
    'servicoDeEsgotoOutroDomiciliosAtendidos',
    'servicoDeEsgotoOutroRuraisAtendidos',
    'servicoDeEsgotoOutroEntidadeResponsavel',
    'capacidadeEmKVA',
    'geradorDeEmergenciaCapacidadeEmKVA',
    'redeUrbanaTotalAbastecido',
    'redeUrbanaEntidadeResponsavel',
    'redeRuralTotalAbastecido',
    'redeRuralEntidadeResponsavel',
    'abastecimentoProprioTotalAtendidos',
    'abastecimentoProprioDomiciliosAtendidos',
    'abastecimentoProprioRuraisAtendidos',
    'abastecimentoProprioEntidadeResponsavel',
    'servicosDeEnergiaOutroTotalNome',
    'servicosDeEnergiaOutroTotalAtendidos',
    'servicosDeEnergiaOutroDomiciliosAtendidos',
    'servicosDeEnergiaOutroEntidadeResponsavel',
    'coletaSeletivaTotalAtendidos',
    'coletaSeletivaDomiciliosAtendidos',
    'coletaSeletivaRuraisAtendidos',
    'coletaSeletivaEntidadeResponsavel',
    'coletaNaoSeletivaTotalAtendidos',
    'coletaNaoSeletivaDomiciliosAtendidos',
    'coletaNaoSeletivaRuraisAtendidos',
    'coletaNaoSeletivaEntidadeResponsavel',
    'coletaSemColetaTotal',
    'coletaSemColetaDomicilios',
    'coletaSemColetaRurais',
    'deposicaoAterroSanitarioTotalAtendidos',
    'deposicaoAterroSanitarioDomiciliosAtendidos',
    'deposicaoAterroSanitarioRuraisAtendidos',
    'deposicaoAterroSanitarioEntidadeResponsavel',
    'deposicaoCompostagemTotalAtendidos',
    'deposicaoCompostagemDomiciliosAtendidos',
    'deposicaoCompostagemRuraisAtendidos',
    'deposicaoCompostagemEntidadeResponsavel',
    'deposicaoACeuAbertoTotalAtendidos',
    'deposicaoACeuAbertoDomiciliosAtendidos',
    'deposicaoACeuAbertoRuraisAtendidos',
    'deposicaoACeuAbertoEntidadeResponsavel',
    'deposicaoOutroTotalNome',
    'deposicaoOutroTotalAtendidos',
    'deposicaoOutroDomiciliosAtendidos',
    'deposicaoOutroEntidadeResponsavel',
    'reciclagemDeAcoTotalReciclado',
    'reciclagemDeAcoEntidadeResponsavel',
    'reciclagemDeAluminioTotalReciclado',
    'reciclagemDeAluminioEntidadeResponsavel',
    'reciclagemDeFerroTotalReciclado',
    'reciclagemDeFerroEntidadeResponsavel',
    'reciclagemOutroNome',
    'reciclagemOutroTotalReciclado',
    'reciclagemOutroEntidadeResponsavel',
    'reciclagemDeBateriasPilhasTotalReciclado',
    'reciclagemDeBateriasPilhasEntidadeResponsavel',
    'reciclagemDeBorrachaTotalReciclado',
    'reciclagemDeBorrachaEntidadeResponsavel',
    'reciclagemDeEletronicosTotalReciclado',
    'reciclagemDeEletronicosEntidadeResponsavel',
    'reciclagemDeEmbalagensLongaVidaTotalReciclado',
    'reciclagemDeEmbalagensLongaVidaEntidadeResponsavel',
    'reciclagemDeEntulhoTotalReciclado',
    'reciclagemDeEntulhoEntidadeResponsavel',
    'reciclagemDeMadeiraTotalReciclado',
    'reciclagemDeMadeiraEntidadeResponsavel',
    'reciclagemDePapelTotalReciclado',
    'reciclagemDePapelEntidadeResponsavel',
    'reciclagemDePlasticoEEmbalagensTotalReciclado',
    'reciclagemDePlasticoEEmbalagensEntidadeResponsavel',
    'reciclagemDeVidroTotalReciclado',
    'reciclagemDeVidroEntidadeResponsavel',
    'reciclagemDeOleoDeCozinhaTotalReciclado',
    'reciclagemDeOleoDeCozinhaEntidadeResponsavel',
    'reciclagemOutrosNome',
    'reciclagemOutrosTotalReciclado',
    'reciclagemOutrosEntidadeResponsavel',
    'divulgacaoImpressaFolder',
    'divulgacaoImpressaRevista',
    'divulgacaoImpressaJornal',
    'divulgacaoImpressaOutros',
    'visitantesAno',
    'visitantesAnoAltaTemporada',
    'origemInternacionalAnoBase',
    'atrativosMaisVisitados'
  ];

  final List<String> _chavesLegislacao = const [
    'leiOrganica',
    'ocupacaoDoSolo',
    'planoDeDesenvolvimentoDoTurismo',
    'protecaoAmbiental',
    'apoioACultura',
    'incentivosFiscaisAoTurismo',
    'planoDiretor',
    'fundoMunicipalDeTurismo',
    'legislacaoOutras',
    'observacoes',
    'referencias'
  ];

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
      _preencherDadosParaTeste();
      _preencherDadosParaTeste2();
      _preencherDadosParaTeste3();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _utils
        .getInfoUsersInPesquisa(valoresJson)
        .then(
          (value) => setState(() {
            pesquisadorId = value;
          }),
        )
        .then(
          (value) => setState(() {
            if (widget.infoModel != null) {
              print("chamando funcao");
              isTheOwner = _utils.isTheOwner(
                  pesquisadorId, widget.infoModel!.usuario_criador!);
            }
          }),
        );
    for (final key in _chavesInfoGerais) {
      _infoGeraisControllers[key] = TextEditingController();
    }

    for (final key in _chavesCaracteristicas) {
      _caracteristicasControllers[key] = TextEditingController();
    }

    for (final key in _chavesLegislacao) {
      _legislacaoControllers[key] = TextEditingController();
    }


    pages = [
      InformacoesGerais(
        controllers: _infoGeraisControllers,
        infoModel: widget.infoModel,
      ),
      Caracteristicas(
        controllers: _caracteristicasControllers,
        infoModel: widget.infoModel,
      ),
      LegislacaoMunicipal(
        controllers: _legislacaoControllers,
      )
    ];
  }

  void _preencherDadosParaTeste() {
    if (widget.infoModel != null) {
      final model = widget.infoModel!;
      final modelMap = model.toMap();
      _infoGeraisControllers.forEach((key, controller) {
        if (modelMap.containsKey(key)) {
          final valor = modelMap[key];
          controller.text = valor?.toString() ?? '';
        }
      });
    }
  }

  void _preencherDadosParaTeste2() {
    if (widget.infoModel != null) {
      final model = widget.infoModel!;
      final modelMap = model.toMap();
      _caracteristicasControllers.forEach((key, controller) {
        if (modelMap.containsKey(key)) {
          final valor = modelMap[key];
          controller.text = valor?.toString() ?? '';
        }
      });
    }
  }

  void _preencherDadosParaTeste3() {
    if (widget.infoModel != null) {
      final model = widget.infoModel!;
      final modelMap = model.toMap();
      _legislacaoControllers.forEach((key, controller) {
        if (modelMap.containsKey(key)) {
          final valor = modelMap[key];
          controller.text = valor?.toString() ?? '';
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _infoGeraisControllers.values) {
      controller.dispose();
    }
    for (final controller in _caracteristicasControllers.values) {
      controller.dispose();
    }
    for (final controller in _legislacaoControllers.values) {
      controller.dispose();
    }
    valoresJson.clear();
    valoresJson['tipo_formulario'] = 'Informações Básicas do Município';
    isUpdate = false;
    super.dispose();
  }

  void _enviarFormulario() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      _infoGeraisControllers.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });

      _caracteristicasControllers.forEach(
        (key, controller) {
          valoresJson[key] = controller.text;
        },
      );

      _legislacaoControllers.forEach(
        (key, value) {
          valoresJson[key] = value.text;
        },
      );
      valoresJson.forEach(
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
        //Navigator.pushNamed(context, '/SendedForm');
        _utils.decideSendingOrUpdating(isUpdate, isTheOwner, context, widget.infoModel?.id ?? 0,
         valoresJson, AppConstants.INFO_BASICA_CREATE);

        // _enviarFormulario(); // Você pode chamar sua função de envio aqui
      }
    } else {
      _formKey.currentState!.save();
      _caracteristicasControllers.forEach(
        (key, controllers) {
          valoresJson[key] = controllers.text;
        },
      );

      _infoGeraisControllers.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });
      _legislacaoControllers.forEach(
        (key, value) {
          valoresJson[key] = value.text;
        },
      );
      valoresJson.forEach(
        (key, value) {
          print("$key  - $value");
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Por favor, corrija os erros no formulário.')));
    }
  }

  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: DotsIndicator(
            dotsCount: pages.length,
            position: currentStep.toDouble(),
            decorator: DotsDecorator(
                activeColor: Colors.white, activeSize: Size(18, 9)),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 55, 111, 60),
        ),
        backgroundColor: Colors.white,
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
            )),
        bottomNavigationBar:
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          // Botão Voltar
          if (currentStep > 0)
            Container(
              margin: EdgeInsets.only(bottom: 55.h),
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
                // _preencherDadosParaTeste();
                // _preencherDadosParaTeste2();
                // _preencherDadosParaTeste3();
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

class Identificacao extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final InformacoesBasicasModel? infoModel;

  const Identificacao(
      {super.key,
      required this.onSaved,
      required this.controllers,
      this.infoModel});
  final void Function(String?) onSaved;

  @override
  State<Identificacao> createState() => _IdentificacaoState();
}

class _IdentificacaoState extends State<Identificacao>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    return Column(
      children: [
        ContainerHeader(title: 'Identificação'),
        UfMunicipioRg(controllers: widget.controllers),

        SizedBox(
          height: 55.h,
        ),

        RadioFormField(
            title: "Tipo",
            initialValue: isUpdate ? widget.infoModel!.tipo! : '',
            options: ['Caracterização do município'],
            onSaved: widget.onSaved)

        // RadioD(
        //   validator: (p0) {
        //     if(p0==null || p0.isEmpty){
        //       return 'Por favor, selecione uma opção';
        //     }
        //     return null;
        //   },
        //   options: ["Caracterização do município"],
        //   getValue: (p0) => valoresjson['tipo'] = p0,
        // )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class InformacoesGerais extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final InformacoesBasicasModel? infoModel;

  const InformacoesGerais(
      {super.key, required this.controllers, this.infoModel});

  @override
  State<InformacoesGerais> createState() => _InformacoesGeraisState();
}

class _InformacoesGeraisState extends State<InformacoesGerais> {
  @override
  Widget build(BuildContext context) {
    print(valoresJson);
    final sizeScreen = MediaQuery.sizeOf(context);
    // TODO: implement build

    final formWidgts = <Widget>[
      Identificacao(
        onSaved: (p0) => valoresJson['tipo'] = p0,
        controllers: widget.controllers,
        infoModel: widget.infoModel,
      ),
      SizedBox(
        height: 65.h,
      ),
      Container(
        color: const Color.fromARGB(255, 55, 111, 60),
        height: sizeScreen.height * 0.06,
        width: sizeScreen.width,
        padding: EdgeInsets.only(
            top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
        child: Text(
          'Informações Gerais',
          style: TextStyle(
              color: Colors.white, fontSize: sizeScreen.height * 0.03),
        ),
      ),
      SizedBox(
        height: 65.h,
      ),
      textLabel(
        name: "Endereço da Prefeitura",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['enderecoPrefeitura'],
        name: "Avenida/rua/travessa/caminho/outro",
      ),
      CustomTextField(
        controller: widget.controllers['bairroPrefeitura'],
        name: "Bairro",
      ),
      CustomTextField(
        controller: widget.controllers['cepPrefeitura'],
        formatter: [
          FilteringTextInputFormatter.digitsOnly,
          _validators.cepFormatter
        ],
        name: 'CEP',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Whatsapp/Instagram",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        formatter: [
          FilteringTextInputFormatter.digitsOnly,
          _validators.phoneFormatter
        ],
        controller: widget.controllers['numeroPrefeitura'],
        name: 'Número',
      ),
      CustomTextField(
        controller: widget.controllers['instagramPrefeitura'],
        name: 'Instagram',
      ),
      CustomTextField(
        controller: widget.controllers['emailPrefeitura'],
        name: 'E-mail',
      ),
      CustomTextField(
        name: 'Site Prefeitura',
        controller: widget.controllers['sitePrefeitura'],
      ),
      CustomTextField(
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['cnpjPrefeitura'],
        name: 'CNPJ',
        //  validat: _validators.validarCNPJ,
        formatter: [_validators.cnpjFormatter],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Coordenadas Geográficas",
        fontWeight: FontWeight.bold,
      ),
      // CustomTextField(
      //   controller: controllers['longitudePrefeitura'],
      //   name: 'Longitude',
      //   keyboardType: TextInputType.numberWithOptions(),
      //   formatter: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))],
      // ),
      // CustomTextField(
      //   controller: controllers['latitudePrefeitura'],
      //   name: 'Latitude',
      //   keyboardType: TextInputType.numberWithOptions(),
      //   formatter: [
      //     FilteringTextInputFormatter.allow(
      //       RegExp(r'^-?\d*\.?\d*'),
      //     ),
      //   ],
      // ),
      MapaWidget(
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              latitude: widget.infoModel?.latitude ?? "Não Informado",
              longitude: widget.infoModel?.longitude ?? "Não Informado"),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Municípios Limítrofes",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['municipiosLimitrofes'],
        name: "Municípios",
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Distância da Capital (km)",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['distanciaDaCapital'],
        name: "(km)",
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      SizedBox(
        height: 55.w,
      ),
      textLabel(
        name: "Quantidade de Funcionários",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['totalFuncionariosPrefeitura'],
        name: "Total (nº)",
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        controller: widget.controllers['pessoasComDeficienciaPrefeitura'],
        name: "Pessoas com deficiência (%)",
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Nome do Prefeito",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['nomeDoPrefeito'],
        name: 'Nome',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Nomes das secretarias, departamentos e outro",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['nomeDasSecretariasEtc'],
        name: 'Nome(s)',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Nome do Orgão Oficial de Turismo",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: "Nome",
        controller: widget.controllers['nomeOrgaoOficialTurismo'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: "Endereço"),
      CustomTextField(
        controller: widget.controllers['enderecoOrgaoOfcTurismo'],
        name: "Avenida/rua/travessa/caminho/outro",
      ),
      CustomTextField(
        controller: widget.controllers['avenidaRuaOfcTurismo'],
        name: "Bairro/localidade",
      ),
      CustomTextField(
        controller: widget.controllers['distritoOrgaoOfcTurismo'],
        name: "Distrito",
      ),
      CustomTextField(
        controller: widget.controllers['cepOrgaoOfcTurismo'],
        formatter: [
          FilteringTextInputFormatter.digitsOnly,
          _validators.cepFormatter
        ],
        name: 'CEP',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Número/Instagram",
      ),
      CustomTextField(
        formatter: [
          FilteringTextInputFormatter.digitsOnly,
          _validators.phoneFormatter
        ],
        controller: widget.controllers['numeroOrgaoOfcTurismo'],
        name: 'Número',
      ),
      CustomTextField(
        controller: widget.controllers['instagramOrgaoOfcTurismo'],
        name: 'Instagram',
      ),
      CustomTextField(
        controller: widget.controllers['emailOrgaoOfcTurismo'],
        name: 'E-mail',
      ),
      CustomTextField(
        name: 'Site',
        controller: widget.controllers['siteOrgaoOfcTurismo'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Quantidade de Funcionários",
      ),
      CustomTextField(
        controller: widget.controllers['qtdeFuncionariosOrgaoOfcTurismo'],
        name: "Total (nº)",
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        controller:
            widget.controllers['qtdeFormacaoSuperiorEmTurismoOrgaoOfcturismo'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: "Formação superior em Turismo (nº)",
        keyboardType: TextInputType.numberWithOptions(),
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Instâncias de Governança, Associativas, Parcerias e Outros",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers["instanciaGovernancaMunicipal"],
        name: "Municipal",
      ),
      CustomTextField(
        controller: widget.controllers["instanciaGovernancaEstadual"],
        name: "Estadual",
      ),
      CustomTextField(
        controller: widget.controllers["instanciaGovernancaRegional"],
        name: "Regional",
      ),
      CustomTextField(
        controller: widget.controllers["instanciaGovernancaNacional"],
        name: "Nacional",
      ),
      CustomTextField(
        controller: widget.controllers["instanciaGovernancaInternacional"],
        name: "Internacional",
      ),
      CustomTextField(
        controller: widget.controllers["instanciaGovernancaOutras"],
        name: "Outras",
      ),
      SizedBox(
        height: 55.h,
      ),
      Row(
        children: [
          textLabel(
            name: 'Aniversário \ndo\nMunicípio',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            width: sizeScreen.width * 0.1,
          ),
          SizedBox(
              width: sizeScreen.width * 0.4,
              //height: sizeScreen.height * 0.07,
              child: CustomTextDate(
                dateController: widget.controllers['aniversarioMunicipio'],
              )),
        ],
      ),
      SizedBox(
        height: 75.h,
      ),
      textLabel(
        name: "Santo(a) Padroeiro(a)",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: "Nome do(a) Santo(a) Padroeiro(a)",
        controller: widget.controllers['santoPadroeiro'],
      ),
      SizedBox(
        height: 55.h,
      ),
      Row(
        children: [
          textLabel(
            name: 'Dia do(a)\nSanto(a)\nPadroeiro(a)',
          ),
          SizedBox(
            width: sizeScreen.width * 0.1,
          ),
          SizedBox(
              width: sizeScreen.width * 0.4,
              //height: sizeScreen.height * 0.07,
              child: CustomTextDate(
                dateController: widget.controllers['diaDoSantoPadroeiro'],
              )),
        ],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Outros feriados municipais",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: 'Feriado ',
        controller: widget.controllers['feriadoMunicipal01'],
      ),
      CustomTextDate(
        dateController: widget.controllers['dataFeriadoMunicipal01'],
      ),
      CustomTextField(
        name: 'Feriado',
        controller: widget.controllers['feriadoMunicipal02'],
      ),
      CustomTextDate(
        dateController: widget.controllers['dataFeriadoMunicipal02'],
      ),
      CustomTextField(
        name: 'Feriado',
        controller: widget.controllers['feriadoMunicipal03'],
      ),
      CustomTextDate(
        dateController: widget.controllers['dataFeriadoMunicipal03'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "História do Município",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['origemDoNome'],
        name: "Origem do Nome",
      ),
      Row(
        children: [
          textLabel(
            name: 'Data \nda\nFundação',
          ),
          SizedBox(
            width: sizeScreen.width * 0.1,
          ),
          SizedBox(
              width: sizeScreen.width * 0.4,
              //height: sizeScreen.height * 0.07,
              child: CustomTextDate(
                dateController: widget.controllers['dataFundacao'],
              )),
        ],
      ),
      SizedBox(
        height: 55.h,
      ),
      Row(
        children: [
          textLabel(
            name: 'Data \nda\nEmancipação',
          ),
          SizedBox(
            width: sizeScreen.width * 0.1,
          ),
          SizedBox(
              width: sizeScreen.width * 0.4,
              //height: sizeScreen.height * 0.07,
              child: CustomTextDate(
                dateController: widget.controllers['dataEmancipacao'],
              )),
        ],
      ),
      CustomTextField(
        controller: widget.controllers['fundadores'],
        name: "Fundadores",
      ),
      CustomTextField(
        controller: widget.controllers['outrosFatosDeImportanciaHistorica'],
        name: "Outros fatos de importância histórica",
      )
    ];

    return SingleChildScrollView(
      child: Column(
        children: formWidgts,
      ),
    );
  }
}

class Caracteristicas extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final InformacoesBasicasModel? infoModel;

  const Caracteristicas({super.key, required this.controllers, this.infoModel});

  @override
  State<Caracteristicas> createState() => _CaracteristicasState();
}

class _CaracteristicasState extends State<Caracteristicas>
    with AutomaticKeepAliveClientMixin {
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
    super.build(context);
    final sizeScreen = MediaQuery.sizeOf(context);

    // TODO: implement build
    final List<Widget> listaWidgets = [
      Container(
        color: const Color.fromARGB(255, 55, 111, 60),
        height: sizeScreen.height * 0.06,
        width: sizeScreen.width,
        padding: EdgeInsets.only(
            top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
        child: Text(
          'Caracteristicas',
          style: TextStyle(
              color: Colors.white, fontSize: sizeScreen.height * 0.03),
        ),
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Aspectos Gerais',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Área',
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        controller: widget.controllers['areaTotalMunicipio'],
        keyboardType: TextInputType.numberWithOptions(),
        name: "Área Total do Município (km²)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['areaUrbana'],
        name: "Área Urbana (km²)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['areaRural'],
        name: "Área Rural (km²)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['anoBase'],
        name: "Ano-Base",
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'População',
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        controller: widget.controllers['populacaoTotal'],
        keyboardType: TextInputType.numberWithOptions(),
        name: "População Total (nº hab.)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['populacaoUrbana'],
        name: "População Urbana (nº hab.)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['populacaoRural'],
        name: "População Rural (nº hab.)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['anoBasePopulacao'],
        name: "Ano-Base",
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Temperatura e Chuvas'),
      CustomTextField(
        controller: widget.controllers['temperaturaMedia'],
        name: 'Média (ºC)',
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        controller: widget.controllers['temperaturaMinima'],
        name: 'Mínima (ºC)',
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        controller: widget.controllers['temperaturaMaxima'],
        name: 'Máxima (ºC)',
        keyboardType: TextInputType.numberWithOptions(),
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Meses Mais Frios',
      ),
      SizedBox(
        height: sizeScreen.height * 0.01,
      ),
      CheckboxGroupFormField(
        initialValue: isUpdate ? widget.infoModel!.mesesMaisFrios : [],
        onSaved: (p0) => valoresJson['mesesMaisFrios'] = p0,
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
      textLabel(name: 'Meses Mais Quentes'),
      SizedBox(
        height: 55.h,
      ),
      CheckboxGroupFormField(
        initialValue: isUpdate ? widget.infoModel!.mesesMaisQuentes : [],
        onSaved: (p0) => valoresJson['mesesMaisQuentes'] = p0,
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
      textLabel(name: 'Meses Mais Chuvosos'),
      SizedBox(
        height: 55.h,
      ),
      CheckboxGroupFormField(
        initialValue: isUpdate ? widget.infoModel!.mesesMaisChuvosos : [],
        onSaved: (p0) => valoresJson['mesesMaisChuvosos'] = p0,
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
      textLabel(name: 'Meses Menos Chuvosos'),
      SizedBox(
        height: 55.h,
      ),
      CheckboxGroupFormField(
        initialValue: isUpdate ? widget.infoModel!.mesesMenosChuvosos : [],
        onSaved: (p0) => valoresJson['mesesMenosChuvosos'] = p0,
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
      CustomTextField(
        name: "Altitude Média (em m)",
        controller: widget.controllers['altitudeMedia'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Equipamentos, instalações e serviços públicos",
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Abastecimento de Água",
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Tipo de Abastecimento'),
      SizedBox(
        height: 55.h,
      ),
      RadioFormField(
          initialValue: isUpdate ? widget.infoModel!.tipoDeAbastecimento : '',
          onSaved: (newValue) => valoresJson['tipoDeAbastecimento'] = newValue,
          options: [
            'Água Não Canalizada',
            'Canalizada de Poço',
            'Canalizada de Nascente',
            'Canalizada de Curso de Água/Barragem',
            'outro'
          ]),
      CustomTextField(
        name: 'Domicílios Atendidos (%)',
        controller: widget.controllers['qtdeDomiciliosAtendidos'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        name: 'Empresa Responsável',
        controller: widget.controllers['empresaResponsavel'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Serviços de Esgoto',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Coleta e Deposição'),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Rede de Esgoto',
          jsonKey: 'redeDeEsgoto',
          optionModelValue: isUpdate ? widget.infoModel!.redeDeEsgoto : '',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['esgotoTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller: widget.controllers['esgotoDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller: widget.controllers['esgotoRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers['esgotoEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Fossa Séptica',
          jsonKey: 'fossaSeptica',
          optionModelValue: isUpdate ? widget.infoModel!.fossaSeptica : '',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['fossaSepticaTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller: widget.controllers['fossaSepticaDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller: widget.controllers['fossaSepticaRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers['fossaSepticaEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Fossa Rudimentar',
          jsonKey: 'fossaRudimentar',
          optionModelValue: isUpdate ? widget.infoModel!.fossaRudimentar : '',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['fossaRudimentarTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['fossaRudimentarDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller: widget.controllers['fossaRudimentarRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['fossaRudimentarEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Vala',
          jsonKey: 'vala',
          optionModelValue: isUpdate ? widget.infoModel!.vala : '',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['valaTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller: widget.controllers['valaDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller: widget.controllers['valaRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers['valaEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Estação de Tratamento',
          jsonKey: 'estacaoDeTratamento',
          optionModelValue:
              isUpdate ? widget.infoModel!.estacaoDeTratamento : '',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['estacaoDeTratamentoTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['estacaoDeTratamentoDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['estacaoDeTratamentoRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['estacaoDeTratamentoEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Esgoto Tratado',
          jsonKey: 'esgotoTratado',
          optionModelValue: isUpdate ? widget.infoModel!.esgotoTratado : '',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['esgotoTratadoTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['esgotoTratadoDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller: widget.controllers['esgotoTratadoRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['esgotoTratadoEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Outros',
          jsonKey: 'servicoDeEsgotoOutros',
          optionModelValue:
              isUpdate ? widget.infoModel!.servicoDeEsgotoOutros : '',
          children: [
            CustomTextField(
              name: 'Nome',
              controller: widget.controllers['servicoDeEsgotoOutroTotalNome'],
            ),
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['servicoDeEsgotoOutroTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['servicoDeEsgotoOutroDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['servicoDeEsgotoOutroRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['servicoDeEsgotoOutroEntidadeResponsavel'],
            )
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Serviços de Energia',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Energia Elétrica'),
      RadioFormField(
          initialValue: isUpdate ? widget.infoModel!.energiaEletrica : '',
          onSaved: (newValue) => valoresJson['energiaEletrica'] = newValue,
          options: ['110 Volts', '220 Volts', '110/220 Volts']),
      CustomTextField(
        name: 'Capacidade em KVA',
        controller: widget.controllers['capacidadeEmKVA'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          optionModelValue:
              isUpdate ? widget.infoModel!.geradorDeEmergencia : '',
          title: 'Gerador de Emergẽncia',
          jsonKey: 'geradorDeEmergencia',
          children: [
            CustomTextField(
              name: 'Capacidade em KVA',
              controller:
                  widget.controllers['geradorDeEmergenciaCapacidadeEmKVA'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            )
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Abastecimento de Energia',
        fontWeight: FontWeight.bold,
      ),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Rede Urbana',
          optionModelValue: isUpdate ? widget.infoModel!.redeUrbana : '',
          jsonKey: 'redeUrbana',
          children: [
            CustomTextField(
              name: 'Total Abastecido (%)',
              controller: widget.controllers['redeUrbanaTotalAbastecido'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers['redeUrbanaEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Rede Rural',
          optionModelValue: isUpdate ? widget.infoModel!.redeRural : '',
          jsonKey: 'redeRural',
          children: [
            CustomTextField(
              name: 'Total Abastecido (%)',
              controller: widget.controllers['redeRuralTotalAbastecido'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers['redeRuralEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Abastecimento Próprio',
          optionModelValue:
              isUpdate ? widget.infoModel!.abastecimentoProprio : '',
          jsonKey: 'abastecimentoProprio',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['abastecimentoProprioTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['abastecimentoProprioDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['abastecimentoProprioRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['abastecimentoProprioEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Outros',
          optionModelValue:
              isUpdate ? widget.infoModel!.servicosDeEnergiaOutro : '',
          jsonKey: 'servicosDeEnergiaOutro',
          children: [
            CustomTextField(
              name: 'Nome',
              controller: widget.controllers['servicosDeEnergiaOutroTotalNome'],
            ),
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['servicosDeEnergiaOutroTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller: widget
                  .controllers['servicosDeEnergiaOutroDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget
                  .controllers['servicosDeEnergiaOutroEntidadeResponsavel'],
            ),
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Serviços de Lixo',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Coleta',
        fontWeight: FontWeight.bold,
      ),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Seletiva',
          optionModelValue: isUpdate ? widget.infoModel!.coletaSeletiva : '',
          jsonKey: 'coletaSeletiva',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['coletaSeletivaTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['coletaSeletivaDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller: widget.controllers['coletaSeletivaRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['coletaSeletivaEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Não Seletiva',
          optionModelValue: isUpdate ? widget.infoModel!.coletaNaoSeletiva : '',
          jsonKey: 'coletaNaoSeletiva',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['coletaNaoSeletivaTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['coletaNaoSeletivaDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['coletaNaoSeletivaRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['coletaNaoSeletivaEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Sem Coleta',
          optionModelValue: isUpdate ? widget.infoModel!.coletaSemColeta : '',
          jsonKey: 'coletaSemColeta',
          children: [
            CustomTextField(
              name: 'Total de lixo sem coleta (%)',
              controller: widget.controllers['coletaSemColetaTotal'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios urbanos sem coleta (%)',
              controller: widget.controllers['coletaSemColetaDomicilios'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios rurais sem coleta (%)',
              controller: widget.controllers['coletaSemColetaRurais'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Deposição e tratamento',
        fontWeight: FontWeight.bold,
      ),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Aterro Sanitário',
          optionModelValue:
              isUpdate ? widget.infoModel!.deposicaoAterroSanitario : '',
          jsonKey: 'deposicaoAterroSanitario',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['deposicaoAterroSanitarioTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller: widget
                  .controllers['deposicaoAterroSanitarioDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['deposicaoAterroSanitarioRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget
                  .controllers['deposicaoAterroSanitarioEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Compostagem',
          optionModelValue:
              isUpdate ? widget.infoModel!.deposicaoCompostagem : '',
          jsonKey: 'deposicaoCompostagem',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['deposicaoCompostagemTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['deposicaoCompostagemDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['deposicaoCompostagemRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['deposicaoCompostagemEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'A Céu Aberto (lixão)',
          optionModelValue:
              isUpdate ? widget.infoModel!.deposicaoACeuAberto : '',
          jsonKey: 'deposicaoACeuAberto',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['deposicaoACeuAbertoTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['deposicaoACeuAbertoDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['deposicaoACeuAbertoRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['deposicaoACeuAbertoEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Outros',
          optionModelValue: isUpdate ? widget.infoModel!.deposicaoOutro : '',
          jsonKey: 'deposicaoOutro',
          children: [
            CustomTextField(
              name: 'Nome',
              controller: widget.controllers['deposicaoOutroTotalNome'],
            ),
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['deposicaoOutroTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['deposicaoOutroDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['deposicaoOutroEntidadeResponsavel'],
            ),
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Reciclagem',
        fontWeight: FontWeight.bold,
      ),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Aço',
          optionModelValue: isUpdate ? widget.infoModel!.reciclagemDeAco : '',
          jsonKey: 'reciclagemDeAco',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemDeAcoTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeAcoEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Alumínio',
          optionModelValue:
              isUpdate ? widget.infoModel!.reciclagemDeAluminio : '',
          jsonKey: 'reciclagemDeAluminio',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeAluminioTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeAluminioEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Ferro',
          optionModelValue: isUpdate ? widget.infoModel!.reciclagemDeFerro : '',
          jsonKey: 'reciclagemDeFerro',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemDeFerroTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeFerroEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Outro Metal',
          optionModelValue: isUpdate ? widget.infoModel!.reciclagemOutro : '',
          jsonKey: 'reciclagemOutro',
          children: [
            CustomTextField(
              name: 'Nome',
              controller: widget.controllers['reciclagemOutroNome'],
            ),
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemOutroTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemOutroEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Baterias e Pilhas',
          optionModelValue:
              isUpdate ? widget.infoModel!.reciclagemDeBateriasPilhas : '',
          jsonKey: 'reciclagemDeBateriasPilhas',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget
                  .controllers['reciclagemDeBateriasPilhasTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget
                  .controllers['reciclagemDeBateriasPilhasEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Borracha',
          optionModelValue:
              isUpdate ? widget.infoModel!.reciclagemDeBorracha : '',
          jsonKey: 'reciclagemDeBorracha',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeBorrachaTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeBorrachaEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Eletrônicos',
          optionModelValue:
              isUpdate ? widget.infoModel!.reciclagemDeEletronicos : '',
          jsonKey: 'reciclagemDeEletronicos',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeEletronicosTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget
                  .controllers['reciclagemDeEletronicosEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Embalagens\nLonga Vida',
          optionModelValue:
              isUpdate ? widget.infoModel!.reciclagemDeEmbalagensLongaVida : '',
          jsonKey: 'reciclagemDeEmbalagensLongaVida',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget
                  .controllers['reciclagemDeEmbalagensLongaVidaTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers[
                  'reciclagemDeEmbalagensLongaVidaEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Entulho',
          optionModelValue:
              isUpdate ? widget.infoModel!.reciclagemDeEntulho : '',
          jsonKey: 'reciclagemDeEntulho',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeEntulhoTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeEntulhoEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Madeira',
          optionModelValue:
              isUpdate ? widget.infoModel!.reciclagemDeMadeira : '',
          jsonKey: 'reciclagemDeMadeira',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeMadeiraTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeMadeiraEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Papel',
          optionModelValue: isUpdate ? widget.infoModel!.reciclagemDePapel : '',
          jsonKey: 'reciclagemDePapel',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemDePapelTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDePapelEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De plástico e\nembalagens',
          optionModelValue:
              isUpdate ? widget.infoModel!.reciclagemDePlasticoEEmbalagens : '',
          jsonKey: 'reciclagemDePlasticoEEmbalagens',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget
                  .controllers['reciclagemDePlasticoEEmbalagensTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers[
                  'reciclagemDePlasticoEEmbalagensEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Vidro',
          optionModelValue: isUpdate ? widget.infoModel!.reciclagemDeVidro : '',
          jsonKey: 'reciclagemDeVidro',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemDeVidroTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeVidroEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'De Óleo de\nCozinha',
          optionModelValue:
              isUpdate ? widget.infoModel!.reciclagemDeOleoDeCozinha : '',
          jsonKey: 'reciclagemDeOleoDeCozinha',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeOleoDeCozinhaTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget
                  .controllers['reciclagemDeOleoDeCozinhaEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Outros',
          optionModelValue: isUpdate ? widget.infoModel!.reciclagemOutros : '',
          jsonKey: 'reciclagemOutros',
          children: [
            CustomTextField(
              name: 'Nome',
              controller: widget.controllers['reciclagemOutrosNome'],
            ),
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemOutrosTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemOutrosEntidadeResponsavel'],
            ),
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Serviços De Comunicação',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Acesso à Internet'),
      SizedBox(
        height: 55.h,
      ),
      RadioFormField(
          initialValue: isUpdate
              ? widget.infoModel!.servicosDeComunicacaoAcessoAInternet
              : '',
          onSaved: (newValue) =>
              valoresJson['servicosDeComunicacaoAcessoAInternet'] = newValue,
          options: [
            'A rádio',
            'A cabo',
            'Banda larga',
            'Discada',
            'Wireless',
            '3G'
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Telefonia Móvel',
          optionModelValue: isUpdate
              ? widget.infoModel!.servicosDeComunicacaoTelefoniaMovel
              : '',
          jsonKey: 'servicosDeComunicacaoTelefoniaMovel',
          children: [
            SizedBox(
              height: 55.h,
            ),
            textLabel(name: 'Área de Cobertura'),
            RadioFormField(
              initialValue: isUpdate
                  ? widget.infoModel!.telefoniaMovelAreaDeCobertura
                  : '',
              options: ['Em Todo Município', 'Em Parte do Município'],
              onSaved: (newValue) =>
                  valoresJson['telefoniaMovelAreaDeCobertura'] = newValue,
            )
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Telefonia Fixa',
          optionModelValue: isUpdate
              ? widget.infoModel!.servicosDeComunicacaoTelefoniaFixa
              : '',
          jsonKey: 'servicosDeComunicacaoTelefoniaFixa',
          children: [
            SizedBox(
              height: 55.h,
            ),
            textLabel(name: 'Área de Cobertura'),
            RadioFormField(
              initialValue: isUpdate
                  ? widget.infoModel!.telefoniaFixaAreaDeCobertura
                  : '',
              options: ['Em Todo Município', 'Em Parte do Município'],
              onSaved: (newValue) =>
                  valoresJson['telefoniaFixaAreaDeCobertura'] = newValue,
            )
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Serviços Turísticos',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Promoção Turística',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Divulgação Impressa',
          optionModelValue: isUpdate
              ? widget.infoModel!.promocaoTuristicaDivulgacaoImpressa
              : '',
          jsonKey: 'promocaoTuristicaDivulgacaoImpressa',
          children: [
            CustomTextField(
              name: 'Folder',
              controller: widget.controllers['divulgacaoImpressaFolder'],
            ),
            CustomTextField(
                name: 'Revista',
                controller: widget.controllers['divulgacaoImpressaRevista']),
            CustomTextField(
                name: 'Jornal',
                controller: widget.controllers['divulgacaoImpressaJornal']),
            CustomTextField(
                name: 'Outros',
                controller: widget.controllers['divulgacaoImpressaOutros'])
          ]),
      ConditionalFieldsGroup(
          isUpdate: isUpdate,
          valoresJson: valoresJson,
          title: 'Divulgação Televisiva',
          optionModelValue: isUpdate
              ? widget.infoModel!.promocaoTuristicaDivulgacaoTelevisiva
              : '',
          jsonKey: 'promocaoTuristicaDivulgacaoTelevisiva',
          children: []),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Atendimento ao Visitante',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Atendimento em Língua Estrangeira',
      ),
      SizedBox(
        height: 55.h,
      ),
      RadioFormField(
        initialValue:
            isUpdate ? widget.infoModel!.atendimentoEmLinguaEstrangeira : '',
        options: ['Não', 'Inglês', 'Espanhol', 'outro'],
        onSaved: (newValue) =>
            valoresJson['atendimentoEmLinguaEstrangeira'] = newValue,
      ),
      textLabel(
        name: 'Informativos Impressos',
      ),
      SizedBox(
        height: 55.h,
      ),
      RadioFormField(
        initialValue: isUpdate
            ? widget.infoModel!.atendimentoAoVisitanteInformativosImpressos
            : '',
        options: ['Não', 'Português', 'Inglês', 'Espanhol', 'outro'],
        onSaved: (newValue) =>
            valoresJson['atendimentoAoVisitanteInformativosImpressos'] =
                newValue,
      ),
      textLabel(
        name: 'Caracterização do Fluxo de Visitantes',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Dados de Visitação'),
      CustomTextField(
        name: 'Visitantes Ano (nº)',
        controller: widget.controllers['visitantesAno'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
      ),
      CustomTextField(
        name: 'Visitantes Alta Temporada (nº)',
        controller: widget.controllers['visitantesAnoAltaTemporada'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Meses Alta Temporada'),
      SizedBox(
        height: 55.h,
      ),
      CheckboxGroupFormField(
        initialValue: isUpdate ? widget.infoModel!.mesesAltaTemporada : [],
        onSaved: (p0) => valoresJson['mesesAltaTemporada'] = p0,
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
        height: 55.h,
      ),
      textLabel(name: 'Origem dos Visitantes/Turistas'),
      SizedBox(
        height: 55.h,
      ),
      RadioFormField(
        initialValue:
            isUpdate ? widget.infoModel!.origemDosVisitantesTuristas : '',
        options: ['Entorno Municipal', 'Estadual', 'Nacional', 'Internacional'],
        onSaved: (newValue) =>
            valoresJson['origemDosVisitantesTuristas'] = newValue,
      ),
      SizedBox(
        height: 55.h,
      ),
      MultiAutocompleteFormField(
        initialValue: isUpdate ? widget.infoModel!.origemNacional : [],
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
          valoresJson['origemNacional'] = newValue;
        },
        validator: (values) {
          // Exemplo de validação: exigir pelo menos um estado
          // if (values == null || values.isEmpty) {
          //   return 'Por favor, selecione pelo menos um estado.';
          // }
          return null;
        },
      ),
      SizedBox(
        height: 55.h,
      ),
      MultiAutocompleteFormField(
        initialValue: isUpdate ? widget.infoModel!.origemInternacional : [],
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
          valoresJson['origemInternacional'] = newValue;
        },
        validator: (values) {
          // if (values == null || values.isEmpty) {
          //   return 'Por favor, selecione pelo menos um pais.';
          // }
          return null;
        },
      ),
      SizedBox(
        height: 55.h,
      ),
      CustomTextField(
        name: 'Ano-base',
        controller: widget.controllers['origemInternacionalAnoBase'],
      ),
      CustomTextField(
        name: 'Atrativos Mais Visitados',
        controller: widget.controllers['atrativosMaisVisitados'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
          name:
              'Segmentos ou Tipos de Turismo em que é Especializado (assinalar até 3)'),
      CheckboxGroupFormField(
        initialValue:
            isUpdate ? widget.infoModel!.segmentosTurismoEspecializado : [],
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
          'Não é especializado em nenhum segmento'
        ],
        isLimitedBy3: true,
        onSaved: (newValue) =>
            valoresJson['segmentosTurismoEspecializado'] = newValue,
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: listaWidgets,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class LegislacaoMunicipal extends StatelessWidget {
  final Map<String, TextEditingController> controllers;

  const LegislacaoMunicipal({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    final List<Widget> listaWidgets = [
      Container(
        color: const Color.fromARGB(255, 55, 111, 60),
        height: sizeScreen.height * 0.06,
        width: sizeScreen.width,
        padding: EdgeInsets.only(
            top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
        child: Text(
          'Legislação Municipal',
          style: TextStyle(
              color: Colors.white, fontSize: sizeScreen.height * 0.03),
        ),
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Lei Orgânica',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: 'tipo/número/data',
        controller: controllers['leiOrganica'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Ocupação do Solo',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: 'tipo/número/data',
        controller: controllers['ocupacaoDoSolo'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Plano de Desenvolvimento do Turismo',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: 'tipo/número/data',
        controller: controllers['planoDeDesenvolvimentoDoTurismo'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Proteção Ambiental',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: 'tipo/número/data',
        controller: controllers['protecaoAmbiental'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Apoio à Cultura',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: 'tipo/número/data',
        controller: controllers['apoioACultura'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Incentivos Fiscais ao Turismo',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: 'tipo/número/data',
        controller: controllers['incentivosFiscaisAoTurismo'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Plano Diretor',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: 'tipo/número/data',
        controller: controllers['planoDiretor'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Fundo Municipal de Turismo',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: 'tipo/número/data',
        controller: controllers['fundoMunicipalDeTurismo'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Outras',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: 'tipo/número/data',
        controller: controllers['legislacaoOutras'],
      ),
      SizedBox(
        height: 75.h,
      ),
      Container(
        color: const Color.fromARGB(255, 55, 111, 60),
        height: sizeScreen.height * 0.06,
        width: sizeScreen.width,
        padding: EdgeInsets.only(
            top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
        child: Text(
          'Observações e Referências',
          style: TextStyle(
              color: Colors.white, fontSize: sizeScreen.height * 0.03),
        ),
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Observações',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: '',
        controller: controllers['observacoes'],
      ),
      textLabel(
        name: 'Referências',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: '',
        controller: controllers['referencias'],
      ),
      SizedBox(
        height: 75.h,
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: listaWidgets,
      ),
    );
  }
}
