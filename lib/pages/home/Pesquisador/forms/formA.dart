import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_form.dart';

class FormularioA extends StatelessWidget {
  const FormularioA({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor:Colors.white,
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
                      fontSize: sizeScreen.width * 0.06,
                      fontWeight: FontWeight.bold),
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
              form: 'Informações básicas do município', routeName: '/Placeholder',
            ),
            // const ContainerA(form: 'Locadoras de imóveis para temporadas'),
            // const ContainerA(form: 'Compras especiais'),
            const ContainerA(form: 'Comércio turístico', routeName: '/Placeholder',),
            
            // const ContainerA(form: 'Representações diplomáticas'),
            // ExpansionTileA(titulo: 'Serviços', minhaLista: [
            //   Tilee(texto: 'Serviços bancários', routeName: '/Placeholder'),
            //   Tilee(texto: 'Serviços mecânicos e postos de combustível', routeName: '/Placeholder'),
            //   const SizedBox(),
            //   const SizedBox()
            // ]),
            ExpansionTileA(titulo: 'Rodoviário', minhaLista: const [
              Tilee(texto: 'Rodovia', routeName: '/Rodovia'),
              Tilee(texto: 'Estação rodoviária', routeName: '/Placeholder'),
              SizedBox(),
              SizedBox()
            ]),
            // ExpansionTileA(titulo: 'Ferroviário', minhaLista: [
            //   Tilee(texto: 'Ferrovia e metrovia', routeName: '/Placeholder'),
            //   Tilee(texto: 'Estação ferroviária', routeName: '/Placeholder'),
            //   const SizedBox(),
            //   const SizedBox()
            // ]),
            // ExpansionTileA(titulo: 'Aeroviário', minhaLista: [
            //   Tilee(texto: 'Aeroporto e campo de pouso', routeName: '/Placeholder'),
            //   Tilee(texto: 'Heliporto', routeName: '/Placeholder'),
            //   const SizedBox(),
            //   const SizedBox()
            // ]),
            // ExpansionTileA(titulo: 'Aquaviário', minhaLista: [
            //   Tilee(texto: 'Hidrovia', routeName: '/Placeholder'),
            //   Tilee(texto: 'Porto, pier, cais, etc', routeName: '/Placeholder'),
            //   const SizedBox(),
            //   const SizedBox()
            // ]),
            ExpansionTileA(
              titulo: 'Sistemas',
              minhaLista: const [
                SizedBox(),
                Tilee(
                  texto: 'Sistemas de segurança', routeName: '/SistemaDeSeguranca'
                ),
                Tilee(
                  texto: 'Sistemas de saúde', routeName: '/Placeholder'
                ),
               SizedBox(),
              ],
            ),

            /*ListTile(title: (Text('aiii', textAlign: TextAlign.center,
                 style: TextStyle(color: Color.fromARGB(255, 55, 111, 60) ),)),
               dense: true, selectedTileColor: Colors.grey,),*/
          ])),
        ]));
  }
}
