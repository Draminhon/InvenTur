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
      this.dataT, this.qtdeL, this.qtdeP, {super.key});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/Pesquisas');
      },
      child: Container(
          padding: EdgeInsets.only(
              left: sizeScreen.width * 0.03,
              top: sizeScreen.height * 0.03,
              bottom: sizeScreen.height * 0.03,
              right: sizeScreen.width * 0.05),
          margin: EdgeInsets.only(top: sizeScreen.height * 0.05),
          height: sizeScreen.height * 0.35,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: const Color.fromARGB(255, 55, 111, 60), width: 2),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 3))
              ]),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Código IBGE:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('$codIBGE')
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Estado:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('$estado')
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Município:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('$municipio')
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Início da pesquisa:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('$dataI')
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Fim da pesquisa:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('$dataT')
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quantidade de locais:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('$qtdeL')
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Quantidade de pesquisadores:',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text('$qtdeP')
                  ],
                ),
              ])),
    );
  }
}
