import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
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
final Map<String, TextEditingController> _infoGeraisControllers = {};

final List<String> _chavesInfoGerais = const [
      'enderecoPrefeitura', 'bairroPrefeitura', 'cepPrefeitura', 'numeroPrefeitura',
      'instagramPrefeitura', 'emailPrefeitura', 'sitePrefeitura', 'cnpjPrefeitura',
      'latitudePrefeitura', 'longitudePrefeitura', 'municipiosLimitrofes',
      'distanciaDaCapital', 'totalFuncionariosPrefeitura', 'pessoasComDeficienciaPrefeitura',
      'nomeDoPrefeito', 'nomeDasSecretariasEtc', 'nomeOrgaoOficialTurismo', // <-- VÍRGULA CORRIGIDA
      'enderecoOrgaoOfcTurismo', 'avenidaRuaOrgaoOfcTurismo', 'distritoOrgaoOfcTurismo',
      'cepOrgaoOfcTurismo', 'numeroOrgaoOfcTurismo', 'instagramOrgaoOfcTurismo',
      'siteOrgaoOfcTurismo', 'emailOrgaoOfcTurismo', 'qtdeFuncionariosOrgaoOfcTurismo',
      'qtdeFormacaoSuperiorEmTurismoOrgaoOfcturismo', 'instanciaGovernancaMunicipal',
      'instanciaGovernancaEstadual', 'instanciaGovernancaRegional', 'instanciaGovernancaNacional',
      'instanciaGovernancaInternacional', 'instanciaGovernancaOutras', 'aniversarioMunicipio',
      'santoPadroeiro', 'diaDoSantoPadroeiro', 'feriadoMunicipal01', 'feriadoMunicipal02',
      'feriadoMunicipal03', 'origemDoNome', 'dataFundacao', 'dataEmancipação',
      'fundadores', 'outrosFatosDeImportanciaHistorica'
];


  List<Widget> _paginaInteiraWidgets = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    // Cria um controller para cada chave no mapa `_infoGeraisControllers`
    for (final key in _chavesInfoGerais) {
      _infoGeraisControllers[key] = TextEditingController();
    }

  
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
        controller.text = '11987654321'; // O formatador cuida do '(11) 98765-4321'
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
        controller.text = '00.139.609/0001-46'; // O formatador cuida do '12.345.678/0001-99'
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
        controller.text = 'Secretaria de Turismo, Secretaria de Cultura, Secretaria de Obras';
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
        controller.text = 'O nome da cidade deriva do Tupi-Guarani, significando "rio das pedras".';
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
        controller.text = 'A cidade foi um importante polo cafeeiro no início do século XX e rota de tropeiros.';
        break;

      // Caso algum campo novo seja adicionado e não esteja no switch
      default:
        controller.text = 'Dado de Teste Padrão';
        break;
    }
  });}
  
  @override
  void dispose() {
    for (final controller in _infoGeraisControllers.values) {
      controller.dispose();
    }
    // for (final controller in _caracteristicasControllers.values) {
    //   controller.dispose();
    // }
    super.dispose();
  }
    void _enviarFormulario() {
    if (_formKey.currentState?.validate() ?? false) {
      // Salva os dados de campos como RadioFormField, Checkbox, etc.
      _formKey.currentState!.save();
      
      // Coleta os dados dos controllers de 'Informações Gerais'
      _infoGeraisControllers.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });
      
      // (Você coletaria os dados dos outros controllers aqui também)

      print("FORMULÁRIO COMPLETO E VÁLIDO: $valoresJson");
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulário enviado com sucesso!'))
      );
    } else {
        _formKey.currentState!.save();
      
      // Coleta os dados dos controllers de 'Informações Gerais'
      _infoGeraisControllers.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });
      
      // (Você coletaria os dados dos outros controllers aqui também)

      print("FORMULÁRIO COMPLETO E VÁLIDO: $valoresJson");
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, corrija os erros no formulário.'))
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
      _paginaInteiraWidgets = [
                InformacoesGerais(controllers: _infoGeraisControllers,),
               //das Caracteristicas(),
               SizedBox(height: 65.h,),
                SizedBox(
                  height: 55,
                  width: 1000.w,
                  child: ElevatedButton(
                    onPressed: () {
                      _preencherDadosParaTeste();

                      _enviarFormulario();
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25), // Use um fontSize fixo
                    ),
                  ),
                  
                ),
               SizedBox(height: 65.h,),
                ];
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "Identificação",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 55, 111, 60),
      ),
      backgroundColor: Colors.white,
      body:Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: _paginaInteiraWidgets,),
            ),),
    );
  }
}

class Identificacao extends StatelessWidget {
  const Identificacao({super.key, required this.onSaved});
final  void Function(String?) onSaved;
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
          options: ['Caracterização do município'],
          onSaved: onSaved
        )

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



class InformacoesGerais extends StatelessWidget{
  final Map<String, TextEditingController> controllers;

  const InformacoesGerais({super.key, required this.controllers});

  
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    // TODO: implement build
    return Column(
      children: [
     Identificacao(onSaved: (p0) => valoresJson['tipo'] = p0,),

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
          controller:  controllers['enderecoPrefeitura'],
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
        CustomTextField(name: 'Site Prefeitura', controller: controllers['sitePrefeitura'],),
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
          formatter: [
            FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))
          ],
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
        CustomTextField(name: 'Site', controller: controllers['siteOrgaoOfcTurismo'],),
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
      ],
    );
  }
}

// class Caracteristicas extends StatefulWidget {
//   const Caracteristicas({super.key});

//   @override
//   State<Caracteristicas> createState() => _CaracteristicasState();
// }

// class _CaracteristicasState extends State<Caracteristicas> {
//   @override
//   Widget build(BuildContext context) {
//     final sizeScreen = MediaQuery.sizeOf(context);
//     String respostaYoN = valoresjson['redeDeEsgoto'] ?? '';
//     // TODO: implement build
//     return Column(
//       children: [
//         SizedBox(
//           height: 65.h,
//         ),
//         Container(
//           color: const Color.fromARGB(255, 55, 111, 60),
//           height: sizeScreen.height * 0.06,
//           width: sizeScreen.width,
//           padding: EdgeInsets.only(
//               top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
//           child: Text(
//             'Caracteristicas',
//             style: TextStyle(
//                 color: Colors.white, fontSize: sizeScreen.height * 0.03),
//           ),
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(
//           name: 'Aspectos Gerais',
//           fontWeight: FontWeight.bold,
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(
//           name: 'Área',
//         ),
//         CustomTextField(
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           controller: getController('areaTotalMunicipio'),
//           keyboardType: TextInputType.numberWithOptions(),
//           name: "Área Total do Município (km²)",
//           getValue: (p0) => valoresjson['areaTotalMunicipio'] = p0,
//         ),
//         CustomTextField(
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           keyboardType: TextInputType.numberWithOptions(),
//           controller: getController('areaUrbana'),
//           name: "Área Urbana (km²)",
//           getValue: (p0) => valoresjson['areaUrbana'] = p0,
//         ),
//         CustomTextField(
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           keyboardType: TextInputType.numberWithOptions(),
//           controller: getController('areaRural'),
//           name: "Área Rural (km²)",
//           getValue: (p0) => valoresjson['areaRural'] = p0,
//         ),
//         CustomTextField(
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           keyboardType: TextInputType.numberWithOptions(),
//           controller: getController('anoBase'),
//           name: "Ano-Base",
//           getValue: (p0) => valoresjson['anoBase'] = p0,
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(
//           name: 'População',
//         ),
//         CustomTextField(
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           controller: getController('populacaoTotal'),
//           keyboardType: TextInputType.numberWithOptions(),
//           name: "População Total (nº hab.)",
//           getValue: (p0) => valoresjson['populacaoTotal'] = p0,
//         ),
//         CustomTextField(
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           keyboardType: TextInputType.numberWithOptions(),
//           controller: getController('populacaoUrbana'),
//           name: "População Urbana (nº hab.)",
//           getValue: (p0) => valoresjson['populacaoUrbana'] = p0,
//         ),
//         CustomTextField(
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           keyboardType: TextInputType.numberWithOptions(),
//           controller: getController('populacaoRural'),
//           name: "População Rural (nº hab.)",
//           getValue: (p0) => valoresjson['populacaoRural'] = p0,
//         ),
//         CustomTextField(
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           keyboardType: TextInputType.numberWithOptions(),
//           controller: getController('anoBasePopulacao'),
//           name: "Ano-Base",
//           getValue: (p0) => valoresjson['anoBasePopulacao'] = p0,
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(name: 'Temperatura e Chuvas'),
//         CustomTextField(
//           controller: getController('temperaturaMedia'),
//           name: 'Média (ºC)',
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           keyboardType: TextInputType.numberWithOptions(),
//           getValue: (p0) => valoresjson['temperaturaMedia'] = p0,
//         ),
//         CustomTextField(
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           controller: getController('temperaturaMinima'),
//           name: 'Mínima (ºC)',
//           keyboardType: TextInputType.numberWithOptions(),
//           getValue: (p0) => valoresjson['temperaturaMinima'] = p0,
//         ),
//         CustomTextField(
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           controller: getController('temperaturaMaxima'),
//           name: 'Máxima (ºC)',
//           keyboardType: TextInputType.numberWithOptions(),
//           getValue: (p0) => valoresjson['temperaturaMaxima'] = p0,
//         ),
//         SizedBox(
//           height: sizeScreen.height * 0.02,
//         ),
//         textLabel(
//           name: 'Meses Mais Frios',
//         ),
//         SizedBox(
//           height: sizeScreen.height * 0.01,
//         ),
//         CheckboxGroupFormField(
//           onSaved: (p0) => valoresjson['mesesMaisFrios'] = p0,
//           options: [
//             'Janeiro',
//             'Fevereiro',
//             'Março',
//             'Abril',
//             'Maio',
//             'Junho',
//             'Julho',
//             'Agosto',
//             'Setembro',
//             'Outubro',
//             'Novembro',
//             'Dezembro',
//             'Ano Inteiro'
//           ],
//         ),
//         textLabel(name: 'Meses Mais Quentes'),
//         SizedBox(
//           height: 55.h,
//         ),
//         CheckboxGroupFormField(
//           onSaved: (p0) => valoresjson['mesesMaisQuentes'] = p0,
//           options: [
//             'Janeiro',
//             'Fevereiro',
//             'Março',
//             'Abril',
//             'Maio',
//             'Junho',
//             'Julho',
//             'Agosto',
//             'Setembro',
//             'Outubro',
//             'Novembro',
//             'Dezembro',
//             'Ano Inteiro'
//           ],
//         ),
//         textLabel(name: 'Meses Mais Chuvosos'),
//         SizedBox(
//           height: 55.h,
//         ),
//         CheckboxGroupFormField(
//           onSaved: (p0) => valoresjson['mesesMaisChuvosos'] = p0,
//           options: [
//             'Janeiro',
//             'Fevereiro',
//             'Março',
//             'Abril',
//             'Maio',
//             'Junho',
//             'Julho',
//             'Agosto',
//             'Setembro',
//             'Outubro',
//             'Novembro',
//             'Dezembro',
//             'Ano Inteiro'
//           ],
//         ),
//         textLabel(name: 'Meses Menos Chuvosos'),
//         SizedBox(
//           height: 55.h,
//         ),
//         CheckboxGroupFormField(
//           onSaved: (p0) => valoresjson['mesesMenosChuvosos'] = p0,
//           options: [
//             'Janeiro',
//             'Fevereiro',
//             'Março',
//             'Abril',
//             'Maio',
//             'Junho',
//             'Julho',
//             'Agosto',
//             'Setembro',
//             'Outubro',
//             'Novembro',
//             'Dezembro',
//             'Ano Inteiro'
//           ],
//         ),
//         CustomTextField(
//           name: "Altitude Média (em m)",
//           getValue: (p0) => valoresjson['altitudeMedia'] = p0,
//           controller: getController('altitudeMedia'),
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           keyboardType: TextInputType.numberWithOptions(),
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(
//           name: "Equipamentos, instalações e serviços públicos",
//           fontWeight: FontWeight.bold,
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(
//           name: "Abastecimento de Água",
//           fontWeight: FontWeight.bold,
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(name: 'Tipo de Abastecimento'),
//         SizedBox(
//           height: 55.h,
//         ),
//         RadioFormField(
//             onSaved: (newValue) =>
//                 valoresjson['tipoDeAbastecimento'] = newValue,
//             options: [
//               'Água Não Canalizada',
//               'Canalizada de Poço',
//               'Canalizada de Nascente',
//               'Canalizada de Curso de Água/Barragem',
//               'outro'
//             ]),
//         CustomTextField(
//           name: 'Domicílios Atendidos (%)',
//           getValue: (p0) => valoresjson['qtdeDomiciliosAtendidos'] = p0,
//           controller: getController('qtdeDomiciliosAtendidos'),
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           keyboardType: TextInputType.numberWithOptions(),
//         ),
//         CustomTextField(
//           name: 'Empresa Responsável',
//           getValue: (p0) => valoresjson['empresaResponsável'] = p0,
//           controller: getController('empresaResponsável'),
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(
//           name: 'Serviços de Esgoto',
//           fontWeight: FontWeight.bold,
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(name: 'Coleta e Deposição'),
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Rede de Esgoto'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['redeDeEsgoto'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['redeDeEsgoto'] = newValue;
//                   respostaYoN = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (respostaYoN == 'sim') ...[
//           CustomTextField(
//             name: 'Total Atendido (%)',
//             getValue: (p0) => valoresjson['esgotoTotalAtendidos'] = p0,
//             controller: getController('esgotoTotalAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Urbanos Atendidos (%)',
//             getValue: (p0) => valoresjson['esgotoDomiciliosAtendidos'] = p0,
//             controller: getController('esgotoDomiciliosAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Rurais Atendidos (%)',
//             getValue: (p0) => valoresjson['esgotoRuraisAtendidos'] = p0,
//             controller: getController('esgotoRuraisAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Entidade Responsável',
//             getValue: (p0) => valoresjson['esgotoEntidadeResponsavel'] = p0,
//             controller: getController('esgotoEntidadeResponsavel'),
//           )
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Fossa Séptica'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['fossaSeptica'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['fossaSeptica'] = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (valoresjson['fossaSeptica'] == 'sim') ...[
//           CustomTextField(
//             name: 'Total Atendido (%)',
//             getValue: (p0) => valoresjson['fossaSepticaTotalAtendidos'] = p0,
//             controller: getController('fossaSepticaTotalAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Urbanos Atendidos (%)',
//             getValue: (p0) =>
//                 valoresjson['fossaSepticaDomiciliosAtendidos'] = p0,
//             controller: getController('fossaSepticaDomiciliosAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Rurais Atendidos (%)',
//             getValue: (p0) => valoresjson['fossaSepticaRuraisAtendidos'] = p0,
//             controller: getController('fossaSepticaRuraisAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Entidade Responsável',
//             getValue: (p0) =>
//                 valoresjson['fossaSepticaEntidadeResponsavel'] = p0,
//             controller: getController('fossaSepticaEntidadeResponsavel'),
//           )
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Fossa Rudimentar'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['fossaRudimentar'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['fossaRudimentar'] = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (valoresjson['fossaRudimentar'] == 'sim') ...[
//           CustomTextField(
//             name: 'Total Atendido (%)',
//             getValue: (p0) => valoresjson['fossaRudimentarTotalAtendidos'] = p0,
//             controller: getController('fossaRudimentarTotalAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Urbanos Atendidos (%)',
//             getValue: (p0) =>
//                 valoresjson['fossaRudimentarDomiciliosAtendidos'] = p0,
//             controller: getController('fossaRudimentarDomiciliosAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Rurais Atendidos (%)',
//             getValue: (p0) =>
//                 valoresjson['fossaRudimentarRuraisAtendidos'] = p0,
//             controller: getController('fossaRudimentarRuraisAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Entidade Responsável',
//             getValue: (p0) =>
//                 valoresjson['fossaRudimentarEntidadeResponsavel'] = p0,
//             controller: getController('fossaRudimentarEntidadeResponsavel'),
//           )
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Vala'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['vala'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['vala'] = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (valoresjson['vala'] == 'sim') ...[
//           CustomTextField(
//             name: 'Total Atendido (%)',
//             getValue: (p0) => valoresjson['valaTotalAtendidos'] = p0,
//             controller: getController('valaTotalAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Urbanos Atendidos (%)',
//             getValue: (p0) => valoresjson['valaDomiciliosAtendidos'] = p0,
//             controller: getController('valaDomiciliosAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Rurais Atendidos (%)',
//             getValue: (p0) => valoresjson['valaRuraisAtendidos'] = p0,
//             controller: getController('valaRuraisAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Entidade Responsável',
//             getValue: (p0) => valoresjson['valaEntidadeResponsavel'] = p0,
//             controller: getController('valaEntidadeResponsavel'),
//           )
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Estação de Tratamento'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['estacaoDeTratamento'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['estacaoDeTratamento'] = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (valoresjson['estacaoDeTratamento'] == 'sim') ...[
//           CustomTextField(
//             name: 'Total Atendido (%)',
//             getValue: (p0) =>
//                 valoresjson['estacaoDeTratamentoTotalAtendidos'] = p0,
//             controller: getController('estacaoDeTratamentoTotalAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Urbanos Atendidos (%)',
//             getValue: (p0) =>
//                 valoresjson['estacaoDeTratamentoDomiciliosAtendidos'] = p0,
//             controller: getController('estacaoDeTratamentoDomiciliosAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Rurais Atendidos (%)',
//             getValue: (p0) =>
//                 valoresjson['estacaoDeTratamentoRuraisAtendidos'] = p0,
//             controller: getController('estacaoDeTratamentoRuraisAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Entidade Responsável',
//             getValue: (p0) =>
//                 valoresjson['estacaoDeTratamentoEntidadeResponsavel'] = p0,
//             controller: getController('estacaoDeTratamentoEntidadeResponsavel'),
//           )
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Esgoto Tratado'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['esgotoTratado'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['esgotoTratado'] = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (valoresjson['esgotoTratado'] == 'sim') ...[
//           CustomTextField(
//             name: 'Total Atendido (%)',
//             getValue: (p0) => valoresjson['esgotoTratadoTotalAtendidos'] = p0,
//             controller: getController('esgotoTratadoTotalAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Urbanos Atendidos (%)',
//             getValue: (p0) =>
//                 valoresjson['esgotoTratadoDomiciliosAtendidos'] = p0,
//             controller: getController('esgotoTratadoDomiciliosAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Rurais Atendidos (%)',
//             getValue: (p0) => valoresjson['esgotoTratadoRuraisAtendidos'] = p0,
//             controller: getController('esgotoTratadoRuraisAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Entidade Responsável',
//             getValue: (p0) =>
//                 valoresjson['esgotoTratadoEntidadeResponsavel'] = p0,
//             controller: getController('esgotoTratadoEntidadeResponsavel'),
//           )
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Outros'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['servicoDeEsgotoOutro'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['servicoDeEsgotoOutro'] = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (valoresjson['servicoDeEsgotoOutro'] == 'sim') ...[
//           CustomTextField(
//             name: 'Nome',
//             getValue: (p0) => valoresjson['servicoDeEsgotoOutroNome'] = p0,
//             controller: getController('servicoDeEsgotoOutroTotalNome'),
//           ),
//           CustomTextField(
//             name: 'Total Atendido (%)',
//             getValue: (p0) =>
//                 valoresjson['servicoDeEsgotoOutroTotalAtendidos'] = p0,
//             controller: getController('servicoDeEsgotoOutroTotalAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Urbanos Atendidos (%)',
//             getValue: (p0) =>
//                 valoresjson['servicoDeEsgotoOutroDomiciliosAtendidos'] = p0,
//             controller:
//                 getController('servicoDeEsgotoOutroDomiciliosAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Rurais Atendidos (%)',
//             getValue: (p0) =>
//                 valoresjson['servicoDeEsgotoOutroRuraisAtendidos'] = p0,
//             controller: getController('servicoDeEsgotoOutroRuraisAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Entidade Responsável',
//             getValue: (p0) =>
//                 valoresjson['servicoDeEsgotoOutroEntidadeResponsavel'] = p0,
//             controller:
//                 getController('servicoDeEsgotoOutroEntidadeResponsavel'),
//           )
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(
//           name: 'Serviços de Energia',
//           fontWeight: FontWeight.bold,
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(name: 'Energia Elétrica'),
//         SizedBox(
//           height: 55.h,
//         ),
//         RadioFormField(
//             onSaved: (newValue) => valoresjson['energiaEletrica'] = newValue,
//             options: ['110 Volts', '220 Volts', '110/220 Volts']),
//         CustomTextField(
//           name: 'Capacidade em KVA',
//           getValue: (p0) => valoresjson['capacidadeEmKVA'] = p0,
//           controller: getController('capacidadeEmKVA'),
//           formatter: [FilteringTextInputFormatter.digitsOnly],
//           keyboardType: TextInputType.numberWithOptions(),
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Gerador de Emergência'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['geradorDeEmergencia'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['geradorDeEmergencia'] = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (valoresjson['geradorDeEmergencia'] == 'sim') ...[
//           CustomTextField(
//             name: 'Capacidade em KVA',
//             getValue: (p0) =>
//                 valoresjson['geradorDeEmergenciaCapacidadeEmKVA'] = p0,
//             controller: getController('geradorDeEmergenciaCapacidadeEmKVA'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           )
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(name: 'Abastecimento de Energia'),
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Rede Urbana'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['redeUrbana'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['redeUrbana'] = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (valoresjson['redeUrbana'] == 'sim') ...[
//           CustomTextField(
//             name: 'Total Abastecido (%)',
//             getValue: (p0) => valoresjson['redeUrbanaTotalAbastecido'] = p0,
//             controller: getController('redeUrbanaTotalAbastecido'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Entidade Responsável',
//             getValue: (p0) => valoresjson['redeUrbanaEntidadeResponsável'] = p0,
//             controller: getController('redeUrbanaEntidadeResponsável'),
//           )
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Rede Rural'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['redeRural'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['redeRural'] = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (valoresjson['redeRural'] == 'sim') ...[
//           CustomTextField(
//             name: 'Total Abastecido (%)',
//             getValue: (p0) => valoresjson['redeRuralTotalAbastecido'] = p0,
//             controller: getController('redeRuralTotalAbastecido'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Entidade Responsável',
//             getValue: (p0) => valoresjson['redeRuralEntidadeResponsável'] = p0,
//             controller: getController('redeRuralEntidadeResponsável'),
//           )
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Abastecimento Próprio'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['abastecimentoProprio'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['abastecimentoProprio'] = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (valoresjson['abastecimentoProprio'] == 'sim') ...[
//           CustomTextField(
//             name: 'Total Atendido (%)',
//             getValue: (p0) =>
//                 valoresjson['abastecimentoProprioTotalAtendidos'] = p0,
//             controller: getController('abastecimentoProprioTotalAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Urbanos Atendidos (%)',
//             getValue: (p0) =>
//                 valoresjson['abastecimentoProprioDomiciliosAtendidos'] = p0,
//             controller:
//                 getController('abastecimentoProprioDomiciliosAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Rurais Atendidos (%)',
//             getValue: (p0) =>
//                 valoresjson['abastecimentoProprioRuraisAtendidos'] = p0,
//             controller: getController('abastecimentoProprioRuraisAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Entidade Responsável',
//             getValue: (p0) =>
//                 valoresjson['abastecimentoProprioEntidadeResponsavel'] = p0,
//             controller:
//                 getController('abastecimentoProprioEntidadeResponsavel'),
//           )
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         Row(children: [
//           textLabel(name: 'Outros'),
//           SizedBox(
//             width: sizeScreen.width * 0.09,
//           ),
//           SizedBox(
//               // width: sizeScreen.width * 0.5,
//               //  //height: sizeScreen.height * 0.07,
//               child: ExpansionTileYoN(
//             getValue: (newValue) {
//               if (valoresjson['servicosDeEnergiaOutro'] == newValue) return;

//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (!mounted) return;
//                 setState(() {
//                   valoresjson['servicosDeEnergiaOutro'] = newValue;
//                 });
//               });
//             },
//           )),
//         ]),
//         if (valoresjson['servicosDeEnergiaOutro'] == 'sim') ...[
//           CustomTextField(
//             name: 'Nome',
//             getValue: (p0) => valoresjson['servicosDeEnergiaOutroNome'] = p0,
//             controller: getController('servicosDeEnergiaOutroTotalNome'),
//           ),
//           CustomTextField(
//             name: 'Total Atendido (%)',
//             getValue: (p0) =>
//                 valoresjson['servicosDeEnergiaOutroTotalAtendidos'] = p0,
//             controller: getController('servicosDeEnergiaOutroTotalAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Domicílios Urbanos Atendidos (%)',
//             getValue: (p0) =>
//                 valoresjson['servicosDeEnergiaOutroDomiciliosAtendidos'] = p0,
//             controller:
//                 getController('servicosDeEnergiaOutroDomiciliosAtendidos'),
//             formatter: [FilteringTextInputFormatter.digitsOnly],
//             keyboardType: TextInputType.numberWithOptions(),
//           ),
//           CustomTextField(
//             name: 'Entidade Responsável',
//             getValue: (p0) =>
//                 valoresjson['servicosDeEnergiaOutroEntidadeResponsavel'] = p0,
//             controller:
//                 getController('servicosDeEnergiaOutroEntidadeResponsavel'),
//           ),
//         ],
//         SizedBox(
//           height: 55.h,
//         ),
//         textLabel(
//           name: 'Serviços de Lixo',
//           fontWeight: FontWeight.bold,
//         ),
//         SizedBox(
//           height: 55.h,
//         ),
//       ],
//     );
//   }
// }