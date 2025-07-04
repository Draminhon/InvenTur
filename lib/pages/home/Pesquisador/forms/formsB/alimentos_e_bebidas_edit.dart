import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/forms/alimentos_bebidas_model.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/tables.dart';
import 'package:inventur/services/form_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../widgets/expandedTileYoN.dart';
import 'widgets/checkBox.dart';
import 'widgets/sendButton.dart';

final GlobalKey<CheckCState> tipo_de_organizacao_key = GlobalKey<CheckCState>();
final GlobalKey<CheckCState> proximidades_key = GlobalKey<CheckCState>();
final GlobalKey<CheckCState> formas_de_pagamento_key = GlobalKey<CheckCState>();
final GlobalKey<CheckCState> vendas_e_reservas_key = GlobalKey<CheckCState>();
final GlobalKey<CheckCState> atendimento_em_lingua_estrangeira_key =
    GlobalKey<CheckCState>();
final GlobalKey<CheckCState> informativos_impressos_key =
    GlobalKey<CheckCState>();

class AlimentoseBebidasEdit extends StatefulWidget {
  final AlimentosEBebidas? alimentosModel;
  AlimentoseBebidasEdit({super.key, this.alimentosModel});

  @override
  State<AlimentoseBebidasEdit> createState() => _AlimentoseBebidasEditState();
}

class _AlimentoseBebidasEditState extends State<AlimentoseBebidasEdit> {

  FormService _formService = FormService();

  final Map<String, dynamic> valoresjson = {
    'tipo_formulario': 'Alimentos e bebidas',
    'nome_pesquisador': 'jose',
    'telefone_pesquisador': '12453',
    'email_pesquisador': 'jose@gmail.com',
    'nome_coordenador': 'oihaioo',
    'telefone_coordenador': '4444',
    'email_coordenador': 'ogaio@gmail.com',
  };
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void autoFillForm() {
    // Verifica se o controlador existe no Map antes de preencher
    void fillIfExists(String key, String value) {
      getController(key).text = value;
    }

    // Preenche os valores dos controladores
    if (widget.alimentosModel != null) {
      fillIfExists('uf', widget.alimentosModel!.uf!);
      fillIfExists('rg', widget.alimentosModel!.regiaoTuristica!);
      fillIfExists('municipio', widget.alimentosModel!.municipio!);
      fillIfExists('observacoes', widget.alimentosModel!.observacoes!);
      fillIfExists('referencias', widget.alimentosModel!.referencias!);
      fillIfExists('nome_pesquisador', widget.alimentosModel!.nomePesquisador!);
      fillIfExists(
          'telefone_pesquisador', widget.alimentosModel!.telefonePesquisador!);
      fillIfExists(
          'email_pesquisador', widget.alimentosModel!.emailPesquisador!);
      fillIfExists('nome_coordenador', widget.alimentosModel!.nomeCoordenador!);
      fillIfExists(
          'telefone_coordenador', widget.alimentosModel!.telefoneCoordenador!);
      fillIfExists(
          'email_coordenador', widget.alimentosModel!.emailCoordenador!);

      // Campos específicos de AlimentosEBebidas
      fillIfExists('razão social', widget.alimentosModel!.razaoSocial!);
      fillIfExists('nome fantasia', widget.alimentosModel!.nomeFantasia!);
      fillIfExists('CNPJ', widget.alimentosModel!.CNPJ!);
      fillIfExists('Código CNAE', widget.alimentosModel!.codigoCNAE!);
      fillIfExists(
          'Atividade Economica', widget.alimentosModel!.atividadeEconomica!);
      fillIfExists(
          'Inscrição Municipal', widget.alimentosModel!.inscricaoMunicipal!);
      fillIfExists('Nome da rede', widget.alimentosModel!.nomeDaRede!);
      fillIfExists(
          'inicio da atividade', widget.alimentosModel!.inicioDaAtividade!);
      fillIfExists('quantidade funcionarios permanentes',
          widget.alimentosModel!.qtdeFuncionariosPermanentes!);
      fillIfExists('Quantidade de funcionarios temporarios',
          widget.alimentosModel!.qtdeFuncionariosTemporarios!);
      fillIfExists('quantidade funcionarios com definicencia',
          widget.alimentosModel!.qtdeFuncionariosComDeficiencia!);
      fillIfExists('latitude', widget.alimentosModel!.latitude!);
      fillIfExists('longitude', widget.alimentosModel!.longitude!);
      fillIfExists('avenida rua', widget.alimentosModel!.avenidaRuaEtc!);
      fillIfExists(
          'bairro localidade', widget.alimentosModel!.bairroLocalidade!);
      fillIfExists('distrito', widget.alimentosModel!.distrito!);
      fillIfExists('CEP', widget.alimentosModel!.CEP!);
      fillIfExists('whatsapp', widget.alimentosModel!.whatsapp!);
      fillIfExists('Instagram', widget.alimentosModel!.instagram!);
      fillIfExists('email', widget.alimentosModel!.email!);
      fillIfExists(
          'sinalizacaoDeAcesso', widget.alimentosModel!.sinalizacaoDeAcesso!);
      fillIfExists(
          'sinalizacaoTuristica', widget.alimentosModel!.sinalizacaoTuristica!);
      fillIfExists(
          'distancia aeroporto', widget.alimentosModel!.distanciasAeroporto!);
      fillIfExists(
          'estação rodoviária', widget.alimentosModel!.distanciasRodoviaria!);
      fillIfExists('estação ferroviária',
          widget.alimentosModel!.distanciaEstacaoFerroviaria!);
      fillIfExists(
          'Estacao maritima', widget.alimentosModel!.distanciaEstacaoMaritima!);
      fillIfExists('estacao metroviaria',
          widget.alimentosModel!.distanciaEstacaoMetroviaria!);
      fillIfExists(
          'ponto de onibus', widget.alimentosModel!.distanciaPontoDeOnibus!);
      fillIfExists(
          'ponto de taxi', widget.alimentosModel!.distanciaPontoDeTaxi!);
      fillIfExists('outras distancias nome',
          widget.alimentosModel!.distanciasOutraNome!);
      fillIfExists(
          'outras distancias', widget.alimentosModel!.distanciaOutras!);
      fillIfExists(
          'ponto de referencia', widget.alimentosModel!.pontosDeReferencia!);
      fillIfExists('estadoGeralDeConservacao',
          widget.alimentosModel!.estadoGeralDeConservacao!);
      fillIfExists(
          'outrosSinalizacao', widget.alimentosModel!.outrosAcessibilidade!);
      fillIfExists('outras regras e informações',
          widget.alimentosModel!.outrasRegraseInformacoes!);
      fillIfExists('capacidade instalada por dia',
          widget.alimentosModel!.capInstaladaPdia!);
      fillIfExists('instaladas pessoas atendidas sentadas',
          widget.alimentosModel!.capInstaladasSentadas!);
      fillIfExists(
          'capacidade simultanea', widget.alimentosModel!.capSimultanea!);
      fillIfExists('simultanea pessoas atendidas sentadas',
          widget.alimentosModel!.capSimultaneaSentadas!);
      fillIfExists(
          'capacidade de veículos', widget.alimentosModel!.capacidadeVeiculos!);
      fillIfExists(
          'numero automoveis', widget.alimentosModel!.numeroAutomoveis!);
      fillIfExists('numero onibus', widget.alimentosModel!.numeroOnibus!);
    }
  }

  TextEditingController getController(String key) {
    controllers[key] ??= TextEditingController();
    return controllers[key]!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllers.forEach((key, controllers) => controllers.dispose());
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    autoFillForm();

    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 55, 111, 60),
          title: const Text(
            'Identificação',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        top: sizeScreen.height * 0.05,
                        left: sizeScreen.width * 0.05),
                    child: Row(
                      children: [
                        SizedBox(
                            width: sizeScreen.width * 0.3,
                            height: sizeScreen.height * 0.045,
                            child: TextFormField(
                              controller: getController('uf'),
                              validator: (value) {
                                return null;
                              },
                              onSaved: (newValue) {
                                valoresjson['uf'] = newValue;
                              },
                              decoration: InputDecoration(
                                  hintText: 'UF',
                                  hintStyle: TextStyle(fontSize: 50.w)),
                            )),
                        SizedBox(
                          width: sizeScreen.width * 0.09,
                        ),
                        SizedBox(
                            width: sizeScreen.width * 0.5,
                            height: sizeScreen.height * 0.045,
                            child: TextFormField(
                              controller: getController('rg'),
                              validator: (value) {
                                return null;
                              },
                              onSaved: (newValue) {
                                valoresjson['regiao_turistica'] = newValue;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Região Turística',
                                  hintStyle: TextStyle(fontSize: 50.w)),
                            ))
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: sizeScreen.width * 0.05,
                      right: sizeScreen.width * 0.1,
                      top: sizeScreen.height * 0.01),
                  child: TextFormField(
                    controller: getController('municipio'),
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Municipio',
                        hintStyle: TextStyle(fontSize: 50.w)),
                    onSaved: (newValue) {
                      valoresjson['municipio'] = newValue;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.w,
                ),
                textLabel(
                  name: 'Tipo:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 50.w,
                ),
                RadioD(
                  indexModel: widget.alimentosModel!.tipo,
                  options: const [
                    'Restaurante',
                    'Bar',
                    'Lanchonete',
                    'Cafeteria',
                    'Quiosque',
                    'Barraca de praia',
                    'Sorveteria',
                    'Confeitaria\nPadaria',
                    'outro'
                  ],
                  getValue: (newValue) {
                    valoresjson['tipo'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                Container(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  height: sizeScreen.height * 0.06,
                  width: sizeScreen.width,
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.008,
                      left: sizeScreen.width * 0.04),
                  child: Text(
                    'Informações Gerais',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: 30.w,
                ),
                CustomTextField(
                    controller: getController('razão social'),
                    name: 'Razão Social',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['razaoSocial'] = newValue;
                    }),
                CustomTextField(
                    controller: getController('nome fantasia'),
                    name: 'Nome Fantasia',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['nomeFantasia'] = newValue;
                    }),
                CustomTextField(
                    controller: getController('CNPJ'),
                    name: 'CNPJ',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['CNPJ'] = newValue;
                    }),

                Row(
                  children: [
                    SizedBox(
                      width: 600.w,
                      child: CustomTextField(
                          controller: getController('Código CNAE'),
                          name: 'Código CNAE',
                          validat: (value) {
                            return null;
                          },
                          getValue: (newValue) {
                            valoresjson['codigoCNAE'] = newValue;
                          }),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: getController('Atividade Economica'),
                        name: 'Atividade Econômica',
                        validat: (value) {},
                        getValue: (value) {
                          valoresjson['atividadeEconomica'] = value;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 600.w,
                      child: CustomTextField(
                          controller: getController('Inscrição Municipal'),
                          name: 'Inscrição Municipal',
                          validat: (value) {
                            return null;
                          },
                          getValue: (newValue) {
                            valoresjson['inscricaoMunicipal'] = newValue;
                          }),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: getController('Nome da rede'),
                        name: 'Nome da rede/holding',
                        validat: (p0) {},
                        getValue: (p0) {
                          valoresjson['nomeDaRede'] = p0;
                        },
                      ),
                    )
                  ],
                ),

                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Column(
                  children: [
                    textLabel(
                      name: 'Natureza:',
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.03,
                    ),
                    RadioD(
                        indexModel: widget.alimentosModel!.natureza,
                        options: const ['pública', 'privada', 'outro'],
                        getValue: (newValue) {
                          valoresjson['natureza'] = newValue;
                        })
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Column(
                  children: [
                    textLabel(
                      name: 'Tipo de organização/instituição:',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.03,
                    ),
                    CheckC(
                      nomesModel:
                          widget.alimentosModel!.tipoDeOrganizacaoInstituicao,
                      key: tipo_de_organizacao_key,
                      nomes: [
                        'associação',
                        'sindicato',
                        'cooperativa',
                        'sistema S',
                        'empresa',
                        'outro'
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(
                  children: [
                    textLabel(
                      name: 'início da atividade:',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: sizeScreen.width * 0.1,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.4,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextDate(
                            dateController:
                                getController('inicio da atividade'),
                            getValue: (newValue) {
                              valoresjson['inicioDaAtividade'] = newValue;
                            }))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                textLabel(
                    name: 'Quantidade de Funcionários:',
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Column(children: [
                  Row(
                    children: [
                      textLabel(name: 'Permanentes'),
                      SizedBox(
                        width: sizeScreen.width * 0.026,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            controller: getController(
                                'quantidade funcionarios permanentes'),
                            name: 'n°',
                            validat: (value) {
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['qtdeFuncionariosPermanentes'] =
                                  newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  Row(
                    children: [
                      textLabel(name: 'Temporários'),
                      SizedBox(
                        width: sizeScreen.width * 0.038,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            controller: getController(
                                'Quantidade de funcionarios temporarios'),
                            name: 'n°',
                            validat: (value) {
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['qtdeFuncionariosTemporarios'] =
                                  newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(height: sizeScreen.height * 0.02),
                  Row(
                    children: [
                      textLabel(name: 'Pessoas com\ndefiicência (%)'),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            controller: getController(
                                'quantidade funcionarios com definicencia'),
                            name: '%',
                            validat: (value) {
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['qtdeFuncionariosComDeficiencia'] =
                                  newValue;
                            },
                          ))
                    ],
                  ),
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(name: 'Localização:', fontWeight: FontWeight.bold),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                RadioD(
                  indexModel: widget.alimentosModel!.localizacao,
                  options: const ['urbana', 'rural'],
                  getValue: (newValue) {
                    valoresjson['localizacao'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                    name: 'Coordenadas Geográficas:',
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Column(children: [
                  Row(
                    children: [
                      textLabel(name: 'Latitude'),
                      SizedBox(
                        width: sizeScreen.width * 0.032,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            controller: getController('latitude'),
                            name: 'valor',
                            validat: (value) {
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['latitude'] = newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  Row(
                    children: [
                      textLabel(name: 'Longitude'),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            controller: getController('longitude'),
                            name: 'valor',
                            validat: (value) {
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['longitude'] = newValue;
                            },
                          ))
                    ],
                  ),
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Endereço:',
                  fontWeight: FontWeight.bold,
                ),
                CustomTextField(
                  controller: getController('avenida rua'),
                  validat: (value) {
                    return null;
                  },
                  name: 'avenida/rua/travessa/caminho/outro',
                  getValue: (newValue) {
                    valoresjson['avenidaRuaEtc'] = newValue;
                  },
                ),
                CustomTextField(
                  controller: getController('bairro localidade'),
                  validat: (value) {
                    return null;
                  },
                  name: 'bairro/localidade',
                  getValue: (newValue) {
                    valoresjson['bairroLocalidade'] = newValue;
                  },
                ),
                CustomTextField(
                  controller: getController('distrito'),
                  validat: (value) {
                    return null;
                  },
                  name: 'distrito',
                  getValue: (newValue) {
                    valoresjson['distrito'] = newValue;
                  },
                ),
                CustomTextField(
                  controller: getController('CEP'),
                  validat: (value) {
                    return null;
                  },
                  name: 'CEP',
                  getValue: (newValue) {
                    valoresjson['CEP'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),

                Column(children: [
                  Row(
                    children: [
                      textLabel(
                        name: 'Whatsapp',
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextNumber(
                            controller: getController('whatsapp'),
                            labelText: '(DD) n°',
                            getValue: (newValue) {
                              valoresjson['whatsapp'] = newValue;
                            },
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      textLabel(
                        name: 'Instagram',
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            controller: getController('Instagram'),
                            getValue: (newValue) {
                              valoresjson['instagram'] = newValue;
                            },
                            name: '@',
                            validat: (p0) {},
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                ]),

                Row(
                  children: [
                    textLabel(
                      name: 'E-mail',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: sizeScreen.width * 0.04,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('email'),
                          validat: (value) {
                            return null;
                          },
                          name: 'e-mail',
                          getValue: (newValue) {
                            valoresjson['email'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),

                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Sinalização:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.04,
                ),
                Row(children: [
                  textLabel(name: 'de acessso -'),
                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                    optionModel: widget.alimentosModel!.sinalizacaoDeAcesso,
                    getValue: (newValue) {
                      valoresjson['sinalizacaoDeAcesso'] = newValue;
                    },
                  ))
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(children: [
                  textLabel(name: 'turística -'),
                  SizedBox(
                    width: sizeScreen.width * 0.14,
                  ),
                  SizedBox(
                      //width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                    optionModel: widget.alimentosModel!.sinalizacaoTuristica,
                    getValue: (newValue) {
                      valoresjson['sinalizacaoTuristica'] = newValue;
                    },
                  ))
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),

                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Proximidades:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                //  RadioD(number: 6, options: options)
                CheckC(
                  nomesModel: widget.alimentosModel!.proximidades,
                  key: proximidades_key,
                  nomes: [
                    'Meio de hospedagem',
                    'Shopping',
                    'Galeria/rua comercial',
                    'Centro de convenções/exposições',
                    'Posto de combustível',
                    'outro'
                  ],
                  // getValue: (newValue) {
                  //   valoresjson['Proximidades'] = newValue;
                  // },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Distâncias (km):',
                  fontWeight: FontWeight.bold,
                ),

                Row(
                  children: [
                    textLabel(name: 'Aeroporto:'),
                    SizedBox(
                      width: sizeScreen.width * 0.06,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('distancia aeroporto'),
                          name: '(km)',
                          getValue: (newValue) {
                            valoresjson['distanciasAeroporto'] = newValue;
                          },
                          validat: (value) {
                            return null;
                          },
                        ))
                  ],
                ),

                Row(
                  children: [
                    textLabel(name: 'Estação\nrodoviária:'),
                    SizedBox(
                      width: sizeScreen.width * 0.06,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('estação rodoviária'),
                          name: '(km)',
                          getValue: (newValue) {
                            valoresjson['distanciasRodoviaria'] = newValue;
                          },
                          validat: (value) {
                            return null;
                          },
                        ))
                  ],
                ),

                Row(
                  children: [
                    textLabel(name: 'Estação\nferroviária:'),
                    SizedBox(
                      width: 70.w,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('estação ferroviária'),
                          name: '(km)',
                          getValue: (newValue) {
                            valoresjson['distanciaEstacaoFerroviaria'] =
                                newValue;
                          },
                          validat: (value) {
                            return null;
                          },
                        ))
                  ],
                ),

                Row(
                  children: [
                    textLabel(name: 'Estação\nmarítima\n/fluvial:'),
                    SizedBox(
                      width: 120.w,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('Estacao maritima'),
                          name: '(km)',
                          getValue: (newValue) {
                            valoresjson['distanciaEstacaoMaritima'] = newValue;
                          },
                          validat: (value) {
                            return null;
                          },
                        ))
                  ],
                ),

                Row(
                  children: [
                    textLabel(name: 'Estação\nmetroviária:'),
                    SizedBox(width: 35.w),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('estacao metroviaria'),
                          name: '(km)',
                          getValue: (newValue) {
                            valoresjson['distanciaEstacaoMetroviaria'] =
                                newValue;
                          },
                          validat: (value) {
                            return null;
                          },
                        ))
                  ],
                ),

                Row(
                  children: [
                    textLabel(name: 'Ponto\nde ônibus'),
                    SizedBox(
                      width: 110.w,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('ponto de onibus'),
                          name: '(km)',
                          getValue: (newValue) {
                            valoresjson['distanciaPontoDeOnibus'] = newValue;
                          },
                          validat: (value) {
                            return null;
                          },
                        ))
                  ],
                ),

                Row(
                  children: [
                    textLabel(name: 'Ponto\nde taxi'),
                    SizedBox(
                      width: 190.w,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('ponto de taxi'),
                          name: '(km)',
                          getValue: (newValue) {
                            valoresjson['distanciaPontoDeTaxi'] = newValue;
                          },
                          validat: (value) {
                            return null;
                          },
                        ))
                  ],
                ),

                Row(
                  children: [
                    textLabel(name: 'Outras:'),
                    SizedBox(width: 170.w),
                    SizedBox(
                        width: sizeScreen.width * 0.4,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('outras distancias nome'),
                          name: 'nome',
                          getValue: (newValue) {
                            valoresjson['distanciasOutraNome'] = newValue;
                          },
                          validat: (value) {
                            return null;
                          },
                        )),
                    SizedBox(
                        width: sizeScreen.width * 0.2,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('outras distancias'),
                          name: '(km)',
                          getValue: (newValue) {
                            valoresjson['distanciaOutras'] = newValue;
                          },
                          validat: (value) {
                            return null;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),

                textLabel(
                  name: 'Pontos de referência:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                CustomTextField(
                  controller: getController('ponto de referencia'),
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'ponto de referência',
                  getValue: (newValue) {
                    valoresjson['pontosDeReferencia'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.1,
                ),

                Container(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  height: 300.h,
                  width: sizeScreen.width,
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.008,
                      left: sizeScreen.width * 0.04),
                  child: Text(
                    'Cadastro, classificação e outros',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                TableMtur(
                  getValues: widget.alimentosModel!.tabelaMTUR,
                  onChanged: (p0) {
                    setState(() {
                      valoresjson['tabelaMTUR'] = p0;
                    });
                  },
                  associacao_e_sindicato:
                      'associações e sindicatos do setor de alimentação',
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),

                Container(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  height: sizeScreen.height * 0.06,
                  width: sizeScreen.width,
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.008,
                      left: sizeScreen.width * 0.04),
                  child: Text(
                    'Funcionamento',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                textLabel(
                  name: 'Estrutura de funcionamento:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                textLabel(
                  name: 'Formas de pagamento:',
                  fontWeight: FontWeight.bold,
                ),

                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.formasDePagamento,
                  key: formas_de_pagamento_key,
                  nomes: [
                    'Dinheiro',
                    'Pix',
                    'Cartão de Crédito',
                    'Cartão de Débito'
                  ],
                  // getValue: (newValue) {
                  //   valoresjson['FormaPagamento'] = newValue;
                  // },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Vendas e Reservas:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.vendasEReservas,
                  key: vendas_e_reservas_key,
                  nomes: ['Balcão', 'Whatsapp', 'Site', 'Instagram', 'outro'],
                ),
                SizedBox(
                  height: 70.w,
                ),

                textLabel(
                  name: 'Atendimento ao público:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Atendimento em língua estrangeira:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                CheckC(
                  nomesModel:
                      widget.alimentosModel!.atendimentoEmLinguasEstrangeiras,
                  key: atendimento_em_lingua_estrangeira_key,
                  nomes: ['Não', 'Inglês', 'Espanhol', 'outro'],
                  // getValue: (newValue) {
                  //   valoresjson['LinguaEstrangeira'] = newValue;
                  // }
                ),
                SizedBox(
                  height: 70.w,
                ),
                textLabel(
                  name: 'Informativos impressos:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.informativosImpressos,
                  key: informativos_impressos_key,
                  nomes: ['Não', 'Inglês', 'Espanhol', 'Português', 'outro'],
                  // getValue: (newValue) {
                  //   valoresjson['InformativosImpressos'] = newValue;
                  // },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),

                Container(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  height: sizeScreen.height * 0.06,
                  width: sizeScreen.width,
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.008,
                      left: sizeScreen.width * 0.04),
                  child: Text(
                    'Regras de Funcionamento',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Período:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.periodo,
                  onChanged: (p0) {
                    valoresjson['periodo'] = p0;
                  },
                  nomes: [
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
                  height: 70.w,
                ),
                textLabel(
                  name: 'Horário:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.01,
                ),

                TabelaHorarios(
                  getValue: widget.alimentosModel!.tabelasHorario,
                  onChanged: (p0) {
                    setState(() {
                      valoresjson['tabelasHorario'] = p0;
                    });
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                textLabel(
                  name: 'Funcionamento 24 horas:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                ExpansionTileYoN(
                  optionModel: widget.alimentosModel!.funcionamento24h,
                  getValue: (newValue) {
                    valoresjson['funcionamento24h'] = newValue;
                  },
                ),
                textLabel(
                  name: 'Funcionamento em feriados:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                ExpansionTileYoN(
                  optionModel: widget.alimentosModel!.funcionamentoEmFeriados,
                  getValue: (newValue) {
                    valoresjson['funcionamentoEmFeriados'] = newValue;
                  },
                ),
                textLabel(
                  name: 'Restrições:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.restricoes,
                  onChanged: (p0) {
                    valoresjson['restricoes'] = p0;
                  },
                  nomes: ['Crianças', 'Fumantes', 'Animais', 'outro'],
                  //getValue: (newValue) {},
                ),
                SizedBox(
                  height: 50.w,
                ),
                textLabel(
                  name: 'Outras regras e informações:',
                  fontWeight: FontWeight.bold,
                ),

                CustomTextField(
                  controller: getController('outras regras e informações'),
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'Outras regras e informações',
                  getValue: (newValue) {
                    valoresjson['outrasRegraseInformacoes'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Capacidade de atendimento:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Capacidade instalada por dia nº:',
                  fontWeight: FontWeight.bold,
                ),

                CustomTextField(
                  controller: getController('capacidade instalada por dia'),
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'nº',
                  getValue: (newValue) {
                    valoresjson['capInstaladaPdia'] = newValue;
                  },
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 50.w,
                    ),
                    textLabel(
                      name: 'Pessoas atendidas sentadas nº:',
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(left: 100.w, right: 50.w),
                  child: CustomTextField(
                    controller:
                        getController('instaladas pessoas atendidas sentadas'),
                    validat: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
                    },
                    name: 'nº',
                    getValue: (newValue) {
                      valoresjson['capInstaladasSentadas'] = newValue;
                    },
                  ),
                ),
                textLabel(
                  name: 'Capacidade simultânea nº:',
                  fontWeight: FontWeight.bold,
                ),

                CustomTextField(
                  controller: getController('capacidade simultanea'),
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'nº',
                  getValue: (newValue) {
                    valoresjson['capSimultanea'] = newValue;
                  },
                ),

                Row(
                  children: [
                    SizedBox(
                      width: 50.w,
                    ),
                    textLabel(
                      name: 'Pessoas atendidas sentadas nº:',
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(left: 100.w, right: 50.w),
                  child: CustomTextField(
                    controller:
                        getController('simultanea pessoas atendidas sentadas'),
                    validat: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
                    },
                    name: 'nº',
                    getValue: (newValue) {
                      valoresjson['capSimultaneaSentadas'] = newValue;
                    },
                  ),
                ),

                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),

                Container(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  height: sizeScreen.height * 0.06,
                  width: sizeScreen.width,
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.008,
                      left: sizeScreen.width * 0.04),
                  child: Text(
                    'Características',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Instalações:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                textLabel(
                  name: 'Estacionamento:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.estacionamento,
                  onChanged: (p0) {
                    valoresjson['estacionamento'] = p0;
                  },
                  nomes: ['Pago', 'Gratuito', 'Coberto', 'Descoberto'],
                ),
                SizedBox(
                  height: 50.w,
                ),
                Column(children: [
                  Row(
                    children: [
                      textLabel(name: 'Capacidade de\nveículos nº'),
                      SizedBox(
                        width: sizeScreen.width * 0.01,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                              controller:
                                  getController('capacidade de veículos'),
                              validat: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Preencha o campo';
                                }
                                return null;
                              },
                              name: '',
                              getValue: (newValue) {
                                valoresjson['capacidadeVeiculos'] = newValue;
                              }))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  Row(
                    children: [
                      textLabel(name: 'Automóveis nº'),
                      SizedBox(
                        width: sizeScreen.width * 0.005,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                              controller: getController('numero automoveis'),
                              validat: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Preencha o campo';
                                }
                                return null;
                              },
                              name: '',
                              getValue: (newValue) {
                                valoresjson['numeroAutomoveis'] = newValue;
                              }))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  Row(
                    children: [
                      textLabel(name: 'Ônibus nº'),
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                              controller: getController('numero onibus'),
                              validat: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Preencha o campo';
                                }
                                return null;
                              },
                              name: '',
                              getValue: (newValue) {
                                valoresjson['numeroOnibus'] = newValue;
                              }))
                    ],
                  ),
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                textLabel(
                  name: 'Serviços e Equipamentos:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.servicosEEquipamentos,
                  onChanged: (p0) => valoresjson['servicosEEquipamentos'] = p0,
                  nomes: [
                    'Música ao vivo',
                    'Atendimento a grupos',
                    'Ventilador',
                    'Adega',
                    'Recreação para crianças',
                    'Cardápio em língua estrangeira',
                    'Música ambiente',
                    'Manobrista',
                    'Internet sem fio',
                    'Área para fumantes',
                    'Carta de vinhos',
                    'Espaço para eventos',
                    'Ar condicionado',
                    'Lareira',
                    'Área de lazer para crianças',
                    'Cardápio em braile',
                    'Sanitário próprio',
                    'outro',
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                textLabel(
                  name: 'Especificação da gastronomia por país:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                CheckC(
                  nomesModel:
                      widget.alimentosModel!.especificacaoDaGastronomiaPorPais,
                  onChanged: (p0) =>
                      valoresjson['especificacaoDaGastronomiaPorPais'] = p0,
                  nomes: [
                    'Não',
                    'Argentina',
                    'Coreana',
                    'Grega',
                    'Judaica',
                    'Polonesa',
                    'Turca',
                    'Alemã',
                    'Asiática',
                    'Escandinava',
                    'Indiana',
                    'Libanesa',
                    'Portuguesa',
                    'Uruguaia',
                    'Americana',
                    'Brasileira',
                    'Espanhola',
                    'Italiana',
                    'Marroquina',
                    'Suíça',
                    'Vietnamita',
                    'Árabe',
                    'Chinesa',
                    'Francesa',
                    'Japonesa',
                    'Mexicana',
                    'Tailandesa',
                    'outro',
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                textLabel(
                  name: 'Se for brasileira, por região:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.seForBrasileiraPorRegiao,
                  onChanged: (p0) =>
                      valoresjson['seForBrasileiraPorRegiao'] = p0,
                  nomes: [
                    'Não',
                    'Amazônica',
                    'Campeira gaúcha',
                    'Capixaba',
                    'Goiana',
                    'Mineira',
                    'Carioca',
                    'Nordestina',
                    'Pantaneira',
                    'Paulista',
                    'outro'
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                textLabel(
                  name: 'Por especialização:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.porEspecializacao,
                  onChanged: (p0) => valoresjson['porEspecializacao'] = p0,
                  nomes: [
                    'Não',
                    'cachaçaria',
                    'cafeteria',
                    'café colonial',
                    'cervejaria',
                    'churrascaria',
                    'creperia',
                    'tapiocaria',
                    'doceria',
                    'empaderia',
                    'frutos do mar',
                    'grelhados (grill)',
                    'galeteria',
                    'pastelaria',
                    'petisqueria',
                    'pizzaria',
                    'sanduicheria',
                    'sucos',
                    'chás',
                    'whiskeria',
                    'sorveteria',
                    'outros'
                  ],
                ),
                SizedBox(
                  height: 55.w,
                ),

                textLabel(
                  name: 'Por tipo de dieta:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 55.w,
                ),
                CheckC(
                    nomesModel: widget.alimentosModel!.porTipoDeDieta,
                    onChanged: (p0) => valoresjson['porTipoDeDieta'] = p0,
                    nomes: [
                      'não',
                      'macrobiótica',
                      'vegetariana',
                      'natural',
                      'outros'
                    ]),

                SizedBox(
                  height: 55.w,
                ),

                textLabel(
                  name: 'Por tipo de serviço:',
                  fontWeight: FontWeight.bold,
                ),

                CheckC(
                    nomesModel: widget.alimentosModel!.porTipoDeServico,
                    onChanged: (p0) => valoresjson['porTipoDeServico'] = p0,
                    nomes: [
                      'a la carte',
                      'self service por preço fixo',
                      'self service por quilo',
                      'rodízio',
                      'rodízio com bufê (buffet)',
                      'drive-thru',
                      'fast food',
                      'delivery',
                      'outros'
                    ]),

                SizedBox(
                  height: 70.w,
                ),

                Container(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  height: sizeScreen.height * 0.15,
                  width: sizeScreen.width,
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.008,
                      left: sizeScreen.width * 0.04),
                  child: Text(
                    'Proteção, Qualificação, Certificação, Premiação, destaques e outros',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                Row(children: [
                  textLabel(
                    name: 'Do equipamento/espaço:',
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: sizeScreen.width * 0.04,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: Padding(
                    padding: EdgeInsets.only(top: sizeScreen.height * 0.04),
                    child: ExpansionTileYoN(
                      optionModel: widget.alimentosModel!.doEquipamento,
                      getValue: (newValue) {
                        valoresjson['doEquipamento'] = newValue;
                      },
                    ),
                  ))
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),

                TabelsEquipamentoEEspaco(
                  getValue: widget.alimentosModel!.tabelaEquipamentoEEspaco,
                  onChanged: (p0) {
                    setState(() {
                      valoresjson['tabelaEquipamentoEEspaco'] = p0;
                    });
                  },
                ),

                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),

                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                Container(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  height: sizeScreen.height * 0.06,
                  width: sizeScreen.width,
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.008,
                      left: sizeScreen.width * 0.04),
                  child: Text(
                    'Estado geral de conservação',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                RadioD(
                  indexModel: widget.alimentosModel!.estadoGeralDeConservacao,
                  options: const ['Muito bom', 'Bom', 'Ruim'],
                  getValue: (newValue) {
                    valoresjson['estadoGeralDeConservacao'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                Container(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  height: sizeScreen.height * 0.06,
                  width: sizeScreen.width,
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.008,
                      left: sizeScreen.width * 0.04),
                  child: Text(
                    'Acessibilidade',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name:
                      'Possui alguma facilidade para pessoas com deficiência ou mobilidade reduzida?',
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.04,
                ),
                ExpansionTileYoN(
                  optionModel: widget.alimentosModel!.possuiFacilidade,
                  getValue: (newValue) {
                    valoresjson['possuiFacilidade'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'obs: caso sim, responder às questões seguintes',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Pessoal capacitado para receber PCD:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                CheckC(
                  nomesModel:
                      widget.alimentosModel!.pessoalCapacitadoParaReceberPCD,
                  onChanged: (p0) {
                    valoresjson['pessoalCapacitadoParaReceberPCD'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Física',
                    'Auditiva',
                    'Visual',
                    'Mental',
                    'Múltipla'
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Rota externa acessível:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.rotaExternaAcessivel,
                  onChanged: (p0) {
                    valoresjson['rotaExternaAcessível'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Estacionamento',
                    'Calçada rebaixada',
                    'Faixa de pedestre',
                    'Rampa',
                    'Semáforo sonoro',
                    'Piso tátil de alerta',
                    'Piso regular antiderrapante',
                    'Livre de obstáculos',
                    'outro'
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Símbolo internacional de acesso:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel:
                      widget.alimentosModel!.simboloInternacionalDeAcesso,
                  onChanged: (p0) {
                    valoresjson['simboloInternacionalDeAcesso'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Entrada',
                    'Área reservada',
                    'Estacionamento',
                    'Área de embarque e desembarque',
                    'Sanitário',
                    'Saída de emergência',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Local de embarque e desembarque:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel:
                      widget.alimentosModel!.localDeEmbarqueEDesembarque,
                  onChanged: (p0) {
                    valoresjson['localDeEmbarqueEDesembarque'] = p0;
                  },
                  nomes: ['Não', 'Sinalizado', 'Com acesso em nível'],
                ),

                SizedBox(
                  height: 50.w,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Vaga em estacionamento:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.vagaEmEstacionamento,
                  onChanged: (p0) {
                    valoresjson['vagaEmEstacionamento'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Sinalizado',
                    'Com acesso em nível',
                    'Alargada para cadeira de rodas',
                    'Rampa de acesso à calçada'
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name:
                        'Área de circulação / acesso interno para cadeira de rodas:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!
                      .areaDeCirculacaoAcessoInternoParaCadeiraDeRodas,
                  onChanged: (p0) {
                    valoresjson[
                        'areaDeCirculacaoAcessoInternoParaCadeiraDeRodas'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Rampa',
                    'Elevador',
                    'Plataforma elevatória',
                    'Porta larga',
                    'Piso regular / antiderrapante'
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Escada:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.escada,
                  onChanged: (p0) {
                    valoresjson['escada'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Corrimão',
                    'Patamar para descanso',
                    'Sinalização tátil de alerta',
                    'Piso antiderrapante',
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Rampa:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.rampa,
                  onChanged: (p0) {
                    valoresjson['rampa'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Corrimão',
                    'Patamar para descanso',
                    'Sinalização tátil de alerta',
                    'Piso antiderrapante',
                    'Inclinação adequada',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Piso:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.piso,
                  onChanged: (p0) {
                    valoresjson['piso'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Tátil',
                    'Sem obstáculos',
                    'Antiderrapante/deslizante',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Elevador:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.elevador,
                  onChanged: (p0) {
                    valoresjson['elevador'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Sinalizado em braile',
                    'Dispositivo sonoro',
                    'Dispositivo luminoso',
                    'Sensor eletrônico (porta)'
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Equipamento motorizado para deslocamento interno:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!
                      .equipamentoMotorizadoParaDeslocamentoInterno,
                  onChanged: (p0) {
                    valoresjson[
                        'equipamentoMotorizadoParaDeslocamentoInterno'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Cadeira',
                    'Carrinho',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Sinalização visual:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.sinalizacaoVisual,
                  onChanged: (p0) {
                    valoresjson['sinalizacaoVisual'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Entrada',
                    'Recepção',
                    'Porta',
                    'Sanitário',
                    'Elevador',
                    'Restaurante',
                    'Área de lazer',
                    'Área de resgate',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Sinalização tátil:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.sinalizacaoTatil,
                  onChanged: (p0) {
                    valoresjson['sinalizacaoTatil'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Entrada',
                    'Recepção',
                    'Porta',
                    'Sanitário',
                    'Elevador',
                    'Restaurante',
                    'Área de lazer',
                    'Área de resgate',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Alarme de emergência:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.alarmeDeEmergencia,
                  onChanged: (p0) {
                    valoresjson['alarmeDeEmergencia'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Sonoro',
                    'Visual',
                    'Vibratório',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Comunicação:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.comunicacao,
                  onChanged: (p0) {
                    valoresjson['comunicacao'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Texto informativo em braile',
                    'Texto informativo em fonte ampliada',
                    'Intérprete em libras',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Balcão de atendimento:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.balcaoDeAtendimento,
                  onChanged: (p0) {
                    valoresjson['balcaoDeAtendimento'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Rebaixado',
                    'Preferencial para PCD ou com deficiência ou mobilidade reduzida',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Mobiliário:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.mobiliario,
                  onChanged: (p0) {
                    valoresjson['mobiliario'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Altura adequada',
                    'Recuo adequado',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Sanitário',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.sanitario,
                  onChanged: (p0) {
                    valoresjson['sanitario'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Porta larga suficiente para entrada de cadeira de rodas ',
                    'Acesso para cadeira de rodas',
                    'Espelho rebaixado ou com ângulo de alcance visual',
                    'Torneira monocomando / alavanca',
                    'Barra de apoio',
                    'Giro para cadeira de rodas',
                    'Pia rebaixada',
                    'Boxe ou banheira daptada',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.02),
                  child: textLabel(
                    name: 'Telefone:',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CheckC(
                  nomesModel: widget.alimentosModel!.telefone,
                  onChanged: (p0) {
                    valoresjson['telefone'] = p0;
                  },
                  nomes: [
                    'Não',
                    'Altura adequada',
                    'Para surdos (TPS ou TTS)',
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.02,
                      bottom: sizeScreen.height * 0.04),
                  child: textLabel(
                    name:
                        'Sinalização indicativa de atendimento preferencial para pessoas com deficiência ou mobilidade reduzida:',
                    fontWeight: FontWeight.bold,
                  ),
                ),

                ExpansionTileYoN(
                  optionModel: widget.alimentosModel!.sinalizacaoIndicativa,
                  getValue: (newValue) {
                    valoresjson['sinalizacaoIndicativa'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(
                      name: 'Outros',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: sizeScreen.width * 0.1,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //eight: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('outrosSinalizacao'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '',
                          getValue: (newValue) {
                            valoresjson['outrosAcessibilidade'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                Container(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  height: sizeScreen.height * 0.06,
                  width: sizeScreen.width,
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.008,
                      left: sizeScreen.width * 0.04),
                  child: Text(
                    'Observações',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                CustomTextField(
                  controller: getController('observacoes'),
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '',
                  getValue: (newValue) {
                    valoresjson['observacoes'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),

                Container(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  height: sizeScreen.height * 0.06,
                  width: sizeScreen.width,
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.008,
                      left: sizeScreen.width * 0.04),
                  child: Text(
                    'Referências',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                CustomTextField(
                  controller: getController('referencias'),
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '',
                  getValue: (newValue) {
                    valoresjson['referencias'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),

                SendButton(
                  onPressed: () {
                    // controllers.forEach((key, value) {
                    //   print(value.text);
                    // },);
                    valoresjson['tipoDeOrganizacaoInstituicao'] =
                        tipo_de_organizacao_key.currentState!
                            .getSelectedValues()
                            .toList();
                    valoresjson['proximidades'] = proximidades_key.currentState!
                        .getSelectedValues()
                        .toList();
                    valoresjson['formasDePagamento'] = formas_de_pagamento_key
                        .currentState!
                        .getSelectedValues()
                        .toList();
                    valoresjson['vendasEReservas'] = vendas_e_reservas_key
                        .currentState!
                        .getSelectedValues()
                        .toList();
                    valoresjson['atendimentoEmLinguasEstrangeiras'] =
                        atendimento_em_lingua_estrangeira_key.currentState!
                            .getSelectedValues()
                            .toList();
                    valoresjson['informativosImpressos'] =
                        informativos_impressos_key.currentState!
                            .getSelectedValues()
                            .toList();

   valoresjson['nome_pesquisador']= widget.alimentosModel!.nomePesquisador;
   valoresjson['telefone_pesquisador']= widget.alimentosModel!.telefonePesquisador;
   valoresjson['email_pesquisador']= widget.alimentosModel!.emailPesquisador;
   valoresjson['nome_coordenador']= widget.alimentosModel!.nomeCoordenador;
   valoresjson['telefone_coordenador']= widget.alimentosModel!.telefoneCoordenador;
   valoresjson['email_coordenador']= widget.alimentosModel!.emailCoordenador;
                    _formKey.currentState!.save();
                    _formService.updateForm(widget.alimentosModel!.id!, valoresjson, AppConstants.ALIMENTOS_E_BEBIDAS);

                    // if (_formKey.currentState!.validate()) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text('processing data')));
                    // } else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text('preencha os dados!')));
                    // }
                    // Navigator.pushReplacementNamed(context, '/SendedForm');
                  },
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            )),
          ),
        ));
  }
}
