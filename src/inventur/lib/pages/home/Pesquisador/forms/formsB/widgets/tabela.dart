import 'package:flutter/material.dart';

class TabelaT1 extends StatelessWidget {
  final List<Widget> column01;
  final List<Widget> column02;

  const TabelaT1({super.key, required this.column01, required this.column02});
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    List<Widget> tablesRows = [];
    for (int i = 0; i < column01.length; i++) {
      tablesRows.add(Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
              decoration: const BoxDecoration(color: Colors.white),
              children: [
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: column01[i])),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0), child: column02[i]),
                )
              ]),
        ],
      ));
    }

    return Column(children: tablesRows);
  }
}

class TabelaT2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Table(
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
        TableRow(
          children: List.generate(
              7,
              (index) => SizedBox(
                    height: sizeScreen.height * 0.1,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Abertura',
                        hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
                      ),
                    ),
                  )),
        ),
        TableRow(
          children: List.generate(
              7,
              (index) => SizedBox(
                    height: sizeScreen.height * 0.1,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Encerramento',
                        hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}

class TabelaT3 extends StatelessWidget {
  const TabelaT3({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
            decoration: BoxDecoration(border: Border.all()),
            children: const [
              TableCell(
                  child: SizedBox(
                child: Text('espaço',textAlign: TextAlign.center,),
              )),
              TableCell(
                  child: SizedBox(
                child: Text('quantidade',textAlign: TextAlign.center,),
                
              )),
              TableCell(
                  child: SizedBox(
                child: Text('Área total(m²)',textAlign: TextAlign.center,),
              )),
              TableCell(
                  child: SizedBox(
                child: Text('Capacidade nº\npessoas',textAlign: TextAlign.center,),
              ))
            ]),
        TableRow(children: [
          TableCell(
              child: SizedBox(
            child: Text('Auditório',textAlign: TextAlign.center,),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
        ]),
        TableRow(children: [
          TableCell(
              child: SizedBox(
            child: Text('Salas Modulares',textAlign: TextAlign.center,),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
        ]),
        TableRow(children: [
          TableCell(
              child: SizedBox(
            child: Text('Pavilhão de feiras',textAlign: TextAlign.center,),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
        ]),
        TableRow(children: [
          TableCell(
              child: SizedBox(
            child: Text('Áreas de exposição coberta',textAlign: TextAlign.center,),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
          TableCell(
              child: SizedBox(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: sizeScreen.width * 0.03),
              ),
            ),
          )),
        ])
      ],
    );
  }
}

class TabelaT4 extends StatelessWidget {
  const TabelaT4({super.key, required this.column01, required this.column02, required this.column03, required this.column04,});
 final List<Widget> column01;
  final List<Widget> column02;
  final List<Widget> column03;
  final List<Widget> column04;

  @override
   Widget build(BuildContext context) {
   

    final sizeScreen = MediaQuery.of(context).size;
    List<Widget> tableRows = [];
    for(int i = 0; i<column01.length; i++){
      tableRows.add(Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(),
      children: [
      TableRow(
              decoration: const BoxDecoration(color: Colors.white),
              children: [
                TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: column01[i])),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0), child: column02[i]),
                ),
                 TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0), child: column03[i]),
                ),
                 TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0), child: column04[i]),
                )
              ]),
       
      ],
      ));
    }
    return Column(children:  tableRows);
  }
}
