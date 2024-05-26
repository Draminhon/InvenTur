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
  final Function(Map<String, dynamic>) getValues;

  const TabelaT2({super.key, required this.getValues});
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    final Map<String, dynamic> valuesAbertura = {
      'Segunda-Feira_abertura': dynamic,
      'Terça-Feira_abertura': dynamic,
      'Quarta-Feira_abertura': dynamic,
      'Quinta-Feira_abertura': dynamic,
      'Sexta-Feira_abertura': dynamic,
      'Sabado_abertura': dynamic,
      'Domingo_abertura': dynamic,
      'Segunda-Feira_encerramento': dynamic,
      'Terça-Feira_encerramento': dynamic,
      'Quarta-Feira_encerramento': dynamic,
      'Quinta-Feira_encerramento': dynamic,
      'Sexta-Feira_encerramento': dynamic,
      'Sabado_encerramento': dynamic,
      'Domingo_encerramento': dynamic,
    };
    return Table(
      
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder.all(),
      children: [
        const TableRow(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 55, 111, 60),
            ),
            children: [
              Text(
                '2º FEIRA',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                '3º FEIRA',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                '4º FEIRA',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                '5º FEIRA',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                '6º FEIRA',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                'SABADO',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              Text(
                'DOMINGO',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ]),
        TableRow(children: [
          TextFormField(
            decoration: const InputDecoration(
                hintText: 'Aber\ntura',
            hintStyle: TextStyle(fontSize: 10),
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Segunda-Feira_abertura'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Terça-Feira_abertura'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Quarta-Feira_abertura'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Quinta-Feira_abertura'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Sexta-Feira_abertura'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Sabado_abertura'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Domingo_abertura'] = newValue;
            },
          )
        ]),
        TableRow(children: [
          TextFormField(
            decoration: const InputDecoration(
                 hintText: 'Encerramento',
            hintStyle: TextStyle(fontSize: 10),
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Segunda-Feira_encerramento'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Terça-Feira_encerramento'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Quarta-Feira_encerramento'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Quinta-Feira_encerramento'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Sexta-Feira_encerramento'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Sabado_encerramento'] = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
                labelText: '',
                border: InputBorder.none,
                fillColor: Colors.white,
                
                filled: true),
            onSaved: (newValue) {
              valuesAbertura['Domingo_encerramento'] = newValue;
            },
          )
        ]),
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
                child: Text(
                  'espaço',
                  textAlign: TextAlign.center,
                ),
              )),
              TableCell(
                  child: SizedBox(
                child: Text(
                  'quantidade',
                  textAlign: TextAlign.center,
                ),
              )),
              TableCell(
                  child: SizedBox(
                child: Text(
                  'Área total(m²)',
                  textAlign: TextAlign.center,
                ),
              )),
              TableCell(
                  child: SizedBox(
                child: Text(
                  'Capacidade nº\npessoas',
                  textAlign: TextAlign.center,
                ),
              ))
            ]),
        TableRow(children: [
          const TableCell(
              child: SizedBox(
            child: Text(
              'Auditório',
              textAlign: TextAlign.center,
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
          const TableCell(
              child: SizedBox(
            child: Text(
              'Salas Modulares',
              textAlign: TextAlign.center,
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
          const TableCell(
              child: SizedBox(
            child: Text(
              'Pavilhão de feiras',
              textAlign: TextAlign.center,
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
          const TableCell(
              child: SizedBox(
            child: Text(
              'Áreas de exposição coberta',
              textAlign: TextAlign.center,
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
  const TabelaT4({
    super.key,
    required this.column01,
    required this.column02,
    required this.column03,
    required this.column04,
  });
  final List<Widget> column01;
  final List<Widget> column02;
  final List<Widget> column03;
  final List<Widget> column04;

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    List<Widget> tableRows = [];
    for (int i = 0; i < column01.length; i++) {
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
    return Column(children: tableRows);
  }
}
