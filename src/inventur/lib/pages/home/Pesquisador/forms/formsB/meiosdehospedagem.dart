import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/apis/estados.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/sendButton.dart';
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
            const textLabel(name: 'Tipo:'),
              Padding(
                padding: EdgeInsets.only(left: sizeScreen.width * 0.12),
                child:  RadioB(name: 'Hotelaria e apoio', getValue: (newValue ) {  },),
              ),
              const textLabel(name: 'Subtipos:'),

              RadioC(number: 18, options: const [
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
            
           
               const textLabel(name: 'Natureza:'),
          
               Column(
                children: [
                  RadioD(
                    options: const ['pública', 'privada', 'outro'], getValue: (String ) {  },
                  ),
                ],
              ),

              const textLabel(
                name: 'Tipo de organização/instituição:',
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
            const CheckC(
                nomes: [
                  'associação',
                  'sindicato',
                  'cooperativa',
                  'sistema S',
                  'empresa',
                  'outro'
                ],
              ),
              Row(
                children: [
          
                  const textLabel(name: 'Início da atividade:'),
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
              const textLabel(name: 'Quantidade de Funcionários:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Column(
                children: [
                  Row(
                    children: [
                   
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
              const textLabel(name: 'Localização:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioD(options: const ['urbana', 'rural'], getValue: (String ) {  },),
              const textLabel(name: 'Coordenadas Geográficas:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Column(children: [
                Row(
                  children: [
                   
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
              const textLabel(name: 'Endereço:'),

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
                   
                  
                    const textLabel(name: 'Whatsapp'),
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
              Row(
                  children: [
                   
                  
                    const textLabel(name: 'Instagram'),
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
                          name: '@', getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(
                  children: [
              
                    const textLabel(name: 'E-mail'),
                      SizedBox(width: sizeScreen.width * 0.03,),
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
                   
                    const textLabel(
                        name: 'Site'),
                          SizedBox(width: sizeScreen.width * 0.05,),
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
                height: sizeScreen.height * 0.06,
              ),
              const textLabel(name: 'Sinalização:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Row(children: [
                
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
                height: sizeScreen.height * 0.05,
              ),
              Row(children: [
             
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
                height: sizeScreen.height * 0.06,
              ),
              const textLabel(name: 'Proximidades:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              //  RadioD(number: 6, options: options)
              const CheckC(nomes: [
                'Restaurante',
                'Centro de Convenções exposições',
                'Shopping',
                'Bar/Lanchconete',
                'Posto de combustível',
                'Galeria/rua comercial',
                'outro'
              ],),
              const textLabel(name: 'Pontos de referência:'),
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
                  padding: EdgeInsets.only(left: sizeScreen.width * 0.04),
                  child: const textLabel(
                      name:
                          '       Segmentos ou tipos de turismo\nem que é especializado (assinalar até 3):')),
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
              const textLabel(name: 'Estrutura de funcionamento:'),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              const textLabel(name: 'Tipo de diária:'),

              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              RadioD( options: const [
                'Sem Alimentação',
                'Café da manhã',
                'Meia Pensão',
                'Pensão Completa',
                'Tudo incluído'
              ], getValue: (String ) {  },),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'Formas de Pagamento:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(
             
                nomes: [
                  'Dinheiro',
                  'Pix',
                  'Cartão de Crédito',
                  'Cartão de Débito'
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'Reservas:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
             const CheckC(
                
                nomes: [
                  'Balcão',
                  'Whatsapp',
                  'Instagram',
                  'Site',
                  'Agência de turismo',
                  'Antecipado'
                ], 
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'Atendimento ao público:'),
              SizedBox(
                height: sizeScreen.height * 0.04,
              ),

              const textLabel(name: 'Atendimento em língua estrangeira:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(nomes: ['Não', 'Inglês', 'Espanhol', 'outro']),
              const textLabel(name: 'Informativos impressos:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(nomes: ['Não', 'Inglês', 'Espanhol', 'outro']),
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
              const textLabel(name: 'Período:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioC(number: 13, options: const [
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
              const textLabel(name: 'Horário:'),
               SizedBox(
                height: sizeScreen.height * 0.01,
              ),
              TabelaT2(getValues: (newValue){
                
              }),
              SizedBox(
                height: sizeScreen.height * 0.01,
              ),
              //TabelaT2(),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const textLabel(name: 'Funcionamento 24 horas:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
           ExpansionTileYoN(getValue: (String ) {  },),
              const textLabel(name: 'Funcionamento em feriados:'),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
               ExpansionTileYoN(getValue: (String ) {  },),
              const textLabel(name: 'Restrições:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(
                  nomes: ['Crianças', 'Fumantes', 'Animais', 'outro'],),
              const textLabel(name: 'Outras regras e informações:'),

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
              const textLabel(name: 'Dados da visitação:'),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const textLabel(name: 'Ocupação ano nº:'),

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
              const textLabel(name: 'Ocupação na alta temporada nº:'),

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
              const textLabel(name: 'Meses de alta temporada:'),
              SizedBox(
                height: sizeScreen.height * 0.01,
              ),

               const CheckC( nomes: [
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
              ], ),
              const textLabel(name: 'Origem dos visitantes/turistas:'),
             const CheckC(nomes: [
                'Entorno municipal',
                'Estadual',
                'Nacional',
                'Internacional'
              ],),
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
      
             const textLabel(name: 'Unidades habitacionais (UH):'),
             SizedBox(height: sizeScreen.height * 0.02,),

              Column(children: [
                Row(
                  children: [
                  
                    const textLabel(name: 'Total de UH nº'),
                    
                    SizedBox(
                      width: sizeScreen.width * 0.055,
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                      
                    const textLabel(name: 'Total de leitos nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.005,
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                      
                    const textLabel(name: 'Uh adaptadas\npara PCD nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.071,
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(
                    left: sizeScreen.width * 0.02,
                    top: sizeScreen.height * 0.03,
                    bottom: sizeScreen.height * 0.03),
                child: const textLabel(name: 'Produtos de higiene pessoal:'),
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
                child: const textLabel(name: 'Equipamentos e Serviços:'),
              ),
            const CheckC(nomes: [
                'TV',
                'Internet',
                'Ar-Condicionado',
                'Cama King Size',
                'Cama Queen Size',
                'Panelas e louças',
                'Micro-ondas',
                'Forno Elétrico',
                'Cofre',
                'Academia',
                'Hidromassagem',
                'Sauna seca',
                'Room - service',
                'Room service 24h',
                'Controle de Iluminação',
                'Luminária para leitura',
                'outro'
              ], ),
              Padding(
                padding: EdgeInsets.only(
                    right: sizeScreen.width * 0.05,
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: const textLabel(name: 'Instalações:'),
              ),
              Padding(
                padding: EdgeInsets.only(
                   
                    top: sizeScreen.height * 0.03,
                    bottom: sizeScreen.height * 0.03),
                child: const textLabel(name: 'Estacionamento:'),
              ),
              const CheckC(
             nomes: ['Pago', 'Gratuito', 'Coberto', 'Descoberto'], 
              ),

              Column(children: [
                Row(
                  children: [
                   
                    const textLabel(name: 'Capacidade de\nveículos nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.01,
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                      
                    const textLabel(name: 'Automóveis nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.005,
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                  
                    const textLabel(name: 'Ônibus nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.1,
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
              ]),
              SizedBox(height: sizeScreen.height * 0.03,),
              const textLabel(name: 'Outras instalações e estruturas:'),
             SizedBox(height: sizeScreen.height * 0.02,),
               const textLabel(name: 'Energia  elétrica:'),
                  SizedBox(height: sizeScreen.height * 0.02,),
              RadioD(
                  options: const ['110 volts', '220 volts', '110/220 volts'], getValue: (String ) {  },),
                      SizedBox(height: sizeScreen.height * 0.02,),
              Row(
                children: [
                     
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
                        name: 'KVA', getValue: (String ) {  },
                      ))
                ],
              ),
                  SizedBox(height: sizeScreen.height * 0.02,),
              const textLabel(name: 'Gerador de emergência:'),
         SizedBox(height: sizeScreen.height * 0.032,),
               ExpansionTileYoN(getValue: (String ) {  },),
                  SizedBox(height: sizeScreen.height * 0.02,),
              Row(
                children: [
                     
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
                        name: 'KVA', getValue: (String ) {  },
                      ))
                ],
              ),
              SizedBox(height: sizeScreen.height * 0.03,),
            const textLabel(name: 'Área de alimentação:'),
SizedBox(height: sizeScreen.height * 0.02,),
               const textLabel(name: 'Restaurante:'),
              SizedBox(height: sizeScreen.height * 0.02,)
,              const CheckC(nomes: [
                'Não',
                'Apenas para hóspedes',
                'Aberto ao público',
                'Adaptado para PCD'
              ], ),
               const textLabel(name: 'Capacidade de atendimento:'),
                SizedBox(height: sizeScreen.height * 0.02,),
              Column(children: [
                Row(
                  children: [
                      
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                  
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                  SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                      
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                Row(
                  children: [
                   
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(height: sizeScreen.height * 0.02,),
           const textLabel(name: 'Lanchonete:'),
                SizedBox(height: sizeScreen.height * 0.02,),
              ]),
              const CheckC(nomes: [
                'Não',
                'Apenas para hóspedes',
                'Aberto ao público',
                'Adaptado para PCD'
              ], ),
              Column(children: [
                Row(
                  children: [
                   
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(height: sizeScreen.height * 0.02,),
                 
                Row(
                  children: [
                   
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                
                SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                 
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(height: sizeScreen.height * 0.02,),
                Row(
                  children: [
                   
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
                          name: 'nº', getValue: (String ) {  },
                        ))
                  ],
                ),
                SizedBox(height: sizeScreen.height * 0.02,),
              ]),
             const textLabel(
                    name:
                    'Área de recreação e lazer:'),
               SizedBox(height: sizeScreen.height * 0.02,),
               const textLabel(name: 'Instalações e espaços:'),
               SizedBox(height: sizeScreen.height * 0.02,),
              const CheckC(nomes: [
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
              ], ),
            
              const textLabel(
                    name: 'Outros espaços, equipamentos e atividades:'),
               SizedBox(height: sizeScreen.height * 0.02,),
              const CheckC(nomes: [
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
              ], ),
               SizedBox(height: sizeScreen.height * 0.02,),
            const textLabel(
                    name: 'Área para eventos:'),
               SizedBox(height: sizeScreen.height * 0.04,),
               const textLabel(name: 'Instalações:'),
                SizedBox(height: sizeScreen.height * 0.04,),
              const TabelaT3(),
               SizedBox(height: sizeScreen.height * 0.02,),
           const textLabel(name: 'Serviços:'),
               SizedBox(height: sizeScreen.height * 0.02,),
              const CheckC(nomes: [
                'Realização de eventos próprios',
                'Aluguel de equipamentos',
                'Aluguel de espaço para terceiros',
                'Serviços de alimentação',
                'Organização de eventos',
                'Serviços de som',
                'outro',
              ], ),
               const textLabel(name: 'Equipamentos:'),
               SizedBox(height: sizeScreen.height * 0.02,),
              const CheckC(nomes: [
                'Internet',
                'Elevador',
                'Poltronas',
                'Tv com canal aberto',
                'Projetor',
                'Computador',
                'Equipamento de tradução simultânea',
                'Parabólica',
                'Ar condicionado central',
                'Palco',
                'outro'
              ], ),
             
              const textLabel(name: 'Facilidades e serviços:'),
               SizedBox(height: sizeScreen.height * 0.02,),
              const CheckC(nomes: [
                'Adaptador de voltagem',
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
              ], ),
            const textLabel(name: 'Facilidades para executivos:'),
               SizedBox(height: sizeScreen.height * 0.02,),
             const CheckC(nomes: [
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
              ],),
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
              RadioD(options: const ['Muito bom', 'Bom', 'Ruim'], getValue: (String ) {  },),
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
                        'Possui alguma facilidade para pessoas com deficiência ou mobilidade reduzida?'),
               SizedBox(height: sizeScreen.height * 0.04,),
               ExpansionTileYoN(getValue: (String ) {  },),
 SizedBox(height: sizeScreen.height * 0.02,),
              const textLabel(
                    name: 'obs: responder às questões seguintes'),
          SizedBox(height: sizeScreen.height * 0.02,),
 const textLabel(
                    name: 'Pessoal capacitado para receber PCD:'),
                SizedBox(height: sizeScreen.height * 0.02,),
              const CheckC(nomes: [
                'Não',
                'Física',
                'Auditiva',
                'Visual',
                'Mental',
                'Múltipla'
              ], ),
             const textLabel(name: 'Rota externa acessível:'),
                SizedBox(height: sizeScreen.height * 0.02,),
              const CheckC(nomes: [
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
              ],),
            const textLabel(name: 'Símbolo internacional de acesso:'),
              
              const CheckC(nomes: [
                'Não',
                'Entrada',
                'Área reservada',
                'Estacionamento',
                'Área de embarque e desembarque',
                'Sanitário',
                'Saída de emergência',
              ], ),
              const textLabel(name: 'Local de embarque e desembarque'),
              
              const CheckC(
                 nomes: ['Não', 'Sinalizado', 'Com acesso em nível'],),
              const textLabel(name: 'Vaga em estacionamento:'),
              
              const CheckC(nomes: [
                'Não',
                'Sinalizado',
                'Com acesso em nível',
                'Alargada para cadeira de rodas',
                'Rampa de acesso á calçada'
              ], ),
              const textLabel(
                    name:
                        'Área de circulação / acesso interno\npara cadeira de rodas:'),
              
              const CheckC(nomes: [
                'Não',
                'Rampa',
                'Elevador',
                'Plataforma elevatória',
                'Porta larga',
                'Piso regular / antiderrapante'
              ], ),
              const textLabel(name: 'Escada:'),
              
              const CheckC(nomes: [
                'Não',
                'Corrimão',
                'Patamar para descanso',
                'Sinalização tátil de alerta',
                'Piso antiderrapante',
              ], ),

         const textLabel(name: 'Rampa:'),
              
              const CheckC(nomes: [
                'Não',
                'Corrimão',
                'Patamar para descanso',
                'Sinalização tátil de alerta',
                'Piso antiderrapante',
                'Inclinação adequada',
              ],),
               const textLabel(name: 'Piso:'),
              
                 const CheckC(nomes: [
                'Não',
                'Tátil',
                'Sem obstáculos',
                'Antiderrapante/deslizante',
              ],),
               const textLabel(name: 'Elevador:'),
              
               const CheckC(nomes: [
                'Não',
                'Sinalizado em braile',
                'Dispositivo sonoro',
                'Dispositivo luminoso',
                'Sensor eletrônico (porta)'
              ], ),
            const textLabel(
                    name:
                        'Equipamento motorizado para deslocamento interno:'),
           
                 const CheckC(nomes: [
                'Não',
                'Cadeira',
                'Carrinho',
              ], ),
             const textLabel(name: 'Sinalização visual:'),
              
                   const CheckC(nomes: [
                'Não',
                'Entrada',
                'Recepção',
                'Porta',
                'Sanitário',
                'Elevador',
                'Restaurante',
                'Área de lazer',
                'Área de resgate',
              ],),
             const textLabel(name: 'Sinalização tátil:'),
              
                   const CheckC(nomes: [
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
             const textLabel(name: 'Alarme de emergência:'),
              
                 const CheckC(nomes: [
                'Não',
                'Sonoro',
                'Visual',
                'Vibratório',
              ], ),
            const textLabel(name: 'Comunicação:'),
              
                    const CheckC(nomes: [
                'Não',
                'Texto informativo em braile',
                'Texto informativo em fonte ampliada',
                'Intérprete em libras',
              ], ),
             const textLabel(name: 'Balcão de atendimento:'),
              
               const CheckC(nomes: [
                'Não',
                'Rebaixado',
                'Preferencial para PCD ou com deficiência ou mobilidade reduzida',
              ], ),
             const textLabel(name: 'Mobiliário:'),
              
                 const CheckC(nomes: [
                'Não',
                'Altura adequada',
                'Recuo adequado',
              ], ),
               const textLabel(name: 'Sanitário:'),
              
                   const CheckC(nomes: [
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
              const textLabel(name: 'Telefone:'),
              
                  const CheckC(nomes: [
                'Não',
                'Altura adequada',
                'Para surdos (TPS ou TTS)',
              ], ),
               const textLabel(
                    name:
                        'Sinalização indicativa de atendimento preferencial para pessoas com deficiência ou mobilidade reduzida:'),
              const SizedBox(height: 50,),

               ExpansionTileYoN(getValue: (String ) {  },),
              SizedBox(height: sizeScreen.height * 0.02,),              Row(
                children: [
                
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
            const SendButton(),

              SizedBox(
                height: sizeScreen.height * 0.05,
              )
            ]),
          ),
        ));
  }
}