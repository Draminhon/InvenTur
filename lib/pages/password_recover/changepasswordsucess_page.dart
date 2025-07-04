import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class ConfirmacaoNovaSenha extends StatelessWidget {
  const ConfirmacaoNovaSenha({super.key});


  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        
        body: 
                Column(children: [
      Padding(
          padding: const EdgeInsets.only(top: 150, left: 45, right: 45, bottom: 145),
          child: Center(
          child: Container(
             
              height: sizeScreen.height * 0.23,
              width: sizeScreen.width * 0.7,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.circular(15)),
              
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/check1.png',
                    height: sizeScreen.height * 0.06,
                    width: sizeScreen.width,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Sua senha foi alterada com sucesso',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              )))),
      SizedBox(
          height: 55,
          width: 1200.w,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => {Navigator.pushNamed(context, '/Login')},
              child: const Text(
                'VOLTAR À TELA INICIAL',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )))
    ]));
  }
}
