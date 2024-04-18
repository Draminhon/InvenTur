import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/pesquisador_homepage.dart';

class ContainerWidget extends StatelessWidget {
  final codIBGE;
  final estado;
  final municipio;
  final dataI;
  final dataT;
  final qtdeL;
  final qtdeP;

  const ContainerWidget(this.codIBGE, this.estado, this.municipio, this.dataI,
      this.dataT, this.qtdeL, this.qtdeP);

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return Container(
        padding: EdgeInsets.only(
            left: sizeScreen.width * 0.03, top: sizeScreen.height * 0.03),
        margin: EdgeInsets.only(top: sizeScreen.height * 0.05),
        height: sizeScreen.height * 0.30,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: Color.fromARGB(255, 55, 111, 60), width: 2),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 3))
            ]),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          RichText(
            text: TextSpan(
              text: 'Código IBGE do município: $codIBGE\n'
                  'Estado: $estado\n'
                  'Município: $municipio\n'
                  'Data de início: $dataI\n'
                  'Data de término: $dataT\n'
                  'Quantidade de locais cadastrados: $qtdeL\n'
                  'Quantidade de pesquisadores: $qtdeP',
              style: TextStyle(
                  fontSize: sizeScreen.height * 0.02,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  height: sizeScreen.height * 0.002),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: sizeScreen.width * 0.7),
              child: SizedBox(
                  height: sizeScreen.height * 0.03,
                  child: IconButton(
                    onPressed: () =>
                        {Navigator.pushNamed(context, '/Pesquisas')},
                    icon: Icon(Icons.arrow_forward),
                    padding: EdgeInsets.only(bottom: sizeScreen.height * 0.005),
                  )))
        ]));
  }
}
