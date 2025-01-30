import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/tables.dart';

import '../../widgets/expandedTileYoN.dart';
import 'widgets/checkBox.dart';
import 'widgets/sendButton.dart';
import 'widgets/tabela.dart';

class AlimentoseBebidas extends StatefulWidget {
   AlimentoseBebidas({super.key});

  @override
  State<AlimentoseBebidas> createState() => _AlimentoseBebidasState();
}

class _AlimentoseBebidasState extends State<AlimentoseBebidas> {
  final Map<String, dynamic> valoresjson = {
   
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor:  Color.fromARGB(255, 55, 111, 60),
          title:  Text(
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
                              validator: (value) {
                                return null;
                              },
                              onSaved: (newValue) {
                                valoresjson['uf'] = newValue;
                              },
                              decoration:  InputDecoration(
                                hintText: 'UF',
                                hintStyle: TextStyle(fontSize: 50.w)
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
                                  hintText: 'Região Turística',
                                hintStyle: TextStyle(fontSize: 50.w)
                                  ),
                                  
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
                                hintStyle: TextStyle(fontSize: 50.w)

                    ),
                    onSaved: (newValue) {
                      valoresjson['Municipio'] = newValue;
                    },
                  ),
                ), SizedBox(
                  height: 20.w,
                ),
                 textLabel(name: 'Tipo:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: 50.w,
                ),
                RadioD(
                  options:  [
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
                  height: 30.w,
                ),
                CustomTextField(
                    name: 'Razão Social',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['razãoSocial'] = newValue;
                    }),
                CustomTextField(
                    name: 'Nome Fantasia',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['nomeFantasia'] = newValue;
                    }),
                CustomTextField(
                    name: 'CNPJ',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['CNPJ'] = newValue;
                    }),

                    Row(children: [ SizedBox(
                      width: 600.w,
                      child: CustomTextField(
                      name: 'Código CNAE',
                      validat: (value) {
                        return null;
                      },
                      getValue: (newValue) {
                        valoresjson['CódigoCNAE'] = newValue;
                      }),
                    ),
                     Expanded(
                       child: CustomTextField(name: 'Atividade Econômica', validat: (p0) {
                        
                                           }, getValue: (p0) {
                        
                                           },
                                         ),
                     ),],),
               Row(
                  children: [
                    SizedBox(
                      width: 600.w,
                      child: CustomTextField(
                          name: 'Inscrição Municipal',
                          validat: (value) {
                            return null;
                          },
                          getValue: (newValue) {
                            valoresjson['NomeDaRede'] = newValue;
                          }),
                    ),
                    Expanded(
                      child: CustomTextField(
                        name: 'Nome da rede/holding',
                        validat: (p0) {},
                        getValue: (p0) {},
                      ),
                    )
                  ],
                ),
             
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Column(
                  children: [
                     textLabel(name: 'Natureza:', fontWeight: FontWeight.w600,),

                    SizedBox(
                      height: sizeScreen.height * 0.03,
                    ),
                    RadioD(
                        options:  ['pública', 'privada', 'outro'],
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
                     textLabel(name: 'Tipo de organização/instituição:', fontWeight: FontWeight.bold,),
                    SizedBox(
                      height: sizeScreen.height * 0.03,
                    ),
                    CheckC(
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
                 
                     textLabel(name: 'início da atividade:', fontWeight: FontWeight.bold,),
                    SizedBox(
                      width: sizeScreen.width * 0.1,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.4,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextDate(getValue: (newValue) {
                          valoresjson['inicioDaAtividade'] = newValue;
                        }))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                 textLabel(name: 'Quantidade de Funcionários:', fontWeight: FontWeight.bold),
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
                  options:  ['urbana', 'rural'],
                  getValue: (newValue) {
                    valoresjson['localização'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                 textLabel(name: 'Coordenadas Geográficas:', fontWeight: FontWeight.bold),
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
                 textLabel(name: 'Endereço:', fontWeight: FontWeight.bold,),
                CustomTextField(
                  validat: (value) {
                    return null;
                  },
                  name: 'avenida/rua/travessa/caminho/outro',
                  getValue: (newValue) {
                    valoresjson['avenida/rua/etc'] = newValue;
                  },
                ),
                CustomTextField(
                  validat: (value) {
                    return null;
                  },
                  name: 'bairro/localidade',
                  getValue: (newValue) {
                    valoresjson['bairro/localidade'] = newValue;
                  },
                ),
                CustomTextField(
                  validat: (value) {
                    return null;
                  },
                  name: 'distrito',
                  getValue: (newValue) {
                    valoresjson['distrito'] = newValue;
                  },
                ),
                CustomTextField(
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
                    
                       textLabel(name: 'Whatsapp', fontWeight: FontWeight.bold,),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextNumber(
                            labelText: '(DD) n°',
                            getValue: (newValue) {
                              valoresjson['TelefonePrincipal'] = newValue;
                            },
                          ))
                    ],
                  ),
                  Row(
                    children: [
                    
                       textLabel(name: 'Instagram', fontWeight: FontWeight.bold,),
                      SizedBox(
                        width: sizeScreen.width * 0.03,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextNumber(
                            labelText: '@',
                            getValue: (newValue) {
                              valoresjson['TelefonePrincipal'] = newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                ]),

                Row(
                  children: [
                   
                     textLabel(name: 'E-mail', fontWeight: FontWeight.bold,),
                     SizedBox(
                      width: sizeScreen.width * 0.04,
                    ),
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
                

                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                 textLabel(name: 'Sinalização:', fontWeight: FontWeight.bold,),
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

                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                 textLabel(name: 'Proximidades:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                //  RadioD(number: 6, options: options)
                 CheckC(
                  nomes: [
                    'Restaurante',
                    'Centro de Convenções exposições',
                    'Shopping',
                    'Bar/Lanchconete',
                    'Posto de combustível',
                    'Galeria/rua comercial',
                    'outro'
                  ],
                  // getValue: (newValue) {
                  //   valoresjson['Proximidades'] = newValue;
                  // },
                ),
                 textLabel(name: 'Pontos de referência:', fontWeight: FontWeight.bold,),
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
                    valoresjson['PontosDeReferência'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.1,
                ),

                Container(
                  color:  Color.fromARGB(255, 55, 111, 60),
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
                TableMtur(),
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
                  height: sizeScreen.height * 0.03,
                ),
                 textLabel(name: 'Estrutura de funcionamento:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                 textLabel(name: 'Formas de pagamento:', fontWeight: FontWeight.bold,),

                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                CheckC(nomes: [
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
                 textLabel(name: 'Vendas e Reservas:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                 CheckC(
                  nomes: [
                      'Balcão',
                      'Whatsapp',
                      'Site',
                      'Instagram',
                      'outro'
                    ],
                  ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
          
                 textLabel(name: 'Atendimento ao público:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                 textLabel(name: 'Atendimento em língua estrangeira:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
               CheckC(nomes:
                     ['Não', 'Inglês', 'Espanhol', 'outro'],
                    // getValue: (newValue) {
                    //   valoresjson['LinguaEstrangeira'] = newValue;
                    // }
                    ),

                 textLabel(name: 'Informativos impressos:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                 CheckC(
                nomes: [
                    'Não',
                    'Inglês',
                    'Espanhol',
                    'Português',
                    'outro'
                  ],
                  // getValue: (newValue) {
                  //   valoresjson['InformativosImpressos'] = newValue;
                  // },
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
                 textLabel(name: 'Período:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                 CheckC(
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
                 textLabel(name: 'Horário:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.01,
                ),

TabelaHorarios(),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                 textLabel(name: 'Funcionamento 24 horas:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                ExpansionTileYoN(
                  getValue: (newValue) {
                    valoresjson['Funcionamento24h'] = newValue;
                  },
                ),
                 textLabel(name: 'Funcionamento em feriados:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                ExpansionTileYoN(
                  getValue: (newValue) {
                    valoresjson['FuncionamentoEmFeriados'] = newValue;
                  },
                ),
                 textLabel(name: 'Restrições:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
               CheckC(
                  nomes: ['Crianças', 'Fumantes', 'Animais', 'outro'],
                  //getValue: (newValue) {},
                ),
                 textLabel(name: 'Outras regras e informações:', fontWeight: FontWeight.bold,),

                CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'Outras regras e informações',
                  getValue: (newValue) {
                    valoresjson['OutrasRegraseInformações'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                 textLabel(name: 'Capacidade de atendimento:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                 textLabel(name: 'Capacidade instalada por dia nº:', fontWeight: FontWeight.bold,),

                CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'nº',
                  getValue: (newValue) {
                    valoresjson['CapInstaladaPdia'] = newValue;
                  },
                ),
                 textLabel(name: 'Pessoas atendidas sentadas nº:', fontWeight: FontWeight.bold,),

                CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'nº',
                  getValue: (newValue) {
                    valoresjson['CapSentadas'] = newValue;
                  },
                ),
                 textLabel(name: 'Capacidade simultânea nº:', fontWeight: FontWeight.bold,),

                CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'nº',
                  getValue: (newValue) {
                    valoresjson['CapSimultanea'] = newValue;
                  },
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
                 textLabel(name: 'Instalações:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                 textLabel(name: 'Estacionamento:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
           CheckC(    nomes: [
                      'Pago',
                      'Gratuito',
                      'Coberto',
                      'Descoberto'
                    ],
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
                              validat: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Preencha o campo';
                                }
                                return null;
                              },
                              name: '',
                              getValue: (newValue) {
                                valoresjson['CapacidadeVeículos'] = newValue;
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
                              validat: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Preencha o campo';
                                }
                                return null;
                              },
                              name: '',
                              getValue: (newValue) {
                                valoresjson['Automóveisnº'] = newValue;
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
                              validat: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Preencha o campo';
                                }
                                return null;
                              },
                              name: '',
                              getValue: (newValue) {
                                valoresjson['Ônibus'] = newValue;
                              }))
                    ],
                  ),
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                 textLabel(name: 'Serviços e Equipamentos:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
               CheckC(
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
                 textLabel(name: 'Espeficiação da gastronomia:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                 CheckC(
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
                 textLabel(name: 'Se for Brasileira, por região:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                 CheckC(
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
                 textLabel(name: 'Por especialização:', fontWeight: FontWeight.bold,),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                 CheckC(
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
                  height: sizeScreen.height * 0.03,
                ),
                Container(
                  color:  Color.fromARGB(255, 55, 111, 60),
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
                  
                   textLabel(name: 'Do equipamento/espaço:', fontWeight: FontWeight.bold,),
                  SizedBox(
                    width: sizeScreen.width * 0.04,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: Padding(
                    padding: EdgeInsets.only(top: sizeScreen.height * 0.04),
                    child: ExpansionTileYoN(
                      getValue: (newValue) {
                        valoresjson['DoEquipamento'] = newValue;
                      },
                    ),
                  ))
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),

                TabelaT4(
                  column01:  [
                    Text('Categoria'),
                    Text('Municipal'),
                    Text('Municipal'),
                    Text('Municipal'),
                    Text('Municipal'),
                  ],
                  column02:  [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                     Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                     Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->outros2coluna'] = newValue;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),

              TabelaT4(
                  column01:  [
                    Text('Categoria'),
                    Text('Estadual'),
                    Text('Estadual'),
                    Text('Estadual'),
                    Text('Estadual'),
                  ],
                  column02:  [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                     Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                     Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->outros2coluna'] = newValue;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                       TabelaT4(
                  column01:  [
                    Text('Categoria'),
                    Text('Federal'),
                    Text('Federal'),
                    Text('Federal'),
                    Text('Federal'),
                  ],
                  column02:  [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                     Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                     Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->outros2coluna'] = newValue;
                      },
                    ),
                  ],
                ),
                SizedBox(height: sizeScreen.height * 0.05,),
                           TabelaT4(
                  column01:  [
                    Text('Categoria'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Outras'),
                  ],
                  column02:  [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                    Text(''),
                  ],
                  column03: [
                     Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->outros'] = newValue;
                      },
                    ),
                        TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                     Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->outros2coluna'] = newValue;
                      },
                    ),
                        TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Outras2'] = newValue;
                      },
                    ),
                  ],
                ),
                   
                   SizedBox(height: sizeScreen.height * 0.05,),
                    textLabel(name: 'Da área ou edificação em que está localizado/instalado:', fontWeight: FontWeight.bold,),
                  SizedBox(height: sizeScreen.height * 0.03,),
                  ExpansionTileYoN(getValue: (newValue){
                    valoresjson['DaÁreaOuEdificação'] = newValue;
                  }),
                   SizedBox(height: sizeScreen.height * 0.03,),
                    TabelaT4(
                  column01:  [
                    Text('Categoria'),
                    Text('Municipal'),
                    Text('Municipal'),
                    Text('Municipal'),
                    Text('Municipal'),
                  ],
                  column02:  [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                     Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                     Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->outros2coluna'] = newValue;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),

                       TabelaT4(
                  column01:  [
                    Text('Categoria'),
                    Text('Estadual'),
                    Text('Estadual'),
                    Text('Estadual'),
                    Text('Estadual'),
                  ],
                  column02:  [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                     Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                     Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->outros2coluna'] = newValue;
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                       TabelaT4(
                  column01:  [
                    Text('Categoria'),
                    Text('Federal'),
                    Text('Federal'),
                    Text('Federal'),
                    Text('Federal'),
                  ],
                  column02:  [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                     Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                     Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->outros2coluna'] = newValue;
                      },
                    ),
                  ],
                ),
                SizedBox(height: sizeScreen.height * 0.05,),
                           TabelaT4(
                  column01:  [
                    Text('Categoria'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Outras'),
                  ],
                  column02:  [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                    Text(''),
                  ],
                  column03: [
                     Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->outros'] = newValue;
                      },
                    ),
                        TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                     Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->outros2coluna'] = newValue;
                      },
                    ),
                        TextFormField(
                      decoration:  InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Outras2'] = newValue;
                      },
                    ),
                  ],
                ),
SizedBox(height: sizeScreen.height * 0.05,),
                     Container(
                  color:  Color.fromARGB(255, 55, 111, 60),
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
              RadioD(options:  ['Muito bom', 'Bom', 'Ruim'], getValue: (newValue) {valoresjson['EstadoGeralDeConservação'] = newValue;  },),
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
                  'Acessibilidade',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
               SizedBox(height: sizeScreen.height * 0.02,),
                SizedBox(height: sizeScreen.height * 0.02,),
               textLabel(
                    name:
                        'Possui alguma facilidade para pessoas com deficiência ou mobilidade reduzida?', fontWeight: FontWeight.bold,),
               SizedBox(height: sizeScreen.height * 0.04,),
               ExpansionTileYoN(getValue: (newValue) {valoresjson['PossuiFacilidade'] = newValue;  },),
 SizedBox(height: sizeScreen.height * 0.02,),
               textLabel(
                    name: 'obs: responder às questões seguintes', fontWeight: FontWeight.bold,),
          SizedBox(height: sizeScreen.height * 0.02,),
  textLabel(
                    name: 'Pessoal capacitado para receber PCD:', fontWeight: FontWeight.bold,),
                SizedBox(height: sizeScreen.height * 0.02,),
              CheckC(nomes: [
                'Não',
                'Física',
                'Auditiva',
                'Visual',
                'Mental',
                'Múltipla'
              ], ),
              textLabel(name: 'Rota externa acessível:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Símbolo internacional de acesso:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Local de embarque e desembarque:', fontWeight: FontWeight.bold,),
              ),
                 CheckC(nomes:  ['Não',
                  'Sinalizado',
                   'Com acesso em nível'
                   ],),
              Padding(
                padding: EdgeInsets.only(
                  
                
                    bottom: sizeScreen.height * 0.02),
                child:  textLabel(name: 'Vaga em estacionamento:', fontWeight: FontWeight.bold,),
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
                        'Área de circulação / acesso interno para cadeira de rodas:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Escada:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Rampa:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Piso:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Elevador:', fontWeight: FontWeight.bold,),
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
                        'Equipamento motorizado para deslocamento interno:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Sinalização visual:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Sinalização tátil:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Alarme de emergência:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Comunicação:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Balcão de atendimento:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Mobiliário:', fontWeight: FontWeight.bold,),
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
                child:  textLabel(name: 'Sanitário:, fontWeight: FontWeight.bold,'),
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
                child:  textLabel(name: 'Telefone:', fontWeight: FontWeight.bold,),
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
                        'Sinalização indicativa de atendimento preferencial para pessoas com deficiência ou mobilidade reduzida:', fontWeight: FontWeight.bold,),
              ),

               ExpansionTileYoN(getValue: (newValue ) {
                valoresjson['SinalizaçãoIndicativa'] = newValue;
                 },),
              SizedBox(height: sizeScreen.height * 0.02,),              Row(
                children: [
                 
                   textLabel(name: 'Outros', fontWeight: FontWeight.bold,),
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
             
                SendButton(),
                SizedBox(height: 15,)
              ],
            )),
          ),
        ));
  }
}
