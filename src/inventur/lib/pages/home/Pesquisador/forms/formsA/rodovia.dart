import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';

import '../../widgets/customTextField.dart';
import '../../widgets/expandedTileYoN.dart';
import '../../widgets/radioButton.dart';
import '../formsB/widgets/sendButton.dart';

class Rodovia extends StatefulWidget {
  const Rodovia({super.key});

  @override
  State<Rodovia> createState() => _RodoviaState();
}

class _RodoviaState extends State<Rodovia> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> valoresjson = {
    'uf': null,
    'RG': null,
    'Municipio': null,
    'Tipo': null,
    'Subtipos': null,
    'NomeOficial': null,
    'NomePopular': null,
    'Jurisdição': null,
    'Natureza': null,
    'TipoDeOrganização': null,
    'Extensão': null,
    'FaixasDeRolamento': null,
    'Pavimentação': null,
    'Pedágio': null,
    'MunicipiosVizinhos': null,
    'inicioDaAtividade': null,
    'Email': null,
    'Site': null,
    'SinalizaçãoDeAcesso': null,
    'SinalizaçãoTuristica': null,
    'PostoDeCombustível': null,
    'OutrosServiços': null,
    'EstruturasAoLongoDaVia': null,
    'Poluição': null,
    'PoluiçãoEspecificação': null,
    'Lixo': null,
    'LixoEspecificação': null,
    'Desmatamento': null,
    'DesmatamentoEspecificação': null,
    'Queimadas': null,
    'QueimadasEspecificação': null,
    'Insegurança': null,
    'InsegurançaEspecificação': null,
    'Extrativismo': null,
    'ExtrativismoEspecificação': null,
    'Prostituição': null,
    'ProstituiçãoEspecificação': null,
    'OcupaçõesIrregulares/invasão': null,
    'OcupaçõesIrregulares/invasãoEspecificação': null,
    'Outras': null,
    'OutrasEspecificação': null,
    'EstadoGeral': null,
    'Observações': null,
    'Referências': null,
    'Pesquisador': null,
    'TelefonePesquisador': null,
    'E-mailPesquisador': null,
    'Coordenador': null,
    'TelefoneCoordenador': null,
    'E-mailCoordenador': null,
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
              options: const ['Rodoviário'],
              getValue: (newValue) {
                valoresjson['Tipo'] = newValue;
              },
            ),
            const textLabel(name: 'Subtipos'),
            RadioD(
                options: const ['Estação rodoviária'],
                getValue: (newValue) {
                  valoresjson['Subtipos'] = newValue;
                }),
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
                name: 'Nome Oficial',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['NomeOficial'] = newValue;
                }),
            CustomTextField(
                name: 'Nome Popular',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['NomePopular'] = newValue;
                }),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Jurisdição'),
            RadioD(
                options: ['Federal', 'Estadual', 'Municipal'],
                getValue: (newValue) {
                  valoresjson['Jurisdição'] = newValue;
                }),
            const textLabel(name: 'Natureza'),
            RadioD(
                options: const ['Pública', 'Privada', 'outro'],
                getValue: (newValue) {
                  valoresjson['Natureza'] = newValue;
                }),
            const textLabel(name: 'Tipo de organização/Instituição'),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            RadioD(
                options: const [
                  'Associação',
                  'Sindicato',
                  'Cooperativa',
                  'Sistema',
                  'Empresa',
                  'outro'
                ],
                getValue: (newValue) {
                  valoresjson['TipoDeOrganização'] = newValue;
                }),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Extensão da rodovia no âmbito do município'),
            CustomTextField(
                name: 'Extensão',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['Extensão'] = newValue;
                }),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Faixas de rolamento'),
            RadioD(
                options: [
                  'Duas',
                  'Três',
                  'Quatro',
                  'Mão única',
                  'Mão dupla',
                  'Acostamento'
                ],
                getValue: (newValue) {
                  valoresjson['FaixasDeRolamento'] = newValue;
                }),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Pavimentação'),
            RadioD(
                options: [
                  'Asfalto',
                  'Concreto',
                  'Paralelepipedo',
                  'Saibro',
                  'Asfalto ecológico',
                  'Chão batido',
                  'outro'
                ],
                getValue: (newValue) {
                  valoresjson['Pavimentação'] = newValue;
                }),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Pedágio'),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            ExpansionTileYoN(getValue: (newValue) {
              valoresjson['Pedágio'] = newValue;
            }),
            textLabel(name: 'Municípios vizinhos interligados por rodovia'),
            CustomTextField(
                name: 'Municípios vizinhos',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['MunicipiosVizinhos'] = newValue;
                }),
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
            SizedBox(
              height: sizeScreen.height * 0.02,
            ),
            SizedBox(
              height: sizeScreen.height * 0.02,
            ),
            textLabel(name: 'Entidade mantedora:'),
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
                const textLabel(name: '  Sítio eletrônico\n(site/página web)'),
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
                  valoresjson['SinalizaçãoTuristica'] = newValue;
                },
              ))
            ]),
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
                'Características',
                style: TextStyle(
                    color: Colors.white, fontSize: sizeScreen.height * 0.03),
              ),
            ),
            SizedBox(
              height: sizeScreen.height * 0.02,
            ),
            textLabel(name: 'Equipamentos e serviçõs ao longo da rodovia'),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Posto de combustível'),
            RadioD(
                options: [
                  'Álcool',
                  'Gasolina',
                  'Diesel',
                  'Gás natural veicular'
                ],
                getValue: (newValue) {
                  valoresjson['PostoDeCombustível'] = newValue;
                }),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Outros serviços'),
            RadioD(
                options: [
                  'Alimentação',
                  'Hospedagem',
                  'Posto de informação',
                  'Polícia rodoviária',
                  'Polícia militar',
                  'Telefone público',
                  'Serviços mecânicos',
                  'Socorro mecânico',
                  'Socorro médico',
                  'Loja de souvenir',
                  'Produtos típicos',
                  'Supermercado',
                  'outro'
                ],
                getValue: (newValue) {
                  valoresjson['OutrosServiços'] = newValue;
                }),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Estruturas ao longo da via'),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            RadioD(
                options: [
                  'Ponte',
                  'Passarela',
                  'Viaduto',
                  'Galeria/túnel',
                  'Atrativo turístico natural',
                  'outro'
                ],
                getValue: (newValue) {
                  valoresjson['EstruturasAoLongoDaVia'] = newValue;
                }),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Questões ambientais/sociais'),
            SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Poluição'),
            SizedBox(height: sizeScreen.height * 0.03,),
            ExpansionTileYoN(getValue: (newValue) {
              valoresjson['Poluição'] = newValue;
            }),
            CustomTextField(
                name: 'Especificação',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['PoluiçãoEspecificação'] = newValue;
                }),
                SizedBox(height: sizeScreen.height * 0.03,),

                 SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Lixo'),
            SizedBox(height: sizeScreen.height * 0.03,),
            ExpansionTileYoN(getValue: (newValue) {
              valoresjson['Lixo'] = newValue;
            }),
            CustomTextField(
                name: 'Especificação',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['LixoEspecificação'] = newValue;
                }),
                SizedBox(height: sizeScreen.height * 0.03,),
                 SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Desmatamento'),
            SizedBox(height: sizeScreen.height * 0.03,),
            ExpansionTileYoN(getValue: (newValue) {
              valoresjson['Desmatamento'] = newValue;
            }),
            CustomTextField(
                name: 'Especificação',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['DesmatamentoEspecificação'] = newValue;
                }),
                SizedBox(height: sizeScreen.height * 0.03,),
                 SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Queimadas'),
            SizedBox(height: sizeScreen.height * 0.03,),
            ExpansionTileYoN(getValue: (newValue) {
              valoresjson['Queimadas'] = newValue;
            }),
            CustomTextField(
                name: 'Especificação',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['QueimadasEspecificação'] = newValue;
                }),
                SizedBox(height: sizeScreen.height * 0.03,),
                 SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Insegurança'),
            SizedBox(height: sizeScreen.height * 0.03,),
            ExpansionTileYoN(getValue: (newValue) {
              valoresjson['Insegurança'] = newValue;
            }),
            CustomTextField(
                name: 'Especificação',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['InsegurançaEspecificação'] = newValue;
                }),
                SizedBox(height: sizeScreen.height * 0.03,),
                 SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Extrativismo'),
            SizedBox(height: sizeScreen.height * 0.03,),
            ExpansionTileYoN(getValue: (newValue) {
              valoresjson['Extrativismo'] = newValue;
            }),
            CustomTextField(
                name: 'Especificação',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['ExtrativismoEspecificação'] = newValue;
                }),
                SizedBox(height: sizeScreen.height * 0.03,),
                 SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Prostituição'),
            SizedBox(height: sizeScreen.height * 0.03,),
            ExpansionTileYoN(getValue: (newValue) {
              valoresjson['Prostituição'] = newValue;
            }),
            CustomTextField(
                name: 'Especificação',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['ProstituiçãoEspecificação'] = newValue;
                }),
                SizedBox(height: sizeScreen.height * 0.03,),
                 SizedBox(
              height: sizeScreen.height * 0.03,
            ),
            textLabel(name: 'Ocupações irregulares/invasão'),
            SizedBox(height: sizeScreen.height * 0.03,),
            ExpansionTileYoN(getValue: (newValue) {
              valoresjson['OcupaçõesIrregulares/invasão'] = newValue;
            }),
            CustomTextField(
                name: 'Especificação',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['OcupaçõesIrregulares/invasãoEspecificação'] = newValue;
                }),
                SizedBox(height: sizeScreen.height * 0.03,),

                   textLabel(name: 'Outras'),
            SizedBox(height: sizeScreen.height * 0.03,),
            ExpansionTileYoN(getValue: (newValue) {
              valoresjson['Outras'] = newValue;
            }),
            CustomTextField(
                name: 'Especificação',
                validat: (value) {
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['OutrasEspecificação'] = newValue;
                }),
                SizedBox(height: sizeScreen.height * 0.03,),
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
                   SizedBox(height: sizeScreen.height * 0.03,),
                   RadioD(options: ['Muito bom', 'Bom', 'Ruim'], getValue: (newValue){
                    valoresjson['EstadoGeral'] = newValue;
                   }),
                   SizedBox(height: sizeScreen.height * 0.03,),
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
                  name: '', getValue: (newValue) {valoresjson['Observações'] = newValue;  },),
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
                  name: '', getValue: (newValue) {  valoresjson['Referências'] = newValue;},),
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
                  name: '', getValue: (newValue) {valoresjson['Pesquisador'] = newValue;  },),
              const textLabel(name: 'Telefone'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (newValue) {valoresjson['TelefonePesquisador'] = newValue;  },),
              const textLabel(name: 'E-mail'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (newValue) {valoresjson['E-mailPesquisador'] = valoresjson; },),
              const textLabel(
                  name: 'Responsável pelo atendimento (Coordenador)'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (newValue) {valoresjson['Coordenador'] = newValue;  },),
              const textLabel(name: 'Telefone'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (newValue) {valoresjson['TelefoneCoordenador'] = newValue;  },),
              const textLabel(name: 'E-mail'),
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
               SendButton(),
               SizedBox(height: 15,)
          ],
        )),
      ),
    );
  }
}
