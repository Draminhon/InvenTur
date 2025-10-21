import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_form.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/sizedBox.dart';

class FormularioB extends StatelessWidget {
  const FormularioB({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        body: Column(children: [
          Padding(
              padding: EdgeInsets.only(
                  right: 1142.5.w,
                  top: 149.6.h),
              child: SizedBox(
                height: 89.76.h,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon:  Icon(Icons.arrow_back, size: 96.h,),
                  padding: EdgeInsets.only(bottom: 14.96.h),
                ),
              )),
           Padding(
            padding: EdgeInsets.symmetric(vertical: 29.92.h),
            child: Column(
              children: [
                Text(
                  'CATEGORIA B',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 55, 111, 60),
                      fontSize: 80.64.w,
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  indent: 134.4.w,
                  endIndent: 134.4.w,
                ),
                SizedBox(
                  height: 5.984.h,
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(children: [
            const ContainerA(
              form: 'Parques', routeName: '/Placeholder',
            ),
            // const ContainerA(form: 'Informações turísticas'),
            // const ContainerA(form: 'Entidades associativas e similares'),
            // const ContainerA(form: 'Guiamento e condução artística'),
            ExpansionTileA(titulo: 'Serviços e equipamentos', minhaLista: const [
              Tilee(texto: 'Serviços e equipamentos de agências de turismo', routeName: '/Placeholder'),
              Tilee(texto: 'Serviços e equipamentos de transporte turístico', routeName: '/Placeholder'),
              Tilee(texto: 'Serviços e equipamentos para alimentos e bebidas', routeName: '/AlimentosEbebidas'),
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
              //Tilee(texto: 'Instalações náuticas', routeName: '/Placeholder'),
              SizedBox(),
              SizedBox(),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Espaços', minhaLista: const [
             // Tilee(texto: 'Espaços livres e áreas verde', routeName: '/Placeholder'),
              Tilee(texto: 'Espaços de diversão e cultura', routeName: '/Placeholder'),
              //Tilee(texto: 'Outros espaços de recreação', routeName: '/Placeholder'),
              SizedBox(),
              SizedBox(),
              SizedBox()
            ]),
            ExpansionTileA(titulo: 'Hospedagem', minhaLista: const [
              Tilee(texto: 'Meios de hospedagem',routeName:'/MeiosDeHospedagem'),
              Tilee(texto: 'Outros tipos de acomodações', routeName: '/OutrasAcomodacoes',),
              SizedBox(),
              SizedBox()
            ]),
            ContainerA(form: 'Informações Turísticas', routeName: '/Placeholder'),
            ContainerA(form: 'Entidades associativas e similares', routeName: '/Placeholder'),
            ContainerA(form: 'Guiamento e condução turística', routeName: '/Placeholder'),



            /*ListTile(title: (Text('aiii', textAlign: TextAlign.center,
                 style: TextStyle(color: Color.fromARGB(255, 55, 111, 60) ),)),
               dense: true, selectedTileColor: Colors.grey,),*/
          ])),
        ]));
  }
}
