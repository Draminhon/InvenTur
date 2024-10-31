import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';

import '../../widgets/customOutro.dart';
import '../../widgets/customTextField.dart';
import '../formsB/widgets/sendButton.dart';

class SistemaDeSeguranca extends StatefulWidget {
  const SistemaDeSeguranca({super.key});

  @override
  State<SistemaDeSeguranca> createState() => _SistemaDeSegurancaState();
}

class _SistemaDeSegurancaState extends State<SistemaDeSeguranca> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> valoresjson = {
    'uf': null,
    'RG': null,
    'Municipio': null,
    'Tipo': null,
    'Tabela01': <String, dynamic>{
      'Nome01': null,
      'Nome02': null,
      'Nome03': null,
      'Nome04': null,
      'Endereço01': null,
      'Endereço02': null,
      'Endereço03': null,
      'Endereço04': null,
      'Telefones01': null,
      'Telefones02': null,
      'Telefones03': null,
      'Telefones04': null,
      'Email01': null,
      'Email02': null,
      'Email03': null,
      'Email04': null,
    },
    'Tabela02': <String, dynamic>{
      'Email01': null,
      'Email02': null,
      'Email03': null,
      'Email04': null,
      'Serviços01': null,
      'Serviços02': null,
      'Serviços03': null,
      'Serviços04': null,
      'OutrasInfo01': null,
      'OutrasInfo02': null,
      'OutrasInfo03': null,
      'OutrasInfo04': null,
    },
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
                    RadioC(
                      options: const [
                        'Polícia Civil',
                        'Polícia Militar',
                        'Polícia Rodoviária',
                        'Corpo de Bombeiros',
                        'Serviços de busca e salvamento',
                        'Serviços de Polícia',
                        'Marítima/Aérea/de Fronteiras',
                        'Guarda Municipal',
                        'Defesa Civil',
                        'outro'
                      ],
                      getValue: (newValue) {
                        valoresjson['Tipos'] = newValue;
                      },
                      number: 10,
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
                        'Informações Gerais',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: sizeScreen.height * 0.03),
                      ),
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.05,
                    ),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        const TableRow(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 55, 111, 60),

                            ),
                            children: [
                              Text(
                                'Nome',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Endereço',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Telefones',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'E-Mail',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                        TableRow(
                            decoration: const BoxDecoration(color: Colors.white),
                            children: [
                              TextFormField(
                                onSaved: (newValue) {
                                  valoresjson['Tabela01']['Nome01'] = newValue;
                                },
                              ),
                              TextFormField(
                                onSaved: (newValue) {
                                  valoresjson['Tabela01']['Endereço01'] =
                                      newValue;
                                },
                              ),
                              TextFormField(
                                onSaved: (newValue) {
                                  valoresjson['Tabela01']['Telefones01'] =
                                      newValue;
                                },
                              ),
                              TextFormField(
                                onSaved: (newValue) {
                                  valoresjson['Tabela01']['Email01'] = newValue;
                                },
                              ),
                            ]),
                        TableRow(children: [
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Nome02'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Endereço02'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Telefones02'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Email02'] = newValue;
                            },
                          ),
                        ]),
                        TableRow(children: [
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Nome03'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Endereço03'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Telefones03'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Email03'] = newValue;
                            },
                          ),
                        ]),
                        TableRow(children: [
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Nome04'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Endereço04'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Telefones04'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela01']['Email04'] = newValue;
                            },
                          ),
                        ]),
                      ],
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.05,
                    ),
                    Table(
                      border: TableBorder.all(),
                      children: [
                        const TableRow(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 55, 111, 60),
                            ),
                            children: [
                              Text(
                                'E-mail',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Serviços especializados',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Outras informações',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                        TableRow(
                            decoration: const BoxDecoration(color: Colors.white),
                            children: [
                              TextFormField(
                                onSaved: (newValue) {
                                  valoresjson['Tabela02']['Email01'] = newValue;
                                },
                              ),
                              TextFormField(
                                onSaved: (newValue) {
                                  valoresjson['Tabela02']['Serviços01'] =
                                      newValue;
                                },
                              ),
                              TextFormField(
                                onSaved: (newValue) {
                                  valoresjson['Tabela02']['OutrasInfo01'] =
                                      newValue;
                                },
                              ),
                            ]),
                        TableRow(children: [
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela02']['Email02'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela02']['Serviços02'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela02']['OutrasInfo02'] =
                                  newValue;
                            },
                          ),
                        ]),
                        TableRow(children: [
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela02']['Email03'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela02']['Serviços03'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela02']['OutrasInfo03'] =
                                  newValue;
                            },
                          ),
                        ]),
                        TableRow(children: [
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela02']['Email04'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela02']['Serviços04'] = newValue;
                            },
                          ),
                          TextFormField(
                            onSaved: (newValue) {
                              valoresjson['Tabela02']['OutrasInfo04'] =
                                  newValue;
                            },
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
                        'Observações',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: sizeScreen.height * 0.03),
                      ),
                    ),
                    CustomTextField(
                      validat: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      name: '',
                      getValue: (newValue) {
                        valoresjson['Observações'] = newValue;
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
                      validat: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      name: '',
                      getValue: (newValue) {
                        valoresjson['Referências'] = newValue;
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
                        'Equipe Responsável',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: sizeScreen.height * 0.03),
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
                      name: '',
                      getValue: (newValue) {
                        valoresjson['Pesquisador'] = newValue;
                      },
                    ),
                    const textLabel(name: 'Telefone'),
                    CustomTextField(
                      validat: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      name: '',
                      getValue: (newValue) {
                        valoresjson['TelefonePesquisador'] = newValue;
                      },
                    ),
                    const textLabel(name: 'E-mail'),
                    CustomTextField(
                      validat: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      name: '',
                      getValue: (newValue) {
                        valoresjson['E-mailPesquisador'] = valoresjson;
                      },
                    ),
                    const textLabel(
                        name: 'Responsável pelo atendimento (Coordenador)'),
                    CustomTextField(
                      validat: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      name: '',
                      getValue: (newValue) {
                        valoresjson['Coordenador'] = newValue;
                      },
                    ),
                    const textLabel(name: 'Telefone'),
                    CustomTextField(
                      validat: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      name: '',
                      getValue: (newValue) {
                        valoresjson['TelefoneCoordenador'] = newValue;
                      },
                    ),
                    const textLabel(name: 'E-mail'),
                    CustomTextField(
                      validat: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Preencha o campo';
                        }
                        return null;
                      },
                      name: '',
                      getValue: (newValue) {
                        valoresjson['E-mailCoordenador'] = newValue;
                      },
                    ),
                    SizedBox(
                      height: sizeScreen.height * 0.05,
                    ),
                   SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('processing data')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('preencha os dados!')));
                          }
          print(valoresjson);

         // Navigator.pushReplacementNamed(context, '/SendedForm');
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.green[800],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          'Enviar',
          style: TextStyle(
              color: Colors.white, fontSize: 25), // Use um fontSize fixo
        ),
      ),
    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ))));
  }
}
