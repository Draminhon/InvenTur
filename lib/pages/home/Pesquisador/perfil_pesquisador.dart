import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContaPesquisador extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userCPF;
  const ContaPesquisador(
      {super.key,
      required this.userName,
      required this.userEmail,
      required this.userCPF});

  String formatCPF(String cpf) {
    if (cpf.length != 11) {
      return cpf;
    }
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}';
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
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
                Text(userName,
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
                              userEmail,
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
                          formatCPF(userCPF),
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
                    'username': userName,
                    'user_cpf': userCPF,
                    'user_email': userEmail
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
        ));
  }
}
