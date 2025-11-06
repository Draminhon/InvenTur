import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/controllers/pesquisa_controller.dart';
import 'package:inventur/models/forms/forms%20B/parques_model.dart';
import 'package:inventur/ui/widgets/widgets/checkBox.dart';
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

final Validators _validators = Validators();
final Map<String, dynamic> valoresjson = {
  'tipo_formulario': 'Parques',
};
bool isUpdate = false;

class Parques extends StatefulWidget {
  final ParquesModel? hospedagemModel;
  const Parques({super.key, this.hospedagemModel});

  @override
  State<Parques> createState() => _ParquesState();
}

class _ParquesState extends State<Parques> {
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
    'areaTotalDoEstabelecimento',
    'instagram',
    'email',
    'site',
    'distanciaOutros',
    'pontosDeReferencia',
    'entidadeManetedora',
    'entidadeManetedoraEmail',
    'entidadeManetedoraSite',
  ];
  final List<String> _chavesFuncionamento = const [
    'outrasRegrasEInformacoes',
    'nAnoOcupacao',
    'nOcupacaoAltaTemporada',
    'nCapacidadeDeVeiculos',
    'nAutomoveis',
    'nOnibus',
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
    valoresjson['tipo_formulario'] = 'Parques';
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
            ? FormService().updateForm(
                widget.hospedagemModel!.id!, valoresjson, AppConstants.PARQUES)
            : FormService().sendForm(valoresjson, AppConstants.PARQUES);
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
  final ParquesModel? hospedagemModel;

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
          options: ['Parques'],
          onSaved: (newValue) {
            valoresjson['tipo'] = newValue;
          },
          initialValue: isUpdate == true ? widget.hospedagemModel!.tipo : "",
        ),

        CheckboxGroupFormField(
          title: 'Subtipos',
          initialValue: isUpdate == true ? widget.hospedagemModel!.subtipo : [],
          options: [
            'Aquático',
            'Temático',
            'Diversões',
            'outro',
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

        CustomTextField(
          name: 'Área Total do Estabelecimento (m²)',
          controller: widget.controllers['areaTotalDoEstabelecimento'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),

        RadioFormField(
          options: [
            'Aventura',
            'Histórico',
            'Infantil',
            'Água',
            'Multitemático',
            'outro'
          ],
          initialValue:
              isUpdate ? widget.hospedagemModel!.ambientacaoTematica : "",
          title: 'Ambientação Temática Principal',
          onSaved: (newValue) => valoresjson['ambientacaoTematica'] = newValue,
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

        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "Entidade Manetedora",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          name: 'Entidade Manetedora',
          controller: widget.controllers['entidadeManetedora'],
        ),

        CustomTextField(
          name: 'Email',
          controller: widget.controllers['entidadeManetedoraEmail'],
        ),

        CustomTextField(
          name: 'Site',
          controller: widget.controllers['entidadeManetedoraSite'],
        ),
      ]),
    );
  }
}

class Funcionamento extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final ParquesModel? hospedagemModel;
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
        name: 'Estrutura de funcionamento',
        fontWeight: FontWeight.bold,
      ),

      ConditionalFieldsGroup(
          title: 'Entrada Gratuita',
          jsonKey: 'entradaGratuita',
          optionModelValue:
              isUpdate ? widget.hospedagemModel!.entradaGratuita : '',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),

      ConditionalFieldsGroup(
          title: 'Entrada Paga',
          jsonKey: 'entradaPaga',
          options: ['Inteira', 'Completa'],
          optionModelValue: isUpdate ? widget.hospedagemModel!.entradaPaga : '',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),

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
        name: 'Outras Instalações, Equipamentos e Serviços',
        fontWeight: FontWeight.bold,
      ),

      CheckboxGroupFormField(
        initialValue:
            isUpdate == true ? widget.hospedagemModel!.outrasIntalacoes : [],
        onSaved: (p0) => valoresjson['outrasIntalacoes'] = p0,
        options: [
          'Área de exposição coberta',
          'Área de exposição não coberta',
          'Sistema de amplificação',
          'Sala de descanso',
          'Sala de imprensa',
          'Som ambiente',
          'Sinalização interna',
          'Saída de emergência',
          'Iluminação noturna',
          'Instalações sanitárias',
          'Piso antiderrapante',
          'Palco para eventos',
          'Quadra polivalente',
          'Detector de metais',
          'Grade ou proteção',
          'Refletores',
          'Telões',
          'Bebedouro',
          'Chafariz',
          'Coreto',
          'Fraldário',
          'Guarda-volume',
          'Loja de souvenir',
          'Caixa eletrônico',
          'Hospedagem',
          'Restaurante',
          'Bar/lanchonete',
          'Telefone público',
          'Achados e perdidos',
          'Disponibilidade de carrinho de bebê',
          'Disponibilidade de cadeira de rodas',
          'outro'
        ],
      ),

      CheckboxGroupFormField(
          options: [
            'Arcade games',
            'Evolution',
            'Teatro',
            'Barco viking',
            'Jogos eletrônicos',
            'Roda-gigante',
            'Barco',
            'Labirinto',
            'Rotor',
            'Brinquedo com reboque',
            'Brinquedo educativo',
            'Brinquedo giratório',
            'Montanha-russa aquática',
            'Montanha-russa',
            'Quadra poliesportiva',
            'Show temático',
            'Carrossel',
            'Simuladores diversos',
            'Campo de futebol',
            'Kartódromo',
            'Carro de bate-bate',
            'Casa assombrada',
            'Parede de escalada',
            'Teleférico',
            'Cascata',
            'Piscina adulto',
            'Piscina olímpica',
            'Piscina infantil',
            'Piscina com ondas',
            'Piscina semiolímpica',
            'Tobogã',
            'Toboágua altura alta',
            'Toboágua altura média',
            'Toboágua altura baixa',
            'Torre aquática alta',
            'Torre aquática média',
            'Torre aquática baixa',
            'Cataclisma',
            'Catapulta',
            'Cinema',
            'Pula-pula aquático',
            'Escorregadores',
            'Playground aquático',
            'Playground',
            'Elevador (brinquedos)',
            'Trem-fantasma',
            'Trenzinho',
            'Aquário',
            'Zoológico',
            'Galeria',
            'Hidromassagem',
            'Sauna',
            'outro'
          ],
          title: 'Outros Equipamentos e Espaços',
          initialValue: isUpdate
              ? widget.hospedagemModel!.outrosEquipamentosEEspacos
              : [],
          onSaved: (newValue) =>
              valoresjson['outrosEquipamentosEEspacos'] = newValue),

      SizedBox(
        height: sizeScreen.height * 0.02,
      )
    ]));
  }
}

class Acessibilidade extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final ParquesModel? hospedagemModel;
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
