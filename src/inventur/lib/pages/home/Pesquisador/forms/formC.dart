import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_form.dart';

class FormularioC extends StatelessWidget {
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
                  'CATEGORIA C',
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
              form: 'Zona Costeira',
            ),
            ContainerA(form: 'Hidrografia'),
            ContainerA(form: 'Unidades de conservação'),
            ContainerA(form: 'Conjuntos arquitetônicos'),
            ContainerA(form: 'Sítios etc'),
            ContainerA(form: 'Lugares de manifestação da fé'),
            ContainerA(form: 'Obras de interesse artístico'),
            ContainerA(form: 'Ruínas, teatros, centros culturais e cineclubes'),
            ContainerA(form: 'Gastronomia, artesanato e trabalhos manuais'),
            ContainerA(form: 'Formas de expressão'),
            ContainerA(form: 'Personalidades'),
            ContainerA(form: 'Atividades econômicas'),
            ContainerA(form: 'Atrações técnicas e ciêntificas'),
            ContainerA(form: 'Eventos programados'),
            ExpansionTileA(titulo: 'Relevos', minhaLista: [
              Tilee(texto: 'Relevo continental'),
              Tilee(texto: 'Relevo cárstico'),
              SizedBox(),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Arquiteturas', minhaLista: [
              Tilee(texto: 'Arquitetura oficial, militar e religiosa'),
              Tilee(texto: 'Arquitetura industrial, agrícola e funerária'),
               Tilee(texto: 'Arquitetura civil'),
              SizedBox()
            ]),
            
            

            /*ListTile(title: (Text('aiii', textAlign: TextAlign.center,
                 style: TextStyle(color: Color.fromARGB(255, 55, 111, 60) ),)),
               dense: true, selectedTileColor: Colors.grey,),*/
          ])),
        ]));
  }
}
