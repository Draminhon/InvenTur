import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          // if (_formKey.currentState!.validate()) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text('processing data')));
          // } else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(content: Text('preencha os dados!')));
          // }
          Navigator.pushReplacementNamed(context, '/SendedForm');
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.green[800],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          'Enviar',
          style: TextStyle(
              color: Colors.white, fontSize: 25), // Use um fontSize fixo
        ),
      ),
    );
  }
}

class SendedFormPage extends StatelessWidget {
  const SendedFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/images/Group 1.png',
            height: 160,
          )),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Formulário enviado com sucesso!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
             const SizedBox(
            height: 25,
          ),
          const SizedBox(
            width: 350,
            child: Text(
              'O formulário estará disponível para visualização em sua respectiva pesquisa.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
              
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
