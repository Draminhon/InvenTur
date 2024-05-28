import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/apis/estados.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/apis/paises.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/sendButton.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/tabela.dart';

import '../../widgets/customOutro.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/expandedTileYoN.dart';
import '../../widgets/radioButton.dart';

class Hidrografia extends StatefulWidget {
  const Hidrografia({super.key});

  @override
  State<Hidrografia> createState() => _HidrografiaState();
}

class _HidrografiaState extends State<Hidrografia> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> valoresjson = {
    'uf': null,
    'RG': null,
    'Municipio': null,
    'Tipo': null,
    'Subtipo': null,
  };
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
                                  return null;
                                },
                                onSaved: (newValue) {
                                  valoresjson['uf'] = newValue;
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
                                  return null;
                                },
                                onSaved: (newValue) {
                                  valoresjson['RG'] = newValue;
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
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Municipio',
                      ),
                      onSaved: (newValue) {
                        valoresjson['Municipio'] = newValue;
                      },
                    ),
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  const textLabel(name: 'Tipo:'),
                RadioD(
               
                      getValue: (newValue) {
                        valoresjson['Tipo'] = newValue;
                      }, options: ['Hidrografia', 'Queda d´água'],
                    ),
              
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Subtipos:'),
                  RadioC(
                      number: 13,
                      options: const [
                        'Rio',
                        'Riacho',
                        'Córrego',
                        'Arroio',
                        'Lago/lagoa/laguna',
                        'Alagado',
                        'Fonte',
                     
                        'Catarata',
                        'Cachoeira',
                        'Salto',
                        'Cascata',
                        'Corredeira',
                        'outro'
                      ],
                      getValue: (newValue) {
                        valoresjson['Subtipo'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
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
                    height: sizeScreen.height * 0.05,
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  CustomTextField(
                    name: 'Nome Oficial',
                    validat: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['NomeOficial'] = newValue;
                    },
                  ),
                  CustomTextField(
                    name: 'Nome Fantasia',
                    validat: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['NomeFantasia'] = newValue;
                    },
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
                        options: const ['pública', 'privada', 'outro'],
                        getValue: (newValue) {
                          valoresjson['natureza'] = newValue;
                        },
                      ),
                    ],
                  ),
                  const textLabel(
                    name: 'tipo de organização/instituição',
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const CheckC(nomes: [
                    'associação',
                    'sindicato',
                    'cooperativa',
                    'sistema S',
                    'empresa',
                    'outro'
                  ]),

                  const textLabel(name: 'localização:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                    options: const ['urbana', 'rural'],
                    getValue: (newValue) {
                      valoresjson['Localização'] = newValue;
                    },
                  ),
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
                              },
                              getValue: (newValue) {
                                valoresjson['Latitude'] = newValue;
                              },
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
                              },
                              getValue: (newValue) {
                                valoresjson['Longitude'];
                              },
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
                    name: 'Bairro/localidade',
                    getValue: (newValue) {
                      valoresjson['Bairro'] = newValue;
                    },
                  ),
                  CustomTextField(
                    validat: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
                    },
                    name: 'distrito',
                    getValue: (newValue) {
                      valoresjson['distrito'] = newValue;
                    },
                  ),
                  CustomTextField(
                    validat: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
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
                        child: ExpansionTileYoN(
                      getValue: (newValue) {
                        valoresjson['SinalizaçãoDeAcesso'] = newValue;
                      },
                    ))
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
                        child: ExpansionTileYoN(
                      getValue: (newValue) {
                        valoresjson['SinalizaçãoTurística'] = newValue;
                      },
                    ))
                  ]),
                  const textLabel(name: 'proximidades:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  //  RadioD(number: 6, options: options)
                  const CheckC(nomes: [
                    'Restaurante',
                    'Meio de hospedagem',
                    'Centro de Convenções exposições',
                    'Shopping',
                    'Bar/Lanchconete',
                    'Posto de combustível',
                    'Galeria/rua comercial',
                    'outro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Distâncias (km):'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Aeroporto:'),
                      SizedBox(
                        width: sizeScreen.width * 0.06,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '(km)',
                            getValue: (newValue) {
                              valoresjson['DistanciasAeroporto'] = newValue;
                            },
                            validat: (value) {
                              return null;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Estação\nferroviária:'),
                      SizedBox(
                        width: sizeScreen.width * 0.06,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '(km)',
                            getValue: (newValue) {
                              valoresjson['DistanciaEstaçãoFerroviaria'] =
                                  newValue;
                            },
                            validat: (value) {
                              return null;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Estação\nmarítima\n/fluvial:'),
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '(km)',
                            getValue: (newValue) {
                              valoresjson['DistanciaEstaçãoMaritima'] =
                                  newValue;
                            },
                            validat: (value) {
                              return null;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Estação\nmetroviária:'),
                      SizedBox(
                        width: sizeScreen.width * 0.045,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '(km)',
                            getValue: (newValue) {
                              valoresjson['DistanciaEstaçãoMetroviaria'] =
                                  newValue;
                            },
                            validat: (value) {
                              return null;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Ponto\nde ônibus'),
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '(km)',
                            getValue: (newValue) {
                              valoresjson['DistanciaPontoDeOnibus'] = newValue;
                            },
                            validat: (value) {
                              return null;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Ponto\n de taxi'),
                      SizedBox(
                        width: sizeScreen.width * 0.14,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '(km)',
                            getValue: (newValue) {
                              valoresjson['DistanciaPontoDeTaxi'] = newValue;
                            },
                            validat: (value) {
                              return null;
                            },
                          ))
                    ],
                  ),
                        SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Estação\nrodoviária'),
                      SizedBox(
                        width: sizeScreen.width * 0.09,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '(km)',
                            getValue: (newValue) {
                              valoresjson['DistanciaEstaçãoFerroviaria'] =
                                  newValue;
                            },
                            validat: (value) {
                              return null;
                            },
                          ))
                    ],
                  ),
                       SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Sede\ndo município'),
                      SizedBox(
                        width: sizeScreen.width * 0.06,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '(km)',
                            getValue: (newValue) {
                              valoresjson['DistanciaEstaçãoFerroviaria'] =
                                  newValue;
                            },
                            validat: (value) {
                              return null;
                            },
                          ))
                    ],
                  ),

                    SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Localidade\nmais próxima'),
                      SizedBox(
                        width: sizeScreen.width * 0.06,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '(km)',
                            getValue: (newValue) {
                              valoresjson['DistanciaEstaçãoFerroviaria'] =
                                  newValue;
                            },
                            validat: (value) {
                              return null;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                 
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.05,
                      ),
                      const textLabel(name: 'Outras:'),
                      SizedBox(
                        width: sizeScreen.width * 0.15,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '(km)',
                            getValue: (newValue) {
                              valoresjson['DistanciaOutras'] = newValue;
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
                    name: 'ponto de referência',
                    getValue: (newValue) {
                      valoresjson['PontoDeReferencia'] = newValue;
                    },
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  const textLabel(name: 'Entidade Mantedora'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  textLabel(name: 'Esfera administrativa'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(options: ['Federal', 'Estadual', 'Municipal', 'Particular', 'Concessão', 'outro'], getValue: (newValue){}),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
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
                              return null;
                            },
                            name: 'e-mail',
                            getValue: (newValue) {
                              valoresjson['Email'] = newValue;
                            },
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
                              return null;
                            },
                            name: 'www.endereço.com',
                            getValue: (newvalue) {
                              valoresjson['Site'] = newvalue;
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
                      'Funcionamento',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: sizeScreen.height * 0.03),
                    ),
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Estrutura de funcionamento'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Visitação'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  ExpansionTileYoN(getValue: (newValue) {
                    valoresjson['Visitação'] = newValue;
                  }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Finalidade da visitação'),
                  const CheckC(nomes: [
                   'Passeio',
                   'Aventura',
                   'Religiosidade',
                   'Pesquisa',
                   'outro'
                  ]),

                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Agendada'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                      options: const ['Não', 'Opcional', 'Obrigatória'],
                      getValue: (newValue) {
                        valoresjson['Agendada'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Autoguiada'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                      options: const ['Não', 'Opcional', 'Obrigatória'],
                      getValue: (newValue) {
                        valoresjson['Autoguiada'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Guiada'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                      options: const ['Não', 'Opcional', 'Obrigatória'],
                      getValue: (newValue) {
                        valoresjson['Guiada'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Entrada'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Gratuita'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  ExpansionTileYoN(getValue: (newValue) {
                    valoresjson['gratuita'] = newValue;
                  }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Paga'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  ExpansionTileYoN(getValue: (newValue) {
                    valoresjson['Paga'] = newValue;
                  }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Instalações de entrada'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Centro de recepção'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  ExpansionTileYoN(getValue: (newValue) {
                    valoresjson['CentroDeRecepção'] = newValue;
                  }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Posto de informação'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  ExpansionTileYoN(getValue: (newValue) {
                    valoresjson['PostoDeInformação'] = newValue;
                  }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Portaria principal'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  ExpansionTileYoN(getValue: (newValue) {
                    valoresjson['PortariaPrincipal'] = newValue;
                  }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Guarita'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  ExpansionTileYoN(getValue: (newValue) {
                    valoresjson['Guarita'] = newValue;
                  }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Bilheteria'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  ExpansionTileYoN(getValue: (newValue) {
                    valoresjson['Bilheteria'] = newValue;
                  }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Outras'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  ExpansionTileYoN(getValue: (newValue) {
                    valoresjson['Outras'] = newValue;
                  }),
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
                  const CheckC(nomes: ['Não', 'Inglês', 'Espanhol', 'outro']),
                  const textLabel(name: 'Informativos impressos'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const CheckC(nomes: [
                    'Não',
                    'Inglês',
                    'Espanhol',
                    'Português',
                    'outro'
                  ]),
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
                      'Regras de Funcionamento',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: sizeScreen.height * 0.03),
                    ),
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Período'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioC(
                    number: 13,
                    options: const [
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
                    getValue: (newValue) {
                      valoresjson['Periodo'] = newValue;
                    },
                  ),
                  const textLabel(name: 'Horário'),
                  Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(),
                    children: [
                      const TableRow(children: [
                        Text('2º FEIRA'),
                        Text('3º FEIRA'),
                        Text('4º FEIRA'),
                        Text('5º FEIRA'),
                        Text('6º FEIRA'),
                        Text('SABADO'),
                        Text('DOMINGO'),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Segunda-Feira_abertura'] = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Terça-Feira_abertura'] = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Quarta-Feira_abertura'] = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Quinta-Feira_abertura'] = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Sexta-Feira_abertura'] = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Sabado_abertura'] = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Domingo_abertura'] = newValue;
                          },
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Segunda-Feira_encerramento'] =
                                newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Terça-Feira_encerramento'] = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Quarta-Feira_encerramento'] = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Quinta-Feira_encerramento'] = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Sexta-Feira_encerramento'] = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Sabado_encerramento'] = newValue;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: '', border: InputBorder.none),
                          onSaved: (newValue) {
                            valoresjson['Domingo_encerramento'] = newValue;
                          },
                        )
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.01,
                  ),
                  //TabelaT2(),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  const textLabel(name: 'Funcionamento 24 horas'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  ExpansionTileYoN(
                    getValue: (newValue) {
                      valoresjson['Funcionamento24H'] = newValue;
                    },
                  ),
                  const textLabel(name: 'Funcionamento em feriados'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  ExpansionTileYoN(
                    getValue: (newValue) {
                      valoresjson['FuncionamentoEmFeriados'] = newValue;
                    },
                  ),
                  const textLabel(name: 'Restrições'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const CheckC(
                    nomes: ['Crianças', 'Fumantes', 'Animais', 'outro'],
                  ),
                  const textLabel(name: 'Outras regras e informações'),

                  CustomTextField(
                    validat: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
                    },
                    name: 'Regras e informações',
                    getValue: (newValue) {
                      valoresjson['RegrasEInformações'] = newValue;
                    },
                  ),
                      SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'CARACTERIZAÇÃO DO FLUXO TURÍSTICO'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Dados da visitação'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Total anual de visitantes (nº)'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  CustomTextField(
                      name: '(nº)',
                      validat: (value) {},
                      getValue: (newValue) {
                        valoresjson['TotalAnualDeVisitantes'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(
                      name: 'Total de visitantes alta temporada(nº)'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  CustomTextField(
                      name: '(nº)',
                      validat: (value) {},
                      getValue: (newValue) {
                        valoresjson['TotalAltaTemporada'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Meses de alta temporada'),
                  SizedBox(
                    height: sizeScreen.height * 0.01,
                  ),

                 CheckC(
                   
                    nomes: const [
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
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Origem dos visitantes/turistas'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
                    'Entorno municipal',
                    'Estadual',
                    'Nacional',
                    'Internacional'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(
                      name: 'Origem dos turistas nacionais (5 estados)'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const Estados(),
                  const Estados(),
                  const Estados(),
                  const Estados(),
                  const Estados(),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(
                      name: 'Origem dos turistas internacionais (5 estados)'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const Paises(),
                  const Paises(),
                  const Paises(),
                  const Paises(),
                  const Paises(),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Ano-base'),

                  CustomTextField(
                      name: 'Ano-base',
                      validat: (value) {},
                      getValue: (newValue) {
                        valoresjson['Ano-base'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Principal público frequentador'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  RadioD(
                      options: const ['Turistas', 'Moradores'],
                      getValue: (newValue) {
                        valoresjson['PrincipalPúblico'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Apoio à comercialização'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(
                        name: 'Integra roteiros turísticos\ncomercializados'),
                    SizedBox(
                      width: sizeScreen.width * 0.04,
                    ),
                    SizedBox(
                        // width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: ExpansionTileYoN(
                      getValue: (newValue) {
                        valoresjson['IntegraRoteiros'] = newValue;
                      },
                    ))
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      const TableRow(children: [
                        Text(
                          'Nome dos principais roteiros (até 5)',
                          textAlign: TextAlign.center,
                        ),
                        Text('E-mail', textAlign: TextAlign.center)
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(name: 'Integra guia turístico'),
                    SizedBox(
                      width: sizeScreen.width * 0.04,
                    ),
                    SizedBox(
                        // width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: ExpansionTileYoN(
                      getValue: (newValue) {
                        valoresjson['IntegraGuia'] = newValue;
                      },
                    ))
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      const TableRow(children: [
                        Text(
                          'Nome dos principais guias impressos (até 5)',
                          textAlign: TextAlign.center,
                        ),
                        Text('E-mail', textAlign: TextAlign.center)
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
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
                      'Características',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: sizeScreen.height * 0.03),
                    ),
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
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
                  const CheckC(
                      nomes: ['Pago', 'Gratuito', 'Coberto', 'Descoberto']),

                  Column(children: [
                    Row(
                      children: [
                        SizedBox(
                          width: sizeScreen.width * 0.05,
                        ),
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
                              name: '',
                              getValue: (newValue) {
                                valoresjson['CapacidadeVeiculos'] = newValue;
                              },
                            ))
                      ],
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.02,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: sizeScreen.width * 0.052,
                        ),
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
                              name: '',
                              getValue: (newValue) {
                                valoresjson['Automóveis'] = newValue;
                              },
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
                              name: '',
                              getValue: (newValue) {
                                valoresjson['Ônibus'] = newValue;
                              },
                            ))
                      ],
                    ),
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Outras e instalações e equipamentos'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const CheckC(nomes: [
                    'Loja de souvenir',
                    'Bar/lanchonete',
                    'Restaurante',
                    'Hospedagem',
                    'Disponibilidade de boias',
                    'Disponibilidade de pedalinhos',
                    'Disponibilidade de embarcações náuticas',
                    'Instalações sanitárias',
                    
                    'Iluminação',
              
                    'outro',
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
             
                  const textLabel(name: 'ATIVIDADES'),

                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Atividades culturais'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Arvorismo'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Atividades pedagógicas'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['AtividadesCulturais'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Boia-cross'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['AtividadesPedagógicas'] = newValue;
                      }),
                
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Bungee-jump'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Bung-jump'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Canoagem'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Caminhada'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Ginástica'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Canoagem'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Kitesurf'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Mergulho'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Mergulho'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Ciclismo'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Observação'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Escalada'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Pesca'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Ginástica'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Rafting'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Rafting'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Remo'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Remo'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Vela'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Motocross'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Windsurft'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['MountainBike'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Trilha'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Observação'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Canionismo'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Arvoriso'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Cachoeirismo'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Parapente/asa-delta'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Outras'),

                  RadioD(
                      options: const [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Pesca'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                

                  const textLabel(name: 'ASPECTOS GERAIS'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.08,
                      ),
                      const textLabel(name: 'Extensão\n(m ou km)'),
                      SizedBox(
                        width: sizeScreen.width * 0.032,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'm ou km',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['Latitude'] = newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.08,
                      ),
                      const textLabel(name: 'Altura (m)'),
                      SizedBox(
                        width: sizeScreen.width * 0.032,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'm',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['Latitude'] = newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.08,
                      ),
                      const textLabel(name: 'Largura\nmédia (m)'),
                      SizedBox(
                        width: sizeScreen.width * 0.032,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'm',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['Latitude'] = newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.08,
                      ),
                      const textLabel(name: 'Volume (m³)'),
                      SizedBox(
                        width: sizeScreen.width * 0.032,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'm³',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['Latitude'] = newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.08,
                      ),
                      const textLabel(name: 'Profundidade\nmédia (m)'),
                      SizedBox(
                        width: sizeScreen.width * 0.032,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'm',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['Latitude'] = newValue;
                            },
                          ))
                    ],
                  ),
                   SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                    textLabel(name: 'Ilhas'),
                       SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                    ExpansionTileYoN(getValue: (newValue){}),
                     SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                    textLabel(name: 'Praias'),
                       SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                    ExpansionTileYoN(getValue: (newValue){}),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.08,
                      ),
                      const textLabel(name: 'Extensão\n(m ou km)'),
                      SizedBox(
                        width: sizeScreen.width * 0.032,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'm ou km',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['PraiaExtensão'] = newValue;
                            },
                          ))]),
                          SizedBox(height: sizeScreen.height * 0.05,),
                    Row(children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(name: 'Arenoso'),
                    SizedBox(
                      width: sizeScreen.width * 0.09,
                    ),
                    SizedBox(
                        // width: sizeScreen.width * 0.5,
                        //  //height: sizeScreen.height * 0.07,
                        child: ExpansionTileYoN(
                      getValue: (newValue) {
                        valoresjson['Rochoso'] = newValue;
                      },
                    )),
                    SizedBox(
                      height: sizeScreen.height * 0.02,
                    ),
                  ]),
         
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Areia'),
                  const CheckC(nomes: [
                    'Fina',
                    'Grossa',
                    'Branca',
                    'Amarela',
                    'Escura',
                    'outro'
                  ]),
                  Row(children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(name: 'Rochoso'),
                    SizedBox(
                      width: sizeScreen.width * 0.09,
                    ),
                    SizedBox(
                        // width: sizeScreen.width * 0.5,
                        //  //height: sizeScreen.height * 0.07,
                        child: ExpansionTileYoN(
                      getValue: (newValue) {
                        valoresjson['Rochoso'] = newValue;
                      },
                    )),
                    SizedBox(
                      height: sizeScreen.height * 0.02,
                    ),
                  ]),
                  const textLabel(name: 'Água'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Característica'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const CheckC(nomes: [
                    'Transparente',
                    'Clara',
                    'Escura',
                    'Azulada',
                    'Esverdeada',
                    'Calma',
                    'Agitada',
                    'Fria',
                    'Morna',
                    'Pequenas ondas',
                    'Ondas médias',
                    'Ondas fortes',
                    'Piscinas naturais',
                    'Correntes fortes'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Utilização'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const CheckC(nomes: [
                    'Banho',
                    'Ingestão',
                    'Navegação',
                    'Aventura',
                    'outro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Finalidade'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const CheckC(
                      nomes: ['Terapêutica', 'Lazer', 'Comercial', 'outro']),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Tipo'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                      options: const ['Termal', 'Mineral'],
                      getValue: (newValue) {
                        valoresjson['tipo'] = newValue;
                      }),
                  const textLabel(name: 'Propriedade'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const CheckC(nomes: [
                    'Ferruginosa',
                    'Magnesiana',
                    'Sulforosa',
                    'Radioativa',
                    'Alcalina',
                    'Arsenical',
                    'Cloretada',
                    'Iodetada',
                    'Sulfatada',
                    'Sulfuretada',
                    'outro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  const textLabel(name: 'Volume'),
                  RadioD(
                      options: const [
                        'Grande',
                        'Médio',
                        'Pequeno',
                        'Perene',
                        'Sazonal'
                      ],
                      getValue: (newValue) {
                        valoresjson['volume'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.07,
                      ),
                      const textLabel(name: 'Encontro\nde águas'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['EncontroDeÁguas'] = newValue;
                          })),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.08,
                      ),
                      const textLabel(name: 'Encontro\ncom o rio'),
                      SizedBox(
                        width: sizeScreen.width * 0.032,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'Encontro com o rio',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['EncontroComoRio'] = newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  const textLabel(name: 'Foz'),
                  RadioD(
                      options: const ['Estuário', 'Delta', 'Estuário deltaico'],
                      getValue: (newValue) {
                        valoresjson['foz'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
               
                 textLabel(name: 'Relevo'),
                   SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  RadioD(options: ['Montanha', 'Serra', 'Monte/morro/colina', 'Pico/cume', 'Chapada/tabuleiro/matacão', 'Patamar', 'Dolina', 'Vale', 'Planalto', 'Planície', 'Depressão', 'Salina', 'Caverna', 'Gruta', 'Furna'], getValue: (newValue){

                  }),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),

                
                  const textLabel(name: 'FLORA'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Vegetação'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  RadioD(
                      options: const [
                        'Floresta amazônica',
                        'Mata atlântica',
                        'Mata de araucária',
                        'Cerrado',
                        'Caatinga',
                        'Campo',
                        'Complexo do pantanal',
                        'Manguezal',
                        'Vegetação litorânea'
                      ],
                      getValue: (newValue) {
                        valoresjson['Vegetação'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Espécies'),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      const SizedBox(
                        child: textLabel(name: 'Endêmica'),
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      SizedBox(child: ExpansionTileYoN(
                        getValue: (newValue) {
                          valoresjson['Endemica'] = newValue;
                        },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Melhores meses de observação'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
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
                    'Dezembro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      const SizedBox(
                        child: textLabel(name: 'Rara'),
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      SizedBox(child: ExpansionTileYoN(
                        getValue: (newValue) {
                          valoresjson['Rara'] = newValue;
                        },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),

                  const textLabel(name: 'Melhores meses de observação'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
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
                    'Dezembro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      const SizedBox(
                        child: textLabel(name: 'Em extinção'),
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      SizedBox(child: ExpansionTileYoN(
                        getValue: (newValue) {
                          valoresjson['EmExtinção'] = newValue;
                        },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Melhores meses de observação'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
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
                    'Dezembro'
                  ]),
                  SizedBox(height: sizeScreen.height * 0.035),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      const SizedBox(
                        child: textLabel(name: 'Exótica'),
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      SizedBox(child: ExpansionTileYoN(
                        getValue: (newValue) {
                          valoresjson['Exótica'] = newValue;
                        },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Melhores meses de observação'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
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
                    'Dezembro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Outras'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  CustomTextField(
                      name: 'outras',
                      validat: (value) {},
                      getValue: (newValue) {
                        valoresjson['outras'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Melhores meses de observação'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
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
                    'Dezembro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'FAUNA'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Espécies'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      const SizedBox(
                        child: textLabel(name: 'Endêmica'),
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      SizedBox(child: ExpansionTileYoN(
                        getValue: (newValue) {
                          valoresjson['Endemica'] = newValue;
                        },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Melhores meses de observação'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
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
                    'Dezembro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      const SizedBox(
                        child: textLabel(name: 'Rara'),
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      SizedBox(child: ExpansionTileYoN(
                        getValue: (newValue) {
                          valoresjson['Rara'] = newValue;
                        },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),

                  const textLabel(name: 'Melhores meses de observação'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
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
                    'Dezembro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      const SizedBox(
                        child: textLabel(name: 'Em extinção'),
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      SizedBox(child: ExpansionTileYoN(
                        getValue: (newValue) {
                          valoresjson['EmExtinção'] = newValue;
                        },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Melhores meses de observação'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
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
                    'Dezembro'
                  ]),
                  SizedBox(height: sizeScreen.height * 0.035),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      const SizedBox(
                        child: textLabel(name: 'Exótica'),
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.1,
                      ),
                      SizedBox(child: ExpansionTileYoN(
                        getValue: (newValue) {
                          valoresjson['Exótica'] = newValue;
                        },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Melhores meses de observação'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
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
                    'Dezembro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Outras'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  CustomTextField(
                      name: 'outras',
                      validat: (value) {},
                      getValue: (newValue) {
                        valoresjson['outras'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Melhores meses de observação'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
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
                    'Dezembro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'ATIVIDADE ECONÔMICA'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Agropecuária'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
                    'Não',
                    'Agricultura',
                    'Pecuária',
                    'Aquicultura',
                    'Sivicultura',
                    'outro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Industrial'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: [
                    'Não',
                    'Petrolífera',
                    'Automobilística',
                    'Têxtil',
                    'Alimentíica',
                    'Coureira',
                    'Joalheira',
                    'Madeireira',
                    'Ceramista',
                    'outro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Extrativista'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const CheckC(nomes: ['Não', 'Mineral', 'Vegetal', 'Animal']),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(
                      name: 'Descritivo das especificidades do atrativo'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  CustomTextField(
                      name: 'Descritivo das especificidades do atrativo',
                      validat: (value) {},
                      getValue: (newValue) {}),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'ACESSO AO ATRATIVO'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'A pé'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  const textLabel(name: 'Trilha de acesso'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  RadioD(
                      options: const ['Pavimentada', 'Não pavimentada'],
                      getValue: (newValue) {}),
                  Row(
                    children: [
                      SizedBox(
                        width: sizeScreen.width * 0.08,
                      ),
                      const textLabel(name: 'Extensão\n(m ou km)'),
                      SizedBox(
                        width: sizeScreen.width * 0.032,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'm ou km',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['Latitude'] = newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  const textLabel(name: 'Grau de dificuldade'),
                  RadioD(
                      options: const ['Leve', 'Semipesada', 'Pesada'],
                      getValue: (newValue) {}),
                  const textLabel(name: 'Transporte'),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  const textLabel(name: 'Regular'),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      const TableRow(children: [
                        Text(
                          'Empresa',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Telefone',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'E-mail',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Site',
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  const textLabel(name: 'Fretado'),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      const TableRow(children: [
                        Text(
                          'Empresa',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Tipo de transporte',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Telefone',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Site',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'E-mail',
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Container(
                    color: const Color.fromARGB(255, 55, 111, 60),
                    height: sizeScreen.height * 0.15,
                    width: sizeScreen.width,
                    padding: EdgeInsets.only(
                        top: sizeScreen.height * 0.008,
                        left: sizeScreen.width * 0.04),
                    child: Text(
                      'Proteção, Qualificação, Certificação, Premiação, Destaques e Outros',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: sizeScreen.height * 0.03),
                    ),
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(name: 'Do atrativo'),
                    SizedBox(
                      width: sizeScreen.width * 0.09,
                    ),
                    SizedBox(
                        // width: sizeScreen.width * 0.5,
                        //  //height: sizeScreen.height * 0.07,
                        child: ExpansionTileYoN(
                      getValue: (newValue) {
                        valoresjson['Do Atrativo'] = newValue;
                      },
                    ))
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      const TableRow(children: [
                        Text(
                          'Categoria',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Instrumento(nº) ',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Nome/Título/Certificação/Licenciamento/outro',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Entidade declaratória/Tipo de declaração',
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      TableRow(children: [
                        const Text(
                          'Municipal',
                          textAlign: TextAlign.center,
                        ),
                        const Column(
                          children: [
                            Text(
                              'Lei/Decreto\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Portaria/Instrução/Deliberação\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Norma/Ato\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Outro',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(children: [
                        const Text(
                          'Estadual/Distrital',
                          textAlign: TextAlign.center,
                        ),
                        const Column(
                          children: [
                            Text(
                              'Lei/Decreto\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Portaria/Instrução/Deliberação\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Norma/Ato\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Outro',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(children: [
                        const Text(
                          'Federal',
                          textAlign: TextAlign.center,
                        ),
                        const Column(
                          children: [
                            Text(
                              'Lei/Decreto\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Portaria/Instrução/Deliberação\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Norma/Ato\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Outro',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(children: [
                        const Text(
                          'Internacional',
                          textAlign: TextAlign.center,
                        ),
                        const Column(
                          children: [
                            Text(
                              'Lei/Decreto\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Portaria/Instrução/Deliberação\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Norma/Ato\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Outro',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ])
                    ],
                  ),SizedBox(height: sizeScreen.height * 0.05,),
                    Row(children: [
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    const textLabel(name: 'Da área em que está\nlocalizado/instalado'),
                    SizedBox(
                      width: sizeScreen.width * 0.09,
                    ),
                    SizedBox(
                        // width: sizeScreen.width * 0.5,
                        //  //height: sizeScreen.height * 0.07,
                        child: ExpansionTileYoN(
                      getValue: (newValue) {
                        valoresjson['Do Atrativo'] = newValue;
                      },
                    ))
                  ]),
                  SizedBox(height: sizeScreen.height * 0.05,),
                     Table(
                    border: TableBorder.all(),
                    children: [
                      const TableRow(children: [
                        Text(
                          'Categoria',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Instrumento(nº) ',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Nome/Título/Certificação/Licenciamento/outro',
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Entidade declaratória/Tipo de declaração',
                          textAlign: TextAlign.center,
                        ),
                      ]),
                      TableRow(children: [
                        const Text(
                          'Municipal',
                          textAlign: TextAlign.center,
                        ),
                        const Column(
                          children: [
                            Text(
                              'Lei/Decreto\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Portaria/Instrução/Deliberação\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Norma/Ato\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Outro',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(children: [
                        const Text(
                          'Estadual/Distrital',
                          textAlign: TextAlign.center,
                        ),
                        const Column(
                          children: [
                            Text(
                              'Lei/Decreto\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Portaria/Instrução/Deliberação\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Norma/Ato\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Outro',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(children: [
                        const Text(
                          'Federal',
                          textAlign: TextAlign.center,
                        ),
                        const Column(
                          children: [
                            Text(
                              'Lei/Decreto\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Portaria/Instrução/Deliberação\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Norma/Ato\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Outro',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(children: [
                        const Text(
                          'Internacional',
                          textAlign: TextAlign.center,
                        ),
                        const Column(
                          children: [
                            Text(
                              'Lei/Decreto\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Portaria/Instrução/Deliberação\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Norma/Ato\n',
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Outro',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ])
                    ],
                  ),
                   SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Container(
                    color: const Color.fromARGB(255, 55, 111, 60),
                    height: sizeScreen.height * 0.06,
                    width: sizeScreen.width,
                    padding: EdgeInsets.only(
                        top: sizeScreen.height * 0.008,
                        left: sizeScreen.width * 0.04),
                    child: Text(
                      'Estado Geral de conservação',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: sizeScreen.height * 0.03),
                    ),
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  RadioD(options: ['Muito bom', 'bom', 'ruim'], getValue: (newValue){

                  }),
                   SizedBox(
                    height: sizeScreen.height * 0.03,
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
                    height: sizeScreen.height * 0.05,
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
              SendButton(),

              SizedBox(
                height: sizeScreen.height * 0.05,
              )
            ]),
                )));
  }
}
