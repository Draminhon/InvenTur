import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/forms/rodovia_model.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/fields.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_widget.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/services/form_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/utils/validators.dart';

final Validators _validators = Validators();
final Map<String, dynamic> valoresJson = {
  'tipo_formulario': 'Rodovia',
};
bool isUpdate = false;

class Rodovia extends StatefulWidget {
  final RodoviaModel? infoModel;
  const Rodovia({super.key, this.infoModel});

  @override
  State<Rodovia> createState() => _RodoviaState();
}

class _RodoviaState extends State<Rodovia> {
  int currentStep = 0;

  late List<Widget> pages;

  final _formKey = GlobalKey<FormState>();

  final PageController _pageController = PageController();

  Map<String, TextEditingController> _identificacaoControllers = {};
  Map<String, TextEditingController> _funcionamentoControllers = {};
  Map<String, TextEditingController> _protecaoControllers = {};

  final List<String> _chavesIdentificacao = const [
  'tipo',
  'subtipo',
  'nomeOficial',
  'nomePopular',
  'uf',
  'regiaoTuristica',
  'municipio',
  'outra',
  'outras',
  'municipiosVizinhos',
  'email',
  'site',
  'entidadeMantenedora'
];

  final List<String> _chavesCaracteristicas = const [
    'poluicao',
    'lixo',
    'desmatamento',
    'queimadas',
    'inseguranca',
    'extrativismo',
    'prostituicao',
    'ocupacoesIrregulares',
    'outras',
    'outros',
    'especificacao',
    'observacoes',
    'referencias',
  ];
  final List<String> _chavesEquipeResponsavel = const [
    'pesquisador',
    'telefone',
    'email',
    'coordenador',
  ];

  // void _preencherDadosParaTeste() {
  //   if (widget.infoModel != null) {
  //     final model = widget.infoModel!;
  //    // final modelMap = model.toMap();
  //     _identificacaoControllers.forEach((key, controller) {
  //       if (modelMap.containsKey(key)) {
  //         final valor = modelMap[key];
  //         controller.text = valor?.toString() ?? '';
  //       }
  //     });

  //     _funcionamentoControllers.forEach(
  //       (key, value) {
  //         if (modelMap.containsKey(key)) {
  //           final valor = modelMap[key];
  //           value.text = valor?.toString() ?? '';
  //         }
  //       },
  //     );

  //     _protecaoControllers.forEach(
  //       (key, value) {
  //         if (modelMap.containsKey(key)) {
  //           final valor = modelMap[key];
  //           value.text = valor?.toString() ?? '';
  //         }
  //       },
  //     );
  //   }
  // }

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
      //  _preencherDadosParaTeste();
    }
  }

  // Atualização das páginas no initState
  @override
  void initState() {
    super.initState();
    getInfoUsersInPesquisa();

    // Inicializa controllers
    for (final key in _chavesIdentificacao) {
      _identificacaoControllers[key] = TextEditingController();
    }

    for (final key in _chavesCaracteristicas) {
      _funcionamentoControllers[key] = TextEditingController();
    }

    for (final key in _chavesEquipeResponsavel) {
      _protecaoControllers[key] = TextEditingController();
    }

    // Define as páginas do formulário
    pages = [
      Identificacao(
        controllers: _identificacaoControllers,
        infoModel: widget.infoModel,
      ),

      Caracteristicas(
        controllers: _identificacaoControllers,
        infoModel: widget.infoModel,
      ),


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
    for (final controller in _protecaoControllers.values) {
      controller.dispose();
    }
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

  void _enviarFormulario() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      _identificacaoControllers.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });

      _funcionamentoControllers.forEach(
        (key, controller) {
          valoresJson[key] = controller.text;
        },
      );

      _protecaoControllers.forEach(
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
                AppConstants.COMERCIO_TURISTICO)
            : FormService()
                .sendForm(valoresJson, AppConstants.COMERCIO_TURISTICO);
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
        valoresJson[key] = controller.text;
      });

      _funcionamentoControllers.forEach(
        (key, controller) {
          valoresJson[key] = controller.text;
        },
      );
      _protecaoControllers.forEach(
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

class Identificacao extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final RodoviaModel? infoModel;

  const Identificacao({
    super.key,
    required this.controllers,
    this.infoModel,
  });

  @override
  State<Identificacao> createState() => _IdentificacaoState();
}

class Caracteristicas extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final RodoviaModel? infoModel;

  const Caracteristicas({
    super.key,
    required this.controllers,
    this.infoModel,
  });

  @override
  State<Caracteristicas> createState() => _CaracteristicaState();
}



class _IdentificacaoState extends State<Identificacao>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          ContainerHeader(title: 'Identifica'),
          UfMunicipioRg(controllers: widget.controllers),
          ContainerHeader(title: 'Informações gerais'),
          // Campos de texto
          TextFormField(
            controller: widget.controllers["tipo"],
            decoration: const InputDecoration(
              labelText: 'Tipo',
              hintText: 'Digite o tipo',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.h),
          TextFormField(
            controller: widget.controllers["subtipo"],
            decoration: const InputDecoration(
              labelText: 'Subtipo',
              hintText: 'Digite o subtipo',
              border: OutlineInputBorder(),
            ),
          ),

          // Campos de texto
          TextFormField(
            controller: widget.controllers["nomeOficial"],
            decoration: const InputDecoration(
              labelText: 'Nome oficial',
              hintText: 'Digite o nome oficial',
              border: OutlineInputBorder(),
            ),
          ),
          
          TextFormField(
            controller: widget.controllers["nomePopular"],
            decoration: const InputDecoration(
              labelText: 'Nome popular',
              hintText: 'Digite o nome popular',
              border: OutlineInputBorder(),
            ),
          ),


          RadioFormField(
            options: ['Federal', 'Municipal', 'Estadual'],
            title: 'Jurisdição',
            initialValue: isUpdate ? widget.infoModel!.jurisdicao! : '',
            onSaved: (newValue) => valoresJson['jurisdicao'] = newValue,
          ),
          RadioFormField(
            options: ['Pública', 'Privada', 'Outra'],
            title: 'Natureza',
            initialValue: isUpdate ? widget.infoModel!.natureza! : '',
            onSaved: (newValue) => valoresJson['natureza'] = newValue,
          ),
          CheckboxGroupFormField(
            title: 'Tipo de organização/instituição',
            initialValue:
                isUpdate ? widget.infoModel!.tipoDeOrganizacaoInstituicao! : [],
            options: [
              'Associação',
              'Sindicato',
              'Cooperativa',
              'Sistemas',
              'Empresa',
              'outro'
            ],
            onSaved: (newValue) =>
                valoresJson['tipoDeOrganizacaoInstituicao'] = newValue,
          ),
          RadioFormField(
            options: ['Pública', 'Privada', 'Outra'],
            title: 'Tipo de organização/instituicao',
            initialValue: isUpdate &&
                    widget.infoModel?.tipoDeOrganizacaoInstituicao != null
                ? widget.infoModel!.tipoDeOrganizacaoInstituicao!.first
                : '',
            onSaved: (newValue) =>
                valoresJson['tipoDeOrganizacaoInstituicao'] = newValue,
          ),
          textLabel(
              name: 'Extensão da rodovia no âmbito do municipio',
              fontWeight: FontWeight.bold),
          SizedBox(height: 55.h),
          RadioFormField(
            options: ['Duas', 'Três', 'Quatro', 'Cinco', 'Seis'],
            title: 'Faixas de rolamento',
            initialValue: isUpdate ? widget.infoModel!.faixasDeRolamento! : '',
            onSaved: (newValue) => valoresJson['faixasDeRolamento'] = newValue,
          ),
          RadioFormField(
            options: [
              'Asfalto',
              'Concreto',
              'Paralelepipedo',
              'Saibro',
              'Asfalto ecológico',
              'Chão batido',
              'Outros'
            ],
            title: 'Pavimentação',
            initialValue: isUpdate ? widget.infoModel!.pavimentacao! : '',
            onSaved: (newValue) => valoresJson['pavimentacao'] = newValue,
          ),
          RadioFormField(
            options: ['Sim', 'Não'],
            title: 'Pedágio',
            initialValue: isUpdate ? widget.infoModel!.pedagio! : '',
            onSaved: (newValue) => valoresJson['pedagio'] = newValue,
          ),
          textLabel(
              name: 'Municípios vizinhos interligados pela rodovia',
              fontWeight: FontWeight.bold),
          SizedBox(height: 55.h),
          TextFormField(
            controller: widget.controllers["municipiosVizinhos"],
            decoration: const InputDecoration(
              labelText: 'Municípios vizinhos interligados pela rodovia',
              hintText: 'Digite o nome dos municipios',
              border: OutlineInputBorder(),
            ),
          ),
          textLabel(
              name: 'Sinalização',
              fontWeight: FontWeight.bold),
      
         
              
              ConditionalFieldsGroup(
                title: "De acesso",
                jsonKey: "sinalizacaoDeAcesso",
                valoresJson: valoresJson,
                isUpdate: isUpdate,
                children: [
                  
                ],
              ),
            
          
          ConditionalFieldsGroup(
                title: "Turistica",
                jsonKey: "sinalizacaoDeAcesso",
                valoresJson: valoresJson,
                isUpdate: isUpdate,
                children: [
                  
                ],
              ),
            
  
          textLabel(
              name: 'Entidade mantenedora',
              fontWeight: FontWeight.bold),
          SizedBox(height: 55.h),
          TextFormField(
            controller: widget.controllers["entidadeMantenedora"],
            decoration: const InputDecoration(
              labelText: 'Entidade mantenedora',
              hintText: 'Digite o nome da entidade',
              border: OutlineInputBorder(),
            ),
          ),

          
          textLabel(
              name: 'Email',
              fontWeight: FontWeight.bold),
          SizedBox(height: 55.h),
          TextFormField(
            controller: widget.controllers["email"],
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Digite o nome email',
              border: OutlineInputBorder(),
            ),
          ),
          textLabel(name: 'Site/Página web', fontWeight: FontWeight.bold),
          
          SizedBox(height: 55.h),
          TextFormField(
            controller: widget.controllers["site"],
            decoration: const InputDecoration(
              labelText: 'Url Site/Página web',
              hintText: 'Digite a url do site',
              border: OutlineInputBorder(),
            ),
          ),
          
        ],
      ),
    );
  }
}

class _CaracteristicaState extends State<Caracteristicas>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          ContainerHeader(title: 'Caracteristicas'),
          textLabel(
              name: 'Equipamentos ao longo da rodovia',
              fontWeight: FontWeight.bold),

          RadioFormField(
            options: ['Álcool', 'Gasolina', 'Diesel', 'Gás Natural Veicular'],
            title: 'Posto de combustível',
            initialValue:
                isUpdate && widget.infoModel?.postoDeCombustivel != null
                    ? widget.infoModel!.postoDeCombustivel!.first
                    : '',
            onSaved: (newValue) => valoresJson['postoDeCombustivel'] = newValue,
          ),

          CheckboxGroupFormField(
            title: 'Outros serviços',
            initialValue: isUpdate ? widget.infoModel!.outrosServicos : [],
            options: [
              'Alimentação',
              'Telefone público',
              'Produtos típicos',
              'Hospedagem',
              'Serviços mecânicos',
              'Supermercado',
              'Posto de informação',
              'Policia rodoviária',
              'Policia militar',
              'Loja de souvenir',
              'Socorro mecânico',
              'Outros',
            ],
            onSaved: (newValue) => valoresJson['outrosServicos'] = newValue,
          ),

          CheckboxGroupFormField(
            title: 'Estruturas ao longo da via',
            initialValue:
                isUpdate ? widget.infoModel!.estruturasAoLongoDaVia : [],
            options: [
              'Ponte',
              'Passarela',
              'Viaduto',
              'Galeria/túnel',
              'Atrativo turístico natural',
              'Outro'
            ],
            onSaved: (newValue) =>
                valoresJson['estruturasAoLongoDaVia'] = newValue,
          ),

          textLabel(name: "Questões Ambientais Sociais"),

          ConditionalFieldsGroup(
            title: "Poluição",
            jsonKey: "poluicao",
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                name: "Especificação",
                controller: widget.controllers['poluicao'],
              ),
            ],
          ),

          ConditionalFieldsGroup(
            title: "Lixo",
            jsonKey: "lixo",
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                name: "Especificação",
                controller: widget.controllers['lixo'],
              ),
              ConditionalFieldsGroup(
                title: "Desmatamento",
                jsonKey: "desmatamento",
                valoresJson: valoresJson,
                isUpdate: isUpdate,
                children: [
                  CustomTextField(
                    name: "Especificação",
                    controller: widget.controllers['desmatamento'],
                  ),
                ],
              ),
            ],
          ),

          ConditionalFieldsGroup(
            title: "Queimadas",
            jsonKey: "queimadas",
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                name: "Especificação",
                controller: widget.controllers
                ['queimadas'],
              ),
            ],
          ),

          ConditionalFieldsGroup(
            title: "Insegurança",
            jsonKey: "inseguranca",
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                name: "Especificação",
                controller: widget.controllers
                ['inseguranca'],
              ),
            ],
          ),

          ConditionalFieldsGroup(
            title: "Extrativismo",
            jsonKey: "extrativismo",
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                name: "Especificação",
                controller: widget.controllers
                ['extrativismo'],
              ),
            ],
          ),

          ConditionalFieldsGroup(
            title: "Prostituição",
            jsonKey: "prostituicao",
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                name: "Especificação",
                controller: widget.controllers
                ['prostituicao'],
              ),
            ],
          ),

          ConditionalFieldsGroup(
            title: "Ocupações irregulares",
            jsonKey: "ocupacoesIrregulares",
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [
              CustomTextField(
                name: "Especificação",
                controller: widget.controllers
                ['ocupacao_irregular_invasao'],
              ),
            ],
          ),

          textLabel(
              name: 'Estado geral de conservação',
              fontWeight: FontWeight.bold),

          RadioFormField(
            options: ['Muito bom', 'Bom', 'Ruim'],
            title: 'Estado geral de conservação',
            initialValue:
                isUpdate && widget.infoModel?.postoDeCombustivel != null
                    ? widget.infoModel!.postoDeCombustivel!.first
                    : '',
            onSaved: (newValue) => valoresJson['estadoGeralDeConservacao'] = newValue,
          ),

          textLabel(
              name: 'Observações',
              fontWeight: FontWeight.bold),
          SizedBox(height: 55.h),
          TextFormField(
            controller: widget.controllers["observacoes"],
            decoration: const InputDecoration(
              labelText: 'Observações',
              hintText: 'Digite as observações',
              border: OutlineInputBorder(),
            ),

            
          ),

          textLabel(
              name: 'Referências',
              fontWeight: FontWeight.bold),
          SizedBox(height: 55.h),
          TextFormField(
            controller: widget.controllers["referencias"],
            decoration: const InputDecoration(
              labelText: 'Referências',
              hintText: 'Digite as referências',
              border: OutlineInputBorder(),
            ),

            
          ),
          
        ],
      ),
    );
  }
}
