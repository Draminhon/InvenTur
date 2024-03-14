import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_form.dart';

class FormularioA extends StatelessWidget {
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        body: Column(children: [
          Padding(
              padding: EdgeInsets.only(
                  right: sizeScreen.width * 0.85,
                  top: sizeScreen.height * 0.05),
              child: SizedBox(
                height: sizeScreen.height * 0.03,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  padding: EdgeInsets.only(bottom: sizeScreen.height * 0.005),
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: sizeScreen.height * 0.01),
            child: Column(
              children: [
                Text(
                  'CATEGORIA A',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 55, 111, 60),
                      fontSize: sizeScreen.width * 0.06),
                ),
                Divider(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  indent: sizeScreen.width * 0.1,
                  endIndent: sizeScreen.width * 0.1,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.002,
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(children: [
            const ContainerA(
              form: 'Informações básicas do município',
            ),
            const ContainerA(form: 'Locadoras de imóveis para temporadas'),
            const ContainerA(form: 'Compras especiais'),
            const ContainerA(form: 'Comércio turístico'),
            const ContainerA(form: 'Representações diplomáticas'),
            ExpansionTileA(titulo: 'Serviços', minhaLista: [
              Tilee(texto: 'Serviços bancários'),
              Tilee(texto: 'Serviços mecânicos e postos de combustível'),
              const SizedBox(),
              const SizedBox()
            ]),
            ExpansionTileA(titulo: 'Rodoviário', minhaLista: [
              Tilee(texto: 'Rodovia'),
              Tilee(texto: 'Estação rodoviária'),
              const SizedBox(),
              const SizedBox()
            ]),
            ExpansionTileA(titulo: 'Ferroviário', minhaLista: [
              Tilee(texto: 'Ferrovia e metrovia'),
              Tilee(texto: 'Estação ferroviária'),
              const SizedBox(),
              const SizedBox()
            ]),
            ExpansionTileA(titulo: 'Aeroviário', minhaLista: [
              Tilee(texto: 'Aeroporto e campo de pouso'),
              Tilee(texto: 'Heliporto'),
              const SizedBox(),
              const SizedBox()
            ]),
            ExpansionTileA(titulo: 'Aquaviário', minhaLista: [
              Tilee(texto: 'Hidrovia'),
              Tilee(texto: 'Porto, pier, cais, etc'),
              const SizedBox(),
              const SizedBox()
            ]),
            ExpansionTileA(
              titulo: 'Sistemas',
              minhaLista: [
                Tilee(
                  texto: 'Sistemas de comunicação',
                ),
                Tilee(
                  texto: 'Sistemas de segurança',
                ),
                Tilee(
                  texto: 'Sistemas de saúde',
                ),
                Tilee(
                  texto: 'Locadoras de imóveis por temporada',
                )
              ],
            )

            /*ListTile(title: (Text('aiii', textAlign: TextAlign.center,
                 style: TextStyle(color: Color.fromARGB(255, 55, 111, 60) ),)),
               dense: true, selectedTileColor: Colors.grey,),*/
          ])),
        ]));
  }
}
