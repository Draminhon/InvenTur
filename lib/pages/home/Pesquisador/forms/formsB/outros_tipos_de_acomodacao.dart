import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/forms/outros_tipos_de_acomodacao_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/fields.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_widget.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/mapa_widget.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/multi_auto_complete_form_field.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/tables.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/services/form_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/utils/validators.dart';

final Validators _validators = Validators();
final Map<String, dynamic> valoresjson = {
  'tipo_formulario': 'Outros Tipos de Acomodação',
};
bool isUpdate = false;

class OutrosTiposDeAcomodacao extends StatefulWidget {
  final OutrosTiposDeAcomodacaoModel? hospedagemModel;
  const OutrosTiposDeAcomodacao({super.key, this.hospedagemModel});

  @override
  State<OutrosTiposDeAcomodacao> createState() =>
      _OutrosTiposDeAcomodacaoState();
}

class _OutrosTiposDeAcomodacaoState extends State<OutrosTiposDeAcomodacao> {
  int currentStep = 0;

  late List<Widget> pages;

  final _formKey = GlobalKey<FormState>();

  final PageController _pageController = PageController();

  Map<String, TextEditingController> _identificacaoControllers = {};
  Map<String, TextEditingController> _funcionamentoControllers = {};
  Map<String, TextEditingController> _acessibilidadeControllers = {};

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
    'avenidaRuaEtc',
    'bairroLocalidade',
    'distrito',
    'CEP',
    'whatsapp',
    'instagram',
    'email',
    'site',
    'distanciaOutros',
    'pontosDeReferencia',
  ];
  final List<String> _chavesFuncionamento = const [
    'barracaCapacidadeEquipamentos',
    'barracaCapacidadePessoas',
    'trailerCapacidadeEquipamentos',
    'trailerCapacidadePessoas',
    'motorHomeCapacidadeEquipamentos',
    'motorHomeCapacidadePessoas',
    'outrasRegrasEInformacoes',

    'sanitarioEspec',
    'chuveiroQuente',
    'chuveiroFrio',
    'piaParaLouca',
    'tanqueParaRoupas',
    'lavatorio',
    'lixeira',
    'cantina',

    'carretaBarracaCapacidadeEquipamentos',
    'carretaBarracaCapacidadePessoas',
    'campersCapacidadeEquipamentos',
    'campersCapacidadePessoas',
    'nAnoOcupacao',
    'nOcupacaoAltaTemporada',
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
  final List<String> _chavesAcessibilidade = const [
    'outrasAcessibilidade',
    'observacoes',
    'referencias'
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

  void _preencherDadosParaTeste() {
    if (widget.hospedagemModel != null) {
      final model = widget.hospedagemModel!;
      final modelMap = model.toMap();
      _identificacaoControllers.forEach((key, controller) {
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

      _acessibilidadeControllers.forEach(
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
    super.initState();
    getInfoUsersInPesquisa();

    for (final key in _chavesIdentificacao) {
      _identificacaoControllers[key] = TextEditingController();
    }

    for (final key in _chavesFuncionamento) {
      _funcionamentoControllers[key] = TextEditingController();
    }

    for (final key in _chavesAcessibilidade) {
      _acessibilidadeControllers[key] = TextEditingController();
    }

    pages = [
      Identificacao(
        controllers: _identificacaoControllers,
        hospedagemModel: widget.hospedagemModel,
      ),
      Funcionamento(
        controllers: _funcionamentoControllers,
        hospedagemModel: widget.hospedagemModel,
      ),
        Acessibilidade(
          controllers: _acessibilidadeControllers,
          hospedagemModel: widget.hospedagemModel,
        )
    ];
  }

  @override
  void dispose() {
    for (final controller in _identificacaoControllers.values) {
      controller.dispose();
    }
    for (final controller in _funcionamentoControllers.values) {
      controller.dispose();
    }
    for (final controller in _acessibilidadeControllers.values) {
      controller.dispose();
    }
    valoresjson.clear();
    valoresjson['tipo_formulario'] = 'Outros Tipos de Acomodação';
    isUpdate = false;
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

      _acessibilidadeControllers.forEach(
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
        isUpdate
            ? FormService().updateForm(widget.hospedagemModel!.id!, valoresjson,
                AppConstants.OUTROS_MEIOS_DE_HOSPEDAGEM)
            : FormService()
                .sendForm(valoresjson, AppConstants.OUTROS_MEIOS_DE_HOSPEDAGEM);
        print("Formulário finalizado e pronto para enviar!");
      }
    } else {
      _formKey.currentState!.save();
      _identificacaoControllers.forEach((key, controller) {
        valoresjson[key] = controller.text;
      });
      _funcionamentoControllers.forEach(
        (key, value) {
          valoresjson[key] = value.text;
        },
      );
      _acessibilidadeControllers.forEach(
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

class Identificacao extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final OutrosTiposDeAcomodacaoModel? hospedagemModel;

  const Identificacao(
      {super.key, required this.controllers, this.hospedagemModel});

  @override
  State<Identificacao> createState() => _IdentificacaoState();
}

class _IdentificacaoState extends State<Identificacao>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final sizeScreen = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Column(children: [
        ContainerHeader(title: 'Identificação'),
        UfMunicipioRg(controllers: widget.controllers),

        RadioFormField(
          title: 'Tipo',
          options: ['Outro tipo de acomodação'],
          onSaved: (newValue) {
            valoresjson['tipo'] = newValue;
          },
          initialValue: isUpdate == true ? widget.hospedagemModel!.tipo : "",
        ),

        RadioFormField(
          title: 'Subtipos',
          initialValue: isUpdate == true ? widget.hospedagemModel!.subtipo : "",
          options: [
            'Acampamento Turístico/Camping',
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
          controller: widget.controllers['razaoSocial'],
        ),
        CustomTextField(
          controller: widget.controllers['nomeFantasia'],
          name: 'Nome Fantasia',
        ),
        CustomTextField(
          controller: widget.controllers['codigoCNAE'],
          name: 'Código CNAE',
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          controller: widget.controllers['atividadeEconomica'],
          name: 'Atividade econômica',
        ),
        CustomTextField(
          controller: widget.controllers['inscricaoMunicipal'],
          name: 'Inscrição Municipal',
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          controller: widget.controllers['nomeDaRede'],
          name: 'Nome da rede/holding',
        ),
        CustomTextField(
          name: 'CNPJ',
          controller: widget.controllers['CNPJ'],
          //validat: _validators.validarCNPJ,
          formatter: [_validators.cnpjFormatter],
          keyboardType: TextInputType.numberWithOptions(),
        ),

        Column(
          children: [
            RadioFormField(
              title: 'Natureza',
              initialValue:
                  isUpdate == true ? widget.hospedagemModel!.natureza : "",
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
              isUpdate == true ? widget.hospedagemModel!.tipoDeOrganizacao : [],
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
                  dateController: widget.controllers['inicioDaAtividade'],
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
                      controller:
                          widget.controllers['qtdeFuncionariosPermanentes'],
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
                      controller:
                          widget.controllers['qtdeFuncionariosTemporarios'],
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
                      controller:
                          widget.controllers['qtdeFuncionarisComDeficiencia'],
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
          initialValue:
              isUpdate == true ? widget.hospedagemModel!.localizacao : "",
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
        MapaWidget(
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            latitude: widget.hospedagemModel?.latitude??"-3.73",
            longitude: widget.hospedagemModel?.longitude?? "-38.52"),
        textLabel(name: 'Endereço:', fontWeight: FontWeight.bold),

        CustomTextField(
          controller: widget.controllers['avenidaRuaEtc'],
          name: 'avenida/rua/travessa/caminho/outro',
        ),
        CustomTextField(
          controller: widget.controllers['bairroLocalidade'],
          name: 'bairro/localidade',
        ),
        CustomTextField(
          controller: widget.controllers['distrito'],
          name: 'distrito',
        ),
        CustomTextField(
          controller: widget.controllers['CEP'],
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
                    controller: widget.controllers['whatsapp'],
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
                    controller: widget.controllers['instagram'],
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
                    controller: widget.controllers['email'],
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
                    controller: widget.controllers['site'],
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
            optionModelValue:
                isUpdate ? widget.hospedagemModel!.sinalizacaoDeAcesso : '',
            children: []),
        ConditionalFieldsGroup(
            title: 'turística',
            jsonKey: 'sinalizacaoTuristica',
            valoresJson: valoresjson,
            optionModelValue:
                isUpdate ? widget.hospedagemModel!.sinalizacaoTuristica : '',
            isUpdate: isUpdate,
            children: []),

        //  RadioD(number: 6, options: options)
        CheckboxGroupFormField(
          title: 'Proximidades',
          onSaved: (p0) => valoresjson['proximidades'] = p0,
          initialValue:
              isUpdate == true ? widget.hospedagemModel!.proximidades : [],
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

        textLabel(name: 'Pontos de Referência', fontWeight: FontWeight.bold),
        SizedBox(
          height: 20.w,
        ),
        CustomTextField(
          controller: widget.controllers['pontosDeReferencia'],
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
          getValues: isUpdate ? widget.hospedagemModel!.tabelaMTUR : {},
          onChanged: (p0) => valoresjson['tabelaMTUR'] = p0,
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
          initialValue: isUpdate
              ? widget.hospedagemModel!.segmentosOuTurismoEspecializado
              : [],
        )
      ]),
    );
  }
}

class Funcionamento extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final OutrosTiposDeAcomodacaoModel? hospedagemModel;
  const Funcionamento(
      {super.key, this.hospedagemModel, required this.controllers});

  @override
  State<Funcionamento> createState() => _FuncionamentoState();
}

class _FuncionamentoState extends State<Funcionamento>
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
        initialValue: isUpdate ? widget.hospedagemModel!.estadosTuristas : [],
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
          valoresjson['estadosTuristas'] = newValue;
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
        initialValue: isUpdate ? widget.hospedagemModel!.paisesTuristas : [],
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
          valoresjson['paisesTuristas'] = newValue;
        },
        validator: (values) {
          // if (values == null || values.isEmpty) {
          //   return 'Por favor, selecione pelo menos um pais.';
          // }
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
        name: 'Equipamentos de Acomodação',
        fontWeight: FontWeight.bold,
      ),

      ConditionalFieldsGroup(
          title: 'Barraca',
          jsonKey: 'barraca',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          optionModelValue: isUpdate ? widget.hospedagemModel!.barraca : "",
          children: [
            CustomTextField(
              name: 'Capacidade de Equipamentos(nº)',
              controller: widget.controllers['barracaCapacidadeEquipamentos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Capacidade de Pessoas(nº)',
              controller: widget.controllers['barracaCapacidadePessoas'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'Trailer',
          jsonKey: 'trailer',
          optionModelValue: isUpdate ? widget.hospedagemModel!.trailer : "",
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: [
            CustomTextField(
              name: 'Capacidade de Equipamentos(nº)',
              controller: widget.controllers['trailerCapacidadeEquipamentos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Capacidade de Pessoas(nº)',
              controller: widget.controllers['trailerCapacidadePessoas'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ]),
      ConditionalFieldsGroup(
        optionModelValue: isUpdate ? widget.hospedagemModel!.motorHome : "",
          title: 'Motor-Home',
          jsonKey: 'motorHome',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: [
            CustomTextField(
              name: 'Capacidade de Equipamentos(nº)',
              controller: widget.controllers['motorHomeCapacidadeEquipamentos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Capacidade de Pessoas(nº)',
              controller: widget.controllers['motorHomeCapacidadePessoas'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ]),
      ConditionalFieldsGroup(
        optionModelValue: isUpdate ? widget.hospedagemModel!.carretaBarraca : "",
          title: 'Carreta-Barraca',
          jsonKey: 'carretaBarraca',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: [
            CustomTextField(
              name: 'Capacidade de Equipamentos(nº)',
              controller:
                  widget.controllers['carretaBarracaCapacidadeEquipamentos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Capacidade de Pessoas(nº)',
              controller: widget.controllers['carretaBarracaCapacidadePessoas'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ]),
      ConditionalFieldsGroup(
        optionModelValue: isUpdate ? widget.hospedagemModel!.campers : "",
          title: 'Campers',
          jsonKey: 'campers',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: [
            CustomTextField(
              name: 'Capacidade de Equipamentos(nº)',
              controller: widget.controllers['campersCapacidadeEquipamentos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Capacidade de Pessoas(nº)',
              controller: widget.controllers['campersCapacidadePessoas'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ]),
      RadioFormField(
        
          title: 'Área de Acampamento',
          initialValue: isUpdate ? widget.hospedagemModel!.areaAcampamento! : "",
          onSaved: (newValue) => valoresjson['areaAcampamento'] = newValue,
          options: ['Pavimentada', 'Brita', 'Gramada', 'Areia', 'outro']),
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
        name: 'Instalações Básicas',
        fontWeight: FontWeight.bold,
      ),

      CustomTextField(
        name: 'Sanitário (qtde)',
        controller: widget.controllers['sanitarioEspec'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        name: 'Chuveiro Quente (qtde)',
        controller: widget.controllers['chuveiroQuente'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        name: 'Chuveiro Frio (qtde)',
        controller: widget.controllers['chuveiroFrio'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        name: 'Pia para Louça (qtde)',
        controller: widget.controllers['piaParaLouca'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        name: 'Tanque para Roupas (qtde)',
        controller: widget.controllers['tanqueParaRoupas'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        name: 'Lavatório (qtde)',
        controller: widget.controllers['lavatorio'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        name: 'Lixeira (qtde)',
        controller: widget.controllers['lixeira'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        name: 'Cantina (qtde)',
        controller: widget.controllers['cantina'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
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

      ConditionalFieldsGroup(
          title: 'Instalações Elétricas',
          jsonKey: 'instalacoesEletricas',
          valoresJson: valoresjson,
          optionModelValue: isUpdate ? widget.hospedagemModel!.instalacoesEletricas! :"",
          isUpdate: isUpdate,
          children: [
            ConditionalFieldsGroup(
                optionModelValue: isUpdate ? widget.hospedagemModel!.pontosDeEnergia! : "",
                title: 'Pontos de Energia',
                jsonKey: 'pontosDeEnergia',
                valoresJson: valoresjson,
                isUpdate: isUpdate,
                children: []),
            ConditionalFieldsGroup(
                optionModelValue: isUpdate ? widget.hospedagemModel!.pontosDeEnergiaIdentificados! : "",

                title: 'Pontos de Energia Identificados nos Módulos',
                jsonKey: 'pontosDeEnergiaIdentificados',
                valoresJson: valoresjson,
                isUpdate: isUpdate,
                children: []),
            ConditionalFieldsGroup(
                optionModelValue: isUpdate ? widget.hospedagemModel!.tomadasDeEnergiaIdentificadas! : "",

                title:
                    'Tomadas de Energia Identificadas na Área de Acampamento',
                jsonKey: 'tomadasDeEnergiaIdentificadas',
                valoresJson: valoresjson,
                isUpdate: isUpdate,
                children: []),
            ConditionalFieldsGroup(
                optionModelValue: isUpdate ? widget.hospedagemModel!.medidoresIndividuais! : "",

                title: 'Medidores Individuais de Energia',
                jsonKey: 'medidoresIndividuais',
                valoresJson: valoresjson,
                isUpdate: isUpdate,
                children: [])
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Água',
        fontWeight: FontWeight.bold,
      ),

      ConditionalFieldsGroup(
        optionModelValue: isUpdate ? widget.hospedagemModel!.instalacoesHidraulicas : "",
          title: 'Instalações Hidráulicas',
          jsonKey: 'instalacoesHidraulicas',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),

      ConditionalFieldsGroup(
        optionModelValue: isUpdate ? widget.hospedagemModel!.pontosDeAgua : "",
          title: 'Pontos de Água nos Módulos',
          jsonKey: 'pontosDeAgua',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),
      ConditionalFieldsGroup(
                optionModelValue: isUpdate ? widget.hospedagemModel!.aguaPotavel! : "",

          title: 'Água Potável (reservatório ou rede pública)',
          jsonKey: 'aguaPotavel',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),
      SizedBox(
        height: 55.h,
      ),
      CheckboxGroupFormField(
          initialValue: isUpdate?widget.hospedagemModel!.equipamentosEServicos!: [],
          onSaved: (newValue) =>
              valoresjson['equipamentosEServicos'] = newValue,
          title: 'Equipamentos e Serviços',
          options: [
            'Aluguel de barracas',
            'Aluguel de equipamento de esporte e lazer',
            'Aluguel de trailers',
            'TV com canal por assinatura',
            'Internet',
            'Telefone público',
            'Portaria 24h',
            'Churrasqueira',
            'Cozinha',
            'Máquina de lavar pratos',
            'Cofre',
            'Equipamentos de combate a incêndios',
            'Iluminação artificial nas áreas sociais',
            'Iluminação artificial nas vias de acesso',
            'Iluminação artificial nas instalações sanitárias',
            'Iluminação artificial na área de acampamento',
            'Registro e controle de campistas',
            'Para-raio',
            'Sinalização na entrada do acampamento com indicação de vagas',
            'Sinalização nas vias internas',
            'Serviço de coleta diária de lixo',
            'Serviço de limpeza',
            'Serviços e equipamentos de segurança',
            'Serviço de vigilância e guarda do acampamento/camping',
            'Ambulatório médico',
            'Esgoto tratado',
            'Coleta seletiva de resíduos',
            'Coleta de esgoto nos módulos',
            'Coleta de água servida para veículos',
            'Coleta de detritos sanitários para veículos',
            'Módulos demarcados para veículos',
            'Módulos demarcados para barracas',
            'outro'
          ]),
      SizedBox(height: 55.h),
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
          'Observação de fauna',
          'Observação de flora',
          'Visita à produção agrícola',
          'Degustação gastronômica',
          'Atividades pedagógicas',
          'Atividades equestres/passeios em cavalo/cavalgadas',
          'Passeios em barcos e lanchas',
          'Passeios em embarcações alugadas',
          'Passeios para cinemas e teatros',
          'Passeios para compras',
          'Realização de cursos, seminários, feiras',
          'Recreação programada para crianças',
          'Recreação programada para adultos',
          'Recreação programada para participantes de convenções',
          'Lago panorâmico',
          'Competições de pesca',
          'Pesca amadora',
          'Mergulho livre/equipamentos para mergulho',
          'Pedalinhos',
          'Banana boat',
          'Jet ski',
          'Esqui aquático',
          'Tirolesa',
          'Arvorismo',
          'Caminhadas/trilhas interpretativas',
          'Mini-zoo',
          'Fazendinha',
          'Horta',
          'Área verde para lazer',
          'Aula de tênis',
          'Organização de eventos esportivos',
          'Peregrinações e romarias',
          'Retiros espirituais',
          'Venda de souvenir e produtos típicos',
          'Passeios para festas, festivais, celebrações locais e manifestações populares',
          'Passeios para estâncias hidrominerais, spas, balneários, resorts, clínicas naturalistas',
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
        CheckboxGroupFormField(
            title: 'Utilização',
            initialValue: isUpdate ? widget.hospedagemModel!.utilizacao! : [],
            onSaved: (newValue) => valoresjson['utilizacao'] = newValue,
            options: ['Eventos promovidos',
         'Aluguel de espaço para eventos',
          'Organização de eventos',
           'Serviço de alimentação para evento',
            'Aluguel de equipamentos',
             'outro']),
      SizedBox(
        height: sizeScreen.height * 0.02,
      )
    ]));
  }
}

class Acessibilidade extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final OutrosTiposDeAcomodacaoModel? hospedagemModel;
  const Acessibilidade(
      {super.key, required this.controllers, this.hospedagemModel});

  @override
  State<Acessibilidade> createState() => _AcessibilidadeState();
}

class _AcessibilidadeState extends State<Acessibilidade>
    with AutomaticKeepAliveClientMixin {
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
          ContainerHeaderToBigTexts(
              title:
                  'Proteção, Qualificação, Certificação, Premiação, Destaques e Outros'),
          SizedBox(
            height: sizeScreen.height * 0.05,
          ),
          ConditionalFieldsGroup(
            optionModelValue: isUpdate == true
                ? widget.hospedagemModel!.doEquipamentoEspaco
                : "não",
            title: 'Do Equipamento/Espaço',
            jsonKey: 'doEquipamentoEspaco',
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            children: [
              TabelsEquipamentoEEspaco(
                getValue: isUpdate == true
                    ? widget.hospedagemModel!.tabelaEquipamentoEEspaco
                    : {},
                onChanged: (p0) {
                  valoresjson['tabelaEquipamentoEEspaco'] = p0;
                },
              ),
            ],
          ),
          ConditionalFieldsGroup(
            optionModelValue: isUpdate == true
                ? widget.hospedagemModel!.daAreaOuEdificacaoEmQueEstaLocalizado
                : "não",
            isUpdate: isUpdate,
            jsonKey: 'daAreaOuEdificacaoEmQueEstaLocalizado',
            title: 'Da Área ou Edificação em que Está Localizado/Instalado',
            valoresJson: valoresjson,
            children: [
              TabelsEquipamentoEEspaco(
                getValue: isUpdate == true
                    ? widget.hospedagemModel!.tabelaEquipamentoEEspaco2
                    : {},
                onChanged: (p0) {
                  valoresjson['tabelaEquipamentoEEspaco2'] = p0;
                },
              ),
            ],
          ),
          SizedBox(
            height: sizeScreen.height * 0.05,
          ),
          ContainerHeader(title: 'Estado Geral de Conservação'),
          SizedBox(
            height: 55.h,
          ),
          RadioFormField(
            initialValue: isUpdate == true
                ? widget.hospedagemModel!.estadoGeralDeConservacao
                : "",
            options: ['Muito bom', 'Bom', 'Ruim'],
            onSaved: (newValue) {
              valoresjson['estadoGeralDeConservacao'] = newValue;
            },
          ),
          SizedBox(
            height: 55.h,
          ),
          ContainerHeader(title: 'Acessibilidade'),
          ConditionalFieldsGroup(
              optionModelValue:
                  isUpdate ? widget.hospedagemModel!.possuiFacilidade : '',
              title:
                  'Possui Alguma Facilidade\npara Pessoas com\nDeficiência\nou Mobilidade Reduzida?',
              jsonKey: 'possuiFacilidade',
              valoresJson: valoresjson,
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
                      ? widget.hospedagemModel!.pessoalCapacitadoParaReceberPCD
                      : [],
                  title:
                      'Pessoal Capacitado Para Receber Pessoas com Deficiência',
                  onSaved: (newValue) =>
                      valoresjson['pessoalCapacitadoParaReceberPCD'] = newValue,
                ),
                CheckboxGroupFormField(
                    title: 'Rota Externa Acessível',
                    onSaved: (newValue) =>
                        valoresjson['rotaExternaAcessivel'] = newValue,
                    initialValue: isUpdate
                        ? widget.hospedagemModel!.rotaExternaAcessivel
                        : [],
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
                    initialValue: isUpdate
                        ? widget.hospedagemModel!.simboloInternacionalDeAcesso
                        : [],
                    title: 'Símbolo Internacional de Acesso',
                    onSaved: (newValue) =>
                        valoresjson['simboloInternacionalDeAcesso'] = newValue,
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
                    initialValue: isUpdate
                        ? widget.hospedagemModel!.localDeEmbarqueEDesembarque
                        : [],
                    title: 'Local de Embarque e Desembarque',
                    onSaved: (newValue) =>
                        valoresjson['localDeEmbarqueEDesembarque'] = newValue,
                    options: ['Não', 'Sinalizado', 'Com Acesso em Nível']),
                CheckboxGroupFormField(
                    initialValue: isUpdate
                        ? widget.hospedagemModel!.vagaEmEstacionamento
                        : [],
                    title: 'Vaga em Estacionamento',
                    onSaved: (newValue) =>
                        valoresjson['vagaEmEstacionamento'] = newValue,
                    options: [
                      'Não',
                      'Sinalizada',
                      'Com Acesso em Nível',
                      'Alargada para Cadeira de Rodas',
                      'Rampa de Acesso à Calçada'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate
                        ? widget.hospedagemModel!.areaDeCirculacaoAcessoInterno
                        : [],
                    title:
                        'Área de Circulação/Acesso Interno para Cadeira de Rodas',
                    onSaved: (newValue) =>
                        valoresjson['areaDeCirculacaoAcessoInterno'] = newValue,
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
                    initialValue:
                        isUpdate ? widget.hospedagemModel!.escada : [],
                    title: 'Escada',
                    onSaved: (newValue) => valoresjson['escada'] = newValue,
                    options: [
                      'Não',
                      'Corrimão',
                      'Patamar para Descanso',
                      'Sinalização Tátil de Alerta',
                      'Piso Antiderrapante'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? widget.hospedagemModel!.rampa : [],
                    title: 'Rampa',
                    onSaved: (newValue) => valoresjson['rampa'] = newValue,
                    options: [
                      'Não',
                      'Corrimão',
                      'Patamar para Descanso',
                      'Piso Antiderrapante',
                      'Sinalização Tátil',
                      'Inclinação Adequada'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? widget.hospedagemModel!.piso : [],
                    title: "Piso",
                    onSaved: (newValue) => valoresjson['piso'] = newValue,
                    options: [
                      'Não',
                      'Tátil',
                      'Sem Obstáculos (tapete ou desnível)',
                      'Antiderrapante/Deslizante'
                    ]),
                CheckboxGroupFormField(
                    title: "Elevador",
                    initialValue:
                        isUpdate ? widget.hospedagemModel!.elevador : [],
                    onSaved: (newValue) => valoresjson['elevador'] = newValue,
                    options: [
                      'Não',
                      'Sinalizado em Braille',
                      'Dispositivo Sonoro',
                      'Dispositivo Luminoso',
                      'Sensor Eletrônico (porta)'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate
                        ? widget.hospedagemModel!
                            .equipamentoMotorizadoParaDeslocamentoInterno
                        : [],
                    title: 'Equipamento Motorizado para Deslocamento Interno',
                    onSaved: (newValue) => valoresjson[
                            'equipamentoMotorizadoParaDeslocamentoInterno'] =
                        newValue,
                    options: ['Não', 'Cadeira', 'Carrinho']),
                CheckboxGroupFormField(
                    initialValue: isUpdate
                        ? widget.hospedagemModel!.sinalizacaoVisual
                        : [],
                    title: 'Sinalização Visual',
                    onSaved: (newValue) =>
                        valoresjson['sinalizacaoVisual'] = newValue,
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
                    initialValue: isUpdate
                        ? widget.hospedagemModel!.sinalizacaoTatil
                        : [],
                    title: "Sinalização Tátil",
                    onSaved: (newValue) =>
                        valoresjson['sinalizacaoTatil'] = newValue,
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
                    initialValue: isUpdate
                        ? widget.hospedagemModel!.alarmeDeEmergencia
                        : [],
                    title: "Alarme de Emergência",
                    onSaved: (newValue) =>
                        valoresjson['alarmeDeEmergencia'] = newValue,
                    options: ['Não', 'Sonoro', 'Visual', 'Vibratório']),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? widget.hospedagemModel!.comunicacao : [],
                    title: "Comunicação",
                    onSaved: (newValue) =>
                        valoresjson['comunicacao'] = newValue,
                    options: [
                      'Não',
                      'Texto Informativo em Braille',
                      'Texto Informativo em Fonte Ampliada',
                      'Intérprete em Libras (língua brasileira de sinais)'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate
                        ? widget.hospedagemModel!.balcaoDeAtendimento
                        : [],
                    title: "Balcão de Atendimento",
                    onSaved: (newValue) =>
                        valoresjson['balcaoDeAtendimento'] = newValue,
                    options: [
                      'Não',
                      'Rebaixamento',
                      'Preferencial para Pessoas com Deficiência ou Mobilidade Reduzida'
                    ]),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? widget.hospedagemModel!.mobiliario : [],
                    title: "Mobiliário",
                    onSaved: (newValue) => valoresjson['mobiliario'] = newValue,
                    options: ['Não', 'Altura Adequada', 'Recuo Adequado']),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? widget.hospedagemModel!.sanitario : [],
                    title: "Sanitário",
                    onSaved: (newValue) => valoresjson['sanitario'] = newValue,
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
                    initialValue:
                        isUpdate ? widget.hospedagemModel!.telefone : [],
                    title: "Telefone",
                    onSaved: (newValue) => valoresjson['telefone'] = newValue,
                    options: [
                      'Não',
                      'Altura Adequada',
                      'Para Surdos (TPS ou TTS)'
                    ]),
                ConditionalFieldsGroup(
                    optionModelValue: isUpdate
                        ? widget.hospedagemModel!.sinalizacaoIndicativa
                        : '',
                    title:
                        'Sinalização Indicativa\nde Atendimento\nPreferencial para Pessoas\ncom Deficiência ou\nMobilidade Reduzida',
                    jsonKey: 'sinalizacaoIndicativa',
                    valoresJson: valoresjson,
                    isUpdate: isUpdate,
                    children: []),
                CustomTextField(
                  name: 'Outras',
                  controller: widget.controllers['outrasAcessibilidade'],
                ),
                SizedBox(
                  height: 55.h,
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
            controller: widget.controllers['observacoes'],
          ),
          CustomTextField(
            name: 'Referências',
            controller: widget.controllers['referencias'],
          )
        ],
      ),
    );
  }
}
