import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/validators/email_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:inventur/pages/widgets/text_field_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ConfirmarCodigo extends StatefulWidget {
  ConfirmarCodigo({super.key});

  @override
  State<ConfirmarCodigo> createState() => _ConfirmarCodigoState();
}

class _ConfirmarCodigoState extends State<ConfirmarCodigo> {
  final _formLoginKey = GlobalKey<FormState>();
  final EmailValidator _emailValidator = EmailValidator();
    final TextEditingController _emailController = TextEditingController();


 

  @override
  Widget build(BuildContext context) {
     Future<void> verificarCPF() async {

      var email = _emailController.text;
    

    final url = Uri.parse('${AppConstants.BASE_URI}/api/v1/verificarcpf/');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
          print(responseData['user']['id']);
          Navigator.pushNamed(context, '/MudarSenha', arguments: {'user_id': responseData['user']['id']});
      }  else if(response.statusCode == 404){
           ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('O Email informado não existe')),
        );
        } 
      
      else {
      
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ocorreu um erro ao verificar o Email')),
        );
      }
    } catch (e) {
      print(e);
    }
  }
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: sizeScreen.height * 0.35),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Form(
                key: _formLoginKey,
                child:      CustomTextField(
                                labelText: 'Informe seu E-mail',
                                controller: _emailController,
                                prefixIcon: FontAwesomeIcons.solidEnvelope,
                                keyboardType: TextInputType.emailAddress,
                                 validator: (email) {
                                   return _emailValidator.validate(email: email);
                                 },
                              ),
              ),
            ),
            SizedBox(height: sizeScreen.height * 0.13),
            SizedBox(
              height: 50,
              width: 300,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  if (_formLoginKey.currentState?.validate() ?? false) {
                    await verificarCPF();
                  }
                },
                child: const Text(
                  'CONFIRMAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            SizedBox(height: sizeScreen.height * 0.04),
            SizedBox(
              height: 50,
              width: 300,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'CANCELAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}