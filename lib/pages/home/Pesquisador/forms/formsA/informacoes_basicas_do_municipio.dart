import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
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

                        print(valoresjson);
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
          validator: (value) {
            if (value == null) {
              return "Por favor, selecione uma opção";
            }
            return null;
          },
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
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) => valoresjson['totalFuncionarios'] = p0,
        ),
        CustomTextField(
          controller: getController('porcentagemFuncionariosComDeficiencia'),
          name: "Pessoas com deficiência (%)",
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
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) =>
              valoresjson['totalFuncionariosOrgaoOficialTurismo'] = p0,
        ),
        CustomTextField(
          controller: getController('totalFormacaoSuperiorOrgaoOficialTurismo'),
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
          getValue: (p0) => valoresjson['fundadoresMunicipio'],
        ),
        CustomTextField(
          controller: getController('outrosFatosMunicipio'),
          name: "Outros fatos de importância histórica",
          getValue: (p0) => valoresjson['outrosFatosMunicipio'],
        )
      ],
    );
  }
}

class Caracteristicas extends StatelessWidget {
  const Caracteristicas({super.key});

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
          controller: getController('areaTotalMunicipio'),
          keyboardType: TextInputType.numberWithOptions(),
          name: "Área Total do Município (km²)",
          getValue: (p0) => valoresjson['areaTotalMunicipio'] = p0,
        ),
        CustomTextField(
          keyboardType: TextInputType.numberWithOptions(),
          controller: getController('areaUrbana'),
          name: "Área Urbana (km²)",
          getValue: (p0) => valoresjson['areaUrbana'] = p0,
        ),
        CustomTextField(
          keyboardType: TextInputType.numberWithOptions(),
          controller: getController('areaRural'),
          name: "Área Rural (km²)",
          getValue: (p0) => valoresjson['areaRural'] = p0,
        ),
        CustomTextField(
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
          controller: getController('populacaoTotal'),
          keyboardType: TextInputType.numberWithOptions(),
          name: "População Total (nº hab.)",
          getValue: (p0) => valoresjson['populacaoTotal'] = p0,
        ),
        CustomTextField(
          keyboardType: TextInputType.numberWithOptions(),
          controller: getController('populacaoUrbana'),
          name: "População Urbana (nº hab.)",
          getValue: (p0) => valoresjson['populacaoUrbana'] = p0,
        ),
        CustomTextField(
          keyboardType: TextInputType.numberWithOptions(),
          controller: getController('populacaoRural'),
          name: "População Rural (nº hab.)",
          getValue: (p0) => valoresjson['populacaoRural'] = p0,
        ),
        CustomTextField(
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
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) => valoresjson['temperaturaMedia'],
        ),
        CustomTextField(
          controller: getController('temperaturaMinima'),
          name: 'Mínima (ºC)',
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) => valoresjson['temperaturaMinima'],
        ),
        CustomTextField(
          controller: getController('temperaturaMaxima'),
          name: 'Máxima (ºC)',
          keyboardType: TextInputType.numberWithOptions(),
          getValue: (p0) => valoresjson['temperaturaMaxima'],
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
          keyboardType: TextInputType.numberWithOptions(),
        ),
        SizedBox(height: 55.h,),
        textLabel(name: "Equipamentos, instalações e serviços públicos", fontWeight: FontWeight.bold,),
        SizedBox(height: 55.h,),

        textLabel(name: "Abastecimento de Água")
      ],
    );
  }
}
