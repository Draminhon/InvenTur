import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/models/forms/Forms%20C/gastronomia_artesanato_trabalhos_manuais_model.dart';
import 'package:inventur/ui/widgets/container_widget.dart';
import 'package:inventur/ui/widgets/radioButton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/ui/widgets/text%20fields/customOutro.dart';
import 'package:inventur/ui/widgets/text%20fields/tables.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/services/form_service.dart';
import 'package:inventur/ui/widgets/widgets/checkBox.dart';
import 'package:inventur/utils/app_constants.dart';
import '../../widgets/text fields/customTextField.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:inventur/controllers/pesquisa_controller.dart';
import 'package:inventur/ui/widgets/widgets/fields.dart';

final Map<String, dynamic> valoresjson = {
  'tipo_formulario': 'Gastronomia e Artesanato',
};
bool isUpdate = false;

class GastronomiaArtesanatoTrabalhosManuais extends StatefulWidget {
  final GastronomiaArtesanatoTrabalhosManuaisModel? hospedagemModel;
  const GastronomiaArtesanatoTrabalhosManuais(
      {super.key, this.hospedagemModel});

  @override
  State<GastronomiaArtesanatoTrabalhosManuais> createState() =>
      _GastronomiaArtesanatoTrabalhosManuaisState();
}

class _GastronomiaArtesanatoTrabalhosManuaisState
    extends State<GastronomiaArtesanatoTrabalhosManuais> {
  List<TabelaGastronomiaArtesanato> sections = [TabelaGastronomiaArtesanato()];
  List<TabelaGastronomiaArtesanato2> sections2 = [
    TabelaGastronomiaArtesanato2()
  ];

  int currentStep = 0;
  int qtdeInfo = 0;
  int qtdeServicosEspecializados = 0;
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
    'nomeOficial',
    'nomeProduto',
    'historicoProduto01',
    'historicoProduto02',
    'historicoProduto03',
    'historicoProduto04',
    'modoPreparo01',
    'modoPreparo02',
    'modoPreparo03',
    'modoPreparo04'
  ];
  final List<String> _chavesFuncionamento = const [
    'outrasRegrasEInformacoes',
    'nAnoOcupacao',
    'nOcupacaoAltaTemporada',
    'nTotalDeUH',
    'nTotalDeLeitos',
    'nUhAdaptadasParaPCD',
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
    'instalacoesOutras',
    'anoBase',
    'roteiro1',
    'siteRoteiro1',
    'roteiro2',
    'siteRoteiro2',
    'roteiro3',
    'siteRoteiro3',
    'roteiro4',
    'siteRoteiro4',
    'roteiro5',
    'siteRoteiro5',
    'Guia1',
    'siteGuia1',
    'Guia2',
    'siteGuia2',
    'Guia3',
    'siteGuia3',
    'Guia4',
    'siteGuia4',
    'Guia5',
    'siteGuia5',
    'descritivoEspecialidades'
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
      if (widget.hospedagemModel!.contatos != null) {
        qtdeInfo = widget.hospedagemModel!.contatos!.length;
        qtdeServicosEspecializados =
            widget.hospedagemModel!.servicosEspecializados!.length;
      }

      if (qtdeInfo >= 0) {
        for (int i = 1; i < qtdeInfo; i++) {
          sections.add(TabelaGastronomiaArtesanato());
        }
        for (int i = 0; i < qtdeInfo; i++) {
          if (i < widget.hospedagemModel!.contatos!.length) {
            var contato = widget.hospedagemModel!.contatos![i];
            sections[i].fillForm(contato.nome_completo!, contato.atelie_aberto!,
                contato.endereco!, contato.email!, contato.telefone!);
          }
        }
      }

      if (qtdeServicosEspecializados >= 0) {
        for (int i = 1; i < qtdeServicosEspecializados; i++) {
          sections2.add(TabelaGastronomiaArtesanato2());
        }

        for (int i = 0; i < qtdeServicosEspecializados; i++) {
          if (i < widget.hospedagemModel!.servicosEspecializados!.length) {
            var servicos = widget.hospedagemModel!.servicosEspecializados![i];
            sections2[i].fillForm(
              servicos.ano_inicio_atividade!,
              servicos.premiacao!,
              servicos.outras_informacoes!,
            );
          }
        }
      }
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
        sections: sections,
        sections2: sections2,
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
    valoresjson['tipo_formulario'] =
        'Gastronomia e Artesanato';
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

      valoresjson['contatos'] =
          sections.map((element) => element.getData()).toList();
      valoresjson['servicos_especializados'] =
          sections2.map((element) => element.getData()).toList();

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
                AppConstants.GASTRONOMIA_ARTESANATO)
            : FormService()
                .sendForm(valoresjson, AppConstants.GASTRONOMIA_ARTESANATO);
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
      valoresjson['contatos'] =
          sections.map((element) => element.getData()).toList();
      valoresjson['servicos_especializados'] =
          sections2.map((element) => element.getData()).toList();

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
  final GastronomiaArtesanatoTrabalhosManuaisModel? hospedagemModel;
  final List<TabelaGastronomiaArtesanato> sections;
  final List<TabelaGastronomiaArtesanato2> sections2;
  const Identificacao(
      {super.key,
      required this.controllers,
      this.hospedagemModel,
      required this.sections,
      required this.sections2});

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
        options: [
          'Gastronomia típica e preparação de alimentos',
          'Artesanato/trabalhos manuais',
          'Atividades tradicionais de trabalho'
        ],
        onSaved: (newValue) {
          valoresjson['tipo'] = newValue;
        },
        initialValue: isUpdate == true ? widget.hospedagemModel!.tipo : "",
      ),
      CheckboxGroupFormField(
        title: 'Subtipos',
        initialValue: isUpdate == true ? widget.hospedagemModel!.subtipos : [],
        options: [
          'Guia de turismo',
          'Monitor',
          'Condutor',
          'Cerâmica',
          'Escultura',
          'Bordado',
          'Cestaria',
          'Mosaico',
          'Tricô/crochê',
          'Entalhe',
          'Renda',
          'Fotografia',
          'Tecelagem',
          'Papel machê',
          'Macramê',
          'Plumária',
          'Bijuteria',
          'Dobradura',
          'Marcenaria/marchetaria',
          'Gravura',
          'Pátina e texturização',
          'Cartonagem',
          'Pintura',
          'Découpage',
          'Topiaria/arranjos florais',
          'Agricultor',
          'Pescador',
          'Seringueiro',
          'Garimpeiro',
          'Quebrador de coco',
          'Fotógrafo lambe-lambe',
          'Carpinteiro',
          'Peão',
          'outro'
        ],
        onSaved: (newValue) {
          valoresjson['subtipos'] = newValue;
        },
      ),
      SizedBox(height: 100.w),
      ContainerHeader(title: 'Informações Gerais'),
      CustomTextField(
        controller: widget.controllers['nomeProduto'],
        name: 'Nome',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Histórico do Produto',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['historicoProduto01'],
        name: 'Histórico do Produto',
      ),
      CustomTextField(
        controller: widget.controllers['historicoProduto02'],
        name: 'Histórico do Produto',
      ),
      CustomTextField(
        controller: widget.controllers['historicoProduto03'],
        name: 'Histórico do Produto',
      ),
      CustomTextField(
        controller: widget.controllers['historicoProduto04'],
        name: 'Histórico do Produto',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Modo de Preparo/Fabricação',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['modoPreparo01'],
        name: 'Modo de Preparo/Fabricação',
      ),
      CustomTextField(
        controller: widget.controllers['modoPreparo02'],
        name: 'Modo de Preparo/Fabricação',
      ),
      CustomTextField(
        controller: widget.controllers['modoPreparo03'],
        name: 'Modo de Preparo/Fabricação',
      ),
      CustomTextField(
        controller: widget.controllers['modoPreparo04'],
        name: 'Modo de Preparo/Fabricação',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Artista/Executante',
        fontWeight: FontWeight.bold,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          widget.sections.length > 1
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.sections.removeLast();
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                widget.sections.add(TabelaGastronomiaArtesanato());
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
        children: widget.sections,
      ),
      SizedBox(
        height: sizeScreen.height * 0.05,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          widget.sections2.length > 1
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.sections2.removeLast();
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                widget.sections2.add(TabelaGastronomiaArtesanato2());
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
        children: widget.sections2,
      ),
      SizedBox(
        height: 55.h,
      ),
    ]));
  }
}

class Funcionamento extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final GastronomiaArtesanatoTrabalhosManuaisModel? hospedagemModel;
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
        name: 'Apoio à Comercialização',
        fontWeight: FontWeight.bold,
      ),
      ConditionalFieldsGroup(
          title: 'Integra Roteiros Turísticos Comercializados',
          jsonKey: 'integraRoteiros',
          optionModelValue:
              isUpdate ? widget.hospedagemModel!.integraRoteiros : "",
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: [
            textLabel(name: 'Nome dos Principais Roteiros (até 5)'),
            CustomTextField(
              name: 'Roteiro 1',
              controller: widget.controllers['roteiro1'],
            ),
            CustomTextField(
              name: 'Site do roteiro 1',
              controller: widget.controllers['siteRoteiro1'],
            ),
            CustomTextField(
              name: 'Roteiro 2',
              controller: widget.controllers['roteiro2'],
            ),
            CustomTextField(
              name: 'Site do roteiro 2',
              controller: widget.controllers['siteRoteiro2'],
            ),
            CustomTextField(
              name: 'Roteiro 3',
              controller: widget.controllers['roteiro3'],
            ),
            CustomTextField(
              name: 'Site do roteiro 3',
              controller: widget.controllers['siteRoteiro3'],
            ),
            CustomTextField(
              name: 'Roteiro 4',
              controller: widget.controllers['roteiro4'],
            ),
            CustomTextField(
              name: 'Site do roteiro 4',
              controller: widget.controllers['siteRoteiro4'],
            ),
            CustomTextField(
              name: 'Roteiro 5',
              controller: widget.controllers['roteiro5'],
            ),
            CustomTextField(
              name: 'Site do roteiro 5',
              controller: widget.controllers['siteRoteiro5'],
            ),
          ]),
      SizedBox(
        height: 55.h,
      ),
      ConditionalFieldsGroup(
          title: 'Integra Guia Turístico',
          jsonKey: 'integraGuiaTuristico',
          optionModelValue:
              isUpdate ? widget.hospedagemModel!.integraGuiaTuristico : "",
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: [
            textLabel(name: 'Nome dos Principais Guias Impressos (até 5)'),
            CustomTextField(
              name: 'Guia 1',
              controller: widget.controllers['Guia1'],
            ),
            CustomTextField(
              name: 'Site do Guia 1',
              controller: widget.controllers['siteGuia1'],
            ),
            CustomTextField(
              name: 'Guia 2',
              controller: widget.controllers['Guia2'],
            ),
            CustomTextField(
              name: 'Site do Guia 2',
              controller: widget.controllers['siteGuia2'],
            ),
            CustomTextField(
              name: 'Guia 3',
              controller: widget.controllers['Guia3'],
            ),
            CustomTextField(
              name: 'Site do Guia 3',
              controller: widget.controllers['siteGuia3'],
            ),
            CustomTextField(
              name: 'Guia 4',
              controller: widget.controllers['Guia4'],
            ),
            CustomTextField(
              name: 'Site do Guia 4',
              controller: widget.controllers['siteGuia4'],
            ),
            CustomTextField(
              name: 'Guia 5',
              controller: widget.controllers['Guia5'],
            ),
            CustomTextField(
              name: 'Site do Guia 5',
              controller: widget.controllers['siteGuia5'],
            ),
          ]),
      SizedBox(
        height: 60.h,
      ),
      ContainerHeader(title: 'Características'),
      SizedBox(
        height: 60.h,
      ),
      CheckboxGroupFormField(
        options: [
          'Restaurante',
          'Bar/lanchonete',
          'Cafeteria',
          'Hospedagem',
          'Feira',
          'Casa de chá',
          'Quiosque/barraca',
          'outro'
        ],
        title: 'Locais de Comercialização',
        initialValue:
            isUpdate ? widget.hospedagemModel!.locaisDeComercializacao : [],
        onSaved: (newValue) =>
            valoresjson['locaisDeComercializacao'] = newValue,
      ),
      CustomTextField(
        name: 'Descritivo das Especialidades',
        controller: widget.controllers['descritivoEspecialidades'],
      ),
      SizedBox(
        height: sizeScreen.height * 0.05,
      ),
    ]));
  }
}

class Acessibilidade extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final GastronomiaArtesanatoTrabalhosManuaisModel? hospedagemModel;
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
        child: Column(children: [
      ContainerHeaderToBigTexts(
          title:
              'Proteção, Qualificação, Certificação, Premiação, Destaques e Outros'),
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
        height: 55.h,
      ),
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
    ]));
  }
}
