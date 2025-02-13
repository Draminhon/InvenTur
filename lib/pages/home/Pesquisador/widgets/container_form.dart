import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerA extends StatelessWidget {
  final String form, routeName;
  const ContainerA({super.key, required this.form, required this.routeName});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, routeName);
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 29.92.h, left: 134.4.w, right: 134.4.w),
          height: 200.52.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [const Color.fromARGB(255, 55, 111, 60), const Color.fromARGB(255, 77, 156, 84)]),
            borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 0.5),
              color: const Color.fromARGB(255, 55, 111, 60),
              boxShadow: [
                // BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     blurRadius: 5,
                //     spreadRadius: 2,
                //     offset: const Offset(0, 3))
              ]),
          child:  Center(
            child: Text(
                  form,
                  textAlign: TextAlign.center,
                  style:  TextStyle(
                fontSize: 55.w,
                      
                      color: Colors.white,
                      fontWeight: FontWeight.w900),
                ),
          )),
    );
  }
}

class Tilee extends StatelessWidget {
  @override
  final String texto, routeName;

  const Tilee({super.key, required this.texto, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, routeName);
      },
      child: Container(
            margin: EdgeInsets.only(bottom: 29.92.h),
            padding: EdgeInsets.symmetric(horizontal: 30.w, ),
            height: 209.52.h,
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  // BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     blurRadius: 5,
                  //     spreadRadius: 2,
                  //     offset: const Offset(0, 3))
                ]),
            child:  Center(
              child: Text(
                    texto,
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                  fontSize: 50.w,
                       
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                  ))),
    );
  }
}

// ignore: must_be_immutable
class ExpansionTileA extends StatefulWidget {
  final String titulo;
  List minhaLista = [];

  ExpansionTileA({super.key, required this.titulo, required this.minhaLista});

  @override
  State<ExpansionTileA> createState() => _ExpansionTileA();
}

class _ExpansionTileA extends State<ExpansionTileA> {
  @override
  Widget build(BuildContext context) {
    final String titulo = widget.titulo;
    List minhaLista = widget.minhaLista;

    return Column(
  children: [
    Container(
      margin: EdgeInsets.only(
        bottom: 29.92.h,
        left: 134.4.w,
        right: 134.4.w,
      ),
      decoration: BoxDecoration(
        
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5),
        color: const Color.fromARGB(255, 55, 111, 60),
            gradient: LinearGradient(colors: [const Color.fromARGB(255, 55, 111, 60), const Color.fromARGB(255, 77, 156, 84)]),
        
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // Remove linha entre itens
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 67.2.w, // Alinha título e ícone com os filhos
          ),
          child: ExpansionTile(
            
            minTileHeight:    200.52.h,
            dense: true,
            collapsedIconColor: Colors.white,
            iconColor: Colors.white,
            title: Text(
                titulo,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white, // Cor do texto para combinar com o botão
                  fontWeight: FontWeight.w900,
                  fontSize: 55.w
                ),
              ),
            
            tilePadding: EdgeInsets.only(left: 130.44.w),
            collapsedBackgroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            childrenPadding: EdgeInsets.zero, // Mantém alinhado com o título
            children: <Widget>[
              minhaLista[0],
              minhaLista[1],
              minhaLista[2],
              minhaLista[3],
            ],
          ),
        ),
      ),
    ),
  ],
);


  }
}
