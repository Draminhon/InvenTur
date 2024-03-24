import 'package:flutter/material.dart';

class ContaPesquisador extends StatelessWidget {
  const ContaPesquisador({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          const CircleAvatar(
            maxRadius: 115,
            child: Icon(
              Icons.person,
              size: 165,
            ),
          ),
          Container(
            
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: const Column(children: [
              Text(
                'nome: Fulano da Silva',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Divider(
                color: const Color.fromARGB(255, 55, 111, 60),
                endIndent: 60,
                indent: 60,
              ),
              Text(
                'email: fulanodasilva@gmail.com',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
             
              
              Text(
                'CPF: 123.456.789-10',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.start,
              ),
              
            ]),
          ),
          SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: () => print('sex'),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: const Color.fromARGB(255, 55, 111, 60)),
                child: const Text(
                  'ALTERAR DADOS PESSOAIS',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      )),
    );
  }
}
