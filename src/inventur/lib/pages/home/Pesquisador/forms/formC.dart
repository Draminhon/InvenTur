import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_form.dart';

class FormularioC extends StatelessWidget {
  const FormularioC({super.key});

  @override
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
                  'CATEGORIA C',
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
              form: 'Zona Costeira',
            ),
            const ContainerA(form: 'Hidrografia'),
            const ContainerA(form: 'Unidades de conservação'),
            const ContainerA(form: 'Conjuntos arquitetônicos'),
            const ContainerA(form: 'Sítios etc'),
            const ContainerA(form: 'Lugares de manifestação da fé'),
           // ContainerA(form: 'Obras de interesse artístico'),
         //   ContainerA(form: 'Ruínas, teatros, centros culturais e cineclubes'),
            const ContainerA(form: 'Gastronomia, artesanato e trabalhos manuais'),
            const ContainerA(form: 'Formas de expressão'),
            const ContainerA(form: 'Personalidades'),
        //    ContainerA(form: 'Atividades econômicas'),
            const ContainerA(form: 'Atrações técnicas e ciêntificas'),
            const ContainerA(form: 'Eventos programados'),
            ExpansionTileA(titulo: 'Relevos', minhaLista: const [
              Tilee(texto: 'Relevo continental', routeName: '/Placeholder'),
              Tilee(texto: 'Relevo cárstico', routeName: '/Placeholder'),
              SizedBox(),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Arquiteturas', minhaLista: const [
              Tilee(texto: 'Arquitetura oficial, militar e religiosa', routeName: '/Placeholder'),
              Tilee(texto: 'Arquitetura industrial, agrícola e funerária', routeName: '/Placeholder'),
               Tilee(texto: 'Arquitetura civil', routeName: '/Placeholder'),
              SizedBox()
            ]),
            
            

            /*ListTile(title: (Text('aiii', textAlign: TextAlign.center,
                 style: TextStyle(color: Color.fromARGB(255, 55, 111, 60) ),)),
               dense: true, selectedTileColor: Colors.grey,),*/
          ])),
        ]));
  }
}
