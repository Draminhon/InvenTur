import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/apis/estados.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/tabela.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/expandedTileYoN.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/apis/paises.dart';

class MeiosDeHospedagem extends StatefulWidget {
  const MeiosDeHospedagem({super.key});

  @override
  State<MeiosDeHospedagem> createState() => _MeiosDeHospedagemState();
}

class _MeiosDeHospedagemState extends State<MeiosDeHospedagem> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 55, 111, 60),
          title: const Text(
            'Identificação',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'UF',
                            ),
                          )),
                      SizedBox(
                        width: sizeScreen.width * 0.09,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          height: sizeScreen.height * 0.045,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Região Turística'),
                          ))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      left: sizeScreen.width * 0.05,
                      right: sizeScreen.width * 0.1,
                      top: sizeScreen.height * 0.01),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Município'),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: sizeScreen.height * 0.05),
                  child: Text(
                    'TIPO',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: sizeScreen.width * 0.045),
                  )),
              Padding(
                padding: EdgeInsets.only(left: sizeScreen.width * 0.12),
                child: const RadioB(),
              ),
              Padding(
                  padding: EdgeInsets.only(top: sizeScreen.height * 0.03),
                  child: Text(
                    'SUBTIPOS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: sizeScreen.width * 0.045),
                  )),

              RadioC(number: 18, options: [
                'Hotel',
                'Hotel histórico',
                'Pousada',
                'Resort',
                'Hotel Fazenda',
                'Flat/apart-hotel',
                'Cama e café',
                'Albergue',
                'Motel',
                'Pensão',
                'Alojamento de floresta',
                'Colônia de férias',
                'Estalagem/ Hospedaria',
                'Alojamento Coletivo',
                'Hospedagem conventual (Mosteiro/Seminário/Convento',
                'Hospedagem Familiar',
                'Hotel de trânsito',
                'Spa'
              ], getValue: (String ) {  },),

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
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),

              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CustomTextField(
                name: 'Razão Social',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                }, getValue: (String ) {  },
              ),
              CustomTextField(
                name: 'Nome Fantasia',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                }, getValue: (String ) {  },
              ),
              CustomTextField(
                name: 'Código CNAE',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                }, getValue: (String ) {  },
              ),
              CustomTextField(
                name: 'Atividade econômica',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                }, getValue: (String ) {  },
              ),
              CustomTextField(
                name: 'Inscrição Municipal',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                }, getValue: (String ) {  },
              ),
              CustomTextField(
                name: 'Nome da rede/holding',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                }, getValue: (String ) {  },
              ),
              CustomTextField(
                name: 'CNPJ',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                }, getValue: (String ) {  },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: sizeScreen.width * 0.05,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'natureza'),
              ),
               Column(
                children: [
                  RadioD(
                    options: ['pública', 'privada', 'outro'], getValue: (String ) {  },
                  ),
                ],
              ),

              const textLabel(
                name: 'tipo de organização/instituição',
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioD(
                options: [
                  'associação',
                  'sindicato',
                  'cooperativa',
                  'sistema S',
                  'empresa',
                  'outro'
                ], getValue: (String ) {  },
              ),
              Row(
                children: [
                  SizedBox(
                    width: sizeScreen.width * 0.05,
                  ),
                  const textLabel(name: 'início da atividade:'),
                  SizedBox(
                    width: sizeScreen.width * 0.1,
                  ),
                  SizedBox(
                      width: sizeScreen.width * 0.4,
                      //height: sizeScreen.height * 0.07,
                      child:  CustomTextDate(getValue: (String ) {  },))
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              const textLabel(name: 'Quantidade de Funcionários'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Permanentes'),
                      SizedBox(
                        width: sizeScreen.width * 0.026,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'n°',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            }, getValue: (String ) {  },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Temporários'),
                      SizedBox(
                        width: sizeScreen.width * 0.038,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'n°',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            }, getValue: (String ) {  },
                          ))
                    ],
                  ),
                  SizedBox(height: sizeScreen.height * 0.02),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Pessoas com\ndefiicência (%)'),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '%',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            }, getValue: (String ) {  },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  )
                ],
              ),
              const textLabel(name: 'localização:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioD(options: ['urbana', 'rural'], getValue: (String ) {  },),
              const textLabel(name: 'Coordenadas Geográficas'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Column(children: [
                Row(
                  children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(name: 'Latitude'),
                    SizedBox(
                      width: sizeScreen.width * 0.032,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          name: 'valor',
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          }, getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: sizeScreen.width * 0.053,
                    ),
                    const textLabel(name: 'Longitude'),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          name: 'valor',
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          }, getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
              ]),
              const textLabel(name: 'endereço:'),

              CustomTextField(
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'avenida/rua/travessa/caminho/outro', getValue: (String ) {  },
              ),
              CustomTextField(
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'bairro/localidade', getValue: (String ) {  },
              ),
              CustomTextField(
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'distrito', getValue: (String ) {  },
              ),
              CustomTextField(
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'CEP', getValue: (String ) {  },
              ),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              Column(children: [
                Row(
                  children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(name: 'Telefone'),
                    SizedBox(
                      width: sizeScreen.width * 0.03,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '(DD) n°', getValue: (String ) {  },
                        ))
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(left: sizeScreen.width * 0.09),
                    child: SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            name: 'Telefone secundário', getValue: (String ) {  },))),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(name: 'Endereço eletrônico\n(e-mail)'),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'e-mail', getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(
                        name: '  Sítio eletrônico\n(site/página web)'),
                    SizedBox(
                      width: sizeScreen.width * 0.045,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'www.endereço.com', getValue: (String ) {  },
                        ))
                  ],
                ),
              ]),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'sinalização:'),
              SizedBox(
                height: sizeScreen.height * 0.04,
              ),
              Row(children: [
                SizedBox(
                  width: sizeScreen.width * 0.05,
                ),
                const textLabel(name: 'de acessso -'),
                SizedBox(
                  width: sizeScreen.width * 0.09,
                ),
                 SizedBox(
                    // width: sizeScreen.width * 0.5,
                    //  //height: sizeScreen.height * 0.07,
                    child: ExpansionTileYoN(getValue: (String ) {  },))
              ]),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Row(children: [
                SizedBox(
                  width: sizeScreen.width * 0.05,
                ),
                const textLabel(name: 'turística -'),
                SizedBox(
                  width: sizeScreen.width * 0.14,
                ),
                SizedBox(
                    //width: sizeScreen.width * 0.5,
                    //  //height: sizeScreen.height * 0.07,
                    child: ExpansionTileYoN(getValue: (String ) {  },))
              ]),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'proximidades:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              //  RadioD(number: 6, options: options)
              RadioD(options: [
                'Restaurante',
                'Centro de Convenções exposições',
                'Shopping',
                'Bar/Lanchconete',
                'Posto de combustível',
                'Galeria/rua comercial',
                'outro'
              ], getValue: (String ) {  },),
              const textLabel(name: 'pontos de referência:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'ponto de referência', getValue: (String ) {  },),
              SizedBox(
                height: sizeScreen.height * 0.1,
              ),

              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.06,
                width: sizeScreen.width,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Cadastro, classificação e outros',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),

              const TabelaT1(column01: [
                Text('Entidade/guia turístico'),
                Text(
                  'Associações e sindicatos do setor de hospedagem',
                ),
                Text('Associações de turismos'),
                Text('Associações comerciais'),
                Text('Guias Turísticos'),
                Text('Outros'),
              ], column02: [
                Text('Categoria/tipo/classificação/número'),
                Text('CADASTUR outros'),
                TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
                TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
                TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
                TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
                TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ]),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Padding(
                  padding: EdgeInsets.only(left: sizeScreen.width * 0.05),
                  child: const textLabel(
                      name:
                          '       Segmentos ou tipos de turismo\nem que é especializado (assinalar até 3)')),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const CheckB(
                nomes: [
                  'Aventura',
                  'Ecoturismo',
                  'Rural',
                  'Estudos e intercâmbio',
                  'Cultural\n(cívico, étnico,\nreligioso, místico e\nesotérico)',
                  'náutico',
                  'Saúde\n(Bem estar e médico)',
                  'Pesca',
                  'Sol e praia',
                  'Negócios e\eventos',
                  'Esporte',
                  'Não é\nespecializado em nenhum segmento'
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
                  'Funcionamento',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'ESTRUTURA DE FUNCIONAMENTO'),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              const textLabel(name: 'Tipo de diária'),

              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              RadioC(number: 5, options: [
                'Sem Alimentação',
                'Café da manhã',
                'Meia Pensão',
                'Pensão Completa',
                'Tudo incluído'
              ], getValue: (String ) {  },),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'Formas de Pagamento'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioC(
                number: 5,
                options: [
                  'Dinheiro',
                  'Cheque',
                  'Cheque de outra praça',
                  'Cartão de Crédito',
                  'Cartão de Débito'
                ], getValue: (String ) {  },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'Reservas'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
             RadioC(
                number: 7,
                options: [
                  'Balcão',
                  'Telefone',
                  'Fax',
                  'Internet',
                  'Agência de turismo',
                  'Com sinal',
                  'Antecipado'
                ], getValue: (String ) {  },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'ATENDIMENTO AO PÚBLICO'),
              SizedBox(
                height: sizeScreen.height * 0.04,
              ),

              const textLabel(name: 'Atendimento em língua estrangeira'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioD(options: ['Não', 'Inglês', 'Espanhol', 'outro'], getValue: (String ) {  },),
              const textLabel(name: 'Informativos impressos'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioD(
                  options: ['Não', 'Inglês', 'Espanhol', 'Português', 'outro'], getValue: (String ) {  },),
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
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'Período'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioC(number: 13, options: [
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
              ], getValue: (String ) {  },),
              const textLabel(name: 'Horário'),
              SizedBox(
                height: sizeScreen.height * 0.01,
              ),
              TabelaT2(),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const textLabel(name: 'Funcionamento 24 horas'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
           ExpansionTileYoN(getValue: (String ) {  },),
              const textLabel(name: 'Funcionamento em feriados'),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
               ExpansionTileYoN(getValue: (String ) {  },),
              const textLabel(name: 'Restrições'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioD(
                  options: ['Crianças', 'Fumantes', 'Animais', 'outro'], getValue: (String ) {  },),
              const textLabel(name: 'Outras regras e informações'),

              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'Regras e informações', getValue: (String ) {  },),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'DADOS DA VISITAÇÃO'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'Ocupação ano nº'),

              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'nº', getValue: (String ) {  },),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'Ocupação na alta temporada nº'),

              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'nº', getValue: (String ) {  },),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'Meses de alta temporada'),
              SizedBox(
                height: sizeScreen.height * 0.01,
              ),

               RadioC(number: 13, options: [
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
              ], getValue: (String ) {  },),
              const textLabel(name: 'Origem dos visitantes/turistas'),
              RadioD(options: [
                'Entorno municipal',
                'Estadual',
                'Nacional',
                'Internacional'
              ], getValue: (String ) {  },),
              const textLabel(
                  name: 'Origem dos turistas nacionais (Até 5 estados)'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const Estados(),
              const Estados(),
              const Estados(),
              const Estados(),
              const Estados(),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(
                  name: 'Origem dos turistas internacionais (Até 5 Países)'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const Paises(),
              const Paises(),
              const Paises(),
              const Paises(),
              const Paises(),
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
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
SizedBox(height: sizeScreen.height * 0.02,),
      
             const textLabel(name: 'Unidades habitacionais (UH)'),
             SizedBox(height: sizeScreen.height * 0.02,),

              Column(children: [
                Row(
                  children: [
                    SizedBox(width: sizeScreen.width * 0.04,),
                    const textLabel(name: 'Total de UH nº'),
                    
                    SizedBox(
                      width: sizeScreen.width * 0.055,
                    ),
                    
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                       SizedBox(width: sizeScreen.width * 0.04,),
                    const textLabel(name: 'Total de leitos nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.005,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                       SizedBox(width: sizeScreen.width * 0.04,),
                    const textLabel(name: 'Uh adaptadas\npara PCD nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.071,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(
                    left: sizeScreen.width * 0.02,
                    top: sizeScreen.height * 0.03,
                    bottom: sizeScreen.height * 0.03),
                child: const textLabel(name: 'Produtos de higiene pessoal'),
              ),
              const CheckC(nomes: [
                'Shampoo',
                'Toalha',
                'Condicionador',
                'Roupão de banho',
                'Sabonete',
                'Touca',
                'Creme dental',
                'Chinelo',
                'Loção',
                'outro'
              ]),
              Padding(
                padding: EdgeInsets.only(
                    left: sizeScreen.width * 0.005,
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Equipamentos e Serviços'),
              ),
            RadioC(number: 23, options: [
                'Aparelho de vídeo',
                'DVD',
                'TV com canal pago',
                'Rádio',
                'Internet',
                'Ar-Condicionado',
                'Calefação',
                'Mesa',
                'Cama King Size',
                'Cama Queen Size',
                'Panelas e louças',
                'Micro-ondas',
                'Forno Elétrico',
                'Cofre',
                'Academia',
                'Ofurô',
                'Hidromassagem',
                'Sauna seca',
                'Room - service',
                'Room service 24h',
                'Controle de Iluminação',
                'Luminária para leitura',
                'outro'
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                    right: sizeScreen.width * 0.05,
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'INSTALAÇÕES'),
              ),
              Padding(
                padding: EdgeInsets.only(
                   
                    top: sizeScreen.height * 0.03,
                    bottom: sizeScreen.height * 0.03),
                child: const textLabel(name: 'Estacionamento'),
              ),
              RadioD(
                options: ['Pago', 'Gratuito', 'Coberto', 'Descoberto'], getValue: (String ) {  },
              ),

              Column(children: [
                Row(
                  children: [
                    SizedBox(width: sizeScreen.width * 0.05,),
                    const textLabel(name: 'Capacidade de\nveículos nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.01,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                            SizedBox(width: sizeScreen.width * 0.052,),
                    const textLabel(name: 'Automóveis nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.005,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                            SizedBox(width: sizeScreen.width * 0.05,),
                    const textLabel(name: 'Ônibus nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.1,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
              ]),
              SizedBox(height: sizeScreen.height * 0.03,),
              const textLabel(name: 'OUTRAS INSTALAÇÕES E ESTRUTURAS'),
             SizedBox(height: sizeScreen.height * 0.02,),
               const textLabel(name: 'Energia  elétrica'),
                  SizedBox(height: sizeScreen.height * 0.02,),
              RadioD(
                  options: ['110 volts', '220 volts', '110/220 volts'], getValue: (String ) {  },),
                      SizedBox(height: sizeScreen.height * 0.02,),
              Row(
                children: [
                      SizedBox(width: sizeScreen.width * 0.05,),
                  const textLabel(name: 'Capacidade\nem KVA'),
                  SizedBox(
                    width: sizeScreen.width * 0.005,
                  ),
                  SizedBox(
                      width: sizeScreen.width * 0.6,
                      //height: sizeScreen.height * 0.07,
                      child: CustomTextField(
                        validat: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          return null;
                        },
                        name: '', getValue: (String ) {  },
                      ))
                ],
              ),
                  SizedBox(height: sizeScreen.height * 0.02,),
              const textLabel(name: 'Gerador de emergência'),
         SizedBox(height: sizeScreen.height * 0.032,),
               ExpansionTileYoN(getValue: (String ) {  },),
                  SizedBox(height: sizeScreen.height * 0.02,),
              Row(
                children: [
                      SizedBox(width: sizeScreen.width * 0.05,),
                  const textLabel(name: 'Capacidade\nem KVA'),
                  SizedBox(
                    width: sizeScreen.width * 0.005,
                  ),
                  SizedBox(
                      width: sizeScreen.width * 0.6,
                      //height: sizeScreen.height * 0.07,
                      child: CustomTextField(
                        validat: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          return null;
                        },
                        name: '', getValue: (String ) {  },
                      ))
                ],
              ),
              SizedBox(height: sizeScreen.height * 0.03,),
            textLabel(name: 'ÁREA DE ALIMENTAÇÃO'),
SizedBox(height: sizeScreen.height * 0.02,),
               const textLabel(name: 'Restaurante'),
              SizedBox(height: sizeScreen.height * 0.02,)
,              RadioD(options: [
                'Não',
                'Apenas para hóspedes',
                'Aberto ao público',
                'Adaptado para PCD'
              ], getValue: (String ) {  },),
               const textLabel(name: 'Capacidade de atendimento'),
                SizedBox(height: sizeScreen.height * 0.02,),
              Column(children: [
                Row(
                  children: [
                      SizedBox(width: sizeScreen.width * 0.05,),
                    const textLabel(name: 'Capacidade\nInstalada\npor dia nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.01,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                    SizedBox(
                      width: sizeScreen.width * 0.04,
                    ),
                    const textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.005,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                      SizedBox(width: sizeScreen.width * 0.04,),
                    const textLabel(name: 'Capacidade\nsimultânea nº'),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(height: sizeScreen.height * 0.02,),
           const textLabel(name: 'Lanchonete'),
                SizedBox(height: sizeScreen.height * 0.02,),
              ]),
              RadioD(options: [
                'Não',
                'Apenas para hóspedes',
                'Aberto ao público',
                'Adaptado para PCD'
              ], getValue: (String ) {  },),
              Column(children: [
                Row(
                  children: [
                    SizedBox(width: sizeScreen.width * 0.05,),
                    const textLabel(name: 'Capacidade\nInstalada\npor dia nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.01,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(height: sizeScreen.height * 0.02,),
                 
                Row(
                  children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.005,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                
                SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                    SizedBox(width: sizeScreen.width * 0.02,),
                    const textLabel(name: 'Capacidade\nsimultânea nº'),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '', getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(height: sizeScreen.height * 0.02,),
              ]),
             const textLabel(
                    name:
                    'ÁREA DE RECREAÇÃO E LAZER\n\n\n   Instalações e espaços'),
               SizedBox(height: sizeScreen.height * 0.02,),
              RadioD(options: [
                'Piscina',
                'Toboágua',
                'Quadra de tênis',
                'Área verde',
                'Piscina aquecida',
                'Parque infantil',
                'Campo de futebol',
                'Lago paronâmico',
                'Piscina infantil',
                'Clube infantil',
                'Campo de golfe',
                'Bar na piscina',
                'Quadra poliesportiva',
                'Pista de cooper',
                'outro'
              ], getValue: (String ) {  },),
            
              const textLabel(
                    name: 'Outros espaços,\nequipamentos e atividades'),
               SizedBox(height: sizeScreen.height * 0.02,),
              RadioD(options: [
                'Observação da fauna',
                'Visita a produção agrícola',
                'Atividades pedagógicas',
                'Atividades Programadas para adultos',
                'Passeios em barcos e lanchas',
                'Realização de cursos, seminários, feiras',
                'Competições de pesca',
                'Equipamento para mergulho',
                'Tirolesa',
                'Cicloturismo / Atividade com bicicleta',
                'Mergulho livre',
                'Banana boat',
                'Mini zoo',
                'Horta',
                'Peregrinação e romarias',
                'Venda de souvenir e produtos típicos',
                'Observação de flora',
                'Degustação gastronômica',
                'Atividades programadas para crianças',
                'atividades equestres',
                'Passeios em embarcações alugadas',
                'Realização de eventos (Esportivos, Sociais, Culturais)',
                'Pesca amadora',
                'Pedalinhos',
                'Arvorismo',
                'Caminhadas / trilha interpretativas',
                'Esqui aquático',
                'Jet ski',
                'Fazendinha',
                'Centro equestre',
                'Retiros espirituais',
                'outro'
              ], getValue: (String ) {  },),
               SizedBox(height: sizeScreen.height * 0.02,),
            const textLabel(
                    name: 'ÁREA PARA EVENTOS\n\n\nInstalações'),
               SizedBox(height: sizeScreen.height * 0.04,),
              const TabelaT3(),
               SizedBox(height: sizeScreen.height * 0.02,),
           const textLabel(name: 'Serviços'),
               SizedBox(height: sizeScreen.height * 0.02,),
              RadioD(options: [
                'Realização de eventos próprios',
                'Aluguel de equipamentos',
                'Aluguel de espaço para terceiros',
                'Serviços de alimentação',
                'Organização de eventos',
                'Serviços de som',
                'outro',
              ], getValue: (String ) {  },),
               const textLabel(name: 'Equipamentos'),
               SizedBox(height: sizeScreen.height * 0.02,),
              RadioD(options: [
                'Cadeira com prancheta',
                'Copa',
                'Vídeo',
                'Tela fixa',
                'Telefonia',
                'Internet sem fio',
                'Sonorização',
                'Elevador',
                'Poltronas',
                'Tv com canal aberto',
                'DVD',
                'Projetor',
                'Computador',
                'Equipamento de tradução simultânea',
                'Parabólica',
                'Ar condicionado central',
                'TV com canal por assinatura',
                'Tela móvel',
                'Retroprojetor',
                'Internet',
                'Videoconferência',
                'Palco',
                'outro'
              ], getValue: (String ) {  },),
             
              const textLabel(name: 'Facilidades e serviços'),
               SizedBox(height: sizeScreen.height * 0.02,),
              RadioD(options: [
                'Adaptador de voltagem',
                'Calefação',
                'Telefones públicos',
                'Impressora',
                'Micro - ondas',
                'Adega climatizada',
                'Loja de conveniência',
                'Cofre ',
                'Agência de turismo',
                'Heliponto',
                'Lavanderia',
                'Serviço de babá',
                'Auditório',
                'Sala de imprensa',
                'Salão de beleza',
                'Passeios e guias',
                'Ar condicionado',
                'Centra telefônica',
                'Internet',
                'Circuito interno de TV',
                'Churrasqueira',
                'Barbearia',
                'Farmácia',
                'Guarda - volume',
                'Locadora de veículos',
                'Embarcações',
                'Serviços de copa',
                'Serviço médico',
                'Sala de reuniões',
                'Sala de ginástica',
                'Salão de jogos',
                'Câmbio',
                'Ventilador',
                'Telefone',
                'Internet sem fio',
                'Forno elétrico',
                'Bar',
                'Lojas',
                'Caixa eletrônico',
                'Informações turísticas',
                'Traslados',
                'Manobrista',
                'Serviço bilíngue',
                'Elevador',
                'Sala de convenções',
                'Equipamento de ginástica',
                'Exposição de arte/artesanato',
                'outro'
              ], getValue: (String ) {  },),
            const textLabel(name: 'Facilidades para executivos'),
               SizedBox(height: sizeScreen.height * 0.02,),
              RadioD(options: [
                'Apartamentos em andares especiais',
                'Café da manhã em ambiente privativo',
                'Jornais diários no apartamento',
                'Acesso á internet sem fio',
                'Acesso a internet em áreas comuns',
                'Impressora',
                'Datashow',
                'Sla de reunião',
                'Serviço de café',
                'Guarda de mala em consignação',
                'Lustro e graxa para os sapatos',
                'Check in e check out expresso em ambiente diferenciado',
                'Early check in e late check out conforme disponibilidade',
                'Acesso á internet banda larga',
                'Acesso a internet na UH',
                'Computador ',
                'fax',
                'Máquina de fotocópia',
                'Serviço de chá',
                'Refrigerante / sucos',
                'Lavagem e passagem de roupa no período noturno',
                'outro'
              ], getValue: (String ) {  },),
               SizedBox(height: sizeScreen.height * 0.02,),
              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.15,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Proteção, Qualificação, Certificação, Premiação, destaques e outros',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Row(children: [
                 SizedBox(width: sizeScreen.width * 0.05,),
                const textLabel(name: 'Do equipamento/espaço:'),
                SizedBox(
                  width: sizeScreen.width * 0.04,
                ),
                 SizedBox(
                    // width: sizeScreen.width * 0.5,
                    //  //height: sizeScreen.height * 0.07,
                    child: ExpansionTileYoN(getValue: (String ) {  },))
              ]),
               SizedBox(height: sizeScreen.height * 0.02,),
              const TabelaT4(
                column01: [
                  Text('Categoria'),
                  Text('Municipal'),
                  Text('Municipal'),
                  Text('Municipal'),
                  Text('Municipal'),
                ],
                column02: [
                  Text('instrumento (nª)'),
                  Text('Lei/decreto'),
                  Text('Portaria/instrução/deliberação'),
                  Text('Norma/ato'),
                  Text('Outros'),
                ],
                column03: [
                  Text('Nome/titulo/certificação/licenciamento/outro'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
                column04: [
                  Text('Entidade declaratória/tipo de declaração'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const TabelaT4(
                column01: [
                  Text('Estadual/Distrital'),
                  Text('Estadual/Distrital'),
                  Text('Estadual/Distrital'),
                  Text('Estadual/Distrital'),
                  Text('Estadual/Distrital'),
                ],
                column02: [
                  Text('instrumento (nª)'),
                  Text('Lei/decreto'),
                  Text('Portaria/instrução/deliberação'),
                  Text('Norma/ato'),
                  Text('Outros'),
                ],
                column03: [
                  Text('Nome/titulo/certificação/licenciamento/outro'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
                column04: [
                  Text('Entidade declaratória/tipo de declaração'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const TabelaT4(
                column01: [
                  Text('Categoria'),
                  Text('Federal'),
                  Text('Federal'),
                  Text('Federal'),
                  Text('Federal'),
                ],
                column02: [
                  Text('instrumento (nª)'),
                  Text('Lei/decreto'),
                  Text('Portaria/instrução/deliberação'),
                  Text('Norma/ato'),
                  Text('Outros'),
                ],
                column03: [
                  Text('Nome/titulo/certificação/licenciamento/outro'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
                column04: [
                  Text('Entidade declaratória/tipo de declaração'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const TabelaT4(
                column01: [
                  Text('Estadual/Distrital'),
                  Text('Internacional'),
                  Text('Internacional'),
                  Text('Internacional'),
                  Text('Internacional'),
                  Text('Outras'),
                ],
                column02: [
                  Text('instrumento (nª)'),
                  Text('Lei/decreto'),
                  Text('Portaria/instrução/deliberação'),
                  Text('Norma/ato'),
                  Text('Outros'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
                column03: [
                  Text('Nome/titulo/certificação/licenciamento/outro'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
                column04: [
                  Text('Entidade declaratória/tipo de declaração'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Row(children: [
                 SizedBox(width: sizeScreen.width * 0.05,),
                const textLabel(
                  
                    name:
                        'Da área ou edificação \nem que está\nlocalizado / Instalado'),
                SizedBox(
                  width: sizeScreen.width * 0.04,
                ),
                 SizedBox(
                    // width: sizeScreen.width * 0.5,
                    //  //height: sizeScreen.height * 0.07,
                    child: ExpansionTileYoN(getValue: (String ) {  },))
              ]),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const TabelaT4(
                column01: [
                  Text('Categoria'),
                  Text('Municipal'),
                  Text('Municipal'),
                  Text('Municipal'),
                  Text('Municipal'),
                ],
                column02: [
                  Text('instrumento (nª)'),
                  Text('Lei/decreto'),
                  Text('Portaria/instrução/deliberação'),
                  Text('Norma/ato'),
                  Text('Outros'),
                ],
                column03: [
                  Text('Nome/titulo/certificação/licenciamento/outro'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
                column04: [
                  Text('Entidade declaratória/tipo de declaração'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const TabelaT4(
                column01: [
                  Text('Estadual/Distrital'),
                  Text('Estadual/Distrital'),
                  Text('Estadual/Distrital'),
                  Text('Estadual/Distrital'),
                  Text('Estadual/Distrital'),
                ],
                column02: [
                  Text('instrumento (nª)'),
                  Text('Lei/decreto'),
                  Text('Portaria/instrução/deliberação'),
                  Text('Norma/ato'),
                  Text('Outros'),
                ],
                column03: [
                  Text('Nome/titulo/certificação/licenciamento/outro'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
                column04: [
                  Text('Entidade declaratória/tipo de declaração'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const TabelaT4(
                column01: [
                  Text('Categoria'),
                  Text('Federal'),
                  Text('Federal'),
                  Text('Federal'),
                  Text('Federal'),
                ],
                column02: [
                  Text('instrumento (nª)'),
                  Text('Lei/decreto'),
                  Text('Portaria/instrução/deliberação'),
                  Text('Norma/ato'),
                  Text('Outros'),
                ],
                column03: [
                  Text('Nome/titulo/certificação/licenciamento/outro'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
                column04: [
                  Text('Entidade declaratória/tipo de declaração'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const TabelaT4(
                column01: [
                  Text('Estadual/Distrital'),
                  Text('Internacional'),
                  Text('Internacional'),
                  Text('Internacional'),
                  Text('Internacional'),
                  Text('Outras'),
                ],
                column02: [
                  Text('instrumento (nª)'),
                  Text('Lei/decreto'),
                  Text('Portaria/instrução/deliberação'),
                  Text('Norma/ato'),
                  Text('Outros'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
                column03: [
                  Text('Nome/titulo/certificação/licenciamento/outro'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ],
                column04: [
                  Text('Entidade declaratória/tipo de declaração'),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                  TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
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
                  'Estado geral de conservação',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              RadioD(options: ['Muito bom', 'Bom', 'Ruim'], getValue: (String ) {  },),
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
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
               SizedBox(height: sizeScreen.height * 0.02,),
              const textLabel(
                    name:
                        'Possui alguma facilidade\npara pessoas com\ndeficiência ou mobilidade\nreduzida?'),
               SizedBox(height: sizeScreen.height * 0.04,),
               ExpansionTileYoN(getValue: (String ) {  },),
 SizedBox(height: sizeScreen.height * 0.02,),
              const textLabel(
                    name: 'obs: responder às questões seguintes'),
          SizedBox(height: sizeScreen.height * 0.02,),
 const textLabel(
                    name: 'Pessoal capacitado para receber PCD'),
                SizedBox(height: sizeScreen.height * 0.02,),
              RadioD(options: [
                'Não',
                'Física',
                'Auditiva',
                'Visual',
                'Mental',
                'Múltipla'
              ], getValue: (String ) {  },),
             const textLabel(name: 'Rota externa acessível'),
                SizedBox(height: sizeScreen.height * 0.02,),
              RadioD(options: [
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
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                   
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Símbolo internacional de acesso'),
              ),
              RadioD(options: [
                'Não',
                'Entrada',
                'Área reservada',
                'Estacionamento',
                'Área de embarque e desembarque',
                'Sanitário',
                'Saída de emergência',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                   
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Local de embarque e desembarque'),
              ),
              RadioD(
                  options: ['Não', 'Sinalizado', 'Com acesso em nível'], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                  
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Vaga em estacionamento'),
              ),
              RadioD(options: [
                'Não',
                'Sinalizado',
                'Com acesso em nível',
                'Alargada para cadeira de rodas',
                'Rampa de acesso á calçada'
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                   
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(
                    name:
                        'Área de circulação / acesso interno\npara cadeira de rodas'),
              ),
              RadioD(options: [
                'Não',
                'Rampa',
                'Elevador',
                'Plataforma elevatória',
                'Porta larga',
                'Piso regular / antiderrapante'
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
        
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Escada'),
              ),
              RadioD(options: [
                'Não',
                'Corrimão',
                'Patamar para descanso',
                'Sinalização tátil de alerta',
                'Piso antiderrapante',
              ], getValue: (String ) {  },),

              Padding(
                padding: EdgeInsets.only(
            
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Rampa'),
              ),
              RadioD(options: [
                'Não',
                'Corrimão',
                'Patamar para descanso',
                'Sinalização tátil de alerta',
                'Piso antiderrapante',
                'Inclinação adequada',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                  
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Piso'),
              ),
              RadioD(options: [
                'Não',
                'Tátil',
                'Sem obstáculos',
                'Antiderrapante/deslizante',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                  
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Elevador'),
              ),
               RadioD(options: [
                'Não',
                'Sinalizado em braile',
                'Dispositivo sonoro',
                'Dispositivo luminoso',
                'Sensor eletrônico (porta)'
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                   
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(
                    name:
                        '  Equipamento motorizado\npara deslocamento interno'),
              ),
              RadioD(options: [
                'Não',
                'Cadeira',
                'Carrinho',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                 
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Sinalização visual'),
              ),
               RadioD(options: [
                'Não',
                'Entrada',
                'Recepção',
                'Porta',
                'Sanitário',
                'Elevador',
                'Restaurante',
                'Área de lazer',
                'Área de resgate',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                  
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Sinalização tátil'),
              ),
               RadioD(options: [
                'Não',
                'Entrada',
                'Recepção',
                'Porta',
                'Sanitário',
                'Elevador',
                'Restaurante',
                'Área de lazer',
                'Área de resgate',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Alarme de emergência'),
              ),
              RadioD(options: [
                'Não',
                'Sonoro',
                'Visual',
                'Vibratório',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                  
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Comunicação'),
              ),
               RadioD(options: [
                'Não',
                'Texto informativo em braile',
                'Texto informativo em fonte ampliada',
                'Intérprete em libras',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                    
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Balcão de atendimento'),
              ),
              RadioD(options: [
                'Não',
                'Rebaixado',
                'Preferencial para PCD ou com deficiência ou mobilidade reduzida',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                    
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Mobiliário'),
              ),
             RadioD(options: [
                'Não',
                'Altura adequada',
                'Recuo adequado',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Sanitário'),
              ),
               RadioD(options: [
                'Não',
                'Porta larga suficiente para entrada de cadeira de rodas ',
                'Acesso para cadeira de rodas',
                'Espelho rebaixado ou com ângulo de alcance visual',
                'Torneira monocomando / alavanca',
                'Barra de apoio',
                'Giro para cadeira de rodas',
                'Pia rebaixada',
                'Boxe ou banheira daptada',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
               
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Telefone'),
              ),
              RadioD(options: [
                'Não',
                'Altura adequada',
                'Para surdos (TPS ou TTS)',
              ], getValue: (String ) {  },),
              Padding(
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.04),
                child: const textLabel(
                    name:
                        'Sinalização indicativa de\natendimento preferencial para pessoas com deficiência ou mobilidade reduzida'),
              ),

               ExpansionTileYoN(getValue: (String ) {  },),
              SizedBox(height: sizeScreen.height * 0.02,),              Row(
                children: [
                  SizedBox(width: sizeScreen.width * 0.05,),
                  const textLabel(name: 'Outros'),
                  SizedBox(
                    width: sizeScreen.width * 0.1,
                  ),
                  SizedBox(
                      width: sizeScreen.width * 0.6,
                      //eight: sizeScreen.height * 0.07,
                      child: CustomTextField(
                        validat: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          return null;
                        },
                        name: '', getValue: (String ) {  },
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
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (String ) {  },),
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
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (String ) {  },),
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
                  'Equipe Responsável',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const textLabel(
                  name: 'Responsável pelo atendimento (Pesquisador)'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (String ) {  },),
              const textLabel(name: 'Telefone'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (String ) {  },),
              const textLabel(name: 'E-mail'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (String ) {  },),
              const textLabel(
                  name: 'Responsável pelo atendimento (Coordenador)'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (String ) {  },),
              const textLabel(name: 'Telefone'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (String ) {  },),
              const textLabel(name: 'E-mail'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (String ) {  },),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              SizedBox(
                height: sizeScreen.height * 0.06,
                width: sizeScreen.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('processing data')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('preencha os dados!')));
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.green[800],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Enviar',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            sizeScreen.height * 0.03), // Use um fontSize fixo
                  ),
                ),
              ),

              SizedBox(
                height: sizeScreen.height * 0.05,
              )
            ]),
          ),
        ));
  }
}