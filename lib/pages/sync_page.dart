import 'package:flutter/material.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/images/sync.png',  
            height: 160,
          )),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Formulário salvo com sucesso!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
             const SizedBox(
            height: 25,
          ),
          const SizedBox(
            width: 350,
            child: Text(
              'O formulário foi salvo localmente, conecte-se à internet e realize a sincronização.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
              
            ),
          ),
          const SizedBox(height: 150),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/PesquisadorHome');
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
    );
  }

}