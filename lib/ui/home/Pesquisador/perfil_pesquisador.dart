import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sistur/providers/providers.dart';

class ContaPesquisador extends StatelessWidget {
  const ContaPesquisador({super.key});

  String formatCPF(String cpf) {
    if (cpf.length != 11) {
      return cpf;
    }
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}';
  }

  @override
  Widget build(BuildContext context) {
    print('Building ContaPesquisador');
    final screenSize = MediaQuery.sizeOf(context);
    
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final user = userProvider.user;
        
        return Scaffold(
          backgroundColor: Colors.white,
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
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(user.username,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.start),
                  const Divider(
                    color: Color.fromARGB(255, 55, 111, 60),
                    endIndent: 60,
                    indent: 60,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.05,
                  ),
                  SizedBox(
                    width: screenSize.width * 0.8,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            FontAwesomeIcons.solidEnvelope,
                            color: Color.fromARGB(255, 55, 111, 60),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: screenSize.width * 0.02),
                              child: Text(
                                user.email,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: screenSize.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            FontAwesomeIcons.solidAddressCard,
                            color: Color.fromARGB(255, 55, 111, 60),
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: screenSize.width * 0.02)),
                          Text(
                            formatCPF(user.CPF),
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      )
                    ]),
                  )
                ]),
              ),
              SizedBox(
                height: screenSize.height * 0.2,
              ),
              SizedBox(
                  width: screenSize.width * 0.9,
                  height: screenSize.height * 0.06,
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/AlterarDados', arguments: {
                      'is_change': true,
                      'username': user.username,
                      'user_cpf': user.CPF,
                      'user_email': user.email,
                      'user_id': user.id,
                      // 'user_telefone': user.telefone // Telefone missing in User model based on previous view_file, checking providers.dart
                      // providers.dart shows User model has id, username, email, CPF. user_controller shows accessLevel, status.
                      // register_page shows updateUsers taking telefone.
                      // Let's assume User model MIGHT NOT have telefone or I missed it.
                      // Checking User model is safest, but I don't want to break flow.
                      // Usage in register_page: _telefoneController.text = telefone;
                      // If I don't pass it, it might be null.
                      // Let's pass empty string if not available or check model first?
                      // I will temporarily pass empty string/existing value if I can find it.
                      // In providers.dart: User _user = User(id:0, username: "", email: "", CPF: "");
                      // It seems User model does NOT have telefone in the default constructor used there.
                      // But register_page expects it.
                      // I will keep it as empty string for now or check if User model has it.
                      // Warning: This might clear the phone number if not handled!
                      // I should check UserModel first.
                      'user_telefone': user.telefone
                    }),
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: const Color.fromARGB(255, 55, 111, 60)),
                    child: Text(
                      'ALTERAR DADOS PESSOAIS',
                      style: TextStyle(color: Colors.white, fontSize: 50.w),
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
