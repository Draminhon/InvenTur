import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/forms/comercio_turistico_model.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/fields.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_widget.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/tables.dart';
import 'package:inventur/pages/widgets/map.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/services/form_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/utils/validators.dart';

final Validators _validators = Validators();
final Map<String, dynamic> valoresJson = {
  'tipo_formulario': 'Comércio Turístico',
};
bool isUpdate = false;

class ComercioTuristico extends StatefulWidget {
  final ComercioTuristicoModel? infoModel;
  const ComercioTuristico({super.key, this.infoModel});

  @override
  State<ComercioTuristico> createState() => _ComercioTuristicoState();
}

class _ComercioTuristicoState extends State<ComercioTuristico> {
  int currentStep = 0;

  late List<Widget> pages;

  final _formKey = GlobalKey<FormState>();

  final PageController _pageController = PageController();

  Map<String, TextEditingController> _identificacaoControllers = {};
  Map<String, TextEditingController> _funcionamentoControllers = {};
  Map<String, TextEditingController> _protecaoControllers = {};

  final List<String> _chavesIdentificacao = const [
    'uf',
    'regiao_turistica',
    'municipio',
    'razaoSocial',
    'nomeFantasia',
    'CNPJ',
    'codigoCNAE',
    'atividadeEconomica',
    'inscricaoMunicipal',
    'nomeDaRedeFranquia',
    'longitudePrefeitura',
    'latitudePrefeitura',
    'avenidaRuaTravessa',
    'bairroLocalidade',
    'distrito',
    'CEP',
    'whatsapp',
    'instagram',
    'email',
    'site',
    'pontosDeReferencia'
  ];
  final List<String> _chavesFuncionamento = const [
    'outrasRegrasEInformacoes',
    'capacidadeDeVeiculos',
    'automoveis',
    'onibus',
  ];
  final List<String> _chavesProtecao = const [
    'outrasAcessibilidade',
    'observacoes',
    'referencias'
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

      _funcionamentoControllers.forEach(
        (key, value) {
          if (modelMap.containsKey(key)) {
            final valor = modelMap[key];
            value.text = valor?.toString() ?? '';
          }
        },
      );

      _protecaoControllers.forEach(
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
    for (final key in _chavesIdentificacao) {
      _identificacaoControllers[key] = TextEditingController();
    }

    for (final key in _chavesFuncionamento) {
      _funcionamentoControllers[key] = TextEditingController();
    }

    for (final key in _chavesProtecao) {
      _protecaoControllers[key] = TextEditingController();
    }

    pages = [
      Identificacao(
        controllers: _identificacaoControllers,
        infoModel: widget.infoModel,
      ),
      Funcionamento(
        controllers: _funcionamentoControllers,
        infoModel: widget.infoModel,
      ),
      Protecao(
        controllers: _protecaoControllers,
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
    for(final controller in _protecaoControllers.values){
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
  final ComercioTuristicoModel? infoModel;

  const Identificacao({
    super.key,
    required this.controllers,
    this.infoModel,
  });

  @override
  State<Identificacao> createState() => _IdentificacaoState();
}

class _IdentificacaoState extends State<Identificacao> with AutomaticKeepAliveClientMixin {
        bool _isFullScreen = false;

  // Altura inicial do mapa quando não está em tela cheia
  final double _initialMapHeight = 300.0;

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final sizeScreen = MediaQuery.sizeOf(context);
    final double currentMapHeight = _isFullScreen ? sizeScreen.height * 0.8 : _initialMapHeight;
    return SingleChildScrollView(
      child: Column(
        children: [
          ContainerHeader(title: 'Identificação'),
          UfMunicipioRg(controllers: widget.controllers),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Tipo:',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 35.h,
          ),
          RadioFormField(
            options: ['Comércio Turístico'],
            initialValue: isUpdate ? widget.infoModel!.tipo : '',
            onSaved: (newValue) => valoresJson['tipo'] = newValue,
          ),
          CheckboxGroupFormField(
            title: 'Subtipos:',
            initialValue: isUpdate ? widget.infoModel!.subtipo : [],
            options: [
              'Loja de artesanato/souvenir',
              'Loja de artigos fotográficos',
              'Antiquário/galeria de arte',
              'outro'
            ],
            onSaved: (newValue) => valoresJson['subtipo'] = newValue,
          ),
          SizedBox(
            height: 55.h,
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
          CustomTextField(
            name: 'Razão Social',
            controller: widget.controllers['razaoSocial'],
          ),
          CustomTextField(
            name: 'Nome Fantasia',
            controller: widget.controllers['nomeFantasia'],
          ),
          CustomTextField(
            name: 'CNPJ',
            validat: _validators.validarCNPJ,
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
            name: 'Inscrição Municipal',
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
            controller: widget.controllers['inscricaoMunicipal'],
          ),
          CustomTextField(
            controller: widget.controllers['nomeDaRedeFranquia'],
            name: 'Nome da Rede/Franquia',
          ),
          RadioFormField(
            title: 'Natureza',
            onSaved: (newValue) => valoresJson['natureza'] = newValue,
            options: ['Pública', 'Privada', 'outro'],
            initialValue: isUpdate ? widget.infoModel!.natureza! : '',
          ),
          RadioFormField(
            title: 'Tipo de Organização/Instituição',
            onSaved: (newValue) => valoresJson['tipoDeOrganizacao'] = newValue,
            options: [
              'Associação',
              'Sindicato',
              'Cooperativa',
              'Sistema S',
              'Empresa',
              'outro'
            ],
            initialValue: isUpdate ? widget.infoModel!.tipoDeOrganizacao! : '',
          ),
          RadioFormField(
            onSaved: (newValue) => valoresJson['localizacao'] = newValue,
            title: 'Localização',
            options: ['Urbana', 'Rural', 'outro'],
            initialValue: isUpdate ? widget.infoModel!.localizacao! : '',
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: "Coordenadas Geográficas",
            fontWeight: FontWeight.bold,
          ),
             SizedBox(
        
        height: _isFullScreen ? currentMapHeight : currentMapHeight,

        width: 1300.h,
        child: GestureDetector(
          onDoubleTap:() =>  _toggleFullScreen(),
          child: MeuMapa(onPlaceSelected: (value) {
            setState(() {
              value.forEach(
                (key, value) {
                  
                  valoresJson[key] = value;
                },
              );
              
            });
          },
         
          initialLatitude: isUpdate ? double.tryParse(widget.infoModel!.latitude!) : null,
          initialLongitute: isUpdate ? double.tryParse(widget.infoModel!.longitude!) : null,
          ))),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Endereço',
            fontWeight: FontWeight.bold,
          ),
          CustomTextField(
            name: 'Avenida/Rua/Travessa/Caminho/Outro',
            controller: widget.controllers['avenidaRuaTravessa'],
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
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Whatsapp/Instagram',
            fontWeight: FontWeight.bold,
          ),
          CustomTextField(
            controller: widget.controllers['whatsapp'],
            name: 'Whatsapp',
            formatter: [
              FilteringTextInputFormatter.digitsOnly,
              _validators.phoneFormatter
            ],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Instagram',
            controller: widget.controllers['instagram'],
          ),
          CustomTextField(
            name: 'E-mail',
            controller: widget.controllers['email'],
          ),
          CustomTextField(
            name: 'Site',
            controller: widget.controllers['site'],
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
            optionModelValue: isUpdate ? widget.infoModel!.sinalizacaoDeAcesso! : '',
          ),
          ConditionalFieldsGroup(
            title: 'Turística',
            jsonKey: 'sinalizacaoTuristica',
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [],
            optionModelValue: isUpdate ? widget.infoModel!.sinalizacaoTuristica! : '',
          ),
          CustomTextField(
            name: 'Pontos de Referência',
            controller: widget.controllers['pontosDeReferencia'],
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }

}

class Funcionamento extends StatefulWidget {
  final ComercioTuristicoModel? infoModel;

  final Map<String, TextEditingController> controllers;

  const Funcionamento({super.key, required this.controllers, this.infoModel});

  @override
  State<Funcionamento> createState() => _FuncionamentoState();
}

class _FuncionamentoState extends State<Funcionamento> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // TODO: implement build
    final sizeScreen = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          ContainerHeader(title: 'Funcionamento'),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Estrutura de Funcionamento',
            fontWeight: FontWeight.bold,
          ),
          CheckboxGroupFormField(
            options: [
              'Dinheiro',
              'Cheque',
              'Cheque de Outra Praça',
              'Cartão de Crédito',
              'Cartão de Débito',
              'Pix'
            ],
            title: 'Formas de Pagamento',
            onSaved: (newValue) => valoresJson['formasDePagamento'] = newValue,
            initialValue: isUpdate ? widget.infoModel!.formasDePagamento! : [],
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(name: 'Atendimento ao Público'),
          RadioFormField(
            options: [
              'Não',
              'Inglês',
              'Espanhol',
              'Inglês e Espanhol',
              'outro'
            ],
            initialValue:
                isUpdate ? widget.infoModel!.atendimentoEmLinguaEstrangeira! : '',
            title: 'Atendimento em Língua Estrangeira',
            onSaved: (newValue) =>
                valoresJson['atendimentoEmLinguaEstrangeira'] = newValue,
          ),
          CheckboxGroupFormField(
            options: ['Não', 'Português', 'Inglês', 'Espanhol', 'outro'],
            title: 'Informativos Impressos',
            onSaved: (newValue) =>
                valoresJson['informativosImpressos'] = newValue,
            initialValue: isUpdate ? widget.infoModel!.informativosImpressos! : [],
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Regras de Funcionamento',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(name: 'Período'),
          SizedBox(
            height: 55.h,
          ),
          CheckboxGroupFormField(
            onSaved: (p0) => valoresJson['regrasDeFuncionamentoPeriodo'] = p0,
            initialValue:
                isUpdate ? widget.infoModel!.regrasDeFuncionamentoPeriodo! : [],
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
          textLabel(name: 'Horário'),
          SizedBox(
            height: 55.h,
          ),
          TabelaHorarios(
            onChanged: (p0) => valoresJson['tabelaHorarios'] = p0,
            getValue: isUpdate ? widget.infoModel!.tabelaHorarios : {},
          ),
          SizedBox(
            height: 55.h,
          ),
          ConditionalFieldsGroup(
              title: 'Funcionamento\n24 Horas',
              jsonKey: 'funcionamento24h',
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              optionModelValue: isUpdate ? widget.infoModel!.funcionamento24h : '',
              children: []),
          ConditionalFieldsGroup(
              title: 'Funcionamento\nem Feriados',
              jsonKey: 'funcionamentoEmFeriados',
              valoresJson: valoresJson,
              optionModelValue:
                  isUpdate ? widget.infoModel!.funcionamentoEmFeriados : '',
              isUpdate: isUpdate,
              children: []),
          CustomTextField(
            name: 'Outras Regras e Informações',
            controller: widget.controllers['outrasRegrasEInformacoes'],
          ),
          SizedBox(
            height: 55.h,
          ),
          Container(
            color: const Color.fromARGB(255, 55, 111, 60),
            height: sizeScreen.height * 0.06,
            width: sizeScreen.width,
            padding: EdgeInsets.only(
                top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
            child: Text(
              'Características',
              style: TextStyle(
                  color: Colors.white, fontSize: sizeScreen.height * 0.03),
            ),
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Instalações',
            fontWeight: FontWeight.bold,
          ),
          RadioFormField(
            options: ['Pago', 'Gratuito', 'Coberto', 'Descoberto'],
            title: 'Estacionamento',
            initialValue: isUpdate ? widget.infoModel!.estacionamento! : '',
            onSaved: (newValue) => valoresJson['estacionamento'] = newValue,
          ),
          CustomTextField(
            name: 'Capacidade de Veículos (nº)',
            controller: widget.controllers['capacidadeDeVeiculos'],
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Automóveis (nº)',
            controller: widget.controllers['automoveis'],
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Ônibus (nº)',
            controller: widget.controllers['onibus'],
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CheckboxGroupFormField(
            title: 'Produtos e Serviços',
            initialValue: isUpdate ? widget.infoModel!.produtosEServicos! : [],
            options: [
              'Alimentos caseiros/regionais',
              'Objetos de decoração',
              'Utilidades para o lar',
              'Artesanato',
              'Arte sacra',
              'Acessórios',
              'Vestuário',
              'Móveis',
              'Esculturas',
              'Pinturas',
              'Gravuras',
              'Desenhos',
              'Fotografias',
              'Loja de souvenirs',
              'Equipamentos/produtos cine-fotos',
              'outro'
            ],
            onSaved: (newValue) => valoresJson['produtosEServicos'] = newValue,
          ),
          CheckboxGroupFormField(
              initialValue: isUpdate ? widget.infoModel!.outrosServicos! : [],
              onSaved: (newValue) => valoresJson['outrosServicos'] = newValue,
              title: 'Outros Serviços',
              options: [
                'Entrega em domicílio',
                'Exposições',
                'Cursos/oficinas',
                'Eventos',
                'Leilão',
                'Degustação',
                'Visitas orientadas',
                'Atendimento a estrangeiros',
                'Registro de visitantes',
                'Histórico estatístico de visitantes',
                'Cafeteria/bar/lanchonete',
                'Vendas pela internet',
                'outro'
              ])
        ],
      ),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class Protecao extends StatelessWidget {
  final Map<String, TextEditingController> controllers;
  final ComercioTuristicoModel? infoModel;

  const Protecao({super.key, required this.controllers, this.infoModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ContainerHeaderToBigTexts(title: 'Proteção, Qualificação e Outros'),
          ConditionalFieldsGroup(
              title: 'Do Equipamento/Espaço',
              jsonKey: 'doEquipamentoEspaco',
              optionModelValue: isUpdate ? infoModel!.doEquipamentoEspaco : '',
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              children: [
                TabelsEquipamentoEEspaco(
                  getValue: isUpdate ? infoModel!.tabelEquipamentoEEspaco : {},
                  onChanged: (p0) =>
                      valoresJson['tabelEquipamentoEEspaco'] = p0,
                )
              ]),
          ConditionalFieldsGroup(
              title: 'Da Área ou Edificação\nem que Está\nLocalizado/Instalado',
              jsonKey: 'areaOuEdificacaoEmQueEstaInstalado',
              optionModelValue:
                  isUpdate ? infoModel!.areaOuEdificacaoEmQueEstaInstalado : '',
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              children: [
                TabelsEquipamentoEEspaco(
                  getValue: isUpdate ? infoModel!.tabelaAreaOuEdificacao : {},
                  onChanged: (p0) => valoresJson['tabelaAreaOuEdificacao'] = p0,
                )
              ]),
          SizedBox(
            height: 55.h,
          ),
          ContainerHeader(title: 'Estado Geral de Conservação'),
          RadioFormField(
            initialValue: isUpdate ? infoModel!.estadoGeralConservacao : '',
            onSaved: (newValue) =>
                valoresJson['estadoGeralConservacao'] = newValue,
            options: ['Muito Bom', 'Bom', 'Ruim'],
            title: 'Estado Geral de Conservação',
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
                  initialValue: isUpdate ? infoModel!.pessoalCapacitado : [],
                  title:
                      'Pessoal Capacitado Para Receber Pessoas com Deficiência',
                  onSaved: (newValue) =>
                      valoresJson['pessoalCapacitado'] = newValue,
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
                    initialValue: isUpdate ? infoModel!.areaDeCirculacao : [],
                    title:
                        'Área de Circulação/Acesso Interno para Cadeira de Rodas',
                    onSaved: (newValue) =>
                        valoresJson['areaDeCirculacao'] = newValue,
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
                    initialValue:
                        isUpdate ? infoModel!.equipamentoMotorizado : [],
                    title: 'Equipamento Motorizado para Deslocamento Interno',
                    onSaved: (newValue) =>
                        valoresJson['equipamentoMotorizado'] = newValue,
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
                    optionModelValue: isUpdate
                        ? infoModel!.sinalizacaoIndicativaPreferencial
                        : '',
                    title:
                        'Sinalização Indicativa\nde Atendimento\nPreferencial para Pessoas\ncom Deficiência ou\nMobilidade Reduzida',
                    jsonKey: 'sinalizacaoIndicativaPreferencial',
                    valoresJson: valoresJson,
                    isUpdate: isUpdate,
                    children: []),
                CustomTextField(
                  name: 'Outras',
                  controller: controllers['outrasAcessibilidade'],
                ),
                SizedBox(
                  height: 55.h,
                ),
               
              ]),
              SizedBox(height: 55.h,),
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
