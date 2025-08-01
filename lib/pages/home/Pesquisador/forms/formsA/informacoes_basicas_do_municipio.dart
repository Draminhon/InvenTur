import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/expandedTileYoN.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/utils/validators.dart';

final Validators _validators = Validators();
final Map<String, dynamic> valoresJson = {};

class InformacoesBasicasDoMunicipio extends StatefulWidget {
  const InformacoesBasicasDoMunicipio({super.key});

  @override
  State<InformacoesBasicasDoMunicipio> createState() =>
      _InformacoesBasicasDoMunicipioState();
}

class _InformacoesBasicasDoMunicipioState
    extends State<InformacoesBasicasDoMunicipio> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  Map<String, TextEditingController> _infoGeraisControllers = {};

  Map<String, TextEditingController> _caracteristicasControllers = {};

  final List<String> _chavesInfoGerais = const [
    'enderecoPrefeitura', 'bairroPrefeitura', 'cepPrefeitura',
    'numeroPrefeitura',
    'instagramPrefeitura', 'emailPrefeitura', 'sitePrefeitura',
    'cnpjPrefeitura',
    'latitudePrefeitura', 'longitudePrefeitura', 'municipiosLimitrofes',
    'distanciaDaCapital', 'totalFuncionariosPrefeitura',
    'pessoasComDeficienciaPrefeitura',
    'nomeDoPrefeito', 'nomeDasSecretariasEtc',
    'nomeOrgaoOficialTurismo', // <-- VÍRGULA CORRIGIDA
    'enderecoOrgaoOfcTurismo', 'avenidaRuaOrgaoOfcTurismo',
    'distritoOrgaoOfcTurismo',
    'cepOrgaoOfcTurismo', 'numeroOrgaoOfcTurismo', 'instagramOrgaoOfcTurismo',
    'siteOrgaoOfcTurismo', 'emailOrgaoOfcTurismo',
    'qtdeFuncionariosOrgaoOfcTurismo',
    'qtdeFormacaoSuperiorEmTurismoOrgaoOfcturismo',
    'instanciaGovernancaMunicipal',
    'instanciaGovernancaEstadual', 'instanciaGovernancaRegional',
    'instanciaGovernancaNacional',
    'instanciaGovernancaInternacional', 'instanciaGovernancaOutras',
    'aniversarioMunicipio',
    'santoPadroeiro', 'diaDoSantoPadroeiro', 'feriadoMunicipal01',
    'feriadoMunicipal02',
    'feriadoMunicipal03', 'origemDoNome', 'dataFundacao', 'dataEmancipação',
    'fundadores', 'outrosFatosDeImportanciaHistorica'
  ];
  late List<Widget> pages;

  final List<String> _chavesCaracteristicas = const [
    'areaTotalMunicipio'
        'areaUrbana'
        'areaRural'
        'anoBase'
        'populacaoTotal'
        'populacaoUrbana'
        'populacaoRural'
        'anoBasePopulacao'
        'temperaturaMedia'
        'temperaturaMinima'
        'temperaturaMaxima'
        'altitudeMedia'
        'qtdeDomiciliosAtendidos'
        'empresaResponsável'
        'energiaEletrica'
        'capacidadeEmKVA'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (final key in _chavesInfoGerais) {
      _infoGeraisControllers[key] = TextEditingController();
    }

    for (final key in _chavesCaracteristicas) {
      _caracteristicasControllers[key] = TextEditingController();
    }

    pages = [
      InformacoesGerais(controllers: _infoGeraisControllers),
      Caracteristicas(controllers: _caracteristicasControllers)
    ];
  }

  void _preencherDadosParaTeste() {
    _infoGeraisControllers.forEach((key, controller) {
      // Usamos a 'key' para decidir qual dado de teste colocar
      switch (key) {
        // --- Informações da Prefeitura ---
        case 'enderecoPrefeitura':
          controller.text = 'Praça da Matriz, 100';
          break;
        case 'bairroPrefeitura':
          controller.text = 'Centro';
          break;
        case 'cepPrefeitura':
          controller.text = '12345000'; // O formatador cuida do '12345-000'
          break;
        case 'numeroPrefeitura':
          controller.text =
              '11987654321'; // O formatador cuida do '(11) 98765-4321'
          break;
        case 'instagramPrefeitura':
          controller.text = '@prefeiturateste';
          break;
        case 'emailPrefeitura':
          controller.text = 'gabinete@prefeiturateste.gov.br';
          break;
        case 'sitePrefeitura':
          controller.text = 'www.prefeiturateste.gov.br';
          break;
        case 'cnpjPrefeitura':
          controller.text =
              '00.139.609/0001-46'; // O formatador cuida do '12.345.678/0001-99'
          break;
        case 'latitudePrefeitura':
          controller.text = '-23.550520'; // Ex: São Paulo
          break;
        case 'longitudePrefeitura':
          controller.text = '-46.633308'; // Ex: São Paulo
          break;
        case 'municipiosLimitrofes':
          controller.text = 'Cidadela, Vilaréjo, Outeiro';
          break;
        case 'distanciaDaCapital':
          controller.text = '150 km';
          break;
        case 'totalFuncionariosPrefeitura':
          controller.text = '450';
          break;
        case 'pessoasComDeficienciaPrefeitura':
          controller.text = '15';
          break;
        case 'nomeDoPrefeito':
          controller.text = 'José Almeida Santos';
          break;
        case 'nomeDasSecretariasEtc':
          controller.text =
              'Secretaria de Turismo, Secretaria de Cultura, Secretaria de Obras';
          break;

        // --- Órgão Oficial de Turismo ---
        case 'nomeOrgaoOficialTurismo':
          controller.text = 'Departamento Municipal de Turismo';
          break;
        case 'enderecoOrgaoOfcTurismo':
          controller.text = 'Rua dos Viajantes, 50';
          break;
        case 'avenidaRuaOrgaoOfcTurismo': // Assumindo ser um complemento
          controller.text = 'Sala 10';
          break;
        case 'distritoOrgaoOfcTurismo':
          controller.text = 'Distrito Turístico';
          break;
        case 'cepOrgaoOfcTurismo':
          controller.text = '12345100';
          break;
        case 'numeroOrgaoOfcTurismo':
          controller.text = '1122223333';
          break;
        case 'instagramOrgaoOfcTurismo':
          controller.text = '@turismocidadeteste';
          break;
        case 'siteOrgaoOfcTurismo':
          controller.text = 'www.turismoteste.com.br';
          break;
        case 'emailOrgaoOfcTurismo':
          controller.text = 'turismo@prefeiturateste.gov.br';
          break;
        case 'qtdeFuncionariosOrgaoOfcTurismo':
          controller.text = '8';
          break;
        case 'qtdeFormacaoSuperiorEmTurismoOrgaoOfcturismo':
          controller.text = '3';
          break;

        // --- Instâncias de Governança ---
        case 'instanciaGovernancaMunicipal':
          controller.text = 'Conselho Municipal de Turismo (COMTUR)';
          break;
        case 'instanciaGovernancaEstadual':
          controller.text = 'Secretaria de Turismo do Estado';
          break;
        case 'instanciaGovernancaRegional':
          controller.text = 'Circuito Turístico Águas da Serra';
          break;
        case 'instanciaGovernancaNacional':
          controller.text = 'Ministério do Turismo';
          break;
        case 'instanciaGovernancaInternacional':
          controller.text = 'Organização Mundial do Turismo (OMT)';
          break;
        case 'instanciaGovernancaOutras':
          controller.text = 'Associação Comercial e Industrial';
          break;

        // --- Datas e Feriados (no formato DD/MM/AAAA para o CustomTextDate) ---
        case 'aniversarioMunicipio':
          controller.text = '29/07/1901'; // Formato correto para a máscara
          break;
        case 'santoPadroeiro':
          controller.text = 'São Sebastião';
          break;
        case 'diaDoSantoPadroeiro':
          controller.text = '20/01/2025'; // Formato correto para a máscara
          break;
        case 'feriadoMunicipal01':
          controller.text = 'Corpus Christi';
          break;
        case 'feriadoMunicipal02':
          controller.text = 'Dia da Consciência Negra';
          break;
        case 'feriadoMunicipal03':
          controller.text = 'Sexta-feira Santa';
          break;

        // --- Dados Históricos ---
        case 'origemDoNome':
          controller.text =
              'O nome da cidade deriva do Tupi-Guarani, significando "rio das pedras".';
          break;
        case 'dataFundacao':
          controller.text = '25/01/1875'; // Formato correto para a máscara
          break;
        case 'dataEmancipação':
          controller.text = '30/07/1925'; // Formato correto para a máscara
          break;
        case 'fundadores':
          controller.text = 'Bandeirantes da família Bueno de Camargo';
          break;
        case 'outrosFatosDeImportanciaHistorica':
          controller.text =
              'A cidade foi um importante polo cafeeiro no início do século XX e rota de tropeiros.';
          break;

        // Caso algum campo novo seja adicionado e não esteja no switch
        default:
          controller.text = 'Dado de Teste Padrão';
          break;
      }
    });
  }

  @override
  void dispose() {
    for (final controller in _infoGeraisControllers.values) {
      controller.dispose();
    }
    for (final controller in _caracteristicasControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _enviarFormulario() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      _infoGeraisControllers.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });

      print("FORMULÁRIO COMPLETO E VÁLIDO: $valoresJson");
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Formulário enviado com sucesso!')));
    } else {
      _formKey.currentState!.save();

      _infoGeraisControllers.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });

      print("FORMULÁRIO COMPLETO E VÁLIDO: $valoresJson");
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
          title: Text(
            '',
            style: TextStyle(color: Colors.white),
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
           Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botão Voltar
                  if (currentStep > 0)
                    TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      child: const Text('VOLTAR'),
                    ),
                  // Espaçador para alinhar o botão Continuar à direita quando não houver o Voltar
                  if (currentStep == 0) const Spacer(),

                  // Botão Continuar / Finalizar
                  Container(
                    height: 160.h,
                    width: 550.w,
                    margin: EdgeInsets.only(right: 55.h, bottom: 55.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 55, 111, 60)),
                      onPressed: () {
                        // Valida o formulário DA PÁGINA ATUAL usando a chave correta
                          _formKey.currentState!.save();
                    
                          if (currentStep < pages.length - 1) {
                            // Avança para a próxima página
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          } else {
                            // Lógica para enviar o formulário final
                            print("Formulário finalizado e pronto para enviar!");
                            // _enviarFormulario(); // Você pode chamar sua função de envio aqui
                          }
                        },
                      child: Text(
                        currentStep < pages.length - 1
                            ? 'CONTINUAR'
                            : 'FINALIZAR',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ]));
  }
}

class Identificacao extends StatelessWidget {
  const Identificacao({super.key, required this.onSaved});
  final void Function(String?) onSaved;
  @override
  Widget build(Object context) {
    // TODO: implement build
    return Column(
      children: [
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "Tipo:",
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 35.h,
        ),

        RadioFormField(
            options: ['Caracterização do município'], onSaved: onSaved)

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
}

class InformacoesGerais extends StatelessWidget {
  final Map<String, TextEditingController> controllers;

  const InformacoesGerais({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    // TODO: implement build
    final formWidgts = <Widget>[
      Identificacao(
        onSaved: (p0) => valoresJson['tipo'] = p0,
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
        controller: controllers['enderecoPrefeitura'],
        name: "Avenida/rua/travessa/caminho/outro",

      ),
      CustomTextField(
        controller: controllers['bairroPrefeitura'],
        name: "Bairro",
      ),
      CustomTextField(
        controller: controllers['cepPrefeitura'],
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
        controller: controllers['numeroPrefeitura'],
        name: 'Número',
      ),
      CustomTextField(
        controller: controllers['instagramPrefeitura'],
        name: 'Instagram',
      ),
      CustomTextField(
        controller: controllers['emailPrefeitura'],
        name: 'E-mail',
      ),
      CustomTextField(
        name: 'Site Prefeitura',
        controller: controllers['sitePrefeitura'],
      ),
      CustomTextField(
        keyboardType: TextInputType.numberWithOptions(),
        controller: controllers['cnpjPrefeitura'],
        name: 'CNPJ',
        validat: _validators.validarCNPJ,
        formatter: [_validators.cnpjFormatter],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Coordenadas Geográficas",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: controllers['longitudePrefeitura'],
        name: 'Longitude',
        keyboardType: TextInputType.numberWithOptions(),
        formatter: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))],
      ),
      CustomTextField(
        controller: controllers['latitudePrefeitura'],
        name: 'Latitude',
        keyboardType: TextInputType.numberWithOptions(),
        formatter: [
          FilteringTextInputFormatter.allow(
            RegExp(r'^-?\d*\.?\d*'),
          ),
        ],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Municípios Limítrofes",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: controllers['municipiosLimitrofes'],
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
        controller: controllers['distanciaDaCapital'],
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
        controller: controllers['totalFuncionariosPrefeitura'],
        name: "Total (nº)",
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        controller: controllers['pessoasComDeficienciaPrefeitura'],
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
        controller: controllers['nomeDoPrefeito'],
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
        controller: controllers['nomeDasSecretariasEtc'],
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
        controller: controllers['nomeOrgaoOficialTurismo'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: "Endereço"),
      CustomTextField(
        controller: controllers['enderecoOrgaoOfcTurismo'],
        name: "Avenida/rua/travessa/caminho/outro",
      ),
      CustomTextField(
        controller: controllers['avenidaRuaOrgaoOfcTurismo'],
        name: "Bairro/localidade",
      ),
      CustomTextField(
        controller: controllers['distritoOrgaoOfcTurismo'],
        name: "Distrito",
      ),
      CustomTextField(
        controller: controllers['cepOrgaoOfcTurismo'],
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
        controller: controllers['numeroOrgaoOfcTurismo'],
        name: 'Número',
      ),
      CustomTextField(
        controller: controllers['instagramOrgaoOfcTurismo'],
        name: 'Instagram',
      ),
      CustomTextField(
        controller: controllers['emailOrgaoOfcTurismo'],
        name: 'E-mail',
      ),
      CustomTextField(
        name: 'Site',
        controller: controllers['siteOrgaoOfcTurismo'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Quantidade de Funcionários",
      ),
      CustomTextField(
        controller: controllers['qtdeFuncionariosOrgaoOfcTurismo'],
        name: "Total (nº)",
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        controller: controllers['qtdeFormacaoSuperiorEmTurismoOrgaoOfcturismo'],
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
        controller: controllers["instanciaGovernancaMunicipal"],
        name: "Municipal",
      ),
      CustomTextField(
        controller: controllers["instanciaGovernancaEstadual"],
        name: "Estadual",
      ),
      CustomTextField(
        controller: controllers["instanciaGovernancaRegional"],
        name: "Regional",
      ),
      CustomTextField(
        controller: controllers["instanciaGovernancaNacional"],
        name: "Nacional",
      ),
      CustomTextField(
        controller: controllers["instanciaGovernancaInternacional"],
        name: "Internacional",
      ),
      CustomTextField(
        controller: controllers["instanciaGovernancaOutras"],
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
                dateController: controllers['aniversarioMunicipio'],
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
        controller: controllers['santoPadroeiro'],
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
                dateController: controllers['diaDoSantoPadroeiro'],
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
        controller: controllers['feriadoMunicipal01'],
      ),
      CustomTextField(
        name: 'Feriado',
        controller: controllers['feriadoMunicipal02'],
      ),
      CustomTextField(
        name: 'Feriado',
        controller: controllers['feriadoMunicipal03'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "História do Município",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: controllers['origemDoNome'],
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
                dateController: controllers['dataFundacao'],
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
                dateController: controllers['dataEmancipação'],
              )),
        ],
      ),
      CustomTextField(
        controller: controllers['fundadores'],
        name: "Fundadores",
      ),
      CustomTextField(
        controller: controllers['outrosFatosDeImportanciaHistorica'],
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

  const Caracteristicas({super.key, required this.controllers});

  @override
  State<Caracteristicas> createState() => _CaracteristicasState();
}

class _CaracteristicasState extends State<Caracteristicas> {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    String respostaYoN = valoresJson['redeDeEsgoto'] ?? '';
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
        controller: widget.controllers['empresaResponsável'],
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
      SizedBox(
        height: 55.h,
      ),

      ConditionalFieldsGroup(title: 'Rede de Esgoto', jsonKey: 'redeDeEsgoto', children: [   CustomTextField(
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
        )]),

      SizedBox(
        height: 55.h,
      ),

      ConditionalFieldsGroup(title: 'Fossa Séptica', jsonKey: 'fossaSeptica', children: [        CustomTextField(
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
        )]),


      SizedBox(
        height: 55.h,
      ),

      ConditionalFieldsGroup(title: 'Fossa Rudimentar', jsonKey: 'fossaRudimentar', children: [CustomTextField(
          name: 'Total Atendido (%)',
          controller: widget.controllers['fossaRudimentarTotalAtendidos'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Domicílios Urbanos Atendidos (%)',
          controller: widget.controllers['fossaRudimentarDomiciliosAtendidos'],
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
          controller: widget.controllers['fossaRudimentarEntidadeResponsavel'],
        )]),

   
      SizedBox(
        height: 55.h,
      ),

      ConditionalFieldsGroup(title: 'Vala' 
      , jsonKey: 'vala', children: [ CustomTextField(
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
        )]),
     
      SizedBox(
        height: 55.h,
      ),
ConditionalFieldsGroup(title: 'Estação de Tratamento', jsonKey: 'estacaoDeTratamento', children: [  CustomTextField(
          name: 'Total Atendido (%)',
          controller: widget.controllers['estacaoDeTratamentoTotalAtendidos'],
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
          controller: widget.controllers['estacaoDeTratamentoRuraisAtendidos'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Entidade Responsável',
          controller:
              widget.controllers['estacaoDeTratamentoEntidadeResponsavel'],
        )]),

      SizedBox(
        height: 55.h,
      ),

      ConditionalFieldsGroup(title: 'Esgoto Tratado', jsonKey: 'esgotoTratado', children: [
         CustomTextField(
          name: 'Total Atendido (%)',
          controller: widget.controllers['esgotoTratadoTotalAtendidos'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Domicílios Urbanos Atendidos (%)',
          controller: widget.controllers['esgotoTratadoDomiciliosAtendidos'],
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
          controller: widget.controllers['esgotoTratadoEntidadeResponsavel'],
        )
      ]),
      SizedBox(
        height: 55.h,
      ),
ConditionalFieldsGroup(title: 'Outros', jsonKey: 'servicoDeEsgotoOutros', children: [
   CustomTextField(
          name: 'Nome',
          controller: widget.controllers['servicoDeEsgotoOutroTotalNome'],
        ),
        CustomTextField(
          name: 'Total Atendido (%)',
          controller: widget.controllers['servicoDeEsgotoOutroTotalAtendidos'],
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
          controller: widget.controllers['servicoDeEsgotoOutroRuraisAtendidos'],
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
      SizedBox(
        height: 55.h,
      ),
      RadioFormField(
          onSaved: (newValue) => valoresJson['energiaEletrica'] = newValue,
          options: ['110 Volts', '220 Volts', '110/220 Volts']),
      CustomTextField(
        name: 'Capacidade em KVA',
        controller: widget.controllers['capacidadeEmKVA'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      SizedBox(
        height: 55.h,
      ),
      ConditionalFieldsGroup(
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
      textLabel(name: 'Abastecimento de Energia', fontWeight: FontWeight.bold,),
      SizedBox(
        height: 55.h,
      ),
      ConditionalFieldsGroup(
          title: 'Rede Urbana',
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
              controller: widget.controllers['redeUrbanaEntidadeResponsável'],
            )
          ]),
      SizedBox(
        height: 55.h,
      ),
      ConditionalFieldsGroup(
          title: 'Rede Rural',
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
              controller: widget.controllers['redeRuralEntidadeResponsável'],
            )
          ]),
      SizedBox(
        height: 55.h,
      ),
      SizedBox(
        width: sizeScreen.width * 0.02,
      ),
      ConditionalFieldsGroup(
          title: 'Abastecimento Próprio',
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
      SizedBox(
        height: 55.h,
      ),
      ConditionalFieldsGroup(
          title: 'Outros',
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
    ];
    return SingleChildScrollView(
      child: Column(
        children: listaWidgets,
      ),
    );
  }
}

class ConditionalFieldsGroup extends StatefulWidget {
  final String title;
  final String jsonKey;
  final List<Widget> children;

  const ConditionalFieldsGroup(
      {super.key,
      required this.title,
      required this.jsonKey,
      required this.children});

  @override
  State<ConditionalFieldsGroup> createState() => _ConditionalFieldsGroupState();
}

class _ConditionalFieldsGroupState extends State<ConditionalFieldsGroup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valoresJson.putIfAbsent(widget.jsonKey, () => 'não');
  }

  @override
  Widget build(BuildContext context) {
    final bool isExpanded = valoresJson[widget.jsonKey] == 'sim';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            textLabel(name: widget.title),
            const Spacer(),
            Expanded(
                flex: 2,
                child: ExpansionTileYoN(
                  getValue: (p0) {
                    if (valoresJson[widget.jsonKey] == p0) return; 

                      WidgetsBinding.instance.addPostFrameCallback((_){
                          if(!mounted) return;
                          setState(() {
                            valoresJson[widget.jsonKey] = p0;
                          });
                      });
                  },
                ))
          ],
        ),
        if (isExpanded) ...widget.children
      ],
    );
  }
}
