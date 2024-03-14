import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_form.dart';

class FormularioB extends StatelessWidget {
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
                  icon: Icon(Icons.arrow_back),
                  padding: EdgeInsets.only(bottom: sizeScreen.height * 0.005),
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(vertical: sizeScreen.height * 0.01),
            child: Column(
              children: [
                Text(
                  'CATEGORIA B',
                  style: TextStyle(
                      color: Color.fromARGB(255, 55, 111, 60),
                      fontSize: sizeScreen.width * 0.06),
                ),
                Divider(
                  color: Color.fromARGB(255, 55, 111, 60),
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
            ContainerA(
              form: 'Parques',
            ),
            ContainerA(form: 'Informações turísticas'),
            ContainerA(form: 'Entidades associativas e similares'),
            ContainerA(form: 'Guiamento e condução artística'),
            ExpansionTileA(titulo: 'Serviços e equipamentos', minhaLista: [
              Tilee(texto: 'Serviços e equipamentos de agências de turismo'),
              Tilee(texto: 'Serviços e equipamentos de transporte turístico'),
              Tilee(texto: 'Serviços e equipamentos para alimentos e bebidas'),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Eventos', minhaLista: [
              Tilee(texto: 'Espaços para eventos'),
              Tilee(texto: 'Serviços para eventos'),
              SizedBox(),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Instalações', minhaLista: [
              Tilee(texto: 'Instalações esportivas'),
              Tilee(texto: 'Instalações náuticas'),
              SizedBox(),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Espaços', minhaLista: [
              Tilee(texto: 'Espaços livres e áreas verde'),
              Tilee(texto: 'Espaços de diversão e cultura'),
              Tilee(texto: 'Outros espaços de recreação'),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Hospedagem', minhaLista: [
              Tilee(texto: 'Meios de hospedagem'),
              Tilee(texto: 'Outros tipos de acomodações'),
              SizedBox(),
              SizedBox()
            ]),

            /*ListTile(title: (Text('aiii', textAlign: TextAlign.center,
                 style: TextStyle(color: Color.fromARGB(255, 55, 111, 60) ),)),
               dense: true, selectedTileColor: Colors.grey,),*/
          ])),
        ]));
  }
}
