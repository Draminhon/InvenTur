import 'package:flutter/material.dart';

class ContainerA extends StatelessWidget {
  final String form, routeName;
  const ContainerA({super.key, required this.form, required this.routeName});
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return Container(
        margin: EdgeInsets.only(bottom: sizeScreen.height * 0.01),
        padding: EdgeInsets.only(
          left: sizeScreen.width * 0.07,
        ),
        width: sizeScreen.width,
        height: sizeScreen.height * 0.06,
        decoration: BoxDecoration(
            border: Border.all(width: 0.5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 3))
            ]),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: sizeScreen.width * 0.8,
            child: Text(
              form,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Color.fromARGB(255, 55, 111, 60),
                  fontWeight: FontWeight.w900),
            ),
          ),
          Expanded(
              child: IconButton(
            onPressed: () => Navigator.pushNamed(context, routeName),
            icon: Icon(
              Icons.arrow_forward,
              size: sizeScreen.height * 0.029,
            ),
            padding: EdgeInsets.only(left: sizeScreen.width * 0.005),
          ))
        ]));
  }
}

class Tilee extends StatelessWidget {
  @override
  final String texto, routeName;

  const Tilee({super.key, required this.texto, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.4),
          color: Colors.grey[300],
        ),
        child: ListTile(
          title: (Text(
            texto,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Color.fromARGB(255, 55, 111, 69),
                fontWeight: FontWeight.bold),
          )),
          dense: true,
          onTap: () => Navigator.pushNamed(context, routeName),
        ));
  }
}

// ignore: must_be_immutable
class ExpansionTileA extends StatefulWidget {
  final String titulo;
  List minhaLista = [];

  ExpansionTileA({super.key, required this.titulo, required this.minhaLista});

  @override
  State<ExpansionTileA> createState() => _ExpansionTileA();
}

class _ExpansionTileA extends State<ExpansionTileA> {
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.sizeOf(context);
    final String titulo = widget.titulo;
    List minhaLista = widget.minhaLista;

    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(bottom: sizeScreen.height * 0.01),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 3))
            ]),
            child: ExpansionTile(
              title: Text(
                titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  fontWeight: FontWeight.w800,
                  fontSize: sizeScreen.width * 0.037,
                ),
              ),
              collapsedBackgroundColor: Colors.white,
              tilePadding: EdgeInsets.only(
                  left: sizeScreen.width * 0.15,
                  right: sizeScreen.width * 0.08),
              backgroundColor: Colors.white,
              collapsedShape: const Border(
                  top: BorderSide(width: 0.5, color: Colors.black),
                  bottom: BorderSide(width: 0.5, color: Colors.black)),
              childrenPadding:
                  EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.0),
              dense: true,
              children: <Widget>[
                minhaLista[0],
                minhaLista[1],
                minhaLista[2],
                minhaLista[3]
              ],
            ))
      ],
    );
  }
}
