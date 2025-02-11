import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/apis/estados.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/apis/paises.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/tabela.dart';

import '../../widgets/customOutro.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/expandedTileYoN.dart';
import '../../widgets/radioButton.dart';
import '../formsB/widgets/sendButton.dart';

class ZonaCosteira extends StatefulWidget {
   ZonaCosteira({super.key});

  @override
  State<ZonaCosteira> createState() => _ZonaCosteiraState();
}

class _ZonaCosteiraState extends State<ZonaCosteira> {
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
          backgroundColor:  Color.fromARGB(255, 55, 111, 60),
          title:  Text(
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
                                decoration:  InputDecoration(
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
                                decoration:  InputDecoration(
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
                      decoration:  InputDecoration(
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
                   textLabel(name: 'Tipo:'),
                  Padding(
                    padding: EdgeInsets.only(left: sizeScreen.width * 0.19),
                    child: RadioB(
                      name: 'Zona costeira',
                      getValue: (newValue) {
                        valoresjson['Tipo'] = newValue;
                      },
                    ),
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Subtipos:'),
                  RadioC(
                      number: 14,
                      options:  [
                        'Restinga',
                        'Duna',
                        'Barreira',
                        'Praia',
                        'Mangue',
                        'Estuário',
                        'Falésia',
                        'Baía/enseada/saco',
                        'Península/cabo/ponta',
                        'Recife/atol',
                        'Ilha',
                        'Arquipélago',
                        'Barra',
                        'outro'
                      ],
                      getValue: (newValue) {
                        valoresjson['Subtipo'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Container(
                    color:  Color.fromARGB(255, 55, 111, 60),
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
                    height: sizeScreen.height * 0.01,
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
                    child:  textLabel(name: 'Natureza:'),
                  ),
                  Column(
                    children: [
                      RadioD(
                        options:  ['pública', 'privada', 'outro'],
                        getValue: (newValue) {
                          valoresjson['natureza'] = newValue;
                        },
                      ),
                    ],
                  ),
                   textLabel(
                    name: 'tipo de organização/instituição:',
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   CheckC(nomes: [
                    'associação',
                    'sindicato',
                    'cooperativa',
                    'sistema S',
                    'empresa',
                    'outro'
                  ]),

                   textLabel(name: 'Localização:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                    options:  ['urbana', 'rural'],
                    getValue: (newValue) {
                      valoresjson['Localização'] = newValue;
                    },
                  ),
                   textLabel(name: 'Coordenadas Geográficas:'),
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
                     
                         textLabel(name: 'Longitude'),
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
                   textLabel(name: 'Endereço:'),
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
                   textLabel(name: 'Sinalização:'),
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
                      getValue: (newValue) {
                        valoresjson['SinalizaçãoDeAcesso'] = newValue;
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
                      getValue: (newValue) {
                        valoresjson['SinalizaçãoTurística'] = newValue;
                      },
                    ))
                  ]),
                   SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   textLabel(name: 'Proximidades:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  //  RadioD(number: 6, options: options)
                   CheckC(nomes: [
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
                   textLabel(name: 'Distâncias (km):'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
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
                   
                       textLabel(name: 'Estação\nferroviária:'),
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
                    
                       textLabel(name: 'Estação\nmarítima\n/fluvial:'),
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
                     
                       textLabel(name: 'Estação\nmetroviária:'),
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
                    
                       textLabel(name: 'Ponto\nde ônibus'),
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
                      
                       textLabel(name: 'Ponto\n de taxi'),
                      SizedBox(
                        width: sizeScreen.width * 0.15,
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
                      
                       textLabel(name: 'Outras:'),
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
                   textLabel(name: 'Pontos de referência:'),
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
                   textLabel(name: 'Entidade Mantedora:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  Row(
                    children: [
                     
                       textLabel(name: 'E-mail'),
                      SizedBox(width: sizeScreen.width * 0.05,),
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
                     
                       textLabel(
                          name: 'Site'),
                      SizedBox(
                        width: sizeScreen.width * 0.11,
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
                    color:  Color.fromARGB(255, 55, 111, 60),
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
                   textLabel(name: 'Estrutura de funcionamento:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   Row(children: [
                    
                     textLabel(name: 'Visitação:'),
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
                   textLabel(name: 'Finalidade da visitação:'),
                      SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   CheckC(nomes: [
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
                   textLabel(name: 'Agendada:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                      options:  ['Não', 'Opcional', 'Obrigatória'],
                      getValue: (newValue) {
                        valoresjson['Agendada'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   textLabel(name: 'Autoguiada:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                      options:  ['Não', 'Opcional', 'Obrigatória'],
                      getValue: (newValue) {
                        valoresjson['Autoguiada'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   textLabel(name: 'Guiada:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                      options:  ['Não', 'Opcional', 'Obrigatória'],
                      getValue: (newValue) {
                        valoresjson['Guiada'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   textLabel(name: 'Entrada:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  Row(children: [
                    
                     textLabel(name: 'Gratuita:'),
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
                    height: sizeScreen.height * 0.05,
                  ),
                   Row(children: [
                    
                     textLabel(name: 'Paga:'),
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
                   textLabel(name: 'Instalações de entrada:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  Row(children: [
                    
                     textLabel(name: 'Centro de recepção:'),
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
                    height: sizeScreen.height * 0.05,
                  ),
                   Row(children: [
                    
                     textLabel(name: 'Posto de informação:'),
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
                    height: sizeScreen.height * 0.05,
                  ),
                   Row(children: [
                    
                     textLabel(name: 'Portaria principal:'),
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
                    height: sizeScreen.height * 0.05,
                  ),
                    Row(children: [
                    
                     textLabel(name: 'Guarita:'),
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
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(children: [
                    
                     textLabel(name: 'Bilheteria:'),
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
                    height: sizeScreen.height * 0.05,
                  ),
                    Row(children: [
                    
                     textLabel(name: 'Outras:'),
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
                   textLabel(name: 'Atendimento ao público:'),
                  SizedBox(
                    height: sizeScreen.height * 0.04,
                  ),

                   textLabel(name: 'Atendimento em língua estrangeira:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   CheckC(nomes: ['Não', 'Inglês', 'Espanhol', 'outro']),
                   textLabel(name: 'Informativos impressos:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   CheckC(nomes: [
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
                    color:  Color.fromARGB(255, 55, 111, 60),
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
                   textLabel(name: 'Período:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioC(
                    number: 13,
                    options:  [
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
                   textLabel(name: 'Horário:'),
                   SizedBox(height: 15,),
                  TabelaT2(getValues: (newValue){}),
                  SizedBox(
                    height: sizeScreen.height * 0.01,
                  ),
                  //TabelaT2(),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                    Row(children: [
                    
                     textLabel(name: 'Funcionamento 24H:'),
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
                  SizedBox(height: sizeScreen.height * 0.05,),
                 Row(children: [
                    
                     textLabel(name: 'Funcionamento em\nferiados:'),
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
                   textLabel(name: 'Restrições:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   CheckC(
                    nomes: ['Crianças', 'Fumantes', 'Animais', 'outro'],
                  ),
                   textLabel(name: 'Outras regras e informações:'),

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
                   textLabel(name: 'Dados da visitação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   textLabel(name: 'Total anual de visitantes (nº):'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  CustomTextField(
                      name: '(nº)',
                      validat: (value) {
                        return null;
                      },
                      getValue: (newValue) {
                        valoresjson['TotalAnualDeVisitantes'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(
                      name: 'Total de visitantes alta temporada(nº):'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  CustomTextField(
                      name: '(nº)',
                      validat: (value) {
                        return null;
                      },
                      getValue: (newValue) {
                        valoresjson['TotalAltaTemporada'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Meses de alta temporada:'),
                  SizedBox(
                    height: sizeScreen.height * 0.01,
                  ),

                 CheckC(nomes:
                     [
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
                   textLabel(name: 'Origem dos visitantes/turistas:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
                    'Entorno municipal',
                    'Estadual',
                    'Nacional',
                    'Internacional'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(
                      name: 'Origem dos turistas nacionais (5 estados):'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   Estados(),
                   Estados(),
                   Estados(),
                   Estados(),
                   Estados(),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(
                      name: 'Origem dos turistas internacionais (5 países):'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   Paises(),
                   Paises(),
                   Paises(),
                   Paises(),
                   Paises(),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Ano-base:'),

                  CustomTextField(
                      name: 'Ano-base',
                      validat: (value) {
                        return null;
                      },
                      getValue: (newValue) {
                        valoresjson['Ano-base'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Principal público frequentador'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  RadioD(
                      options:  ['Turistas', 'Moradores'],
                      getValue: (newValue) {
                        valoresjson['PrincipalPúblico'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Apoio à comercialização:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(children: [
                   
                     textLabel(
                        name: 'Integra roteiros turísticos\ncomercializados:'),
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
                       TableRow(decoration: BoxDecoration(color: Color.fromARGB(255, 55, 111, 60)),children: [
                        Text(
                          'Nome dos principais\nroteiros (até 5)',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('E-mail', textAlign: TextAlign.center,   style: TextStyle(color: Colors.white),)
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(children: [
                 
                     textLabel(name: 'Integra guia turístico:'),
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
                       TableRow(decoration: BoxDecoration(color: Color.fromARGB(255, 55, 111, 60)),children: [
                        Text(
                          'Nome dos principais guias impressos (até 5)',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('E-mail', textAlign: TextAlign.center,     style: TextStyle(color: Colors.white),)
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Container(
                    color:  Color.fromARGB(255, 55, 111, 60),
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
                    child:  textLabel(name: 'Instalações:'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: sizeScreen.height * 0.03,
                        bottom: sizeScreen.height * 0.03),
                    child:  textLabel(name: 'Estacionamento:'),
                  ),
                   CheckC(
                      nomes: ['Pago', 'Gratuito', 'Coberto', 'Descoberto']),

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
                        
                         textLabel(name: 'Automóveis nº'),
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
                        
                         textLabel(name: 'Ônibus nº'),
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
                   textLabel(name: 'Outras instalações e estruturas:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   CheckC(nomes: [
                    'Ambulatório médico',
                    'Espaço para festas e eventos',
                    'Loja de souvenir',
                    'Sinalização interna',
                    'Quadra poliesportiva',
                    'Zoológico',
                    'Feiras',
                    'Museu',
                    'Anfiteatro',
                    'Iluminação',
                    'Instalações sanitárias',
                    'Caixa eletrônico',
                    ' Grade ou proteção',
                    ' Telefones públicos',
                    'Guarda-volumes',
                    'Bebedouros',
                    'Refletores',
                    'Churrasqueira',
                    'outro',
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Estruturas e serviços:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
                    'Hospedagem',
                    'Restaurante',
                    'Bar/lanchonete',
                    'Serviço de informações',
                    'Vendedores ambulantes',
                    'Instalações sanitárias',
                    'Disponibilidade de biciletas',
                    'Disponibilidade de cavalos',
                    'Disponobilidade de boias',
                    'outro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),

                   textLabel(name: 'Atividades:'),

                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Arvorismo:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Atividades culturais:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Atividades pedagógicas:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Boia-cross:'),

                  RadioD(
                      options:  [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Boia-cross'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Bungee-jump:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Caminhada:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Canoagem:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Cavalgada:'),

                  RadioD(
                      options:  [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Cavalgada'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Ciclismo:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Escalada:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Ginástica:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Kitesurf:'),

                  RadioD(
                      options:  [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Kitesurf'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Mergulho:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Motocross:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Mountain bike:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Observação:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Off road:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Parapente/asa-delta:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Pesca:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Rafting:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'Rapel:'),

                  RadioD(
                      options:  [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Rapel'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Remo:'),

                  RadioD(
                      options:  [
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
                   textLabel(name: 'SafáriFotográfico:'),

                  RadioD(
                      options:  [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['SafáriFotográfico'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Skate:'),

                  RadioD(
                      options:  [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Skate'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Vela:'),

                  RadioD(
                      options:  [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Vela'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Voo livre:'),

                  RadioD(
                      options:  [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['VooLivre'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Windsurf:'),

                  RadioD(
                      options:  [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['WindSurf'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Trilha:'),

                  RadioD(
                      options:  [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Trilha'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Outras:'),

                  RadioD(
                      options:  [
                        'Não',
                        'Sim',
                        'Disponibilidade de equipamentos'
                      ],
                      getValue: (newValue) {
                        valoresjson['Outras'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),

                   textLabel(name: 'Aspectos gerais:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                     
                       textLabel(name: 'Extensão\n(m ou km):'),
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
                   textLabel(name: 'Recife:'),
                  RadioD(
                      options:  ['Arenítico', 'Coralígeno'],
                      getValue: (newValue) {
                        valoresjson['Recife'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.01,
                  ),
                   textLabel(name: 'Orla:'),
                  SizedBox(
                    height: sizeScreen.height * 0.01,
                  ),
                   textLabel(name: 'Tipo:'),
                  RadioD(
                      options:  [
                        'Mar aberto',
                        'Mar abrigado',
                        'Correntes fortes',
                        'Piscinas naturais',
                        'Pequenas ondas',
                        'Ondas médias',
                        'Ondas fortes'
                      ],
                      getValue: (newValue) {
                        valoresjson['orla'] = newValue;
                      }),
                   textLabel(name: 'Ocupação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.01,
                  ),
                   textLabel(name: 'Tipo:'),
                  RadioD(
                      options:  [
                        'Moradia de residentes',
                        'Moradia de veranistas',
                        'Sem ocupação'
                      ],
                      getValue: (newValue) {
                        valoresjson['Ocupação'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.01,
                  ),
                   textLabel(name: 'Forma:'),
                  RadioD(
                      options:  ['Urbanizada', 'Não urbanizada'],
                      getValue: (newValue) {
                        valoresjson['Forma'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.01,
                  ),
                   textLabel(name: 'Praia:'),
                  Row(
                    children: [
                      
                       textLabel(name: 'Extensão\n(m ou km):'),
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
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
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
                      getValue: (newValue) {
                        valoresjson['SinalizaçãoDeAcesso'] = newValue;
                      },
                    ))
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   textLabel(name: 'Areia:'),
                   SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   CheckC(nomes: [
                    'Fina',
                    'Grossa',
                    'Branca',
                    'Amarela',
                    'Escura',
                    'outro'
                  ]),
                  Row(children: [
                    
                     textLabel(name: 'Rochoso:'),
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
                   textLabel(name: 'Água:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   textLabel(name: 'Característica:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   CheckC(nomes: [
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
                   textLabel(name: 'Utilização:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   CheckC(nomes: [
                    'Banho',
                    'Ingestão',
                    'Navegação',
                    'Aventura',
                    'outro'
                  ]),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   textLabel(name: 'Finalidade:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   CheckC(
                      nomes: ['Terapêutica', 'Lazer', 'Comercial', 'outro']),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   textLabel(name: 'Tipo:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                      options:  ['Termal', 'Mineral'],
                      getValue: (newValue) {
                        valoresjson['tipo'] = newValue;
                      }),
                   textLabel(name: 'Propriedade:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                   CheckC(nomes: [
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
                   textLabel(name: 'Volume:'),
                  RadioD(
                      options:  [
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
                     
                       textLabel(name: 'Encontro\nde águas:'),
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
                     
                       textLabel(name: 'Encontro\ncom o rio:'),
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
                   textLabel(name: 'Foz:'),
                  RadioD(
                      options:  ['Estuário', 'Delta', 'Estuário deltaico'],
                      getValue: (newValue) {
                        valoresjson['foz'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                      
                       textLabel(name: 'Profundidade\nmédia (m):'),
                      SizedBox(
                        width: sizeScreen.width * 0.032,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '(m)',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['ProfundidadeMédia'] = newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                   textLabel(name: 'Hidrografia:'),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                     
                       textLabel(name: 'Rio:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['Rio'] = newValue;
                          })),
                    ],
                  ),

                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                      
                       textLabel(name: 'Quedas\nd agua:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['Rio'] = newValue;
                          })),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                   textLabel(name: 'Tipo:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                      options:  [
                        'Catarata',
                        'Cachoeira',
                        'Salto',
                        'Cascata',
                        'Corredeira'
                      ],
                      getValue: (newValue) {
                        valoresjson['tipo'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                    
                       textLabel(name: 'Riacho:'),
                      
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['Riacho'] = newValue;
                          })),
                    ],
                  ),

                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                      
                       textLabel(name: 'Quedas\nd agua:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['RiachoQuedasDagua'] = newValue;
                          })),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                     
                       textLabel(name: 'Rio:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['Rio'] = newValue;
                          })),
                    ],
                  ),

                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                     
                       textLabel(name: 'Quedas\nd agua:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['Rio'] = newValue;
                          })),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                   textLabel(name: 'Tipo:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                      options:  [
                        'Catarata',
                        'Cachoeira',
                        'Salto',
                        'Cascata',
                        'Corredeira'
                      ],
                      getValue: (newValue) {
                        valoresjson['tipo'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                      
                       textLabel(name: 'Córrego:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['Corrego'] = newValue;
                          })),
                    ],
                  ),

                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                     
                       textLabel(name: 'Quedas d agua:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['CorregoQuedasDagua'] = newValue;
                          })),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                    
                       textLabel(name: 'Rio:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['Rio'] = newValue;
                          })),
                    ],
                  ),

                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                      
                       textLabel(name: 'Quedas\nd agua:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['Rio'] = newValue;
                          })),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                   textLabel(name: 'Tipo:'),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  RadioD(
                      options:  [
                        'Catarata',
                        'Cachoeira',
                        'Salto',
                        'Cascata',
                        'Corredeira'
                      ],
                      getValue: (newValue) {
                        valoresjson['tipo'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                     
                       textLabel(name: 'Fonte:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['Fonte'] = newValue;
                          })),
                    ],
                  ),

                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                      
                       textLabel(name: 'Lago/lagoa\n/laguna:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['RiachoQuedasDagua'] = newValue;
                          })),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                      
                       textLabel(name: 'Alagado:'),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          //height: sizeScreen.height * 0.07,
                          child: ExpansionTileYoN(getValue: (newValue) {
                            valoresjson['Alagado'] = newValue;
                          })),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                     
                       textLabel(name: 'Outras'),
                      SizedBox(
                        width: sizeScreen.width * 0.032,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['Outras'] = newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Relevo:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),

                  RadioC(
                    options:  [
                      'Montanha',
                      'Serra',
                      'Monte/morro/colina',
                      'Pico/cume',
                      'Chapada/tabuleiro/matacão',
                      'Patamar',
                      'Dolina',
                      'Vale',
                      'Planalto',
                      'Planície',
                      'Depressão',
                      'Salina',
                      'Caverna',
                      'Gruta',
                      'Furna'
                    ],
                    getValue: (newValue) {
                      valoresjson['Relevo'] = newValue;
                    },
                    number: 15,
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Flora:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Vegetação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  RadioD(
                      options:  [
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
                   textLabel(name: 'Espécies:'),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Row(
                    children: [
                     
                       SizedBox(
                        child: textLabel(name: 'Endêmica:'),
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
                   textLabel(name: 'Melhores meses de observação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                        child: textLabel(name: 'Rara:'),
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

                   textLabel(name: 'Melhores meses de observação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                        child: textLabel(name: 'Em extinção:'),
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
                   textLabel(name: 'Melhores meses de observação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                        child: textLabel(name: 'Exótica:'),
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
                   textLabel(name: 'Melhores meses de observação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                   textLabel(name: 'Outras:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  CustomTextField(
                      name: 'outras',
                      validat: (value) {
                        return null;
                      },
                      getValue: (newValue) {
                        valoresjson['outras'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Melhores meses de observação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                   textLabel(name: 'Fauna:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Espécies:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Row(
                    children: [
                    
                       SizedBox(
                        child: textLabel(name: 'Endêmica:'),
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
                   textLabel(name: 'Melhores meses de observação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                        child: textLabel(name: 'Rara:'),
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

                   textLabel(name: 'Melhores meses de observação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                        child: textLabel(name: 'Em extinção:'),
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
                   textLabel(name: 'Melhores meses de observação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                        child: textLabel(name: 'Exótica:'),
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
                   textLabel(name: 'Melhores meses de observação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                   textLabel(name: 'Outras:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  CustomTextField(
                      name: 'outras',
                      validat: (value) {
                        return null;
                      },
                      getValue: (newValue) {
                        valoresjson['outras'] = newValue;
                      }),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Melhores meses de observação:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                   textLabel(name: 'Atividade econômica:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Agropecuária:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                   textLabel(name: 'Industrial:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: [
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
                   textLabel(name: 'Extrativista:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   CheckC(nomes: ['Não', 'Mineral', 'Vegetal', 'Animal']),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(
                      name: 'Descritivo das especificidades do atrativo:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  CustomTextField(
                      name: 'Descritivo das especificidades do atrativo',
                      validat: (value) {
                        return null;
                      },
                      getValue: (newValue) {}),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Acesso ao atrativo:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'A pé:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                   textLabel(name: 'Trilha de acesso:'),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  RadioD(
                      options:  ['Pavimentada', 'Não pavimentada'],
                      getValue: (newValue) {}),
                  Row(
                    children: [
                    
                       textLabel(name: 'Extensão\n(m ou km):'),
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
                   textLabel(name: 'Grau de dificuldade:'),
                  RadioD(
                      options:  ['Leve', 'Semipesada', 'Pesada'],
                      getValue: (newValue) {}),
                   textLabel(name: 'Transporte:'),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                   textLabel(name: 'Regular:'),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                       TableRow(decoration: BoxDecoration(color: Color.fromARGB(255, 55, 111, 60),),children: [
                        Text(
                          'Empresa',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Telefone',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'E-mail',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Site',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                   textLabel(name: 'Fretado:'),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Table(
                    border: TableBorder.all(),
                    children: [
                       TableRow(decoration: BoxDecoration(color: Color.fromARGB(255, 55, 111, 60),),children: [
                        Text(
                          'Empresa',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Tipo de transporte',
                          textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Telefone',
                          textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Site',
                          textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'E-mail',
                          textAlign: TextAlign.center,      style: TextStyle(color: Colors.white),
                        ),
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                      TableRow(children: [
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        ),
                        TextFormField(
                          decoration:  InputDecoration(
                              fillColor: Colors.white, filled: true),
                        )
                      ]),
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.05,
                  ),
                  Container(
                    color:  Color.fromARGB(255, 55, 111, 60),
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
                  
                     textLabel(name: 'Do atrativo:'),
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
                       TableRow(decoration: BoxDecoration(color: Colors.white), children: [
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
                      TableRow(decoration:  BoxDecoration(color: Colors.white),children: [
                         Text(
                          'Municipal',
                          textAlign: TextAlign.center,
                        ),
                         Column(
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
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(decoration:  BoxDecoration(color: Colors.white),children: [
                         Text(
                          'Estadual/Distrital',
                          textAlign: TextAlign.center,
                        ),
                         Column(
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
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(decoration:  BoxDecoration(color: Colors.white),children: [
                         Text(
                          'Federal',
                          textAlign: TextAlign.center,
                        ),
                         Column(
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
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(decoration:  BoxDecoration(color: Colors.white),children: [
                         Text(
                          'Internacional',
                          textAlign: TextAlign.center,
                        ),
                         Column(
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
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ])
                    ],
                  ),SizedBox(height: sizeScreen.height * 0.05,),
                    Row(children: [
                  
                     textLabel(name: 'Da área em que está\nlocalizado/instalado:'),
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
                       TableRow(decoration: BoxDecoration(color: Colors.white),children: [
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
                      TableRow(decoration:  BoxDecoration(color: Colors.white),children: [
                         Text(
                          'Municipal',
                          textAlign: TextAlign.center,
                        ),
                         Column(
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
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(decoration:  BoxDecoration(color: Colors.white),children: [
                         Text(
                          'Estadual/Distrital',
                          textAlign: TextAlign.center,
                        ),
                         Column(
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
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(decoration:  BoxDecoration(color: Colors.white),children: [
                         Text(
                          'Federal',
                          textAlign: TextAlign.center,
                        ),
                         Column(
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
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        )
                      ]),
                         TableRow(decoration:  BoxDecoration(color: Colors.white),children: [
                         Text(
                          'Internacional',
                          textAlign: TextAlign.center,
                        ),
                         Column(
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
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
                                  fillColor: Colors.white, filled: true),
                            ),
                            TextFormField(
                              decoration:  InputDecoration(
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
                    color:  Color.fromARGB(255, 55, 111, 60),
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
                  RadioD(options:  ['Muito bom', 'bom', 'ruim'], getValue: (newValue){

                  }),
                   SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                  Container(
                    color:  Color.fromARGB(255, 55, 111, 60),
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
               textLabel(
                    name:
                        'Possui alguma facilidade para pessoas com deficiência ou mobilidade reduzida?'),
               SizedBox(height: sizeScreen.height * 0.04,),
               ExpansionTileYoN(getValue: (String ) {  },),
 SizedBox(height: sizeScreen.height * 0.02,),
          textLabel(
                    name: 'obs: responder às questões seguintes'),
          SizedBox(height: sizeScreen.height * 0.02,),
  textLabel(
                    name: 'Pessoal capacitado para receber PCD:'),
                SizedBox(height: sizeScreen.height * 0.02,),
              CheckC(nomes: [
                'Não',
                'Física',
                'Auditiva',
                'Visual',
                'Mental',
                'Múltipla'
              ], ),
              textLabel(name: 'Rota externa acessível:'),
                SizedBox(height: sizeScreen.height * 0.02,),
                 CheckC(nomes: [
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
              ], ),
              Padding(
                padding: EdgeInsets.only(
                   
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Símbolo internacional de acesso:'),
              ),
                 CheckC(nomes: [
                'Não',
                'Entrada',
                'Área reservada',
                'Estacionamento',
                'Área de embarque e desembarque',
                'Sanitário',
                'Saída de emergência',
              ], ),
              Padding(
                padding: EdgeInsets.only(
                   
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Local de embarque e desembarque:'),
              ),
                 CheckC(nomes:  ['Não', 'Sinalizado', 'Com acesso em nível'],),
              Padding(
                padding: EdgeInsets.only(
                  
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Vaga em estacionamento:'),
              ),
                 CheckC(nomes: [
                'Não',
                'Sinalizado',
                'Com acesso em nível',
                'Alargada para cadeira de rodas',
                'Rampa de acesso á calçada'
              ],),
              Padding(
                padding: EdgeInsets.only(
                   
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(
                    name:
                        'Área de circulação / acesso interno para cadeira de rodas:'),
              ),
                CheckC(nomes: [
                'Não',
                'Rampa',
                'Elevador',
                'Plataforma elevatória',
                'Porta larga',
                'Piso regular / antiderrapante'
              ], ),
              Padding(
                padding: EdgeInsets.only(
        
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Escada:'),
              ),
                 CheckC(nomes: [
                'Não',
                'Corrimão',
                'Patamar para descanso',
                'Sinalização tátil de alerta',
                'Piso antiderrapante',
              ], ),

              Padding(
                padding: EdgeInsets.only(
            
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Rampa:'),
              ),
                  CheckC(nomes: [
                'Não',
                'Corrimão',
                'Patamar para descanso',
                'Sinalização tátil de alerta',
                'Piso antiderrapante',
                'Inclinação adequada',
              ], ),
              Padding(
                padding: EdgeInsets.only(
                  
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Piso:'),
              ),
                  CheckC(nomes: [
                'Não',
                'Tátil',
                'Sem obstáculos',
                'Antiderrapante/deslizante',
              ], ),
              Padding(
                padding: EdgeInsets.only(
                  
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Elevador:'),
              ),
                   CheckC(nomes: [
                'Não',
                'Sinalizado em braile',
                'Dispositivo sonoro',
                'Dispositivo luminoso',
                'Sensor eletrônico (porta)'
              ], ),
              Padding(
                padding: EdgeInsets.only(
                   
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(
                    name:
                        'Equipamento motorizado para deslocamento interno:'),
              ),
                CheckC(nomes: [
                'Não',
                'Cadeira',
                'Carrinho',
              ], ),
              Padding(
                padding: EdgeInsets.only(
                 
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Sinalização visual:'),
              ),
                   CheckC(nomes: [
                'Não',
                'Entrada',
                'Recepção',
                'Porta',
                'Sanitário',
                'Elevador',
                'Restaurante',
                'Área de lazer',
                'Área de resgate',
              ], ),
              Padding(
                padding: EdgeInsets.only(
                  
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Sinalização tátil:'),
              ),
                   CheckC(nomes: [
                'Não',
                'Entrada',
                'Recepção',
                'Porta',
                'Sanitário',
                'Elevador',
                'Restaurante',
                'Área de lazer',
                'Área de resgate',
              ], ),
              Padding(
                padding: EdgeInsets.only(
                
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Alarme de emergência:'),
              ),
                 CheckC(nomes: [
                'Não',
                'Sonoro',
                'Visual',
                'Vibratório',
              ], ),
              Padding(
                padding: EdgeInsets.only(
                  
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Comunicação:'),
              ),
                   CheckC(nomes: [
                'Não',
                'Texto informativo em braile',
                'Texto informativo em fonte ampliada',
                'Intérprete em libras',
              ], ),
              Padding(
                padding: EdgeInsets.only(
                    
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Balcão de atendimento:'),
              ),
                  CheckC(nomes: [
                'Não',
                'Rebaixado',
                'Preferencial para PCD ou com deficiência ou mobilidade reduzida',
              ], ),
              Padding(
                padding: EdgeInsets.only(
                    
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Mobiliário:'),
              ),
                CheckC(nomes: [
                'Não',
                'Altura adequada',
                'Recuo adequado',
              ],),
              Padding(
                padding: EdgeInsets.only(
                
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Sanitário:'),
              ),
                  CheckC(nomes: [
                'Não',
                'Porta larga suficiente para entrada de cadeira de rodas ',
                'Acesso para cadeira de rodas',
                'Espelho rebaixado ou com ângulo de alcance visual',
                'Torneira monocomando / alavanca',
                'Barra de apoio',
                'Giro para cadeira de rodas',
                'Pia rebaixada',
                'Boxe ou banheira daptada',
              ], ),
              Padding(
                padding: EdgeInsets.only(
               
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Telefone:'),
              ),
                CheckC(nomes: [
                'Não',
                'Altura adequada',
                'Para surdos (TPS ou TTS)',
              ], ),
              Padding(
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.04),
                child:  textLabel(
                    name:
                        'Sinalização indicativa de atendimento preferencial para pessoas com deficiência ou mobilidade reduzida:'),
              ),

               ExpansionTileYoN(getValue: (newValue ) {
                valoresjson['SinalizaçãoIndicativa'] = newValue;
                 },),
              SizedBox(height: sizeScreen.height * 0.02,),              Row(
                children: [
                 
                   textLabel(name: 'Outros'),
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
                        name: '', getValue: (newValue) {valoresjson['OutrosAcessibilidade'] = newValue;  },
                      ))
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Container(
                color:  Color.fromARGB(255, 55, 111, 60),
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
                  name: '', getValue: (newValue) {valoresjson['Observações'] = newValue;  },),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),

              Container(
                color:  Color.fromARGB(255, 55, 111, 60),
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
                  name: '', getValue: (newValue) {  valoresjson['Referências'] = newValue;},),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Container(
                color:  Color.fromARGB(255, 55, 111, 60),
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
               textLabel(
                  name: 'Responsável pelo atendimento (Pesquisador)'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (newValue) {valoresjson['Pesquisador'] = newValue;  },),
               textLabel(name: 'Telefone'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (newValue) {valoresjson['TelefonePesquisador'] = newValue;  },),
               textLabel(name: 'E-mail'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (newValue) {valoresjson['E-mail'];  },),
               textLabel(
                  name: 'Responsável pelo atendimento (Coordenador)'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (newValue) {valoresjson['Coordenador'];  },),
               textLabel(name: 'Telefone'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (newValue) {valoresjson['TelefoneCoordenador'] = newValue;  },),
               textLabel(name: 'E-mail'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (newValue) {valoresjson['E-mailCoordenador'] = newValue;  },),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
                SendButton(onPressed: () {  },),
                SizedBox(height: 15,)
              ],
            )),
          ),
        );
  }
}
