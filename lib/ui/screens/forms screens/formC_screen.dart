import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/ui/widgets/container_form.dart';

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
                  'CATEGORIA C',
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
            // const ContainerA(
            //   form: 'Zona Costeira', routeName: '/ZonaCosteira',
            // ),
            //const ContainerA(form: 'Hidrografia', routeName: '/Hidrografia',),
            const ContainerA(form: 'Unidades de conservação',routeName: '/Placeholder'),
           // const ContainerA(form: 'Conjuntos arquitetônicos',routeName: '/Placeholder'),
            //const ContainerA(form: 'Sítios etc',routeName: '/Placeholder'),
           // const ContainerA(form: 'Lugares de manifestação da fé',routeName: '/Placeholder'),
           // ContainerA(form: 'Obras de interesse artístico'),
         //   ContainerA(form: 'Ruínas, teatros, centros culturais e cineclubes'),
            const ContainerA(form: 'Gastronomia, artesanato e trabalhos manuais',routeName: '/Placeholder'),
           // const ContainerA(form: 'Formas de expressão',routeName: '/Placeholder'),
            //const ContainerA(form: 'Personalidades',routeName: '/Placeholder'),
        //    ContainerA(form: 'Atividades econômicas'),
            //const ContainerA(form: 'Atrações técnicas e ciêntificas',routeName: '/Placeholder'),
             const ContainerA(form: 'Eventos programados',routeName: '/Placeholder'),
            // ExpansionTileA(titulo: 'Relevos', minhaLista: const [
            //   Tilee(texto: 'Relevo continental', routeName: '/Placeholder'),
            //   Tilee(texto: 'Relevo cárstico', routeName: '/Placeholder'),
            //   SizedBox(),
            //   SizedBox()
            // ]),
            // ExpansionTileA(titulo: 'Arquiteturas', minhaLista: const [
            //   Tilee(texto: 'Arquitetura oficial, militar e religiosa', routeName: '/Placeholder'),
              // Tilee(texto: 'Arquitetura industrial, agrícola e funerária', routeName: '/Placeholder'),
            //    Tilee(texto: 'Arquitetura civil', routeName: '/Placeholder'),
            //   SizedBox()
            // ]),
            
            

            /*ListTile(title: (Text('aiii', textAlign: TextAlign.center,
                 style: TextStyle(color: Color.fromARGB(255, 55, 111, 60) ),)),
               dense: true, selectedTileColor: Colors.grey,),*/
          ])),
        ]));
  }
}
