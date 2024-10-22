import 'package:flutter/material.dart';

import 'package:inventur/validators/password_validator.dart';


class ConfirmacaoNovaSenha extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
        body: 
                Column(children: [
      Padding(
          padding: const EdgeInsets.only(top: 150, left: 45, right: 45, bottom: 145),
          child: Center(
          child: Container(
             
              height: sizeScreen.height * 0.23,
              width: sizeScreen.width * 0.7,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
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
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              )))),
      SizedBox(
          height: 50,
          width: 300,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 55, 111, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => {Navigator.pushNamed(context, '/Login')},
              child: const Text(
                'VOLTAR À TELA INICIAL',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              )))
    ]));
  }
}
