import 'package:flutter/material.dart';
import 'package:inventur/pages/password_recover/changepasswordsucess_page.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/validators/password_validator.dart';
import 'package:inventur/pages/widgets/text_field_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class MudarSenha extends StatefulWidget {

  MudarSenha({super.key, required this.email});
  final String email;
  @override
  State<MudarSenha> createState() => _MudarSenhaState();
}

class _MudarSenhaState extends State<MudarSenha> {
  final _formLoginKey = GlobalKey<FormState>();

  final PasswordValidator _passwordValidator = PasswordValidator();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  



  @override
  @override
  Widget build(BuildContext context) {
    //         final arguments = ModalRoute.of(context)?.settings.arguments as Map;

    // final int userId = arguments['user_id'];

    // Future<void> alterPassword() async{
    //   final response = await http.patch(
    //   Uri.parse('${AppConstants.BASE_URI}/api/v1/user/$userId/change-password/'),
    //   headers: {
    //     'Content-Type': 'application/json',
    //   },
    //   body: jsonEncode({'new_password': _passwordController.text}),
    //   );

    //   if(response.statusCode == 200){
    //     print("Senha alterada cm sucesso!");
    //                   Navigator.pushNamed(context, '/NewPassword');

    //   }else{
    //     print(_passwordController.text);
    //     print("Erro ao alterar a senha");
    //   }
    // }
       final screenSize = MediaQuery.sizeOf(context);
   Future<void> requestOtp(String password) async {
      String email = widget.email;
      try {
        final response = await http.post(
          Uri.parse('${AppConstants.BASE_URI}password-reset/change-password/'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'new_password': password}),
        );

        if (response.statusCode == 200) {
              print(response.body);
             Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return ConfirmacaoNovaSenha();
          }));

        } else {
          print(response.body);
        }
      } catch (e) {}
    }
    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),

            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Padding(
              //     padding: EdgeInsets.only(
              //       top: sizeScreen.height * 0.08,
              //       left: sizeScreen.height * 0.02,
              //       right: sizeScreen.height * 0.02,
              //       bottom: sizeScreen.height * 0.04,
              //     ),
              //     child: Center(
              //         child: Container(
              //             padding: EdgeInsets.only(
              //               top: sizeScreen.height * 0.02,
              //               left: sizeScreen.height * 0.02,
              //               right: sizeScreen.height * 0.02,
              //               bottom: sizeScreen.height * 0.008,
              //             ),
              //             height: sizeScreen.height * 0.28,
              //             margin: EdgeInsets.only(
              //               top: sizeScreen.height * 0.02,
              //               bottom: sizeScreen.height * 0.02,
              //             ),
              //             decoration: BoxDecoration(
              //                 color: Colors.grey[300],
              //                 borderRadius: BorderRadius.circular(15)),
              //             child: Column(
              //               children: [
              //                 Icon(
              //                   Icons.info,
              //                   size: sizeScreen.height * 0.08,
              //                   color: const Color.fromARGB(255, 55, 111, 60),
              //                 ),
              //                 SizedBox(height: sizeScreen.height * 0.02),
              //                 RichText(
              //                   textAlign: TextAlign.justify,
              //                   text: TextSpan(
              //                     text:
              //                         'Para garantir a segurança da sua conta, enviaremos um código de 6 dígitos para o e-mail cadastrado. Por favor, insira o código no aplicativo. O código tem validade de 15 minutos.',
              //                     style: TextStyle(
              //                       color: Colors.black,
              //                       fontSize: sizeScreen.height * 0.02,
              //                     ),
              //                   ),
              //                 )
              //               ],
              //             )))),
              SizedBox(
                height: screenSize.height * 0.35,
              ),
              Padding(
                  padding:  const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Container(
                    child: Form(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Form(
                    key: _formLoginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                       
                        SizedBox(height: screenSize.height * 0.02),
                        CustomTextField(
                          isSecret: true,
                          labelText: 'Nova senha',
                          controller: _passwordController,
                          prefixIcon: Icons.lock,
                           validator: (password) {
                            if(password == null){
                              return 'Preencha o campo!';
                            }
                             return _passwordValidator.validate(password: password);
                             
                           },
                        ),
                        SizedBox(height: screenSize.height * 0.02),

                         CustomTextField(
                          isSecret: true,
                          labelText: 'Confirmar senha',
                          controller: _passwordController2,
                          prefixIcon: Icons.lock,
                            validator: (value) {
                                                    if (value == null || value.isEmpty) {
                    return 'Insira uma senha válida';
                  }else if(_passwordController.text != _passwordController2.text){
                    return 'As senhas precisam ser iguais!';
                  }
                  return null;
                                 }, 
                          
                        ),
                        SizedBox(height: screenSize.height * 0.02),

                      ],
                    )),
                
             
              SizedBox(
                height: 50,
                width: 300,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: ()async {
          if (_formLoginKey.currentState?.validate() ?? false) {

                 if(_passwordController.text == _passwordController2.text ){
                     requestOtp(_passwordController2.text);
                    }
                    
                    else{
                        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('As senhas não coincidem!')));
                    }


                  }
                   
                  },
                  child: const Text(
                    'CONFIRMAR',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.02,
              ),
              SizedBox(
                  height: 50,
                  width: 300,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () =>
                          {Navigator.pop(context, '/PassWordRecover')},
                      child: const Text(
                        'CANCELAR',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      )))
            ]))))])));
  }
}
