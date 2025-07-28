import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/expandedTileYoN.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/sizedBox.dart';
import 'package:inventur/utils/validators.dart';

final Map<String, dynamic> valoresjson = {};
final Validators _validators = Validators();
final Map<String, TextEditingController> controllers = {};

TextEditingController getController(String key) {
  controllers[key] ??= TextEditingController();
  return controllers[key]!;
}

class InformacoesBasicasDoMunicipio extends StatefulWidget {
  const InformacoesBasicasDoMunicipio({super.key});

  @override
  State<InformacoesBasicasDoMunicipio> createState() =>
      _InformacoesBasicasDoMunicipioState();
}

class _InformacoesBasicasDoMunicipioState
    extends State<InformacoesBasicasDoMunicipio> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    controllers.forEach((key, controllers) => controllers.dispose());
    controllers.clear();
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Identificacao(),
                InformacoesGerais(),
                Caracteristicas(),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      } else {
                        _formKey.currentState!.save();

                        print(valoresjson.containsKey(
                            'servicoDeEsgotoOutroEntidadeResponsavel'));
                        valoresjson.containsKey('redeUrbanaEntidadeResponsável')
                            ? print(valoresjson)
                            : print("too bad bitch");
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('preencha os dados!')));
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Enviar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25), // Use um fontSize fixo
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class Identificacao extends StatelessWidget {
  const Identificacao({super.key});

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
          onSaved: (newValue) => valoresjson['tipo'] = newValue,
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

class InformacoesGerais extends StatelessWidget {
  const InformacoesGerais({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    // TODO: implement build
    return Column(
      children: [
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
          controller: getController('enderecoPrefeituraAvenidaRua'),
          name: "Avenida/rua/travessa/caminho/outro",
          getValue: (p0) => valoresjson['enderecoPrefeituraAvenidaRua'] = p0,
        ),
        CustomTextField(
          controller: getController('enderecoPrefeituraBairro'),
          name: "Bairro",
          getValue: (p0) => valoresjson['enderecoPrefeituraBairro'] = p0,
        ),
        CustomTextField(
          controller: getController('prefeituraCEP'),
          formatter: [
            FilteringTextInputFormatter.digitsOnly,
            _validators.cepFormatter
          ],
          name: 'CEP',
          getValue: (newValue) {
            valoresjson['prefeituraCEP'] = newValue;
          },
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
          controller: getController('whatsapp'),
          name: 'Whatsapp',
          getValue: (newValue) {
            valoresjson['whatsapp'] = newValue;
          },
        ),
        CustomTextField(
          controller: getController('instagram'),
          name: 'Instagram',
          getValue: (newvalue) {
            valoresjson['instagram'] = newvalue;
          },
        ),
        CustomTextField(
          controller: getController('email'),
          name: 'E-mail',
          getValue: (newValue) {
            valoresjson['email'] = newValue;
          },
        ),
        CustomTextField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: getController('CNPJ'),
            name: 'CNPJ',
            validat: _validators.validarCNPJ,
            formatter: [_validators.cnpjFormatter],
            getValue: (newValue) {
              valoresjson['CNPJ'] = newValue;
            }),
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "Coordenadas Geográficas",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('longitude'),
          name: 'Longitude',
          keyboardType: TextInputType.numberWithOptions(),
          formatter: [
            FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))
          ],
          getValue: (newValue) {
            valoresjson['longitude'] = newValue;
          },
        ),
        CustomTextField(
          controller: getController('latitude'),
          name: 'Latitude',
          keyboardType: TextInputType.numberWithOptions(),
          formatter: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^-?\d*\.?\d*'),
            ),
          ],
          getValue: (newValue) {
            valoresjson['latitude'] = newValue;
          },
        ),
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "Municípios Limítrofes",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('municipiosLimitrofes'),
          name: "Municípios",
          getValue: (p0) => valoresjson['municipiosLimitrofes'] = p0,
        ),
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "Distância da Capital (km)",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('distanciaDaCapital'),
          name: "(km)",
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) => valoresjson['distanciaDaCapital'] = p0,
        ),
        SizedBox(
          height: 55.w,
        ),
        textLabel(
          name: "Quantidade de Funcionários",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('totalFuncionarios'),
          name: "Total (nº)",
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) => valoresjson['totalFuncionarios'] = p0,
        ),
        CustomTextField(
          controller: getController('porcentagemFuncionariosComDeficiencia'),
          name: "Pessoas com deficiência (%)",
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) =>
              valoresjson['porcentagemFuncionariosComDeficiencia'] = p0,
        ),
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "Nome do Prefeito",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('nomeDoPrefeito'),
          name: 'Nome',
          getValue: (p0) => valoresjson['nomeDoPrefeito'] = p0,
        ),
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "Nomes das secretarias, departamentos e outro",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('nomeSecretarias'),
          name: 'Nome(s)',
          getValue: (p0) => valoresjson['nomeSecretarias'] = p0,
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
          getValue: (p0) => valoresjson['nomeOrgaoOficialTurismo'] = p0,
          controller: getController('nomeOrgaoOficialTurismo'),
        ),
        SizedBox(
          height: 55.h,
        ),
        textLabel(name: "Endereço"),
        CustomTextField(
          controller: getController('avenidaRuaOrgaoOficialTurismo'),
          name: "Avenida/rua/travessa/caminho/outro",
          getValue: (p0) => valoresjson['avenidaRuaOrgaoOficialTurismo'] = p0,
        ),
        CustomTextField(
          controller: getController('bairroLocalidadeOrgaoOficialTurismo'),
          name: "Bairro/localidade",
          getValue: (p0) =>
              valoresjson['bairroLocalidadeOrgaoOficialTurismo'] = p0,
        ),
        CustomTextField(
          controller: getController('distritoOrgaoOficialTurismo'),
          name: "Distrito",
          getValue: (p0) => valoresjson['distritoOrgaoOficialTurismo'] = p0,
        ),
        CustomTextField(
          controller: getController('CEPOrgaoOficialTurismo'),
          formatter: [
            FilteringTextInputFormatter.digitsOnly,
            _validators.cepFormatter
          ],
          name: 'CEP',
          getValue: (newValue) {
            valoresjson['CEPOrgaoOficialTurismo'] = newValue;
          },
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
          controller: getController('numeroOrgaoOficialTurismo'),
          name: 'Número',
          getValue: (newValue) {
            valoresjson['numeroOrgaoOficialTurismo'] = newValue;
          },
        ),
        CustomTextField(
          controller: getController('instagramOrgaoOficialTurismo'),
          name: 'Instagram',
          getValue: (newvalue) {
            valoresjson['instagramOrgaoOficialTurismo'] = newvalue;
          },
        ),
        CustomTextField(
          controller: getController('emailOrgaoOficialTurismo'),
          name: 'E-mail',
          getValue: (newValue) {
            valoresjson['emailOrgaoOficialTurismo'] = newValue;
          },
        ),
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "Quantidade de Funcionários",
        ),
        CustomTextField(
          controller: getController('totalFuncionariosOrgaoOficialTurismo'),
          name: "Total (nº)",
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) =>
              valoresjson['totalFuncionariosOrgaoOficialTurismo'] = p0,
        ),
        CustomTextField(
          controller: getController('totalFormacaoSuperiorOrgaoOficialTurismo'),
          formatter: [FilteringTextInputFormatter.digitsOnly],
          name: "Formação superior em Turismo (nº)",
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) =>
              valoresjson['totalFormacaoSuperiorOrgaoOficialTurismo'] = p0,
        ),
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "Instâncias de Governança, Associativas, Parcerias e Outros",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController("instanciaDeGovernancaMunicipal"),
          name: "Municipal",
          getValue: (p0) => valoresjson['instanciaDeGovernancaMunicipal'] = p0,
        ),
        CustomTextField(
          controller: getController("instanciaDeGovernancaEstadual"),
          name: "Estadual",
          getValue: (p0) => valoresjson['instanciaDeGovernancaEstadual'] = p0,
        ),
        CustomTextField(
          controller: getController("instanciaDeGovernancaRegional"),
          name: "Regional",
          getValue: (p0) => valoresjson['instanciaDeGovernancaRegional'] = p0,
        ),
        CustomTextField(
          controller: getController("instanciaDeGovernancaNacional"),
          name: "Nacional",
          getValue: (p0) => valoresjson['instanciaDeGovernancaNacional'] = p0,
        ),
        CustomTextField(
          controller: getController("instanciaDeGovernancaInternacional"),
          name: "Internacional",
          getValue: (p0) =>
              valoresjson['instanciaDeGovernancaInternacional'] = p0,
        ),
        CustomTextField(
          controller: getController("instanciaDeGovernancaOutras"),
          name: "Outras",
          getValue: (p0) => valoresjson['instanciaDeGovernancaOutras'] = p0,
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
                    dateController: getController('aniversarioDoMunicipio'),
                    getValue: (newValue) {
                      valoresjson['aniversarioDoMunicipio'] = newValue;
                    })),
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
          getValue: (p0) => valoresjson['nomeDoSanto'] = p0,
          controller: getController('nomeDoSanto'),
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
                    dateController: getController('diaDoSantoPadroeiro'),
                    getValue: (newValue) {
                      valoresjson['diaDoSantoPadroeiro'] = newValue;
                    })),
          ],
        ),
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "Outros feriados municipais",
          fontWeight: FontWeight.bold,
        ),
        CustomTextDate(
          getValue: (p0) => valoresjson['outroFeriado01'] = p0,
        ),
        CustomTextDate(
          getValue: (p0) => valoresjson['outroFeriado02'] = p0,
        ),
        CustomTextDate(
          getValue: (p0) => valoresjson['outroFeriado03'] = p0,
        ),
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "História do Município",
          fontWeight: FontWeight.bold,
        ),
        CustomTextField(
          controller: getController('origemDoNome'),
          name: "Origem do Nome",
          getValue: (p0) => valoresjson['origemDoNome'] = p0,
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
                    dateController: getController('dataFundacaoMunicipio'),
                    getValue: (newValue) {
                      valoresjson['dataFundacaoMunicipio'] = newValue;
                    })),
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
                    dateController: getController('dataFundacaoMunicipio'),
                    getValue: (newValue) {
                      valoresjson['dataFundacaoMunicipio'] = newValue;
                    })),
          ],
        ),
        CustomTextField(
          controller: getController('fundadoresMunicipio'),
          name: "Fundadores",
          getValue: (p0) => valoresjson['fundadoresMunicipio'] = p0,
        ),
        CustomTextField(
          controller: getController('outrosFatosMunicipio'),
          name: "Outros fatos de importância histórica",
          getValue: (p0) => valoresjson['outrosFatosMunicipio'] = p0,
        )
      ],
    );
  }
}

class Caracteristicas extends StatefulWidget {
  const Caracteristicas({super.key});

  @override
  State<Caracteristicas> createState() => _CaracteristicasState();
}

class _CaracteristicasState extends State<Caracteristicas> {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    String respostaYoN = valoresjson['redeDeEsgoto'] ?? '';
    // TODO: implement build
    return Column(
      children: [
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
          controller: getController('areaTotalMunicipio'),
          keyboardType: TextInputType.numberWithOptions(),
          name: "Área Total do Município (km²)",
          getValue: (p0) => valoresjson['areaTotalMunicipio'] = p0,
        ),
        CustomTextField(
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
          controller: getController('areaUrbana'),
          name: "Área Urbana (km²)",
          getValue: (p0) => valoresjson['areaUrbana'] = p0,
        ),
        CustomTextField(
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
          controller: getController('areaRural'),
          name: "Área Rural (km²)",
          getValue: (p0) => valoresjson['areaRural'] = p0,
        ),
        CustomTextField(
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
          controller: getController('anoBase'),
          name: "Ano-Base",
          getValue: (p0) => valoresjson['anoBase'] = p0,
        ),
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: 'População',
        ),
        CustomTextField(
          formatter: [FilteringTextInputFormatter.digitsOnly],
          controller: getController('populacaoTotal'),
          keyboardType: TextInputType.numberWithOptions(),
          name: "População Total (nº hab.)",
          getValue: (p0) => valoresjson['populacaoTotal'] = p0,
        ),
        CustomTextField(
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
          controller: getController('populacaoUrbana'),
          name: "População Urbana (nº hab.)",
          getValue: (p0) => valoresjson['populacaoUrbana'] = p0,
        ),
        CustomTextField(
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
          controller: getController('populacaoRural'),
          name: "População Rural (nº hab.)",
          getValue: (p0) => valoresjson['populacaoRural'] = p0,
        ),
        CustomTextField(
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
          controller: getController('anoBasePopulacao'),
          name: "Ano-Base",
          getValue: (p0) => valoresjson['anoBasePopulacao'] = p0,
        ),
        SizedBox(
          height: 55.h,
        ),
        textLabel(name: 'Temperatura e Chuvas'),
        CustomTextField(
          controller: getController('temperaturaMedia'),
          name: 'Média (ºC)',
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) => valoresjson['temperaturaMedia'] = p0,
        ),
        CustomTextField(
          formatter: [FilteringTextInputFormatter.digitsOnly],
          controller: getController('temperaturaMinima'),
          name: 'Mínima (ºC)',
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) => valoresjson['temperaturaMinima'] = p0,
        ),
        CustomTextField(
          formatter: [FilteringTextInputFormatter.digitsOnly],
          controller: getController('temperaturaMaxima'),
          name: 'Máxima (ºC)',
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) => valoresjson['temperaturaMaxima'] = p0,
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
          onSaved: (p0) => valoresjson['mesesMaisFrios'] = p0,
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
          onSaved: (p0) => valoresjson['mesesMaisQuentes'] = p0,
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
          onSaved: (p0) => valoresjson['mesesMaisChuvosos'] = p0,
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
          onSaved: (p0) => valoresjson['mesesMenosChuvosos'] = p0,
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
          getValue: (p0) => valoresjson['altitudeMedia'] = p0,
          controller: getController('altitudeMedia'),
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
            onSaved: (newValue) =>
                valoresjson['tipoDeAbastecimento'] = newValue,
            options: [
              'Água Não Canalizada',
              'Canalizada de Poço',
              'Canalizada de Nascente',
              'Canalizada de Curso de Água/Barragem',
              'outro'
            ]),
        CustomTextField(
          name: 'Domicílios Atendidos (%)',
          getValue: (p0) => valoresjson['qtdeDomiciliosAtendidos'] = p0,
          controller: getController('qtdeDomiciliosAtendidos'),
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Empresa Responsável',
          getValue: (p0) => valoresjson['empresaResponsável'] = p0,
          controller: getController('empresaResponsável'),
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
        Row(children: [
          textLabel(name: 'Rede de Esgoto'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['redeDeEsgoto'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['redeDeEsgoto'] = newValue;
                  respostaYoN = newValue;
                });
              });
            },
          )),
        ]),
        if (respostaYoN == 'sim') ...[
          CustomTextField(
            name: 'Total Atendido (%)',
            getValue: (p0) => valoresjson['esgotoTotalAtendidos'] = p0,
            controller: getController('esgotoTotalAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Urbanos Atendidos (%)',
            getValue: (p0) => valoresjson['esgotoDomiciliosAtendidos'] = p0,
            controller: getController('esgotoDomiciliosAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Rurais Atendidos (%)',
            getValue: (p0) => valoresjson['esgotoRuraisAtendidos'] = p0,
            controller: getController('esgotoRuraisAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Entidade Responsável',
            getValue: (p0) => valoresjson['esgotoEntidadeResponsavel'] = p0,
            controller: getController('esgotoEntidadeResponsavel'),
          )
        ],
        SizedBox(
          height: 55.h,
        ),
        Row(children: [
          textLabel(name: 'Fossa Séptica'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['fossaSeptica'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['fossaSeptica'] = newValue;
                });
              });
            },
          )),
        ]),
        if (valoresjson['fossaSeptica'] == 'sim') ...[
          CustomTextField(
            name: 'Total Atendido (%)',
            getValue: (p0) => valoresjson['fossaSepticaTotalAtendidos'] = p0,
            controller: getController('fossaSepticaTotalAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Urbanos Atendidos (%)',
            getValue: (p0) =>
                valoresjson['fossaSepticaDomiciliosAtendidos'] = p0,
            controller: getController('fossaSepticaDomiciliosAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Rurais Atendidos (%)',
            getValue: (p0) => valoresjson['fossaSepticaRuraisAtendidos'] = p0,
            controller: getController('fossaSepticaRuraisAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Entidade Responsável',
            getValue: (p0) =>
                valoresjson['fossaSepticaEntidadeResponsavel'] = p0,
            controller: getController('fossaSepticaEntidadeResponsavel'),
          )
        ],
        SizedBox(
          height: 55.h,
        ),
        Row(children: [
          textLabel(name: 'Fossa Rudimentar'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['fossaRudimentar'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['fossaRudimentar'] = newValue;
                });
              });
            },
          )),
        ]),
        if (valoresjson['fossaRudimentar'] == 'sim') ...[
          CustomTextField(
            name: 'Total Atendido (%)',
            getValue: (p0) => valoresjson['fossaRudimentarTotalAtendidos'] = p0,
            controller: getController('fossaRudimentarTotalAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Urbanos Atendidos (%)',
            getValue: (p0) =>
                valoresjson['fossaRudimentarDomiciliosAtendidos'] = p0,
            controller: getController('fossaRudimentarDomiciliosAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Rurais Atendidos (%)',
            getValue: (p0) =>
                valoresjson['fossaRudimentarRuraisAtendidos'] = p0,
            controller: getController('fossaRudimentarRuraisAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Entidade Responsável',
            getValue: (p0) =>
                valoresjson['fossaRudimentarEntidadeResponsavel'] = p0,
            controller: getController('fossaRudimentarEntidadeResponsavel'),
          )
        ],
        SizedBox(
          height: 55.h,
        ),
        Row(children: [
          textLabel(name: 'Vala'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['vala'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['vala'] = newValue;
                });
              });
            },
          )),
        ]),
        if (valoresjson['vala'] == 'sim') ...[
          CustomTextField(
            name: 'Total Atendido (%)',
            getValue: (p0) => valoresjson['valaTotalAtendidos'] = p0,
            controller: getController('valaTotalAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Urbanos Atendidos (%)',
            getValue: (p0) => valoresjson['valaDomiciliosAtendidos'] = p0,
            controller: getController('valaDomiciliosAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Rurais Atendidos (%)',
            getValue: (p0) => valoresjson['valaRuraisAtendidos'] = p0,
            controller: getController('valaRuraisAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Entidade Responsável',
            getValue: (p0) => valoresjson['valaEntidadeResponsavel'] = p0,
            controller: getController('valaEntidadeResponsavel'),
          )
        ],
        SizedBox(
          height: 55.h,
        ),
        Row(children: [
          textLabel(name: 'Estação de Tratamento'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['estacaoDeTratamento'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['estacaoDeTratamento'] = newValue;
                });
              });
            },
          )),
        ]),
        if (valoresjson['estacaoDeTratamento'] == 'sim') ...[
          CustomTextField(
            name: 'Total Atendido (%)',
            getValue: (p0) =>
                valoresjson['estacaoDeTratamentoTotalAtendidos'] = p0,
            controller: getController('estacaoDeTratamentoTotalAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Urbanos Atendidos (%)',
            getValue: (p0) =>
                valoresjson['estacaoDeTratamentoDomiciliosAtendidos'] = p0,
            controller: getController('estacaoDeTratamentoDomiciliosAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Rurais Atendidos (%)',
            getValue: (p0) =>
                valoresjson['estacaoDeTratamentoRuraisAtendidos'] = p0,
            controller: getController('estacaoDeTratamentoRuraisAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Entidade Responsável',
            getValue: (p0) =>
                valoresjson['estacaoDeTratamentoEntidadeResponsavel'] = p0,
            controller: getController('estacaoDeTratamentoEntidadeResponsavel'),
          )
        ],
        SizedBox(
          height: 55.h,
        ),
        Row(children: [
          textLabel(name: 'Esgoto Tratado'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['esgotoTratado'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['esgotoTratado'] = newValue;
                });
              });
            },
          )),
        ]),
        if (valoresjson['esgotoTratado'] == 'sim') ...[
          CustomTextField(
            name: 'Total Atendido (%)',
            getValue: (p0) => valoresjson['esgotoTratadoTotalAtendidos'] = p0,
            controller: getController('esgotoTratadoTotalAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Urbanos Atendidos (%)',
            getValue: (p0) =>
                valoresjson['esgotoTratadoDomiciliosAtendidos'] = p0,
            controller: getController('esgotoTratadoDomiciliosAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Rurais Atendidos (%)',
            getValue: (p0) => valoresjson['esgotoTratadoRuraisAtendidos'] = p0,
            controller: getController('esgotoTratadoRuraisAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Entidade Responsável',
            getValue: (p0) =>
                valoresjson['esgotoTratadoEntidadeResponsavel'] = p0,
            controller: getController('esgotoTratadoEntidadeResponsavel'),
          )
        ],
        SizedBox(
          height: 55.h,
        ),
        Row(children: [
          textLabel(name: 'Outros'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['servicoDeEsgotoOutro'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['servicoDeEsgotoOutro'] = newValue;
                });
              });
            },
          )),
        ]),
        if (valoresjson['servicoDeEsgotoOutro'] == 'sim') ...[
          CustomTextField(
            name: 'Nome',
            getValue: (p0) => valoresjson['servicoDeEsgotoOutroNome'] = p0,
            controller: getController('servicoDeEsgotoOutroTotalNome'),
          ),
          CustomTextField(
            name: 'Total Atendido (%)',
            getValue: (p0) =>
                valoresjson['servicoDeEsgotoOutroTotalAtendidos'] = p0,
            controller: getController('servicoDeEsgotoOutroTotalAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Urbanos Atendidos (%)',
            getValue: (p0) =>
                valoresjson['servicoDeEsgotoOutroDomiciliosAtendidos'] = p0,
            controller:
                getController('servicoDeEsgotoOutroDomiciliosAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Rurais Atendidos (%)',
            getValue: (p0) =>
                valoresjson['servicoDeEsgotoOutroRuraisAtendidos'] = p0,
            controller: getController('servicoDeEsgotoOutroRuraisAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Entidade Responsável',
            getValue: (p0) =>
                valoresjson['servicoDeEsgotoOutroEntidadeResponsavel'] = p0,
            controller:
                getController('servicoDeEsgotoOutroEntidadeResponsavel'),
          )
        ],
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
            onSaved: (newValue) => valoresjson['energiaEletrica'] = newValue,
            options: ['110 Volts', '220 Volts', '110/220 Volts']),
        CustomTextField(
          name: 'Capacidade em KVA',
          getValue: (p0) => valoresjson['capacidadeEmKVA'] = p0,
          controller: getController('capacidadeEmKVA'),
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        SizedBox(
          height: 55.h,
        ),
        Row(children: [
          textLabel(name: 'Gerador de Emergência'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['geradorDeEmergencia'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['geradorDeEmergencia'] = newValue;
                });
              });
            },
          )),
        ]),
        if (valoresjson['geradorDeEmergencia'] == 'sim') ...[
          CustomTextField(
            name: 'Capacidade em KVA',
            getValue: (p0) =>
                valoresjson['geradorDeEmergenciaCapacidadeEmKVA'] = p0,
            controller: getController('geradorDeEmergenciaCapacidadeEmKVA'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          )
        ],
        SizedBox(
          height: 55.h,
        ),
        textLabel(name: 'Abastecimento de Energia'),
        SizedBox(
          height: 55.h,
        ),
        Row(children: [
          textLabel(name: 'Rede Urbana'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['redeUrbana'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['redeUrbana'] = newValue;
                });
              });
            },
          )),
        ]),
        if (valoresjson['redeUrbana'] == 'sim') ...[
          CustomTextField(
            name: 'Total Abastecido (%)',
            getValue: (p0) => valoresjson['redeUrbanaTotalAbastecido'] = p0,
            controller: getController('redeUrbanaTotalAbastecido'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Entidade Responsável',
            getValue: (p0) => valoresjson['redeUrbanaEntidadeResponsável'] = p0,
            controller: getController('redeUrbanaEntidadeResponsável'),
          )
        ],
        SizedBox(
          height: 55.h,
        ),
        Row(children: [
          textLabel(name: 'Rede Rural'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['redeRural'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['redeRural'] = newValue;
                });
              });
            },
          )),
        ]),
        if (valoresjson['redeRural'] == 'sim') ...[
          CustomTextField(
            name: 'Total Abastecido (%)',
            getValue: (p0) => valoresjson['redeRuralTotalAbastecido'] = p0,
            controller: getController('redeRuralTotalAbastecido'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Entidade Responsável',
            getValue: (p0) => valoresjson['redeRuralEntidadeResponsável'] = p0,
            controller: getController('redeRuralEntidadeResponsável'),
          )
        ],
        SizedBox(
          height: 55.h,
        ),
        Row(children: [
          textLabel(name: 'Abastecimento Próprio'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['abastecimentoProprio'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['abastecimentoProprio'] = newValue;
                });
              });
            },
          )),
        ]),
        if (valoresjson['abastecimentoProprio'] == 'sim') ...[
          CustomTextField(
            name: 'Total Atendido (%)',
            getValue: (p0) =>
                valoresjson['abastecimentoProprioTotalAtendidos'] = p0,
            controller: getController('abastecimentoProprioTotalAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Urbanos Atendidos (%)',
            getValue: (p0) =>
                valoresjson['abastecimentoProprioDomiciliosAtendidos'] = p0,
            controller:
                getController('abastecimentoProprioDomiciliosAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Rurais Atendidos (%)',
            getValue: (p0) =>
                valoresjson['abastecimentoProprioRuraisAtendidos'] = p0,
            controller: getController('abastecimentoProprioRuraisAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Entidade Responsável',
            getValue: (p0) =>
                valoresjson['abastecimentoProprioEntidadeResponsavel'] = p0,
            controller:
                getController('abastecimentoProprioEntidadeResponsavel'),
          )
        ],
        SizedBox(
          height: 55.h,
        ),
        Row(children: [
          textLabel(name: 'Outros'),
          SizedBox(
            width: sizeScreen.width * 0.09,
          ),
          SizedBox(
              // width: sizeScreen.width * 0.5,
              //  //height: sizeScreen.height * 0.07,
              child: ExpansionTileYoN(
            getValue: (newValue) {
              if (valoresjson['servicosDeEnergiaOutro'] == newValue) return;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                setState(() {
                  valoresjson['servicosDeEnergiaOutro'] = newValue;
                });
              });
            },
          )),
        ]),
        if (valoresjson['servicosDeEnergiaOutro'] == 'sim') ...[
          CustomTextField(
            name: 'Nome',
            getValue: (p0) => valoresjson['servicosDeEnergiaOutroNome'] = p0,
            controller: getController('servicosDeEnergiaOutroTotalNome'),
          ),
          CustomTextField(
            name: 'Total Atendido (%)',
            getValue: (p0) =>
                valoresjson['servicosDeEnergiaOutroTotalAtendidos'] = p0,
            controller: getController('servicosDeEnergiaOutroTotalAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Domicílios Urbanos Atendidos (%)',
            getValue: (p0) =>
                valoresjson['servicosDeEnergiaOutroDomiciliosAtendidos'] = p0,
            controller:
                getController('servicosDeEnergiaOutroDomiciliosAtendidos'),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(
            name: 'Entidade Responsável',
            getValue: (p0) =>
                valoresjson['servicosDeEnergiaOutroEntidadeResponsavel'] = p0,
            controller:
                getController('servicosDeEnergiaOutroEntidadeResponsavel'),
          ),
        ],
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
      ],
    );
  }
}
