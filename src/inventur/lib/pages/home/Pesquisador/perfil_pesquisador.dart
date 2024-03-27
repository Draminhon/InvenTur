import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContaPesquisador extends StatelessWidget {
  const ContaPesquisador({super.key});

  @override
  Widget build(BuildContext context) {
    final  screenSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
           CircleAvatar(
            maxRadius: screenSize.height * 0.15,
            child: Icon(
              Icons.person,
              size: screenSize.height * 0.15,
            ),
          ),
          Container(
            
            padding: EdgeInsets.only(top: screenSize.height * 0.03),
            child:  Column(mainAxisAlignment: MainAxisAlignment.end,children: [
              const Text(
                'Fulano da Silva',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.start
              ),
              const Divider(
                color: Color.fromARGB(255, 55, 111, 60),
                endIndent: 60,
                indent: 60,
              ),
              SizedBox(height: screenSize.height * 0.05,),
             
             Container(
              width: screenSize.width * 0.8,
              child: 
              Column(children: [
               Row(mainAxisAlignment: MainAxisAlignment.start,children:[
              Icon(FontAwesomeIcons.solidEnvelope, color: Color.fromARGB(255, 55, 111, 60),),
              Padding(padding: EdgeInsets.only(left: screenSize.width * 0.02), child: 
              Text('fulanodasilva@gmail.com', style: TextStyle(fontSize: 18),)
              )
             ],),

              SizedBox(height: screenSize.height * 0.02,),
              Row(mainAxisAlignment: MainAxisAlignment.start,children: [
              Icon(FontAwesomeIcons.solidAddressCard, color: Color.fromARGB(255, 55, 111, 60),),
              Padding(padding: EdgeInsets.only(left: screenSize.width * 0.02)),
              Text('123.456.789-10',  style: TextStyle(fontSize: 18),)
            
             ],)
             ]),
            
        
              
            )  ]),
          )
          ,
          SizedBox(height: screenSize.height * 0.2,),
          SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: () => Navigator.pushNamed(context, '/AlterarDados'),
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
      ));
    
  }
}
