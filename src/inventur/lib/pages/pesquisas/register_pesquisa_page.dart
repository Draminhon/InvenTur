import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/pesquisas/widgets/user_pesquisa_card_widget.dart';

class RegisterPesquisa extends StatefulWidget {
  const RegisterPesquisa({super.key});

  @override
  State<RegisterPesquisa> createState() => _RegisterPesquisaState();
}

class _RegisterPesquisaState extends State<RegisterPesquisa> {
  bool _tileExpanded = false;

  List<UserModel> users = [
    UserModel(nome: "Fulano Silva da Costa", cpf: "789.214.878-02", email: "fulanosilva@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    UserModel(nome: "Ciclano Fonseca Silva", cpf: "584.978.010-80", email: "ciclano@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Beltrano Alves Oliveira", cpf: "785.441.210-70", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
    UserModel(nome: "Fulano Silva da Costa", cpf: "789.214.878-02", email: "fulanosilva@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    UserModel(nome: "Ciclano Fonseca Silva", cpf: "584.978.010-80", email: "ciclano@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Beltrano Alves Oliveira", cpf: "785.441.210-70", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
    UserModel(nome: "Fulano Silva da Costa", cpf: "789.214.878-02", email: "fulanosilva@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    UserModel(nome: "Ciclano Fonseca Silva", cpf: "584.978.010-80", email: "ciclano@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    UserModel(nome: "Beltrano Alves Oliveira", cpf: "785.441.210-70", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
  ];

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
                        childrenPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStatePropertyAll(
                                     RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                  ),
                                  side: const MaterialStatePropertyAll(
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
                                  shape: MaterialStatePropertyAll(
                                     RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                  ),
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
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return UserPesquisaCard(user: users[index]);
                    },
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