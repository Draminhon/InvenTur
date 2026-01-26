import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sistur/models/forms/Forms%20C/eventos_programados_model.dart';
import 'package:sistur/controllers/pesquisa_controller.dart';
import 'package:sistur/ui/widgets/widgets/checkBox.dart';
import 'package:sistur/ui/widgets/widgets/fields.dart';
import 'package:sistur/ui/widgets/container_widget.dart';
import 'package:sistur/ui/widgets/text%20fields/customOutro.dart';
import 'package:sistur/ui/widgets/text%20fields/customTextField.dart';
import 'package:sistur/ui/widgets/maps/mapa_widget.dart';
import 'package:sistur/ui/widgets/text%20fields/multi_auto_complete_form_field.dart';
import 'package:sistur/ui/widgets/radioButton.dart';
import 'package:sistur/ui/widgets/text%20fields/tables.dart';
import 'package:sistur/services/admin_service.dart';
import 'package:sistur/services/form_service.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sistur/utils/utils_functions.dart';
import 'package:sistur/validators/validators.dart';

final Validators _validators = Validators();
final Map<String, dynamic> valoresjson = {
  'tipo_formulario': 'Eventos Programados',
};
bool isUpdate = false;

class EventosProgramados extends StatefulWidget {
  final EventosProgramadosModel? hospedagemModel;
  final bool? isAdmin;
  const EventosProgramados({super.key, this.hospedagemModel, this.isAdmin});

  @override
  State<EventosProgramados> createState() => _EventosProgramadosState();
}

class _EventosProgramadosState extends State<EventosProgramados> {
  int currentStep = 0;
  int pesquisadorId = 0;
  bool isTheOwner = false;
  final UtilsFunctions _utils = UtilsFunctions();
  late List<Widget> pages;

  final _formKey = GlobalKey<FormState>();

  final PageController _pageController = PageController();

  Map<String, TextEditingController> _identificacaoControllers = {};
  Map<String, TextEditingController> _funcionamentoControllers = {};
  Map<String, TextEditingController> _caracteristicasControllers = {};
  Map<String, TextEditingController> _acessibilidadeControllers = {};

  final List<String> _chavesIdentificacao = const [
    'uf',
    'regiao_turistica',
    'municipio',
    'nomeOficial',
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
    'distanciasAeroporto',
    'distanciasRodoviaria',
    'distanciaEstacaoFerroviaria',
    'distanciaEstacaoMaritima',
    'distanciaEstacaoMetroviaria',
    'distanciaPontoDeOnibus',
    'distanciaPontoDeTaxi',
    'distanciasOutraNome',
    'distanciaOutras',
    'distanciaOutros',
    'pontosDeReferencia',
    'entidadeManetedora',
    'entidadeManetedoraEmail',
    'entidadeManetedoraSite',
    'cnpjRealizador',
    'entidadeManetedoraInstagram',
    'entidadeManetedoraWhatsapp'
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
    'siteGuia5'
  ];
  final List<String> _chavesCaracteristicas = const [
  'descritivoDasEspecifidades'
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
      _caracteristicasControllers.forEach(
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
    _utils
        .getInfoUsersInPesquisa(valoresjson, widget.isAdmin
        ??false)
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
                  pesquisadorId, widget.hospedagemModel!.usuario_criador!,widget.isAdmin
                  ??false,context);
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
    for (final key in _chavesCaracteristicas) {
      _caracteristicasControllers[key] = TextEditingController();
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
      Caracteristicas(
        controllers: _caracteristicasControllers,
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

    for (final controller in _caracteristicasControllers.values) {
      controller.dispose();
    }
    valoresjson.clear();
    valoresjson['tipo_formulario'] = 'Eventos Programados';
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

      _caracteristicasControllers.forEach((key, value) {
        valoresjson[key] = value.text;
      });

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
        _utils.decideSendingOrUpdating(isUpdate,
        isTheOwner,
        context,
        widget.hospedagemModel?.id ?? 0,
        valoresjson,
        AppConstants.EVENTOS_PROGRAMADOS);

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

      _caracteristicasControllers.forEach((key, value) {
        valoresjson[key] = value.text;
      });

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
  final EventosProgramadosModel? hospedagemModel;

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

        CheckboxGroupFormField(
          title: 'Tipos',
          validator: (value) {
                        if (value == null || value.isEmpty) {
               return 'Selecione pelo menos uma opção.';
             }
            return null;
          },
          options: [
            'Feiras/exposições',
            'Congressos',
            'Convenções',
            'Festivais/shows',
            'Seminários',
            'Oficinas/workshops',
            'Competições',
            'Desfiles/passeatas',
            'Encontros temáticos',
            'Festas/celebrações',
          ],
          onSaved: (newValue) {
            valoresjson['tipoLista'] = newValue;
          },
          initialValue: isUpdate == true ? widget.hospedagemModel!.tipoLista : [],
        ),

        CheckboxGroupFormField(
          title: 'Subtipos',
          initialValue: isUpdate == true ? widget.hospedagemModel!.subtipo : [],
          options: [
            'Religiosa/manifestação de fé', 'Popular/folclórica', 'Referente ao trabalho ou ciclo produtivo', 'Festa cívica', 'outro'
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
          name: 'Nome Oficial',
          controller: widget.controllers['nomeOficial'],
        ),
        CustomTextField(
          controller: widget.controllers['nomeFantasia'],
          name: 'Nome Fantasia',
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

        textLabel(name: 'Sinalização', fontWeight: FontWeight.bold),
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
        SizedBox(
          height: 20.w,
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
          height: 20.h,
        ),
        textLabel(
          name: "Entidade Manetedora",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          name: 'Entidade Manetedora',
          controller: widget.controllers['entidadeManetedora'],
        ),

    CustomTextField(name: 'CNPJ do Realizador/Entidade',
    controller: widget.controllers['cnpjRealizador'],
    formatter: [_validators.cnpjFormatter],
    keyboardType: TextInputType.numberWithOptions(),

    ),

        CustomTextField(
          name: 'Email',
          controller: widget.controllers['entidadeManetedoraEmail'],
        ),

        CustomTextField(
          name: 'Site',
          controller: widget.controllers['entidadeManetedoraSite'],
        ),
         CustomTextField(
          name: 'Whatsapp',
          controller: widget.controllers['entidadeManetedoraWhatsapp'],
        ), CustomTextField(
          name: 'Instagram',
          controller: widget.controllers['entidadeManetedoraInstagram'],
        ),

       
      ]),
    );
  }
}

class Funcionamento extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final EventosProgramadosModel? hospedagemModel;
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
        name: 'Estrutura de Funcionamento',
        fontWeight: FontWeight.bold,
      ),

      ConditionalFieldsGroup(
          title: 'Entrada Gratuita',
          jsonKey: 'entradaGratuita',
          optionModelValue:
              isUpdate ? widget.hospedagemModel!.entradaGratuita : "",
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
      SizedBox(height: 55.h),
      textLabel(
        name: 'Instalações de Entrada',
        fontWeight: FontWeight.bold,
      ),

      ConditionalFieldsGroup(
          title: 'Centro de recepção',
          jsonKey: 'centroDeRecepcao',
          optionModelValue:
              isUpdate ? widget.hospedagemModel!.centroDeRecepcao : '',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),

      ConditionalFieldsGroup(
          title: 'Posto de informação',
          jsonKey: 'postoDeInformacao',
          optionModelValue:
              isUpdate ? widget.hospedagemModel!.postoDeInformacao : '',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),

      ConditionalFieldsGroup(
          title: 'Portaria principal',
          jsonKey: 'portariaPrincipal',
          optionModelValue:
              isUpdate ? widget.hospedagemModel!.portariaPrincipal : '',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),

      ConditionalFieldsGroup(
          title: 'Guarita',
          jsonKey: 'guarita',
          optionModelValue: isUpdate ? widget.hospedagemModel!.guarita : '',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),

      ConditionalFieldsGroup(
          title: 'Bilheteria',
          jsonKey: 'bilheteria',
          optionModelValue: isUpdate ? widget.hospedagemModel!.bilheteria : '',
          valoresJson: valoresjson,
          isUpdate: isUpdate,
          children: []),
      SizedBox(
        height: 55.h,
      ),

      CustomTextField(
        name: 'Outras',
        controller: widget.controllers['instalacoesOutras'],
      ),

      SizedBox(
        height: 55.h,
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
        name: 'Total de Visitantes por Evento (nº)',
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
        height: 55.h,
      ),
      textLabel(name: 'Ano base', fontWeight: FontWeight.bold),
      SizedBox(
        width: sizeScreen.width * 0.1,
      ),
      CustomTextDate(
        dateController: widget.controllers['anoBase'],
      ),

      RadioFormField(
        options: ['Turistas', 'Moradores'],
        title: 'Principal Público Frequentador',
        onSaved: (newValue) => valoresjson['principalPublicoFrequentador'] = newValue,
        initialValue: isUpdate
            ? widget.hospedagemModel!.principalPublicoFrequentador
            : "",
      ),

      SizedBox(
        height: 55.h,
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
        height: sizeScreen.height * 0.05,
      ),
    ]));
  }
}

class Caracteristicas extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final EventosProgramadosModel? hospedagemModel;
  const Caracteristicas(
      {super.key, required this.controllers, this.hospedagemModel});

  @override
  State<Caracteristicas> createState() => _CaracteristicasState();
}

class _CaracteristicasState extends State<Caracteristicas>
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
          ContainerHeader(title: 'Características'),
          SizedBox(
            height: sizeScreen.height * 0.02,
          ),
          ConditionalFieldsGroup(title: 'Período de Realização',
           jsonKey: 'periodoDeRealizacao',
          valoresJson: valoresjson,
          optionModelValue: isUpdate ? widget.hospedagemModel!.periodoDeRealizacao : "",
           isUpdate: isUpdate,
           options: ['Data Fixa', 'Data Móvel'],
            children: []),

            RadioFormField(options: ['Mensal', 'Semestral', 'Anual', 'Bienal', 'outro'],
            title: 'Periodicidade',
            initialValue: isUpdate ? widget.hospedagemModel!.periodicidade : "",
            onSaved: (newValue) => valoresjson['periodicidade'] = newValue,
            ),
            RadioFormField(
            options: [
              'Social (envolve assuntos próprios da sociedade, comunidade ou agremiação, com vistas ao bem comum)',
              'Comercial (associado às transações de compra e venda de produtos e serviços)',
              'Promocional (realizado apenas para divulgação institucional ou de apoio às estratégias de marketing)',
              'Cultural (eventos tradicionais das comunidades com características de realização próprias da região ou dos grupos detentores)',
              'Técnico-científico (abarca especialidades, processos, habilidades, domínio de uma prática, arte ou ciência)',
              'outro'
            ],
            title: 'Caráter do Evento',
            initialValue: isUpdate ? widget.hospedagemModel!.caraterEvento : "",
            onSaved: (newValue) => valoresjson['caraterEvento'] = newValue,
          ),

          CustomTextField(name: 'Descritivo das Especificidades do Evento',
          controller: widget.controllers['descritivoDasEspecifidades'],
          ),
          
                    SizedBox(
            height: sizeScreen.height * 0.02,
          )
        ],
      ),
    );
  }
}

class Acessibilidade extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final EventosProgramadosModel? hospedagemModel;
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
