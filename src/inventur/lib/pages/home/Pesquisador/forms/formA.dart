import 'package:flutter/material.dart';

class FormularioA extends StatelessWidget{
  const FormularioA({super.key});

  @override
  Widget build(BuildContext context) {
      final sizeScreen = MediaQuery.sizeOf(context);
      
   return Scaffold(
   
          backgroundColor: const Color.fromARGB(255, 245, 245, 245),
    body: Column(children: [
      
      Padding(padding: EdgeInsets.only(right: sizeScreen.width * 0.85, top: sizeScreen.height * 0.05),child: 
      SizedBox(height: sizeScreen.height * 0.03,
      child: 
      IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back), padding: EdgeInsets.only(bottom: sizeScreen.height * 0.005),),
      )),

      Padding(padding: EdgeInsets.symmetric(vertical: sizeScreen.height * 0.01), child: 
      Column(children: [Text('CATEGORIA A', 
      style: TextStyle(color: const Color.fromARGB(255, 55, 111, 60), fontSize: sizeScreen.width * 0.06)),
        Divider(color: const Color.fromARGB(255, 55, 111, 60), 
        indent: sizeScreen.width * 0.1,
        endIndent: sizeScreen.width * 0.1,)
      ],)
      )

   ]));



  }

}