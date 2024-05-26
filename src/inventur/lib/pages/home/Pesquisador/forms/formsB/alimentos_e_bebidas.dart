import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';

import '../../widgets/expandedTileYoN.dart';
import 'widgets/sendButton.dart';
import 'widgets/tabela.dart';

class AlimentoseBebidas extends StatefulWidget {
  const AlimentoseBebidas({super.key});

  @override
  State<AlimentoseBebidas> createState() => _AlimentoseBebidasState();
}

class _AlimentoseBebidasState extends State<AlimentoseBebidas> {
  final Map<String, dynamic> valoresjson = {
    'uf': null,
    'RG': null,
    'Municipio': null,
    'tipo': null,
    'razãoSocial': null,
    'nomeFantasia': null,
    'CNPJ': null,
    'CódigoCNAE': null,
    'NomeDaRede': null,
    'natureza': null,
    'tipoDeOrganizacao': null,
    'inicioDaAtividade': null,
    'qtdeFuncionariosPermanentes': null,
    'qtdeFuncionariosTemporarios': null,
    'qtdeFuncionariosComDeficiencia': null,
    'localização': null,
    'latitude': null,
    'longitude': null,
    'avenida/rua/etc': null,
    'bairro/localidade': null,
    'distrito': null,
    'CEP': null,
    'TelefonePrincipal': null,
    'TelefoneSecundario': null,
    'Email': null,
    'Site': null,
    'SinalizaçãoDeAcesso': null,
    'SinalizaçãoTurística': null,
    'Proximidades': null,
    'PontosDeReferência': null,
    'AssociaçõesDeTurismos': null,
    'AssociaçõesComerciais': null,
    'GuiasTurísticos': null,
    'Outros': null,
    'FormaPagamento': null,
    'VendaseReservas': null,
    'LinguaEstrangeira': null,
    'InformativosImpressos': null,
    'PeriodoFuncionamento': null,
    'Segunda-Feira_abertura': null,
    'Terça-Feira_abertura': null,
    'Quarta-Feira_abertura': null,
    'Quinta-Feira_abertura': null,
    'Sexta-Feira_abertura': null,
    'Sabado_abertura': null,
    'Domingo_abertura': null,
    'Segunda-Feira_encerramento': null,
    'Terça-Feira_encerramento': null,
    'Quarta-Feira_encerramento': null,
    'Quinta-Feira_encerramento': null,
    'Sexta-Feira_encerramento': null,
    'Sabado_encerramento': null,
    'Domingo_encerramento': null,
    'Funcionamento24h': null,
    'FuncionamentoEmFeriados': null,
    'Restrições': null,
    'OutrasRegraseInformações': null,
    'CapInstaladaPdia': null,
    'CapSentadas': null,
    'CapSimultanea': null,
    'Estacionamento': null,
    'CapacidadeVeículos': null,
    'Automóveisnº': null,
    'Ônibus': null,
    'ServiçoseEquipamentos': null,
    'EspecificaçãoDaGastronomia': null,
    'SeForBrasileira': null,
    'PorEspecialização': null,
    'DoEquipamento': null,
    'TabelaCategMunicipal': <String, dynamic>{
      'Municipal->Lei/decreto': null,
      'Municipal->Portaria/instrução': null,
      'Municipal->Norma/ato': null,
      'Municipal->outros': null,
      'Municipal->Lei/decreto2coluna': null,
      'Municipal->Portaria/instrução2coluna': null,
      'Municipal->Norma/ato2coluna': null,
      'Municipal->outros2coluna': null,
    },
    'TabelaCategEstadual': <String, dynamic>{
      'Estadual->Lei/decreto': null,
      'Estadual->Portaria/instrução': null,
      'Estadual->Norma/ato': null,
      'Estadual->outros': null,
      'Estadual->Lei/decreto2coluna': null,
      'Estadual->Portaria/instrução2coluna': null,
      'Estadual->Norma/ato2coluna': null,
      'Estadual->outros2coluna': null,
    },
    'TabelaCategFederal': <String, dynamic>{
      'Federal->Lei/decreto': null,
      'Federal->Portaria/instrução': null,
      'Federal->Norma/ato': null,
      'Federal->outros': null,
      'Federal->Lei/decreto2coluna': null,
      'Federal->Portaria/instrução2coluna': null,
      'Federal->Norma/ato2coluna': null,
      'Federal->outros2coluna': null,
    },
    'TabelaCategInternacional': <String, dynamic>{
      'Internacional->Lei/decreto': null,
      'Internacional->Portaria/instrução': null,
      'Internacional->Norma/ato': null,
      'Internacional->outros': null,
      'Internacional->Lei/decreto2coluna': null,
      'Internacional->Portaria/instrução2coluna': null,
      'Internacional->Norma/ato2coluna': null,
      'Internacional->outros2coluna': null,
      'Outras': null,
      'Outras2': null,
    },
    'DaÁreaOuEdificação': null,
     'TabelaCategMunicipal2': <String, dynamic>{
      'Municipal->Lei/decreto': null,
      'Municipal->Portaria/instrução': null,
      'Municipal->Norma/ato': null,
      'Municipal->outros': null,
      'Municipal->Lei/decreto2coluna': null,
      'Municipal->Portaria/instrução2coluna': null,
      'Municipal->Norma/ato2coluna': null,
      'Municipal->outros2coluna': null,
    },
    'TabelaCategEstadual2': <String, dynamic>{
      'Estadual->Lei/decreto': null,
      'Estadual->Portaria/instrução': null,
      'Estadual->Norma/ato': null,
      'Estadual->outros': null,
      'Estadual->Lei/decreto2coluna': null,
      'Estadual->Portaria/instrução2coluna': null,
      'Estadual->Norma/ato2coluna': null,
      'Estadual->outros2coluna': null,
    },
    'TabelaCategFederal2': <String, dynamic>{
      'Federal->Lei/decreto': null,
      'Federal->Portaria/instrução': null,
      'Federal->Norma/ato': null,
      'Federal->outros': null,
      'Federal->Lei/decreto2coluna': null,
      'Federal->Portaria/instrução2coluna': null,
      'Federal->Norma/ato2coluna': null,
      'Federal->outros2coluna': null,
    },
    'TabelaCategInternacional2': <String, dynamic>{
      'Internacional->Lei/decreto': null,
      'Internacional->Portaria/instrução': null,
      'Internacional->Norma/ato': null,
      'Internacional->outros': null,
      'Internacional->Lei/decreto2coluna': null,
      'Internacional->Portaria/instrução2coluna': null,
      'Internacional->Norma/ato2coluna': null,
      'Internacional->outros2coluna': null,
      'Outras': null,
      'Outras2': null,
    },
    'EstadoGeralDeConservação': null,
    'PossuiFacilidade': null,
    'PessoalCapacitadoParaReceberPCD': null,
    'RotaExternaAcessível': null,
    'SimboloInternacionalDeAcesso': null,
    'LocalDeEmbarqueEDesembarque': null,
    'VagaEmEstacionamento': null,
    'ÁreaDeCirculação': null,
    'Escada': null,
    'Rampa': null,
    'Piso': null,
    'Elevador': null,
    'EquipamentoMotorizado': null,
    'SinalizaçãoVisual': null,
    'SinalizaçãoTátil': null,
    'AlarmeDeEmemergência': null,
    'Comunicação': null,
    'BalcãoDeAtendimento': null,
    'Mobiliário': null,
    'Sanitário': null,
    'Telefone': null,
    'SinalizaçãoIndicativa': null,
    'OutrosAcessibilidade': null,
    'Observações': null,
    'Referências': null,
    'Pesquisador': null,
    'TelefonePesquisador': null,
    'E-mail': null,
    'Coordenador': null,
    'TelefoneCoordenador': null,
    'E-mailCoordenador': null,


  };

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
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
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
                    const textLabel(name: 'natureza'),
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
                    const textLabel(name: 'tipo de organização/instituição'),
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
                            labelText: '(DD) n°',
                            getValue: (newValue) {
                              valoresjson['TelefonePrincipal'] = newValue;
                            },
                          ))
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: sizeScreen.width * 0.09),
                      child: SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextNumber(
                            labelText: 'Telefone secundário',
                            getValue: (newValue) {
                              valoresjson['TelefoneSecundario'] = newValue;
                            },
                          ))),
                  SizedBox(
                    height: sizeScreen.height * 0.03,
                  ),
                ]),

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
                RadioD(
                  options: const [
                    'Restaurante',
                    'Centro de Convenções exposições',
                    'Shopping',
                    'Bar/Lanchconete',
                    'Posto de combustível',
                    'Galeria/rua comercial',
                    'outro'
                  ],
                  getValue: (newValue) {
                    valoresjson['Proximidades'] = newValue;
                  },
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
                    valoresjson['PontosDeReferência'] = newValue;
                  },
                ),
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
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                TabelaT1(column01: const [
                  Text('Entidade/guia turístico'),
                  Text(
                    'Associações e sindicatos do setor de hospedagem',
                  ),
                  Text('Associações de turismos'),
                  Text('Associações comerciais'),
                  Text('Guias Turísticos'),
                  Text('Outros'),
                ], column02: [
                  const Text('Categoria/tipo/classificação/número'),
                  const Text('CADASTUR outros'),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: '', border: InputBorder.none),
                    onSaved: (newValue) {
                      valoresjson['AssociaçõesDeTurismos'] = newValue;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: '', border: InputBorder.none),
                    onSaved: (newValue) {
                      valoresjson['AssociaçõesComerciais'] = newValue;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: '', border: InputBorder.none),
                    onSaved: (newValue) {
                      valoresjson['GuiasTurísticos'] = newValue;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: '', border: InputBorder.none),
                    onSaved: (newValue) {
                      valoresjson['Outros'] = newValue;
                    },
                  ),
                  const TextField(
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
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'ESTRUTURA DE FUNCIONAMENTO'),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                const textLabel(name: 'Formas de pagamento'),

                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                RadioD(
                  options: const [
                    'Dinheiro',
                    'Cheque',
                    'Cheque de outra praça',
                    'Cartão de Crédito',
                    'Cartão de Débito'
                  ],
                  getValue: (newValue) {
                    valoresjson['FormaPagamento'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                const textLabel(name: 'Vendas e Reservas'),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                RadioC(
                    number: 5,
                    options: const [
                      'Balcão',
                      'Telefone',
                      'Fax',
                      'Internet',
                      'outro'
                    ],
                    getValue: (newValue) {
                      valoresjson['VendaseReservas'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                const Divider(),
                const textLabel(name: 'ATENDIMENTO AO PÚBLICO'),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                const textLabel(name: 'Atendimento em língua estrangeira'),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                RadioD(
                    options: const ['Não', 'Inglês', 'Espanhol', 'outro'],
                    getValue: (newValue) {
                      valoresjson['LinguaEstrangeira'] = newValue;
                    }),

                const textLabel(name: 'Informativos impressos'),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                RadioD(
                  options: const [
                    'Não',
                    'Inglês',
                    'Espanhol',
                    'Português',
                    'outro'
                  ],
                  getValue: (newValue) {
                    valoresjson['InformativosImpressos'] = newValue;
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
                    valoresjson['PeriodoFuncionamento'] = newValue;
                  },
                ),
                const textLabel(name: 'Horário'),
                SizedBox(
                  height: sizeScreen.height * 0.01,
                ),

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
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Segunda-Feira_abertura'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Terça-Feira_abertura'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Quarta-Feira_abertura'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Quinta-Feira_abertura'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Sexta-Feira_abertura'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Sabado_abertura'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Domingo_abertura'] = newValue;
                        },
                      )
                    ]),
                    TableRow(children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Segunda-Feira_encerramento'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Terça-Feira_encerramento'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Quarta-Feira_encerramento'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Quinta-Feira_encerramento'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Sexta-Feira_encerramento'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Sabado_encerramento'] = newValue;
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: '',
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true),
                        onSaved: (newValue) {
                          valoresjson['Domingo_encerramento'] = newValue;
                        },
                      )
                    ]),
                  ],
                ),

                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                const textLabel(name: 'Funcionamento 24 horas'),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                ExpansionTileYoN(
                  getValue: (newValue) {
                    valoresjson['Funcionamento24h'] = newValue;
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
                RadioD(
                  options: const ['Crianças', 'Fumantes', 'Animais', 'outro'],
                  getValue: (newValue) {},
                ),
                const textLabel(name: 'Outras regras e informações'),

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
                const textLabel(name: 'CAPACIDADE DE ATENDIMENTO'),
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
                  name: 'nº',
                  getValue: (newValue) {
                    valoresjson['CapInstaladaPdia'] = newValue;
                  },
                ),
                const textLabel(name: 'Pessoas atendidas sentadas nº'),

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
                const textLabel(name: 'Capacidade simultânea nº'),

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
                const textLabel(name: 'INSTALAÇÕES'),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'Estacionamento'),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                RadioD(
                    options: const [
                      'Pago',
                      'Gratuito',
                      'Coberto',
                      'Descoberto'
                    ],
                    getValue: (newValue) {
                      valoresjson['Estacionamento'] = newValue;
                    }),

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
                                valoresjson['CapacidadeVeículos'] = newValue;
                              }))
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
                                valoresjson['Automóveisnº'] = newValue;
                              }))
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
                              }))
                    ],
                  ),
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'Serviços e Equipamentos'),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                RadioD(
                    options: const [
                      'Música ao vivo',
                      'Atendimento a grupos',
                      'Ventilador',
                      'Adega',
                      'Recreação para crianças',
                      'Cardápio em língua estrangeira',
                      'Música ambiente',
                      'Manobrista',
                      'Calefação',
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
                    getValue: (newValue) {
                      valoresjson['ServiçoseEquipamentos'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'Espeficiação da gastronomia'),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                RadioD(
                    options: const [
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
                    getValue: (newValue) {
                      valoresjson['EspecificaçãoDaGastronomia'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'Se for Brasileira, por região'),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                RadioD(
                    options: const [
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
                    getValue: (newValue) {
                      valoresjson['SeForBrasileira'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'Por especialização'),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                RadioD(
                    options: const [
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
                    getValue: (newValue) {
                      valoresjson['PorEspecialização'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
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
                  SizedBox(
                    width: sizeScreen.width * 0.05,
                  ),
                  const textLabel(name: 'Do equipamento/espaço:'),
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
                  column01: const [
                    Text('Categoria'),
                    Text('Municipal'),
                    Text('Municipal'),
                    Text('Municipal'),
                    Text('Municipal'),
                  ],
                  column02: const [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                    const Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                    const Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal']
                            ['Municipal->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
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
                  column01: const [
                    Text('Categoria'),
                    Text('Estadual'),
                    Text('Estadual'),
                    Text('Estadual'),
                    Text('Estadual'),
                  ],
                  column02: const [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                    const Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                    const Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual']
                            ['Estadual->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
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
                  column01: const [
                    Text('Categoria'),
                    Text('Federal'),
                    Text('Federal'),
                    Text('Federal'),
                    Text('Federal'),
                  ],
                  column02: const [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                    const Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                    const Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal']
                            ['Federal->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
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
                  column01: const [
                    Text('Categoria'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Outras'),
                  ],
                  column02: const [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                    Text(''),
                  ],
                  column03: [
                    const Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->outros'] = newValue;
                      },
                    ),
                        TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                    const Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Internacional->outros2coluna'] = newValue;
                      },
                    ),
                        TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional']
                            ['Outras2'] = newValue;
                      },
                    ),
                  ],
                ),
                   
                   SizedBox(height: sizeScreen.height * 0.05,),
                   textLabel(name: 'Da área ou edificação em que está localizado/instalado'),
                  SizedBox(height: sizeScreen.height * 0.03,),
                  ExpansionTileYoN(getValue: (newValue){
                    valoresjson['DaÁreaOuEdificação'] = newValue;
                  }),
                    TabelaT4(
                  column01: const [
                    Text('Categoria'),
                    Text('Municipal'),
                    Text('Municipal'),
                    Text('Municipal'),
                    Text('Municipal'),
                  ],
                  column02: const [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                    const Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                    const Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategMunicipal2']
                            ['Municipal->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
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
                  column01: const [
                    Text('Categoria'),
                    Text('Estadual'),
                    Text('Estadual'),
                    Text('Estadual'),
                    Text('Estadual'),
                  ],
                  column02: const [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                    const Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                    const Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategEstadual2']
                            ['Estadual->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
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
                  column01: const [
                    Text('Categoria'),
                    Text('Federal'),
                    Text('Federal'),
                    Text('Federal'),
                    Text('Federal'),
                  ],
                  column02: const [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                  ],
                  column03: [
                    const Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                    const Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategFederal2']
                            ['Federal->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
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
                  column01: const [
                    Text('Categoria'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Internacional'),
                    Text('Outras'),
                  ],
                  column02: const [
                    Text('instrumento (nª)'),
                    Text('Lei/decreto'),
                    Text('Portaria/instrução/deliberação'),
                    Text('Norma/ato'),
                    Text('Outros'),
                    Text(''),
                  ],
                  column03: [
                    const Text('Nome/titulo/certificação/licenciamento/outro'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Lei/decreto'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Portaria/instrução'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Norma/ato'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->outros'] = newValue;
                      },
                    ),
                        TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['outros'] = newValue;
                      },
                    ),
                  ],
                  column04: [
                    const Text('Entidade declaratória/tipo de declaração'),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Lei/decreto2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Portaria/instrução2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->Norma/ato2coluna'] = newValue;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: '', border: InputBorder.none),
                      onSaved: (newValue) {
                        valoresjson['TabelaCategInternacional2']
                            ['Internacional->outros2coluna'] = newValue;
                      },
                    ),
                        TextFormField(
                      decoration: const InputDecoration(
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
              RadioD(options: ['Muito bom', 'Bom', 'Ruim'], getValue: (newValue) {valoresjson['EstadoGeralDeConservação'] = newValue;  },),
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
                SizedBox(height: sizeScreen.height * 0.02,),
              const textLabel(
                    name:
                        'Possui alguma facilidade\npara pessoas com\ndeficiência ou mobilidade\nreduzida?'),
               SizedBox(height: sizeScreen.height * 0.04,),
               ExpansionTileYoN(getValue: (newValue) {valoresjson['PossuiFacilidade'] = newValue;  },),
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
              ], getValue: (newValue) { valoresjson['PessoalCapacitadoParaReceberPCD'] = newValue; },),
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
              ], getValue: (newValue ) {valoresjson['RotaExternaAcessível'] = newValue;  },),
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
              ], getValue: (newValue) {valoresjson['SimboloInternacionalDeAcesso'] = newValue;  },),
              Padding(
                padding: EdgeInsets.only(
                   
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Local de embarque e desembarque'),
              ),
              RadioD(
                  options: ['Não', 'Sinalizado', 'Com acesso em nível'], getValue: (newValue) { valoresjson['LocalDeEmbarqueEDesembarque'] = newValue; },),
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
              ], getValue: (newValue) {valoresjson['VagaEmEstacionamento'] = newValue;  },),
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
              ], getValue: (newValue ) {valoresjson['ÁreaDeCirculação'] = newValue;  },),
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
              ], getValue: (newValue ) {valoresjson['Escada'] = newValue;  },),

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
              ], getValue: (newValue ) {valoresjson['Rampa'] = newValue;  },),
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
              ], getValue: (newValue ) {valoresjson['Piso'] = newValue;  },),
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
              ], getValue: (newValue) {valoresjson['Elevador'] = newValue; },),
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
              ], getValue: (newValue ) {valoresjson['EquipamentoMotorizado'] = newValue;  },),
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
              ], getValue: (newValue ) {valoresjson['SinalizaçãoVisual'] = newValue;  },),
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
              ], getValue: (newValue ) {valoresjson['SinalizaçãoTátil'] = newValue;  },),
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
              ], getValue: (newValue) {valoresjson['AlarmeDeEmemergência'] = newValue;  },),
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
              ], getValue: (newValue) {valoresjson['Comunicação'] = newValue;  },),
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
              ], getValue: (newValue ) {valoresjson['BalcãoDeAtendimento'] = newValue;  },),
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
              ], getValue: (newValue) {valoresjson['Mobiliário'] = newValue;  },),
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
              ], getValue: (newValue) {valoresjson['Sanitário'] = newValue;  },),
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
              ], getValue: (newValue) {valoresjson['Telefone'] = newValue;  },),
              Padding(
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.04),
                child: const textLabel(
                    name:
                        'Sinalização indicativa de\natendimento preferencial para pessoas com deficiência ou mobilidade reduzida'),
              ),

               ExpansionTileYoN(getValue: (newValue ) {
                valoresjson['SinalizaçãoIndicativa'] = newValue;
                 },),
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
                        name: '', getValue: (newValue) {valoresjson['OutrosAcessibilidade'] = newValue;  },
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
                  name: '', getValue: (newValue) {valoresjson['E-mail'];  },),
              const textLabel(
                  name: 'Responsável pelo atendimento (Coordenador)'),
              CustomTextField(
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '', getValue: (newValue) {valoresjson['Coordenador'];  },),
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
        ));
  }
}
