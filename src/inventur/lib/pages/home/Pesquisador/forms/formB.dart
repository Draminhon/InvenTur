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
                  icon: const Icon(Icons.arrow_back),
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
              form: 'Parques',
            ),
            const ContainerA(form: 'Informações turísticas'),
            const ContainerA(form: 'Entidades associativas e similares'),
            const ContainerA(form: 'Guiamento e condução artística'),
            ExpansionTileA(titulo: 'Serviços e equipamentos', minhaLista: const [
              Tilee(texto: 'Serviços e equipamentos de agências de turismo', routeName: '/Placeholder'),
              Tilee(texto: 'Serviços e equipamentos de transporte turístico', routeName: '/Placeholder'),
              Tilee(texto: 'Serviços e equipamentos para alimentos e bebidas', routeName: '/Placeholder'),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Eventos', minhaLista: const [
              Tilee(texto: 'Espaços para eventos', routeName: '/Placeholder'),
              Tilee(texto: 'Serviços para eventos', routeName: '/Placeholder'),
              SizedBox(),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Instalações', minhaLista: const [
              Tilee(texto: 'Instalações esportivas', routeName: '/Placeholder'),
              Tilee(texto: 'Instalações náuticas', routeName: '/Placeholder'),
              SizedBox(),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Espaços', minhaLista: const [
              Tilee(texto: 'Espaços livres e áreas verde', routeName: '/Placeholder'),
              Tilee(texto: 'Espaços de diversão e cultura', routeName: '/Placeholder'),
              Tilee(texto: 'Outros espaços de recreação', routeName: '/Placeholder'),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Hospedagem', minhaLista: const [
              Tilee(texto: 'Meios de hospedagem',routeName:'/MeiosDeHospedagem'),
              Tilee(texto: 'Outros tipos de acomodações', routeName: '/Placeholder',),
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
