import 'package:flutter/material.dart';

class PlaceHolder extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/images/Group 2.png',
            height: 160,
          )),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'O referido formulário encontra-se em estado de desenvolvimento!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
             const SizedBox(
            height: 25,
          ),
          const SizedBox(
            width: 350,
            child: Text(
              'O formulário estará disponível para utilização em breve.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
              
            ),
          ),
          const SizedBox(height: 150),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/A');
            },
            child: Container(
              height: 55,
              width: 350,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: const Color.fromARGB(255, 55, 111, 60), width: 2)),
              child: const Text(
                'Voltar para a seleção de formulários',
                style: TextStyle(
                    color: const Color.fromARGB(255, 55, 111, 60),
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}

  