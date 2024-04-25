import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPesquisa extends StatefulWidget {
  const RegisterPesquisa({super.key});

  @override
  State<RegisterPesquisa> createState() => _RegisterPesquisaState();
}

class _RegisterPesquisaState extends State<RegisterPesquisa> {
  bool _tileExpanded = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: const Text('Cadastrar Nova Pesquisa'),
        foregroundColor: const Color.fromARGB(255, 55, 111, 60),
        backgroundColor: Colors.white,
      ),
      body: PageView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: TextField(
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              filled: true,
                              isCollapsed: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              labelText: "Data Início",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: TextField(
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              filled: true,
                              isCollapsed: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              labelText: "Data Término",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Flexible(
                          child: TextField(
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              filled: true,
                              isCollapsed: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              labelText: "Código IBGE",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          child: TextField(
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              filled: true,
                              isCollapsed: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              labelText: "Estado",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        filled: true,
                        isCollapsed: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(10),
                        labelText: "Município",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: Colors.grey[600]!
                          )
                        )
                      ),
                      child: ExpansionTile(
                        childrenPadding: const EdgeInsets.symmetric(vertical: 10),
                        title: const Row(
                          children: [
                            Spacer(flex: 2),
                            Text("Adicionar Pesquisador(es)"),
                            Spacer(),
                          ],
                        ),
                        trailing: Icon(
                          _tileExpanded
                          ? Icons.remove_rounded
                          : Icons.add_rounded,
                          color: const Color.fromARGB(255, 55, 111, 60),
                          size: 32,
                        ),
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              isCollapsed: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              labelText: "Nome do Pesquisador",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              isCollapsed: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              labelText: "CPF do Pesquisador",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlinedButton(
                                style: const ButtonStyle(
                                  side: MaterialStatePropertyAll(
                                    BorderSide(
                                      color: Color.fromARGB(255, 55, 111, 60)
                                    )
                                  )
                                ),
                                onPressed: () {},
                                child: const Row(
                                  children: [
                                    Text("Confirmar"),
                                    SizedBox(width: 10),
                                    Icon(Icons.done_rounded)
                                  ],
                                ),
                              ),
                              OutlinedButton(
                                style: ButtonStyle(
                                  side: const MaterialStatePropertyAll(
                                    BorderSide(
                                      color: Color.fromARGB(255, 232, 0, 0)
                                    )
                                  ),
                                  foregroundColor: const MaterialStatePropertyAll(
                                    Color.fromARGB(255, 232, 0, 0)
                                  ),
                                  overlayColor: MaterialStatePropertyAll(
                                    Colors.red[100]
                                  )
                                ),
                                onPressed: () {},
                                child: const Row(
                                  children: [
                                    Text("Cancelar"),
                                    SizedBox(width: 10),
                                    Icon(Icons.clear_rounded)
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                        onExpansionChanged: (expanded) {
                          setState(() {
                            _tileExpanded = expanded;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Flexible(
                  child: ListView(
                    children: [
                      Container(height: 100, color: Colors.red,),
                      Container(height: 100, color: Colors.green,),
                      Container(height: 100, color: Colors.blue,),
                      Container(height: 100, color: Colors.yellow,),
                      Container(height: 100, color: Colors.orange,),
                      Container(height: 100, color: Colors.pink,),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: screenSize.height * .06,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.012
                                )
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 55, 111, 60)
                              ),
                              overlayColor: MaterialStateProperty.all(
                                Colors.green[600]
                              )
                            ),
                            onPressed: () {},
                            child: Text(
                              "Confirmar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenSize.height * .03
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          height: screenSize.height * .06,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.012
                                )
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 232, 0, 0)
                              ),
                              overlayColor: MaterialStateProperty.all(
                                Colors.red[500]
                              )
                            ),
                            onPressed: () {
                              
                            },
                            child: Text(
                              "Cancelar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenSize.height * .03
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}