import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/forms/forms%20B/agencia_de_turismo_model.dart';
import 'package:inventur/controllers/pesquisa_controller.dart';
import 'package:inventur/ui/widgets/widgets/fields.dart';
import 'package:inventur/ui/widgets/container_widget.dart';
import 'package:inventur/ui/widgets/text%20fields/customOutro.dart';
import 'package:inventur/ui/widgets/text%20fields/customTextField.dart';
import 'package:inventur/ui/widgets/maps/mapa_widget.dart';
import 'package:inventur/ui/widgets/text%20fields/multi_auto_complete_form_field.dart';
import 'package:inventur/ui/widgets/radioButton.dart';
import 'package:inventur/ui/widgets/text%20fields/tables.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/services/form_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/validators/validators.dart';
import '../../widgets/widgets/checkBox.dart';

final Validators _validators = Validators();
final Map<String, dynamic> valoresJson = {
  'tipo_formulario': 'Agência de Turismo',
};
bool isUpdate = false;

//formulario
class AgenciasDeTurismo extends StatefulWidget {
  final AgenciasDeTurismoModel? infoModel;
  const AgenciasDeTurismo({super.key, this.infoModel});

  @override
  State<AgenciasDeTurismo> createState() => _AgenciasDeTurismoState();
}

class _AgenciasDeTurismoState extends State<AgenciasDeTurismo> {
  int currentStep = 0;
  late List<Widget> pages;
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  Map<String, TextEditingController> _informacoesGeralController = {};
  Map<String, TextEditingController> _funcionamentoControllers = {};
  Map<String, TextEditingController> _acessibilidadeController = {};

  final List<String> _chavesInfo = const [
    'uf',
    'regiao_turistica',
    'municipio',
    'razaoSocial',
    'nomeFantasia',
    'CNPJ',
    'codigoCNAE',
    'atividadeEconomica',
    'inscricaoMunicipal',
    'nomeDaRede',
    'inicioDaAtividade',
    'qtdeFuncionariosPermanentes',
    'qtdeFuncionariosTemporarios',
    'qtdeFuncionariosComDeficiencia',
    'avenidaRuaEtc',
    'bairroLocalidade',
    'distrito',
    'CEP',
    'whatsapp',
    'instagram',
    'email',
    'distanciasAeroporto',
    'distanciasRodoviaria',
    'distanciaEstacaoFerroviaria',
    'distanciaEstacaoMaritima',
    'distanciaEstacaoMetroviaria',
    'distanciaPontoDeOnibus',
    'distanciaPontoDeTaxi',
    'distanciasOutraNome',
    'distanciaOutras',
    'pontosDeReferencia',
  ];
  final List<String> _chavesFun = const [
    'capacidadeVeiculos',
    'numeroAutomoveis',
    'totalVendasEmissivos',
    'totalVendasReceptivos',
    'numeroOnibus',
    'anoBaseEmissivos',
    'vendasAltaTemporada',
    'outrasRegrasEInformacoes',
    'vendasBaixaTemporada',
    'servicosBasicosOutros',
    'totalDeVeiculos',
    'totalDeVeiculosAdaptados',
    'totalDeVeiculosAquaticos',
    'totalDeVeiculosAquaticosAdaptados',
    'totalDeVeiculosAeronaves',
    'totalDeVeiculosAeronavesAdaptados'
  ];
  final List<String> _chavesAcessi = const [
    'outrosAcessibilidade',
    'observacoes',
    'referencias',
  ];

  void _preencherDadosParaTeste() {
    if (widget.infoModel != null) {
      final model = widget.infoModel!;
      final modelMap = model.toMap();

      _informacoesGeralController.forEach((key, controller) {
        if (modelMap.containsKey(key)) {
          final valor = modelMap[key];
          controller.text = valor?.toString() ?? '';
        }
      });

      _funcionamentoControllers.forEach(
        (key, value) {
          if (modelMap.containsKey(key)) {
            final valor = modelMap[key];
            value.text = valor?.toString() ?? '';
          }
        },
      );

      _acessibilidadeController.forEach(
        (key, value) {
          if (modelMap.containsKey(key)) {
            final valor = modelMap[key];
            value.text = valor?.toString() ?? '';
          }
        },
      );
    }
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
      _preencherDadosParaTeste();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfoUsersInPesquisa();
    for (final key in _chavesInfo) {
      _informacoesGeralController[key] = TextEditingController();
    }

    for (final key in _chavesFun) {
      _funcionamentoControllers[key] = TextEditingController();
    }

    for (final key in _chavesAcessi) {
      _acessibilidadeController[key] = TextEditingController();
    }

    pages = [
      InformacaoPage(
        controllers: _informacoesGeralController,
        infoModel: widget.infoModel,
      ),
      FuncionamentoPage(
        controllers: _funcionamentoControllers,
        infoModel: widget.infoModel,
      ),
      ProtecaoPage(
        controllers: _acessibilidadeController,
        infoModel: widget.infoModel,
      ),
    ];
  }

  @override
  void dispose() {
    for (final controller in _informacoesGeralController.values) {
      controller.dispose();
    }
    for (final controller in _funcionamentoControllers.values) {
      controller.dispose();
    }
    for (final controller in _acessibilidadeController.values) {
      controller.dispose();
    }
    valoresJson.clear();
    valoresJson['tipo_formulario'] = 'Agência de Turismo';
    isUpdate = false;
    super.dispose();
  }

  void getInfoUsersInPesquisa() async {
    Map<String, dynamic> info = await getAdminAndPesquisadorInfo();

    valoresJson['nome_pesquisador'] = info['pesquisador']['nome'];
    valoresJson['telefone_pesquisador'] = info['pesquisador']['telefone'];
    valoresJson['email_pesquisador'] = info['pesquisador']['email'];

    valoresJson['nome_coordenador'] = info['coordenador']['nome'];
    valoresJson['telefone_coordenador'] = info['coordenador']['telefone'];
    valoresJson['email_coordenador'] = info['coordenador']['email'];
  }

  void _enviarFormulario() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      _informacoesGeralController.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });
      _funcionamentoControllers.forEach(
        (key, controller) {
          valoresJson[key] = controller.text;
        },
      );
      _acessibilidadeController.forEach(
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
        // isUpdate ? FormService().updateForm(widget.infoModel!.id!, valoresJson,AppConstants.INFO_BASICA_CREATE ) :
        isUpdate
            ? FormService().updateForm(widget.infoModel!.id!, valoresJson,
                AppConstants.AGENCIA_TURISMO)
            : FormService().sendForm(valoresJson, AppConstants.AGENCIA_TURISMO);
        print("Formulário finalizado e pronto para enviar!");

        // _enviarFormulario(); // Você pode chamar sua função de envio aqui
      }
    } else {
      _formKey.currentState!.save();
      _informacoesGeralController.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });
      _funcionamentoControllers.forEach(
        (key, controller) {
          valoresJson[key] = controller.text;
        },
      );
      _acessibilidadeController.forEach(
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

class InformacaoPage extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final AgenciasDeTurismoModel? infoModel;

  const InformacaoPage({
    super.key,
    required this.controllers,
    this.infoModel,
  });

  @override
  State<InformacaoPage> createState() => _InformacaoPageState();
}

class FuncionamentoPage extends StatefulWidget {
  final AgenciasDeTurismoModel? infoModel;

  final Map<String, TextEditingController> controllers;

  const FuncionamentoPage(
      {super.key, required this.controllers, this.infoModel});

  @override
  State<FuncionamentoPage> createState() => _FuncionamentoPageState();
}

/*construção*/

class _InformacaoPageState extends State<InformacaoPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final sizeScreen = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          ContainerHeader(title: 'Identificação'),
          UfMunicipioRg(controllers: widget.controllers),
          SizedBox(
            height: 55.h,
          ),
          RadioFormField(
            options: const [
              'Agência de viagem',
              'Operadora de turismo',
              'Agência de receptivo',
              'Agência consolidadora',
            ],
            title: 'Tipo',
            onSaved: (newValue) {
              valoresJson['tipo'] = newValue;
            },
            initialValue: isUpdate == true ? widget.infoModel!.tipo : "",
          ),
          SizedBox(
            height: 55.h,
          ),
          ContainerHeaderToBigTexts(title: 'Informações Gerais'),
          SizedBox(
            height: 55.h,
          ),
          CustomTextField(
            name: "Razão Social",
            controller: widget.controllers['razaoSocial'],
          ),
          CustomTextField(
            name: "Nome Fantasia",
            controller: widget.controllers['nomeFantasia'],
          ),
          CustomTextField(
            name: 'CNPJ',
            //   validat: _validators.validarCNPJ,
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [_validators.cnpjFormatter],
            controller: widget.controllers['CNPJ'],
          ),
          CustomTextField(
            name: 'Código CNAE',
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            controller: widget.controllers['codigoCNAE'],
          ),
          CustomTextField(
            name: 'Atividade Econômica',
            controller: widget.controllers['atividadeEconomica'],
          ),
          CustomTextField(
            name: 'Nome da Rede/holding',
            controller: widget.controllers['nomeDaRede'],
          ),
          CustomTextField(
            name: 'Inscrição Municipal',
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            controller: widget.controllers['inscricaoMunicipal'],
          ),
          RadioFormField(
            title: 'Natureza',
            onSaved: (newValue) => valoresJson['natureza'] = newValue,
            options: ['Pública', 'Privada', 'outro'],
            initialValue: isUpdate ? widget.infoModel!.natureza! : '',
          ),
          CheckboxGroupFormField(
            title: 'Tipo de Organização/Instituição',
            onSaved: (newValue) =>
                valoresJson['tipoDeOrganizacaoInstituicao'] = newValue,
            options: [
              'Associação',
              'Sindicato',
              'Cooperativa',
              'Sistema S',
              'Empresa',
              'outro'
            ],
            initialValue:
                isUpdate ? widget.infoModel!.tipoDeOrganizacaoInstituicao! : [],
          ),
          //formatação inicio da atividade
          Row(children: [
            textLabel(
              name: "Inicio da atividade",
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            Container(
              height: sizeScreen.height * 0.1,
              width: sizeScreen.width * 0.4,
              child: CustomTextDate(
                dateController: widget.controllers['inicioDaAtividade'],
              ),
            )
          ]),
          //formatação quantidade de funcionários
          textLabel(
            name: 'Quantidade de Funcionários',
            fontWeight: FontWeight.bold,
          ),
          Row(
            children: [
              textLabel(name: 'Permanentes'),
              SizedBox(
                width: sizeScreen.width * 0.026,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: 'n°',
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: widget.controllers['qtdeFuncionariosPermanentes'],
                ),
              ),
            ],
          ),
          Row(
            children: [
              textLabel(name: 'Temporários '),
              SizedBox(
                width: sizeScreen.width * 0.026,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: 'n°',
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: widget.controllers['qtdeFuncionariosTemporarios'],
                ),
              ),
            ],
          ),
          Row(
            children: [
              textLabel(name: 'Pessoas com \nDeficiência'),
              SizedBox(
                width: sizeScreen.width * 0.026,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: '%',
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                  controller:
                      widget.controllers['qtdeFuncionariosComDeficiencia'],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.w,
          ),
          //localização
          RadioFormField(
            onSaved: (newValue) => valoresJson['localizacao'] = newValue,
            title: 'Localização',
            options: ['Urbana', 'Rural'],
            initialValue: isUpdate ? widget.infoModel!.localizacao! : '',
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Coordenadas Geográficas',
            fontWeight: FontWeight.bold,
          ),
          MapaWidget(
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              latitude: widget.infoModel?.latitude ?? "-3.73",
              longitude: widget.infoModel?.longitude ?? "-38.52"),
          textLabel(
            name: 'Endereço:',
            fontWeight: FontWeight.bold,
          ),
          CustomTextField(
            name: 'Avenida/Rua/Travessa/Caminho/Outro',
            controller: widget.controllers['avenidaRuaEtc'],
          ),
          CustomTextField(
            name: 'Bairro/Localidade',
            controller: widget.controllers['bairroLocalidade'],
          ),
          CustomTextField(
            name: 'Distrito',
            controller: widget.controllers['distrito'],
          ),
          CustomTextField(
            name: 'CEP',
            controller: widget.controllers['CEP'],
            formatter: [
              FilteringTextInputFormatter.digitsOnly,
              _validators.cepFormatter
            ],
          ),
          //contato
          textLabel(name: 'Contato:', fontWeight: FontWeight.bold),
          Row(
            children: [
              textLabel(name: "WhatsApp"),
              SizedBox(
                width: sizeScreen.width * 0.1,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: '(DD) *****-****',
                  keyboardType: TextInputType.numberWithOptions(),
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    _validators.phoneFormatter
                  ],
                  controller: widget.controllers['whatsapp'],
                ),
              ),
            ],
          ),
          Row(
            children: [
              textLabel(name: "Instagram"),
              SizedBox(
                width: sizeScreen.width * 0.1,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: '@username',
                  controller: widget.controllers['instagram'],
                ),
              ),
            ],
          ),
          Row(
            children: [
              textLabel(name: "E-mail"),
              SizedBox(
                width: sizeScreen.width * 0.17,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: 'E-mail',
                  controller: widget.controllers['email'],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Sinalização',
            fontWeight: FontWeight.bold,
          ),
          ConditionalFieldsGroup(
            title: 'De Acesso',
            jsonKey: 'sinalizacaoDeAcesso',
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [],
            optionModelValue:
                isUpdate ? widget.infoModel!.sinalizacaoDeAcesso! : '',
          ),
          ConditionalFieldsGroup(
            title: 'Turística',
            jsonKey: 'sinalizacaoTuristica',
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [],
            optionModelValue:
                isUpdate ? widget.infoModel!.sinalizacaoTuristica! : '',
          ),
          CheckboxGroupFormField(
            title: 'Proximidades: ',
            onSaved: (newValue) => valoresJson['proximidades'] = newValue,
            options: [
              'Restaurante',
              'Bar/lanchonete',
              'Meios de hospedagem',
              'Shopping',
              'Galeria/rua comercial',
              'Centro de convenções/exposições',
              'Posto de combustível',
              'outro'
            ],
            initialValue: isUpdate ? widget.infoModel!.proximidades! : [],
          ),
          SizedBox(
            height: 30.w,
          ),
          //distancias
          textLabel(name: 'Distâncias até:', fontWeight: FontWeight.bold),
          Row(
            children: [
              textLabel(name: "Aeroporto:"),
              SizedBox(
                width: sizeScreen.width * 0.1,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: '(km)',
                  controller: widget.controllers['distanciasAeroporto'],
                ),
              ),
            ],
          ),
          Row(
            children: [
              textLabel(name: "Estação \nrodoviária:"),
              SizedBox(
                width: sizeScreen.width * 0.1,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: '(km)',
                  controller: widget.controllers['distanciasRodoviaria'],
                ),
              ),
            ],
          ),
          Row(
            children: [
              textLabel(name: "Estação \nferroviária:"),
              SizedBox(
                width: sizeScreen.width * 0.1,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: '(km)',
                  controller: widget.controllers['distanciaEstacaoFerroviaria'],
                ),
              ),
            ],
          ),
          Row(
            children: [
              textLabel(name: "Estação \nmarítima/\nfluvial:"),
              SizedBox(
                width: sizeScreen.width * 0.1,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: '(km)',
                  controller: widget.controllers['distanciaEstacaoMaritima'],
                ),
              ),
            ],
          ),
          Row(
            children: [
              textLabel(name: "Estação \nmetroviária:"),
              SizedBox(
                width: sizeScreen.width * 0.05,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: '(km)',
                  controller: widget.controllers['distanciaEstacaoMetroviaria'],
                ),
              ),
            ],
          ),
          Row(
            children: [
              textLabel(name: "Ponto de\nônibus:"),
              SizedBox(
                width: sizeScreen.width * 0.1,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: '(km)',
                  controller: widget.controllers['distanciaPontoDeOnibus'],
                ),
              ),
            ],
          ),
          Row(
            children: [
              textLabel(name: "Ponto de\ntaxi:"),
              SizedBox(
                width: sizeScreen.width * 0.1,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: '(km)',
                  controller: widget.controllers['distanciaPontoDeTaxi'],
                ),
              ),
            ],
          ),
          Row(
            children: [
              textLabel(name: "Outros:"),
              SizedBox(
                width: sizeScreen.width * 0.1,
              ),
              SizedBox(
                width: sizeScreen.width * 0.37,
                child: CustomTextField(
                  name: 'nome',
                  controller: widget.controllers['distanciasOutraNome'],
                ),
              ),
              SizedBox(
                width: sizeScreen.width * 0.2,
                child: CustomTextField(
                  name: '(km)',
                  controller: widget.controllers['distanciaOutras'],
                ),
              ),
            ],
          ),
          textLabel(name: 'Ponto de referência:', fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'Ponto de referência',
            controller: widget.controllers['pontosDeReferencia'],
          ),
          SizedBox(
            height: 55.h,
          ),
          ContainerHeaderToBigTexts(title: 'Cadastro, classificação e outros'),
          SizedBox(
            height: 55.h,
          ),
          TableMtur(
            getValues: isUpdate ? widget.infoModel!.tabelaMTUR : {},
            onChanged: (p0) => valoresJson['tabelaMTUR'] = p0,
          ),

          CheckboxGroupFormField(
              isLimitedBy3: true,
              onSaved: (newValue) =>
                  valoresJson['segmentosEspecializado'] = newValue,
              initialValue:
                  isUpdate ? widget.infoModel!.segmentosEspecializado : [],
              title:
                  'Segmentos ou Tipos de Turismo em que é Especializado (assinalar até 3)',
              options: [
                'Aventura',
                'Ecoturismo',
                'Sol e praia',
                'Rural',
                'Estudos e intercâmbio',
                'Negócio e eventos',
                'Cultural (cívico, étnico, religioso, místico e esotérico)',
                'Náutico',
                'Esporte',
                'Saúde (bem-estar e médico)',
                'Pesca',
                'Não é especializado em nenhum segmento'
              ]),
          SizedBox(
            height: 55.h,
          ),
        ],
      ),
    );
  }
}

class _FuncionamentoPageState extends State<FuncionamentoPage>
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final sizeScreen = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          ContainerHeaderToBigTexts(title: 'Funcionamento'),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
              name: 'Estrutura de funcionamento:', fontWeight: FontWeight.bold),
          //pagamentos
          CheckboxGroupFormField(
            title: 'Formas de pagamento: ',
            onSaved: (newValue) => valoresJson['formasDePagamento'] = newValue,
            options: [
              'Dinheiro',
              'Pix',
              'Cartão de Crédito',
              'Cartão de Débito'
            ],
            initialValue: isUpdate ? widget.infoModel!.formasDePagamento! : [],
          ),

          //atendimento
          textLabel(
              name: 'Atendimento ao público:', fontWeight: FontWeight.bold),
          CheckboxGroupFormField(
            title: 'Atendimento em língua estrangueira: ',
            onSaved: (newValue) =>
                valoresJson['atendimentoEmLinguasEstrangeiras'] = newValue,
            options: ['Não', 'Inglês', 'Espanhol', 'Outro'],
            initialValue: isUpdate
                ? widget.infoModel!.atendimentoEmLinguasEstrangeiras!
                : [],
          ),
          CheckboxGroupFormField(
            title: 'Informativos impressos: ',
            onSaved: (newValue) =>
                valoresJson['informativosImpressos'] = newValue,
            options: ['Não', 'Inglês', 'Espanhol', 'Português', 'Outro'],
            initialValue:
                isUpdate ? widget.infoModel!.informativosImpressos! : [],
          ),
          SizedBox(
            height: 55.h,
          ),
          ContainerHeaderToBigTexts(title: 'Regras de funcionamento'),
          SizedBox(
            height: 55.h,
          ),
          CheckboxGroupFormField(
            title: 'Périodo: ',
            onSaved: (newValue) => valoresJson['periodo'] = newValue,
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
              'Ano inteiro'
            ],
            initialValue: isUpdate ? widget.infoModel!.periodo! : [],
          ),
          textLabel(name: 'Horário'),
          SizedBox(
            height: 55.h,
          ),
          TabelaHorarios(
            onChanged: (p0) => valoresJson['tabelasHorario'] = p0,
            getValue: isUpdate ? widget.infoModel!.tabelasHorario : {},
          ),
          SizedBox(
            height: 55.h,
          ),
          ConditionalFieldsGroup(
              title: 'Funcionamento\n24 Horas',
              jsonKey: 'funcionamento24h',
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              optionModelValue:
                  isUpdate ? widget.infoModel!.funcionamento24h : '',
              children: []),
          ConditionalFieldsGroup(
              title: 'Funcionamento\nem Feriados',
              jsonKey: 'funcionamentoEmFeriados',
              valoresJson: valoresJson,
              optionModelValue:
                  isUpdate ? widget.infoModel!.funcionamentoEmFeriados : '',
              isUpdate: isUpdate,
              children: []),
          SizedBox(
            height: 55.h,
          ),

          textLabel(
              name: 'Outras regras e informações:',
              fontWeight: FontWeight.bold),
          CustomTextField(
            name: 'Outras Regras e Informações',
            controller: widget.controllers['outrasRegrasEInformacoes'],
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Caracterização do Fluxo Turístico',
            fontWeight: FontWeight.bold,
          ),

          CustomTextField(
            name: 'Total de Vendas Emissivo (nº)',
            controller: widget.controllers['totalVendasEmissivos'],
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          SizedBox(
            height: 55.h,
          ),

          textLabel(
            name: 'Destinos Emissivos',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 55.h,
          ),
          MultiAutocompleteFormField(
            initialValue:
                isUpdate ? widget.infoModel!.destinosEmissivosNacionais : [],
            title: 'Principais Destinos Emissivos Nacionais (até 5)',
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
              valoresJson['destinosEmissivosNacionais'] = newValue;
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
            height: 120.h,
          ),
          MultiAutocompleteFormField(
            initialValue: isUpdate
                ? widget.infoModel!.destinosEmissivosInternacionais
                : [],
            title: 'Principais Destinos Emissivos Internacionais (até 5)',
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
              valoresJson['destinosEmissivosInternacionais'] = newValue;
            },
            validator: (values) {
              // if (values == null || values.isEmpty) {
              //   return 'Por favor, selecione pelo menos um pais.';
              // }
              return null;
            },
          ),

          CustomTextField(
            name: 'Total de Vendas Receptivo (nº)',
            controller: widget.controllers['totalVendasReceptivos'],
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          SizedBox(
            height: 55.h,
          ),

          textLabel(
            name: 'Receptivos',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 55.h,
          ),

          MultiAutocompleteFormField(
            initialValue:
                isUpdate ? widget.infoModel!.origemEmissivosNacionais : [],
            title: 'Origem do Receptivo Nacional (até 5)',
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
              valoresJson['origemEmissivosNacionais'] = newValue;
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
            height: 120.h,
          ),
          MultiAutocompleteFormField(
            initialValue:
                isUpdate ? widget.infoModel!.origemEmissivosInternacionais : [],
            title: 'Origem do Receptivo Internacionais (até 5)',
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
              valoresJson['origemEmissivosInternacionais'] = newValue;
            },
            validator: (values) {
              // if (values == null || values.isEmpty) {
              //   return 'Por favor, selecione pelo menos um pais.';
              // }
              return null;
            },
          ),
          textLabel(
            name: 'Ano Base',
            fontWeight: FontWeight.bold,
          ),
          CustomTextDate(
            dateController: widget.controllers['anoBaseEmissivos'],
          ),
          CustomTextField(
            name: 'Vendas Alta Temporada (nº pax)',
            controller: widget.controllers['vendasAltaTemporada'],
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CheckboxGroupFormField(
            title: 'Meses de Alta Temporada',
            initialValue:
                isUpdate == true ? widget.infoModel!.mesesAltaTemporada : [],
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

          CustomTextField(
            name: 'Vendas Baixa Temporada (nº pax)',
            controller: widget.controllers['vendasBaixaTemporada'],
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CheckboxGroupFormField(
            title: 'Meses de Baixa Temporada',
            initialValue:
                isUpdate == true ? widget.infoModel!.mesesBaixaTemporada : [],
            onSaved: (p0) => valoresJson['mesesBaixaTemporada'] = p0,
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
          //caracteriscas do local
          ContainerHeaderToBigTexts(title: 'Características'),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Serviços básicos',
            fontWeight: FontWeight.bold,
          ),
          //veiculos
          CheckboxGroupFormField(
            title: 'Bilhetes Terrestres',
            onSaved: (newValue) => valoresJson['bilhetesTerrestres'] = newValue,
            options: [
              'Reserva',
              'Emissão',
              'Alteração',
              'Remarcação',
              'Cancelamento',
              'Tarifa net',
              'Tarifa comissionada',
              'Tarifa especial para agentes de viagem',
              'Tarifa especial para empresas'
            ],
            initialValue: isUpdate ? widget.infoModel!.bilhetesTerrestres! : [],
          ),

          CheckboxGroupFormField(
            title: 'Bilhetes Aereos',
            onSaved: (newValue) => valoresJson['bilhetesAereos'] = newValue,
            options: [
              'Reserva',
              'Emissão',
              'Alteração',
              'Remarcação',
              'Cancelamento',
              'Tarifa net',
              'Tarifa comissionada',
              'Tarifa especial para agentes de viagem',
              'Tarifa especial para empresas'
            ],
            initialValue: isUpdate ? widget.infoModel!.bilhetesAereos! : [],
          ),

          CheckboxGroupFormField(
            title: 'Pacotes Turísticos',
            onSaved: (newValue) => valoresJson['pacotesTuristicos'] = newValue,
            options: [
              'Reserva',
              'Emissão',
              'Alteração',
              'Remarcação',
              'Cancelamento',
              'Venda direta',
              'Venda via agentes'
            ],
            initialValue: isUpdate ? widget.infoModel!.pacotesTuristicos! : [],
          ),
          CheckboxGroupFormField(
            title: 'Cruzeiros Marítimos',
            onSaved: (newValue) => valoresJson['cruzeirosMaritimos'] = newValue,
            options: [
              'Reserva',
              'Emissão',
              'Alteração',
              'Remarcação',
              'Cancelamento',
              'Venda direta',
              'Venda via agentes'
            ],
            initialValue: isUpdate ? widget.infoModel!.cruzeirosMaritimos! : [],
          ),
          CheckboxGroupFormField(
            title: 'Meios de Hospedgem',
            onSaved: (newValue) => valoresJson['meiosDeHospedagem'] = newValue,
            options: [
              'Reserva',
              'Emissão',
              'Alteração',
              'Remarcação',
              'Cancelamento',
              'Venda direta',
              'Venda via agentes',
              'Tarifas Especiais para Agentes de Viagem',
              'Tarifas Especiais para Empresas',
            ],
            initialValue: isUpdate ? widget.infoModel!.meiosDeHospedagem! : [],
          ),
          CheckboxGroupFormField(
            title: 'Serviços de Traslados, Passeios, Visitas e Outros',
            onSaved: (newValue) => valoresJson['servicosTraslados'] = newValue,
            options: [
              'Reserva',
              'Emissão',
              'Alteração',
              'Remarcação',
              'Cancelamento',
              'Venda direta',
              'Venda via agentes',
              'Tarifas Especiais para Agentes de Viagem',
              'Tarifas Especiais para Empresas',
            ],
            initialValue: isUpdate ? widget.infoModel!.servicosTraslados! : [],
          ),
          CheckboxGroupFormField(
            title: 'Seguro de Viagem',
            onSaved: (newValue) => valoresJson['seguroDeViagem'] = newValue,
            options: [
              'Reserva',
              'Emissão',
              'Alteração',
              'Remarcação',
              'Cancelamento',
              'Venda direta',
              'Venda via agentes',
              'Tarifas Especiais para Agentes de Viagem',
              'Tarifas Especiais para Empresas',
            ],
            initialValue: isUpdate ? widget.infoModel!.seguroDeViagem! : [],
          ),
          CheckboxGroupFormField(
            title: 'Locação de Automóveis',
            onSaved: (newValue) =>
                valoresJson['locacaoDeAutomoveis'] = newValue,
            options: [
              'Reserva',
              'Emissão',
              'Alteração',
              'Remarcação',
              'Cancelamento',
              'Venda direta',
              'Venda via agentes',
              'Tarifas Especiais para Agentes de Viagem',
              'Tarifas Especiais para Empresas',
            ],
            initialValue:
                isUpdate ? widget.infoModel!.locacaoDeAutomoveis! : [],
          ),
          ConditionalFieldsGroup(
              title: 'Câmbio',
              jsonKey: 'cambio',
              optionModelValue: isUpdate ? widget.infoModel!.cambio : "",
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              children: []),

          RadioFormField(
            options: ['Passaporte', 'Visto', 'outro'],
            title: 'Apoio a Despachos de Documentos',
            initialValue: isUpdate ? widget.infoModel!.apoioADespachos! : "",
            onSaved: (newValue) => valoresJson['apoioADespachos'] = newValue,
          ),
          CustomTextField(
            name: 'Outros',
            controller: widget.controllers['servicosBasicosOutros'],
          ),
          CheckboxGroupFormField(
              title: 'Serviços e Atividades Especializadas',
              onSaved: (newValue) =>
                  valoresJson['servicosEAtividadesEspecializadas'] = newValue,
              initialValue: isUpdate
                  ? widget.infoModel!.servicosEAtividadesEspecializadas!
                  : [],
              options: [
                'Visita técnica e missões empresariais',
                'Atividades pedagógicas',
                'Viagens corporativas',
                'Viagens para torcedores esportivos',
                'Visitas a propriedades rurais',
                'Cursos técnicos e estágios',
                'Organização de eventos esportivos',
                'Organização de viagens de equipes esportivas',
                'Cruzeiros',
                'Viagens para estâncias hidrominerais, spas, balneários, resorts, clínicas naturalistas',
                'Intercâmbio estudantil e/ou universitário',
                'Realização de cursos, seminários, feiras',
                'Viagens para fins médico-hospitalares',
                'Kitesurf e/ou Windsurf',
                'Escalada',
                'Observação da fauna',
                'Acampamentos',
                'Degustação gastronômica',
                'Passeios para compras',
                'Visitas a sítios históricos',
                'Pesca amadora',
                'Atividades equestres',
                'Atividades em caverna (Espeleoturismo)',
                'Atividades fora de estrada (veículos 4x4, buggys, motos)',
                'Atividades com bicicleta',
                'Atividades aquáticas (jet ski, banana boat, esqui-aquático)',
                'Passeios náuticos',
                'Passeios para festas, festivais, celebrações locais e manifestações populares',
                'Safáris fotográficos',
                'Visitas a sítios arqueológicos/paleontológicos',
                'Visitas a locais e eventos religiosos',
                'Visitas a monumentos e celebrações cívicas',
                'Visitas a museus e casas de cultura',
                'Visitas a comunidades tradicionais e/ou étnicas',
                'Visitas a locais místicos e esotéricos',
                'Visitas a feiras e mercados',
                'Caminhada de curta duração (sem pernoite)',
                'Caminhada de longa duração (com pernoite)',
                'Arvorismo',
                'Canoagem',
                'Mergulho',
                'Boia-cross',
                'Flutuação',
                'Rafting',
                'Balonismo',
                'Tirolesa',
                'Surfe',
                'Rapel',
                'Canoismo',
                'Montanhismo',
                'Bungee-jump',
                'Voo livre',
                'Parapente',
                'Paraquedismo',
                'Cachoeirismo',
                'outro'
              ]),

          textLabel(
            name: 'Serviços de Transporte',
            fontWeight: FontWeight.bold,
          ),
          ConditionalFieldsGroup(
              title: 'Transporte Terreste',
              jsonKey: 'transporteTerrestre',
              valoresJson: valoresJson,
              optionModelValue:
                  isUpdate ? widget.infoModel!.transporteTerrestre : "",
              isUpdate: isUpdate,
              children: [
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Automóvel de Passeio',
                  initialValue:
                      isUpdate ? widget.infoModel!.aumovelDePasseio : "",
                  onSaved: (newValue) =>
                      valoresJson['aumovelDePasseio'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Buggy',
                  initialValue: isUpdate ? widget.infoModel!.buggy : "",
                  onSaved: (newValue) => valoresJson['buggy'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Motocicleta',
                  initialValue: isUpdate ? widget.infoModel!.motocicleta : "",
                  onSaved: (newValue) => valoresJson['motocicleta'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Caminhão',
                  initialValue: isUpdate ? widget.infoModel!.caminhao : "",
                  onSaved: (newValue) => valoresJson['caminhao'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Caminhonete',
                  initialValue: isUpdate ? widget.infoModel!.caminhonete : "",
                  onSaved: (newValue) => valoresJson['caminhonete'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Ônibus',
                  initialValue: isUpdate ? widget.infoModel!.onibus : "",
                  onSaved: (newValue) => valoresJson['onibus'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Utilitário',
                  initialValue: isUpdate ? widget.infoModel!.utilitario : "",
                  onSaved: (newValue) => valoresJson['utilitario'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Trem',
                  initialValue: isUpdate ? widget.infoModel!.trem : "",
                  onSaved: (newValue) => valoresJson['trem'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'outro',
                  initialValue:
                      isUpdate ? widget.infoModel!.outrosTipoVeiculo : "",
                  onSaved: (newValue) =>
                      valoresJson['outrosTipoVeiculo'] = newValue,
                ),
                CustomTextField(
                  name: 'Total de Veículos',
                  controller: widget.controllers['totalDeVeiculos'],
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                CustomTextField(
                  name: 'Veículos Adaptados',
                  controller: widget.controllers['totalDeVeiculosAdaptados'],
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                CheckboxGroupFormField(
                  options: ['Aluguel', 'Carga', 'Passeio'],
                  title: 'Tipo de Serviço',
                  initialValue:
                      isUpdate ? widget.infoModel!.tipoDeServico! : [],
                  onSaved: (newValue) =>
                      valoresJson['tipoDeServico'] = newValue,
                ),
              ]),

          ConditionalFieldsGroup(
              title: 'Transporte Aquático',
              jsonKey: 'transporteAquatico',
              optionModelValue:
                  isUpdate ? widget.infoModel!.transporteAquatico : "",
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              children: [
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Iate',
                  initialValue: isUpdate ? widget.infoModel!.iate : "",
                  onSaved: (newValue) => valoresJson['iate'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Chalana',
                  initialValue: isUpdate ? widget.infoModel!.chalana : "",
                  onSaved: (newValue) => valoresJson['chalana'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Navio',
                  initialValue: isUpdate ? widget.infoModel!.navio : "",
                  onSaved: (newValue) => valoresJson['navio'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Saveiro',
                  initialValue: isUpdate ? widget.infoModel!.saveiro : "",
                  onSaved: (newValue) => valoresJson['saveiro'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Escuna',
                  initialValue: isUpdate ? widget.infoModel!.escuna : "",
                  onSaved: (newValue) => valoresJson['escuna'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Jangada',
                  initialValue: isUpdate ? widget.infoModel!.jangada : "",
                  onSaved: (newValue) => valoresJson['jangada'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Traineira',
                  initialValue: isUpdate ? widget.infoModel!.traineira : "",
                  onSaved: (newValue) => valoresJson['traineira'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Catamarã',
                  initialValue: isUpdate ? widget.infoModel!.catarama : "",
                  onSaved: (newValue) => valoresJson['catarama'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Veleiro',
                  initialValue: isUpdate ? widget.infoModel!.veleiro : "",
                  onSaved: (newValue) => valoresJson['veleiro'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Ferry Boat',
                  initialValue: isUpdate ? widget.infoModel!.ferryBoat : "",
                  onSaved: (newValue) => valoresJson['ferryBoat'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Lancha',
                  initialValue: isUpdate ? widget.infoModel!.lancha : "",
                  onSaved: (newValue) => valoresJson['lancha'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'outros',
                  initialValue:
                      isUpdate ? widget.infoModel!.outrosEmbarcacao : "",
                  onSaved: (newValue) =>
                      valoresJson['outrosEmbarcacao'] = newValue,
                ),
                CustomTextField(
                  name: 'Total de Veículos',
                  controller: widget.controllers['totalDeVeiculosAquaticos'],
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                CustomTextField(
                  name: 'Veículos Adaptados',
                  controller:
                      widget.controllers['totalDeVeiculosAquaticosAdaptados'],
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                CheckboxGroupFormField(
                  options: ['Aluguel', 'Carga', 'Passeio'],
                  title: 'Tipo de Serviço',
                  initialValue:
                      isUpdate ? widget.infoModel!.tipoDeServicoAquatico! : [],
                  onSaved: (newValue) =>
                      valoresJson['tipoDeServicoAquatico'] = newValue,
                ),
                RadioFormField(
                  options: ['Mar Aberto', 'Interior'],
                  initialValue:
                      isUpdate ? widget.infoModel!.caracterizacaoServico : "",
                  onSaved: (newValue) =>
                      valoresJson['caracterizacaoServico'] = newValue,
                  title: 'Caracterização do Serviço',
                ),
              ]),

          ConditionalFieldsGroup(
              title: 'Transporte Aéreo',
              jsonKey: 'transporteAereo',
              optionModelValue:
                  isUpdate ? widget.infoModel!.transporteAereo : "",
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              children: [
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Helicóptero',
                  initialValue: isUpdate ? widget.infoModel!.helicoptero : "",
                  onSaved: (newValue) => valoresJson['helicoptero'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'Avião',
                  initialValue: isUpdate ? widget.infoModel!.aviao : "",
                  onSaved: (newValue) => valoresJson['aviao'] = newValue,
                ),
                RadioFormField(
                  options: ['Próprio', 'De Terceiros'],
                  title: 'outros',
                  initialValue:
                      isUpdate ? widget.infoModel!.outrosAeronave : "",
                  onSaved: (newValue) =>
                      valoresJson['outrosAeronave'] = newValue,
                ),
                CustomTextField(
                  name: 'Total de Veículos',
                  controller: widget.controllers['totalDeVeiculosAeronaves'],
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                CustomTextField(
                  name: 'Veículos Adaptados',
                  controller:
                      widget.controllers['totalDeVeiculosAeronavesAdaptados'],
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                CheckboxGroupFormField(
                  options: ['Aluguel', 'Carga', 'Passeio'],
                  title: 'Tipo de Serviço',
                  initialValue:
                      isUpdate ? widget.infoModel!.tipoDeServicoAeronave! : [],
                  onSaved: (newValue) =>
                      valoresJson['tipoDeServicoAeronave'] = newValue,
                ),
              ]),

          SizedBox(
            height: 55.h,
          ),
        ],
      ),
    );
  }
}

class ProtecaoPage extends StatelessWidget {
  final Map<String, TextEditingController> controllers;
  final AgenciasDeTurismoModel? infoModel;

  const ProtecaoPage({super.key, required this.controllers, this.infoModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ContainerHeaderToBigTexts(
              title:
                  'Proteção, Qualificação, Certificação, Premiação, destaques e outros'),
          ConditionalFieldsGroup(
              title: 'Do Equipamento/Espaço',
              jsonKey: 'doEquipamento',
              optionModelValue: isUpdate ? infoModel!.doEquipamento : '',
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              children: [
                TabelsEquipamentoEEspaco(
                  getValue: isUpdate ? infoModel!.tabelaEquipamentoEEspaco : {},
                  onChanged: (p0) =>
                      valoresJson['tabelaEquipamentoEEspaco'] = p0,
                )
              ]),
          ConditionalFieldsGroup(
              title: 'Da área ou edificação em que está localizado/instalado ',
              jsonKey: 'areaOuEdificacao',
              optionModelValue: isUpdate ? infoModel!.areaOuEdificacao : '',
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              children: [
                TabelsEquipamentoEEspaco(
                  getValue: isUpdate ? infoModel!.tabelaAreaOuEdificacao : {},
                  onChanged: (p0) => valoresJson['tabelaAreaOuEdificacao'] = p0,
                )
              ]),
          SizedBox(
            height: 35.h,
          ),
          ContainerHeader(title: 'Estado Geral de Conservação'),
          RadioFormField(
            initialValue: isUpdate ? infoModel!.estadoGeralDeConservacao : '',
            onSaved: (newValue) =>
                valoresJson['estadoGeralDeConservacao'] = newValue,
            options: ['Muito Bom', 'Bom', 'Ruim'],
            title: 'Estado Geral de Conservação',
          ),
          SizedBox(
            height: 85.h,
          ),
          SizedBox(
            height: 85.h,
          ),
          ContainerHeader(title: 'Acessibilidade'),
          ConditionalFieldsGroup(
              optionModelValue: isUpdate ? infoModel!.possuiFacilidade : '',
              title:
                  'Possui Alguma Facilidade\npara Pessoas com\nDeficiência\nou Mobilidade Reduzida?',
              jsonKey: 'possuiFacilidade',
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              children: [
                CheckboxGroupFormField(
                  options: [
                    'Não',
                    'Física',
                    'Auditiva',
                    'Visual',
                    'Mental',
                    'Múltipla'
                  ],
                  initialValue: isUpdate
                      ? infoModel!.pessoalCapacitadoParaReceberPCD
                      : [],
                  title:
                      'Pessoal Capacitado Para Receber Pessoas com Deficiência',
                  onSaved: (newValue) =>
                      valoresJson['pessoalCapacitadoParaReceberPCD'] = newValue,
                ),
                CheckboxGroupFormField(
                    title: 'Rota Externa Acessível',
                    onSaved: (newValue) =>
                        valoresJson['rotaExternaAcessivel'] = newValue,
                    initialValue:
                        isUpdate ? infoModel!.rotaExternaAcessivel : [],
                    options: [
                      'Não',
                      'Estacionamento',
                      'Calçada Rebaixada',
                      'Faixa de Pedestre',
                      'Rampa',
                      'Semáforo Sonoro',
                      'Piso Tátil de Alerta',
                      'Piso Regular e Antiderrapante',
                      'Livre de Obstáculos',
                      'outro'
                    ]),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? infoModel!.simboloInternacionalDeAcesso : [],
                    title: 'Símbolo Internacional de Acesso',
                    onSaved: (newValue) =>
                        valoresJson['simboloInternacionalDeAcesso'] = newValue,
                    options: [
                      'Não',
                      'Entrada',
                      'Área Reservada',
                      'Estacionamento',
                      'Área de Embarque e Desembarque',
                      'Sanitário',
                      'Saída de Emergência'
                    ]),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? infoModel!.localDeEmbarqueEDesembarque : [],
                    title: 'Local de Embarque e Desembarque',
                    onSaved: (newValue) =>
                        valoresJson['localDeEmbarqueEDesembarque'] = newValue,
                    options: ['Não', 'Sinalizado', 'Com Acesso em Nível']),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? infoModel!.vagaEmEstacionamento : [],
                    title: 'Vaga em Estacionamento',
                    onSaved: (newValue) =>
                        valoresJson['vagaEmEstacionamento'] = newValue,
                    options: [
                      'Não',
                      'Sinalizada',
                      'Com Acesso em Nível',
                      'Alargada para Cadeira de Rodas',
                      'Rampa de Acesso à Calçada'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate
                        ? infoModel!
                            .areaDeCirculacaoAcessoInternoParaCadeiraDeRodas
                        : [],
                    title:
                        'Área de Circulação/Acesso Interno para Cadeira de Rodas',
                    onSaved: (newValue) => valoresJson[
                            'areaDeCirculacaoAcessoInternoParaCadeiraDeRodas'] =
                        newValue,
                    options: [
                      'Não',
                      'Rampa',
                      'Elevador',
                      'Plataforma Elevatória',
                      'Com Circulação Entre Mobiliário',
                      'Porta Larga',
                      'Piso Regular/Antiderrapante'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.escada : [],
                    title: 'Escada',
                    onSaved: (newValue) => valoresJson['escada'] = newValue,
                    options: [
                      'Não',
                      'Corrimão',
                      'Patamar para Descanso',
                      'Sinalização Tátil de Alerta',
                      'Piso Antiderrapante'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.rampa : [],
                    title: 'Rampa',
                    onSaved: (newValue) => valoresJson['rampa'] = newValue,
                    options: [
                      'Não',
                      'Corrimão',
                      'Patamar para Descanso',
                      'Piso Antiderrapante',
                      'Sinalização Tátil',
                      'Inclinação Adequada'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.piso : [],
                    title: "Piso",
                    onSaved: (newValue) => valoresJson['piso'] = newValue,
                    options: [
                      'Não',
                      'Tátil',
                      'Sem Obstáculos (tapete ou desnível)',
                      'Antiderrapante/Deslizante'
                    ]),
                CheckboxGroupFormField(
                    title: "Elevador",
                    initialValue: isUpdate ? infoModel!.elevador : [],
                    onSaved: (newValue) => valoresJson['elevador'] = newValue,
                    options: [
                      'Não',
                      'Sinalizado em Braille',
                      'Dispositivo Sonoro',
                      'Dispositivo Luminoso',
                      'Sensor Eletrônico (porta)'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate
                        ? infoModel!
                            .equipamentoMotorizadoParaDeslocamentoInterno
                        : [],
                    title: 'Equipamento Motorizado para Deslocamento Interno',
                    onSaved: (newValue) => valoresJson[
                            'equipamentoMotorizadoParaDeslocamentoInterno'] =
                        newValue,
                    options: ['Não', 'Cadeira', 'Carrinho']),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.sinalizacaoVisual : [],
                    title: 'Sinalização Visual',
                    onSaved: (newValue) =>
                        valoresJson['sinalizacaoVisual'] = newValue,
                    options: [
                      'Não',
                      'Entrada',
                      'Recepção',
                      'Porta',
                      'Sanitário',
                      'Elevador',
                      'Restaurante',
                      'Área de Lazer',
                      'Área de Resgate'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.sinalizacaoTatil : [],
                    title: "Sinalização Tátil",
                    onSaved: (newValue) =>
                        valoresJson['sinalizacaoTatil'] = newValue,
                    options: [
                      'Não',
                      'Entrada',
                      'Recepção',
                      'Porta',
                      'Sanitário',
                      'Elevador',
                      'Restaurante',
                      'Área de Lazer',
                      'Área de Resgate'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.alarmeDeEmergencia : [],
                    title: "Alarme de Emergência",
                    onSaved: (newValue) =>
                        valoresJson['alarmeDeEmergencia'] = newValue,
                    options: ['Não', 'Sonoro', 'Visual', 'Vibratório']),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.comunicacao : [],
                    title: "Comunicação",
                    onSaved: (newValue) =>
                        valoresJson['comunicacao'] = newValue,
                    options: [
                      'Não',
                      'Texto Informativo em Braille',
                      'Texto Informativo em Fonte Ampliada',
                      'Intérprete em Libras (língua brasileira de sinais)'
                    ]),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? infoModel!.balcaoDeAtendimento : [],
                    title: "Balcão de Atendimento",
                    onSaved: (newValue) =>
                        valoresJson['balcaoDeAtendimento'] = newValue,
                    options: [
                      'Não',
                      'Rebaixamento',
                      'Preferencial para Pessoas com Deficiência ou Mobilidade Reduzida'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.mobiliario : [],
                    title: "Mobiliário",
                    onSaved: (newValue) => valoresJson['mobiliario'] = newValue,
                    options: ['Não', 'Altura Adequada', 'Recuo Adequado']),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.sanitario : [],
                    title: "Sanitário",
                    onSaved: (newValue) => valoresJson['sanitario'] = newValue,
                    options: [
                      'Não',
                      'Barra de Apoio',
                      'Porta Larga Suficiente Para Entrada de Cadeira de Rodas',
                      'Giro para Cadeira de Rodas',
                      'Acesso para Cadeira de Rodas',
                      'Pia Rebaixada',
                      'Espelho Rebaixado ou com Ângulo de Alcance Visual',
                      'Boxe ou Banheira Adaptada',
                      'Torneira Monocomando/Alavanca'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.telefone : [],
                    title: "Telefone",
                    onSaved: (newValue) => valoresJson['telefone'] = newValue,
                    options: [
                      'Não',
                      'Altura Adequada',
                      'Para Surdos (TPS ou TTS)'
                    ]),
                ConditionalFieldsGroup(
                    optionModelValue:
                        isUpdate ? infoModel!.sinalizacaoIndicativa : '',
                    title:
                        'Sinalização Indicativa\nde Atendimento\nPreferencial para Pessoas\ncom Deficiência ou\nMobilidade Reduzida',
                    jsonKey: 'sinalizacaoIndicativa',
                    valoresJson: valoresJson,
                    isUpdate: isUpdate,
                    children: []),
                CustomTextField(
                  name: 'Outras',
                  controller: controllers['outrosAcessibilidade'],
                ),
              ]),
          SizedBox(
            height: 55.h,
          ),
          ContainerHeader(title: 'Observações e Referências'),
          SizedBox(
            height: 55.h,
          ),
          CustomTextField(
            name: 'Observações',
            controller: controllers['observacoes'],
          ),
          CustomTextField(
            name: 'Referências',
            controller: controllers['referencias'],
          )
        ],
      ),
    );
  }
}
