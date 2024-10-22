import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AlterarCadastro extends StatelessWidget {
  const AlterarCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            padding: EdgeInsets.only(top: sizeScreen.height * 0.15),
            child: Padding(
                padding: EdgeInsets.only(
                  left: sizeScreen.width * 0.05,
                  right: sizeScreen.width * 0.05,
                ),
                child: Container(
                  child: Form(
                      child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 55, 111, 60),
                            ),
                            enabledBorder: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  width: 2,
                                    color: Color.fromARGB(255, 55, 111, 60),
                                    style: BorderStyle.solid)),
                            hintText: 'nome',
                            isDense: true,
                            contentPadding:
                                EdgeInsets.all(sizeScreen.height * 0.015),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: sizeScreen.height * 0.02,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.solidAddressCard,
                              color: Color.fromARGB(255, 55, 111, 60),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                   width: 2,
                                    color: Color.fromARGB(255, 55, 111, 60),
                                    style: BorderStyle.solid)),
                            hintText: 'cpf',
                            isDense: true,
                            contentPadding:
                                EdgeInsets.all(sizeScreen.height * 0.015),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: sizeScreen.height * 0.02,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.solidEnvelope,
                              color: Color.fromARGB(255, 55, 111, 60),
                            ),
                            enabledBorder: OutlineInputBorder(
                              
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                   width: 2,
                                    color: Color.fromARGB(255, 55, 111, 60))),
                            hintText: 'email',
                            isDense: true,
                            contentPadding:
                                EdgeInsets.all(sizeScreen.height * 0.015),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: sizeScreen.height * 0.02,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 55, 111, 60),
                            ),
                            enabledBorder: OutlineInputBorder(
                              
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                   width: 2,
                                    color: Color.fromARGB(255, 55, 111, 60))),
                            hintText: 'nova senha',
                            isDense: true,
                            contentPadding:
                                EdgeInsets.all(sizeScreen.height * 0.015),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: sizeScreen.height * 0.02,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromARGB(255, 55, 111, 60),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                 width: 2,
                                  color: Color.fromARGB(255, 55, 111, 60)),
                            ),
                            hintText: 'confirmar senha',
                            isDense: true,
                            contentPadding:
                                EdgeInsets.all(sizeScreen.height * 0.015),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(
                        height: sizeScreen.height * 0.15,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 1,
                                height: sizeScreen.height * 0.06,
                          child: OutlinedButton(
                              onPressed: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        content: SizedBox(
                                      height: sizeScreen.height * 0.1,
                                      child: Text(
                                        "Dados alterados com sucesso!",
                                        style: TextStyle(
                                            fontSize: sizeScreen.width * 0.05),
                                      ),
                                    ));
                                  }),
                              style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 55, 111, 60),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text(
                                'CONFIRMAR ALTERAÇÕES',
                                style: TextStyle(color: Colors.white),
                              ))),
                      SizedBox(
                        height: sizeScreen.height * 0.03,
                      ),
                      SizedBox(
                        height: sizeScreen.height * 0.06,
                          width: sizeScreen.width * 1,
                          child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10))),
                              child: const Text(
                                'CANCELAR',
                                style: TextStyle(color: Colors.white),
                              )))
                    ],
                  )),
                ))));
  }
}
