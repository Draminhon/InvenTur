import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterConfimation extends StatelessWidget {
  const RegisterConfimation({super.key});

  @override
 Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              'assets/images/correto.png',
              height: 160,
            )),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Tudo certo!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
               const SizedBox(
              height: 25,
            ),
            const SizedBox(
              width: 350,
              child: Text(
                'Seu cadastro foi concluído com sucesso',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
                
              ),
            ),
            const SizedBox(height: 150),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/Login');
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
                  'Voltar para a tela inicial',
                  style: TextStyle(
                      color: Color.fromARGB(255, 55, 111, 60),
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
