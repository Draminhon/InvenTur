import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

class UpdatedForm extends StatelessWidget {
  const UpdatedForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Formulário atualizado com sucesso!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
             const SizedBox(
            height: 25,
          ),
          const SizedBox(
            width: 350,
            child: Text(
              'O formulário foi atualizado com sucesso.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
              
            ),
          ),
          const SizedBox(height: 150),
          GestureDetector(
            onTap: () {
                           Navigator.pop(context);

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

class UpdatedFormError extends StatelessWidget {
  const UpdatedFormError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/images/close.png',
            height: 160,
          )),
          const SizedBox(
            height: 50,
          ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 100.w),
              child: Text(
                'Ocorreu um erro ao atualizar o formulário!',
                style: TextStyle(fontSize:80.w, fontWeight: FontWeight.w600),
              textAlign: TextAlign.justify,
              ),
            ),
             const SizedBox(
            height: 25,
          ),
          const SizedBox(
            width: 350,
            child: Text(
              'Entre em contato com um administrador ou tente novamente.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
              
            ),
          ),
          const SizedBox(height: 150),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
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