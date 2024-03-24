import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formA.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formB.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formC.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class A extends StatefulWidget {
  @override
  State<A> createState() => _A();
}

class _A extends State<A> {
  int _selectedIndex = 0;
  int paginaAtual = 0;
  late PageController pc;

  void initState() {
    // TODO: implement initState
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: pc,
          onPageChanged: setPaginaAtual,
          children: [FormularioA(), FormularioB(), FormularioC()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaAtual,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.a),
              label: 'Categoria A',
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.b), label: 'Categoria B'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.c), label: 'Categoria C')
          ],
          selectedItemColor: const Color.fromARGB(255, 55, 111, 60),
          onTap: (pagina) {
            pc.animateToPage(pagina,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease);
          },
        ));
  }
}

class Pesquisas extends StatelessWidget {
  const Pesquisas({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
              padding: EdgeInsets.only(right: sizeScreen.width * 0.15),
              child: TextButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/A'),
                icon: const Icon(FontAwesomeIcons.plus),
                label: const Text(
                  'Adicionar uma nova pesquisa',
                ),
              ))
        ],
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: sizeScreen.height * 0.01),
              child: Column(
                children: [
                  Text('LOCAIS CADASTRADOS',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 55, 111, 60),
                          fontSize: sizeScreen.width * 0.06)),
                  Divider(
                    color: const Color.fromARGB(255, 55, 111, 60),
                    indent: sizeScreen.width * 0.1,
                    endIndent: sizeScreen.width * 0.1,
                  )
                ],
              )),
          Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Table(
                columnWidths: {
                  1: FlexColumnWidth(sizeScreen.width * 0.001)
                },
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children:  [
                  const TableRow(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 55, 111, 50)),
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'LOCALIDADE',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'CATEGORIA',
                              style: TextStyle(color: Colors.white),
                                   textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                      TableRow(
                      decoration: BoxDecoration(
                          color: Colors.grey[300]),
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '',
                              style: TextStyle(color: Colors.white),
                                   textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                       TableRow(
                      decoration: BoxDecoration(
                          color: Colors.grey[300]),
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '',
                              style: TextStyle(color: Colors.white),
                                   textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
