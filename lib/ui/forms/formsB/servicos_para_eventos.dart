import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sistur/controllers/pesquisa_controller.dart';
import 'package:sistur/models/forms/forms%20B/servicos_para_eventos_model.dart';
import 'package:sistur/ui/widgets/widgets/checkBox.dart';
import 'package:sistur/ui/widgets/widgets/fields.dart';
import 'package:sistur/ui/widgets/container_widget.dart';
import 'package:sistur/ui/widgets/text%20fields/customOutro.dart';
import 'package:sistur/ui/widgets/text%20fields/customTextField.dart';
import 'package:sistur/ui/widgets/maps/mapa_widget.dart';
import 'package:sistur/ui/widgets/radioButton.dart';
import 'package:sistur/ui/widgets/text%20fields/tables.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sistur/utils/utils_functions.dart';
import 'package:sistur/validators/validators.dart';

final Validators _validators = Validators();
final Map<String, dynamic> valoresjson = {
  'tipo_formulario': 'Serviço para Eventos',
};
bool isUpdate = false;

class ServicosParaEventos extends StatefulWidget {
  final ServicosParaEventosModel? hospedagemModel;
  final bool? isAdmin;
  const ServicosParaEventos({super.key, this.hospedagemModel, this.isAdmin});

  @override
  State<ServicosParaEventos> createState() => _ServicosParaEventosState();
}

class _ServicosParaEventosState extends State<ServicosParaEventos> {
  int currentStep = 0;
  int pesquisadorId = 0;
  bool isTheOwner = false;
  final UtilsFunctions _utils = UtilsFunctions();
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
    'outrasRegrasEInformacoes',
    'outrosOutros'
  ];
  final List<String> _chavesAcessibilidade = const [
    'outrasAcessibilidade',
    'observacoes',
    'referencias'
  ];

 

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
      _utils.getInfoUsersInPesquisa(valoresjson, widget.isAdmin??false)
        .then(
          (value) => setState(() {
            pesquisadorId = value;
          }),
        )
        .then(
          (value) => setState(() {
            if (widget.hospedagemModel != null) {
              print("chamando funcao");
              isTheOwner = _utils.isTheOwner(
                  pesquisadorId, widget.hospedagemModel!.usuario_criador!,widget.isAdmin??false,context);
            }
          }),
        );
    super.initState();

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
    valoresjson['tipo_formulario'] = 'Serviço para Eventos';
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

        _utils.decideSendingOrUpdating(isUpdate, isTheOwner, context, widget.hospedagemModel?.id ?? 0, valoresjson, AppConstants.SERVICO_PARA_EVENTOS);

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
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(bottom: 20.h),
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
            ),
          // Espaçador para alinhar o botão Continuar à direita quando não houver o Voltar
          if (currentStep == 0) const Spacer(),

          // Botão Continuar / Finalizar
          SafeArea(
            child: Container(
              height: 160.h,
              width: 550.w,
              margin: currentStep > 0
                  ? EdgeInsets.only(bottom: 20.h)
                  : EdgeInsets.only(bottom: 20.h, right: 55.w),
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
            ),
          )
        ]));
  }
}

class Identificacao extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final ServicosParaEventosModel? hospedagemModel;

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
          options: ['Serviços para eventos'],
          onSaved: (newValue) {
            valoresjson['tipo'] = newValue;
          },
          initialValue: isUpdate == true ? widget.hospedagemModel!.tipo : "",
        ),

        RadioFormField(
          title: 'Subtipos',
          initialValue: isUpdate == true ? widget.hospedagemModel!.subtipo : "",
          options: [
            'Organizadora',
            'Promotora',
            'Outros serviços especializados',
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
              latitude: widget.hospedagemModel?.latitude ?? "Não Informado",
              longitude: widget.hospedagemModel?.longitude ?? "Não Informado"),
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
      ]),
    );
  }
}

class Funcionamento extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final ServicosParaEventosModel? hospedagemModel;
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


    
      SizedBox(
        height: 50.w,
      ),

      ContainerHeader(title: 'Características'),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),

      CheckboxGroupFormField(options: [
        'Eventos sociais (casamentos, formaturas, aniversários e outros)',
        'Eventos corporativos, institucionais, científico, profissionais, promocionais (oficinas, seminários, confraternizações, congressos, simpósios, salões, feiras, exposições e outros)',
        'Eventos esportivos',
        'Eventos culturais e artísticos (shows, festivais, exposições e outros)',
        'outro',
      ],
      title: 'Atividades Básicas',
      initialValue: isUpdate ? widget.hospedagemModel!.atividadesBasicas : [],
      onSaved: (newValue) => valoresjson['atividadesBasicas'] = newValue,
      ),
     
      CheckboxGroupFormField(
          title: 'Outras Atividades e Serviços',
          initialValue:
              isUpdate ? widget.hospedagemModel!.equipamentosEServicos : [],
          onSaved: (newValue) =>
              valoresjson['equipamentosEServicos'] = newValue,
          options: [
            'Captação de eventos',
            'Planejamento de eventos',
            'Administração de eventos',
            'Cerimonial',
            'Secretaria preparatória',
            'Secretaria operacional',
            'Secretaria during o evento',
            'Secretaria pós-evento',
            'Serviço de café/buffet',
            'Manobrista',
            'Recepcionista',
            'Limpeza',
            'Sinalização',
            'Filmagem',
            'Fotografia',
            'Gravação',
            'Recrutamento de pessoal',
            'Recreação/animação',
            'Efeitos especiais e pirotécnicos',
            'Locação de telões',
            'Gestão',
            'Organização',
            'Promoção',
            'Coordenação',
            'Operacionalização',
            'Produção',
            'Assessoria de eventos',
            'Locação de projetor multimídia',
            'Locação e montagem de equipamentos de som',
            'Locação e montagem de tendas e estandes',
            'Locação e montagem de equipamentos de iluminação',
            'Locação e montagem de equipamento de tradução simultânea',
            'Locação e montagem de estruturas para shows',
            'Locação e montagem de banheiros químicos',
            'Locação e montagem de brinquedos',
            'Locação e montagem de equipamentos de videoconferência',
            'Locação e montagem de camarins',
            'Locação de espaços',
            'Locação de mobiliário',
            'Locação de utensílios',
            'outro'
          ]),

    
    ]));
  }
}

class Acessibilidade extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final ServicosParaEventosModel? hospedagemModel;
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

    return SingleChildScrollView(
      child: Column(
        children: [

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
