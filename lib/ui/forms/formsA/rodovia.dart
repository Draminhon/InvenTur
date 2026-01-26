import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sistur/models/forms/forms%20A/rodovia_model.dart';
import 'package:sistur/ui/widgets/widgets/fields.dart';
import 'package:sistur/ui/widgets/container_widget.dart';
import 'package:sistur/ui/widgets/text%20fields/customOutro.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sistur/utils/utils_functions.dart';
import '../../widgets/text fields/customTextField.dart';
import '../../widgets/radioButton.dart';
import '../../widgets/widgets/checkBox.dart';

final Map<String, dynamic> valoresjson = {
  'tipo_formulario': 'Rodovia',
};

bool isUpdate = false;

class Rodovia extends StatefulWidget {
  final RodoviaModel? infoModel;
  final bool? isAdmin;
  Rodovia({super.key, this.infoModel, this.isAdmin});

  @override
  State<Rodovia> createState() => _RodoviaState();
}

class _RodoviaState extends State<Rodovia> {
  int currentStep = 0;
  int pesquisadorId = 0;
  bool isTheOwner = false;
  bool isAdmin = false;
  final UtilsFunctions _utils = UtilsFunctions();
  late List<Widget> pages;

  final _formKey = GlobalKey<FormState>();

  final PageController _pageController = PageController();

  Map<String, TextEditingController> _identificacaoControllers = {};
  Map<String, TextEditingController> _caracteristicasControllers = {};

  final List<String> _chavesIdentificacao = const [
    'uf',
    'regiao_turistica',
    'municipio',
    'nome_oficial',
    'nome_popular',
    'extensao_rodovia_municipio',
    'municipios_vizinhos_interligados_rodovia',
    'whatsapp',
    'instagram',
  ];

  final List<String> _chavesCaracteristicas = const [
    'poluicao_especificacao',
    'lixo_especificacao',
    'desmatamento_especificacao',
    'queimadas_especificacao',
    'inseguranca_especificacao',
    'extrativismo_especificacao',
    'prostituicao_especificacao',
    'ocupacao_irregular_invasao_especificacao',
    'outras_especificacao',
    'observacoes',
    'referencias',
  ];

  void _preencherDadosParaTeste() {
    if (widget.infoModel != null) {
      final model = widget.infoModel!;
      final modelMap = model.toMap();
      _identificacaoControllers.forEach((key, controller) {
        if (modelMap.containsKey(key)) {
          final valor = modelMap[key];
          controller.text = valor?.toString() ?? '';
        }
      });

      _caracteristicasControllers.forEach(
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
        if (argument.containsKey('isUpdate')) {
        isUpdate = argument['isUpdate'];
      }

      if(argument.containsKey('isAdmin')){
        isAdmin = argument['isAdmin'];
      } else {
        isUpdate = false;
      }
    } catch (e) {
      isUpdate = false;
      isAdmin = false;
    }
    if (isUpdate == true) {
      _preencherDadosParaTeste();
    }
  }

  @override
  void initState() {
    super.initState();

    _utils
        .getInfoUsersInPesquisa(valoresjson, widget.isAdmin ?? false)
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
                  pesquisadorId,  widget.infoModel!.usuario_criador!, widget.isAdmin ?? false, context);
            }
          }),
        );

    for (final key in _chavesIdentificacao) {
      _identificacaoControllers[key] = TextEditingController();
    }

    for (final key in _chavesCaracteristicas) {
      _caracteristicasControllers[key] = TextEditingController();
    }

    pages = [
      Identificacao(
        controllers: _identificacaoControllers,
        hospedagemModel: widget.infoModel,
      ),
      Caracteristicas(
        controllers: _caracteristicasControllers,
        hospedagemModel: widget.infoModel,
      ),
    ];
  }

  @override
  void dispose() {
    for (final controller in _identificacaoControllers.values) {
      controller.dispose();
    }
    for (final controller in _caracteristicasControllers.values) {
      controller.dispose();
    }

    valoresjson.clear();
    valoresjson['tipo_formulario'] = 'Rodovia';
    isUpdate = false;

    super.dispose();
  }

  void _enviarFormulario() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      _identificacaoControllers.forEach((key, controller) {
        valoresjson[key] = controller.text;
      });

      _caracteristicasControllers.forEach(
        (key, value) {
          valoresjson[key] = value.text;
        },
      );

      if (currentStep < pages.length - 1) {
        // Avança para a próxima página
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {

          _utils.decideSendingOrUpdating(isUpdate,
           isTheOwner,
            context,
             widget.infoModel?.id ?? 0,
              valoresjson,
               AppConstants.RODOVIA_CREATE);
      }
    } else {
      _formKey.currentState!.save();
      _identificacaoControllers.forEach((key, controller) {
        valoresjson[key] = controller.text;
      });
      _caracteristicasControllers.forEach(
        (key, value) {
          valoresjson[key] = value.text;
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
                  ? EdgeInsets.only(bottom: 20.h, top: 20.h)
                  : EdgeInsets.only(bottom: 20.h, top: 20.h, right: 55.w),
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
  final RodoviaModel? hospedagemModel;

  const Identificacao(
      {super.key, required this.controllers, this.hospedagemModel});

  @override
  State<Identificacao> createState() => _IdentificacaoState();
}

class _IdentificacaoState extends State<Identificacao>
    with AutomaticKeepAliveClientMixin {
  @override
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
        title: 'Tipo:',
        options: ['Rodoviário'],
        onSaved: (newValue) {
          valoresjson['tipo'] = newValue;
        },
        initialValue: isUpdate ? widget.hospedagemModel!.tipo! : "",
      ),
      RadioFormField(
        title: 'Subtipos:',
        options: ['Rodovia'],
        onSaved: (newValue) {
          valoresjson['subtipos'] = newValue;
        },
        initialValue: isUpdate ? widget.hospedagemModel!.subtipos! : "",
      ),
      SizedBox(
        height: 55.w,
      ),
      ContainerHeader(title: 'Informações Gerais'),
      CustomTextField(
        controller: widget.controllers['nome_oficial'],
        name: 'Nome Oficial',
      ),
      CustomTextField(
        controller: widget.controllers['nome_popular'],
        name: 'Nome Popular',
      ),
      RadioFormField(
        title: 'Jurisdição:',
        options: ['Federal', 'Estadual', 'Municipal'],
        onSaved: (newValue) {
          valoresjson['jurisdicao'] = newValue;
        },
        initialValue: isUpdate ? widget.hospedagemModel!.jurisdicao! : "",
      ),
      RadioFormField(
        title: 'Natureza:',
        options: ['Pública', 'Privada', 'outro'],
        onSaved: (newValue) {
          valoresjson['natureza'] = newValue;
        },
        initialValue: isUpdate ? widget.hospedagemModel!.natureza : "",
      ),
      SizedBox(
        height: 50.w,
      ),
      CheckboxGroupFormField(
        title: 'Tipo de organização/Instituição:',
        options: [
          'Associação',
          'Sindicato',
          'Cooperativa',
          'Sistema',
          'Empresa',
          'outro'
        ],
        onSaved: (newValue) =>
            valoresjson['tipo_de_organizacao_instituicao'] = newValue,
        initialValue: isUpdate
            ? widget.hospedagemModel!.tipoDeOrganizacaoInstituicao
            : [],
      ),
      SizedBox(
        height: sizeScreen.height * 0.03,
      ),
      textLabel(
        name: 'Extensão da rodovia no âmbito do município:',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['extensao_rodovia_municipio'],
        name: 'Extensão',
        formatter: [FilteringTextInputFormatter.digitsOnly],
      ),
      RadioFormField(
          title: 'Faixas de Rolamento:',
          initialValue:
              isUpdate ? widget.hospedagemModel!.faixasDeRolamento : "",
          options: [
            'Duas',
            'Três',
            'Quatro',
            'Mão única',
            'Mão dupla',
            'Acostamento'
          ],
          onSaved: (newValue) {
            valoresjson['faixas_de_rolamento'] = newValue;
          }),
      RadioFormField(
          title: 'Pavimentação:',
          initialValue: isUpdate ? widget.hospedagemModel!.pavimentacao : "",
          options: [
            'Asfalto',
            'Concreto',
            'Paralelepipedo',
            'Saibro',
            'Asfalto ecológico',
            'Chão batido',
            'outro'
          ],
          onSaved: (newValue) {
            valoresjson['pavimentacao'] = newValue;
          }),
      SizedBox(
        height: 90.w,
      ),
      ConditionalFieldsGroup(
          title: 'Pedágio:',
          jsonKey: 'pedagio',
          optionModelValue:
              isUpdate == true ? widget.hospedagemModel!.pedagio! : "não",
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),
      SizedBox(
        height: 55.w,
      ),
      textLabel(
        name: 'Municípios vizinhos interligados por rodovia:',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller:
            widget.controllers['municipios_vizinhos_interligados_rodovia'],
        name: 'Municípios vizinhos',
      ),
      SizedBox(
        height: 55.w,
      ),
      textLabel(
        name: 'Entidade mantedora:',
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: widget.controllers['whatsapp'],
        name: '(xx) x xxxx-xxxx',
      ),
      CustomTextField(
        controller: widget.controllers['instagram'],
        name: '@',
      ),
      SizedBox(
        height: sizeScreen.height * 0.03,
      ),
      textLabel(
        name: 'Sinalização:',
        fontWeight: FontWeight.bold,
      ),
      ConditionalFieldsGroup(
          title: 'de acesso - ',
          jsonKey: 'sinalizacao_de_acesso',
          optionModelValue: isUpdate == true
              ? widget.hospedagemModel!.sinalizacaoDeAcesso!
              : "não",
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),
      ConditionalFieldsGroup(
          title: 'turística - ',
          jsonKey: 'sinalizacao_turistica',
          optionModelValue:
              isUpdate ? widget.hospedagemModel!.sinalizacaoTuristica : "",
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),
      SizedBox(
        height: sizeScreen.height * 0.03,
      )
    ]));
  }
}

class Caracteristicas extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final RodoviaModel? hospedagemModel;
  const Caracteristicas(
      {super.key, required this.controllers, this.hospedagemModel});

  @override
  State<Caracteristicas> createState() => _CaracteristicasState();
}

class _CaracteristicasState extends State<Caracteristicas> {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
        child: Column(
      children: [
        ContainerHeader(title: 'Características'),
        SizedBox(
          height: 55.w,
        ),
        textLabel(
          name: 'Equipamentos e serviços ao longo da rodovia:',
          fontWeight: FontWeight.bold,
        ),
        CheckboxGroupFormField(
          title: 'Posto de Combustível:',
          options: ['Álcool', 'Gasolina', 'Diesel'],
          initialValue:
              isUpdate ? widget.hospedagemModel!.postoDeCombustivel : [],
          onSaved: (newValue) => valoresjson['posto_de_combustivel'] = newValue,
        ),
        CheckboxGroupFormField(
          title: 'Outros Serviços:',
          options: [
            'Alimentação',
            'Hospedagem',
            'Polícia rodoviária',
            'Polícia militar',
            'WiFi livre',
            'Serviços mecânicos',
            'Socorro mecânico',
            'Socorro médico',
            'Loja de souvenir',
            'Produtos típicos',
            'Supermercado',
            'outro'
          ],
          initialValue: isUpdate ? widget.hospedagemModel!.outrosServicos : [],
          onSaved: (newValue) => valoresjson['outros_servicos'] = newValue,
        ),
        CheckboxGroupFormField(
          title: 'Estruturas ao Longo da Via:',
          options: [
            'Ponte',
            'Passarela',
            'Viaduto',
            'Galeria/túnel',
            'Atrativo turístico natural',
            'outro'
          ],
          initialValue:
              isUpdate ? widget.hospedagemModel!.estruturasAoLongoDaVia : [],
          onSaved: (newValue) =>
              valoresjson['estruturas_ao_longo_da_via'] = newValue,
        ),
        textLabel(
          name: 'Questões ambientais/sociais:',
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: sizeScreen.height * 0.03,
        ),
        ConditionalFieldsGroup(
            title: 'Poluição:',
            jsonKey: 'poluicao',
            valoresJson: valoresjson,
            optionModelValue: isUpdate ? widget.hospedagemModel!.poluicao : "",
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                controller: widget.controllers['poluicao_especificacao'],
                name: 'Especificação',
              )
            ]),
        ConditionalFieldsGroup(
            title: 'Lixo:',
            jsonKey: 'lixo',
            optionModelValue: isUpdate ? widget.hospedagemModel!.lixo : "",
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                controller: widget.controllers['lixo_especificacao'],
                name: 'Especificação',
              ),
            ]),
        ConditionalFieldsGroup(
            title: 'Desmatamento',
            jsonKey: 'desmatamento',
            optionModelValue:
                isUpdate ? widget.hospedagemModel!.desmatamento : "",
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                controller: widget.controllers['desmatamento_especificacao'],
                name: 'Especificação',
              ),
            ]),
        ConditionalFieldsGroup(
            title: 'Queimadas:',
            jsonKey: 'queimadas',
            optionModelValue: isUpdate ? widget.hospedagemModel!.queimadas : "",
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                controller: widget.controllers['queimadas_especificacao'],
                name: 'Especificação',
              ),
            ]),
        ConditionalFieldsGroup(
            title: 'Insegurança:',
            jsonKey: 'inseguranca',
            optionModelValue:
                isUpdate ? widget.hospedagemModel!.inseguranca : "",
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                controller: widget.controllers['inseguranca_especificacao'],
                name: 'Especificação',
              ),
            ]),
        ConditionalFieldsGroup(
            title: 'Extrativismo:',
            jsonKey: 'extrativismo',
            optionModelValue:
                isUpdate ? widget.hospedagemModel!.extrativismo : "",
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                controller: widget.controllers['extrativismo_especificacao'],
                name: 'Especificação',
              ),
            ]),
        ConditionalFieldsGroup(
            title: 'Prostituição:',
            jsonKey: 'prostituicao',
            optionModelValue:
                isUpdate ? widget.hospedagemModel!.prostituicao : "",
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                controller: widget.controllers['prostituicao_especificacao'],
                name: 'Especificação',
              ),
            ]),
        ConditionalFieldsGroup(
            title: 'Ocupações\nirregulares/invasão:',
            jsonKey: 'ocupacao_irregular_invasao',
            optionModelValue: isUpdate
                ? widget.hospedagemModel!.ocupacaoIrregularInvasao
                : "",
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                controller: widget
                    .controllers['ocupacao_irregular_invasao_especificacao'],
                name: 'Especificação',
              ),
            ]),
        ConditionalFieldsGroup(
            title: 'Outras:',
            jsonKey: 'outras',
            optionModelValue: isUpdate ? widget.hospedagemModel!.outras : "",
            valoresJson: valoresjson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                controller: widget.controllers['outras_especificacao'],
                name: 'Especificação',
              ),
            ]),
        SizedBox(
          height: 55.h,
        ),
        ContainerHeader(
          title: 'Estado geral de conservação',
        ),
        SizedBox(
          height: sizeScreen.height * 0.03,
        ),
        RadioFormField(
            initialValue: isUpdate
                ? widget.hospedagemModel!.estadoGeralDeConservacao
                : "",
            options: ['Muito bom', 'Bom', 'Ruim'],
            onSaved: (newValue) {
              valoresjson['estado_geral_de_conservacao'] = newValue;
            }),
        SizedBox(
          height: sizeScreen.height * 0.03,
        ),
        Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          width: sizeScreen.width,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Observações',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
        CustomTextField(
          controller: widget.controllers['observacoes'],
          name: '',
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        Container(
          color: const Color.fromARGB(255, 55, 111, 60),
          height: sizeScreen.height * 0.06,
          width: sizeScreen.width,
          padding: EdgeInsets.only(
              top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
          child: Text(
            'Referências',
            style: TextStyle(
                color: Colors.white, fontSize: sizeScreen.height * 0.03),
          ),
        ),
        CustomTextField(
          controller: widget.controllers['referencias'],
          name: '',
        ),
        SizedBox(
          height: sizeScreen.height * 0.05,
        ),
        const SizedBox(
          height: 15,
        )
      ],
    ));
  }
}
