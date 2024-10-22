import 'package:flutter/material.dart';

class Choose extends StatelessWidget{
  const Choose({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Padding(
          padding: EdgeInsets.only(top: 150, left: 45, right: 45, bottom: 145),
          child: Center(
              
                  child:
               
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      '----------TESTE----------\nSelecione qual área deseja acessar:',
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  )
                
              )),
      SizedBox(
          height: 50,
          width: 300,
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () => {Navigator.pushNamed(context, '/AdminHome')},
              child: const Text(
                'área ADM',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ))),
            const SizedBox(height: 25,),
          SizedBox(
            height: 50,
            width: 300,
              child: OutlinedButton(
                 style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                                    onPressed: () => {Navigator.pushNamed(context, '/PesquisadorHome')},
              child: const Text(
                'área pesquisador',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              )
              ),
          )
    ])));
  }

  }
