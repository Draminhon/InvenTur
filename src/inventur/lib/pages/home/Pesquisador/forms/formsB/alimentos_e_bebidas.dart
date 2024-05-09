import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';

import '../../widgets/expandedTileYoN.dart';
import 'widgets/tabela.dart';

class AlimentoseBebidas extends StatefulWidget {
  const AlimentoseBebidas({super.key});

  @override
  State<AlimentoseBebidas> createState() => _AlimentoseBebidasState();
}

class _AlimentoseBebidasState extends State<AlimentoseBebidas> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> valoresjson = {
    'uf': dynamic,
    'RG': dynamic,
    'Municipio': dynamic,
    'tipo': dynamic,
    'razãoSocial': dynamic,
    'nomeFantasia': dynamic,
    'CNPJ': dynamic,
    'CódigoCNAE': dynamic,
    'NomeDaRede': dynamic,
    'natureza': dynamic,
    'tipoDeOrganizacao': dynamic,
    'inicioDaAtividade': dynamic,
    'qtdeFuncionariosPermanentes': dynamic,
    'qtdeFuncionariosTemporarios': dynamic,
    'qtdeFuncionariosComDeficiencia': dynamic,
    'localização': dynamic,
    'latitude': dynamic,
    'longitude': dynamic,
    'avenida/rua/etc': dynamic,
    'bairro/localidade': dynamic,
    'distrito': dynamic,
    'CEP': dynamic,
    'TelefonePrincipal': dynamic,
    'TelefoneSecundario': dynamic,
    'Email': dynamic,
    'Site': dynamic,
    'SinalizaçãoDeAcesso': dynamic,
    'SinalizaçãoTurística': dynamic,
    'Proximidades': dynamic,
    'PontosDeReferência': dynamic,
    'FormaPagamento': dynamic,
    'VendaseReservas': dynamic,
    'LinguaEstrangeira': dynamic,
    'InformativosImpressos': dynamic,
    'PeriodoFuncionamento': dynamic,
    'Funcionamento24h': dynamic,
    'FuncionamentoEmFeriados': dynamic,
    'Restrições': dynamic,
    'OutrasRegraseInformações': dynamic,
    'CapInstaladaPdia': dynamic,
    'CapSentadas': dynamic,
    'CapSimultanea': dynamic,

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
            child: SingleChildScrollView(
              child: 
              Column(
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
                RadioD(
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
                        color: Colors.white, fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
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
                CustomTextField(
                    name: 'Código CNAE',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['CódigoCNAE'] = newValue;
                    }),
                CustomTextField(
                    name: 'Nome da rede/holding',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['NomeDaRede'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Column(
                  children: [
                    textLabel(name: 'natureza'),
                    SizedBox(
                      height: sizeScreen.height * 0.03,
                    ),
                    RadioD(
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
                    textLabel(name: 'tipo de organização/instituição'),
                    SizedBox(
                      height: sizeScreen.height * 0.03,
                    ),
                    RadioD(
                        options: const [
                          'associação',
                          'sindicato',
                          'cooperativa',
                          'sistema S',
                          'empresa',
                          'outro'
                        ],
                        getValue: (newValue) {
                          valoresjson['tipoDeOrganizacao'] = newValue;
                        })
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
                    const textLabel(name: 'início da atividade:'),
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
                const textLabel(name: 'Quantidade de Funcionários'),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Column(children: [
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
                const textLabel(name: 'localização:'),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                RadioD(
                  options: const ['urbana', 'rural'],
                  getValue: (newValue) {
                    valoresjson['localização'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
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
                const textLabel(name: 'endereço:'),
                CustomTextField(
                  validat: (value) {
                    return null;
                  },
                  name: 'avenida/rua/travessa/caminho/outro',
                  getValue: (newValue) {valoresjson['avenida/rua/etc'] = newValue;},
                ),
                CustomTextField(
                  validat: (value) {
                    return null;
                  },
                  name: 'bairro/localidade',
                  getValue: (newValue) {valoresjson['bairro/localidade'] = newValue;},
                ),
                CustomTextField(
                  validat: (value) {
                    return null;
                  },
                  name: 'distrito',
                  getValue: (newValue) {valoresjson['distrito'] = newValue;},
                ),
                CustomTextField(
                  validat: (value) {
                    return null;
                  },
                  name: 'CEP',
                 getValue: (newValue) {valoresjson['CEP'] = newValue;},
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
                          child: CustomTextNumber(
                         
                            labelText: '(DD) n°', getValue: (newValue) {valoresjson['TelefonePrincipal'] = newValue;  },
                          ))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: sizeScreen.width * 0.09),
                      child: SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextNumber(
                        
                              labelText: 'Telefone secundário', getValue: (newValue) { valoresjson['TelefoneSecundario'] = newValue; },))),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),]),
        
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
                            name: 'e-mail', getValue: (newValue ) { valoresjson['Email'] = newValue; },
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
                            name: 'www.endereço.com', getValue: (newvalue) {valoresjson['Site'] = newvalue;  },
                          ))
                    ],
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
                      child: ExpansionTileYoN(getValue: (newValue) { valoresjson['SinalizaçãoDeAcesso'] = newValue; },))
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
                      child: ExpansionTileYoN(getValue: (newValue) { valoresjson['SinalizaçãoTurística'] = newValue; },))
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
        
         SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                const textLabel(name: 'proximidades:'),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                //  RadioD(number: 6, options: options)
               RadioD(options: const [
                  'Restaurante',
                  'Centro de Convenções exposições',
                  'Shopping',
                  'Bar/Lanchconete',
                  'Posto de combustível',
                  'Galeria/rua comercial',
                  'outro'
                ], getValue: (newValue) { valoresjson['Proximidades'] = newValue; },),
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
                    name: 'ponto de referência', getValue: (newValue) {valoresjson['PontosDeReferência'] = newValue;  },),
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
                SizedBox(height: sizeScreen.height * 0.03,),
                textLabel(name: 'ESTRUTURA DE FUNCIONAMENTO'),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                   const textLabel(name: 'Formas de pagamento'),

              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
               RadioD( options: const [
                'Dinheiro',
                'Cheque',
                'Cheque de outra praça',
                'Cartão de Crédito',
                'Cartão de Débito'
              ], getValue: (newValue) { valoresjson['FormaPagamento'] = newValue; },),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
                textLabel(name: 'Vendas e Reservas'),
  SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioC(number: 5, options: ['Balcão', 'Telefone', 'Fax', 'Internet', 'outro'], getValue: (newValue) {valoresjson['VendaseReservas'] = newValue;}),
  SizedBox(
                height: sizeScreen.height * 0.02,
              ),
Divider(),
textLabel(name: 'ATENDIMENTO AO PÚBLICO'),
  SizedBox(
                height: sizeScreen.height * 0.02,
              ),
textLabel(name: 'Atendimento em língua estrangeira'),
  SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioD(options: ['Não', 'Inglês', 'Espanhol', 'outro'], getValue: (newValue){valoresjson['LinguaEstrangeira'] = newValue;}),

       const textLabel(name: 'Informativos impressos'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
               RadioD(
                  options: ['Não', 'Inglês', 'Espanhol', 'Português', 'outro'], getValue: (newValue) {  valoresjson['InformativosImpressos'] = newValue;},),
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
              ], getValue: (newValue ) {valoresjson['PeriodoFuncionamento'] = newValue; },),
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
              ExpansionTileYoN(getValue: (newValue) { valoresjson['Funcionamento24h'] = newValue;},),
              const textLabel(name: 'Funcionamento em feriados'),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              ExpansionTileYoN(getValue: (newValue) { valoresjson['FuncionamentoEmFeriados'] = newValue;},),
              const textLabel(name: 'Restrições'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
               RadioD(
                  options: ['Crianças', 'Fumantes', 'Animais', 'outro'], getValue: (newValue) {  },),
              const textLabel(name: 'Outras regras e informações'),

              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'Outras regras e informações', getValue: (newValue ) {valoresjson['OutrasRegraseInformações'] = newValue; },),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(name: 'CAPACIDADE DE ATENDIMENTO'), 
                 SizedBox(
                height: sizeScreen.height * 0.02,
              ),
               const textLabel(name: 'Capacidade instalada por dia nº'),

              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'nº', getValue: (newValue ) { valoresjson['CapInstaladaPdia'] = newValue; },),
                   const textLabel(name: 'Pessoas atendidas sentadas nº'),

              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'nº', getValue: (newValue ) { valoresjson['CapSentadas'] = newValue; },),
                   const textLabel(name: 'Capacidade simultânea nº'),

              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: 'nº', getValue: (newValue ) { valoresjson['CapSimultanea'] = newValue; },),
SizedBox(height: sizeScreen.height * 0.05,),

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
            
                ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.save();
                      valoresjson.forEach((key, value) {
                        print('$key, $value');
                      });
                    },
                    child: const Icon(Icons.arrow_forward))
              ],
            )),
            ),
      ));
  }
}
