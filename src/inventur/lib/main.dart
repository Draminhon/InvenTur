import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventur/pages/auth/login_page.dart';
import 'package:inventur/pages/auth/register_page.dart';
import 'package:inventur/pages/home/Administrador/admin_home_page.dart';
import 'package:inventur/pages/pesquisas/register_pesquisa_page.dart';
import 'package:inventur/pages/recover/changepasswordsucess_page.dart';
import 'package:inventur/pages/home/Pesquisador/choose/choosebetween.dart';
import 'package:inventur/pages/home/Pesquisador/pesquisador_homepage.dart';
import 'package:inventur/pages/home/Pesquisador/pesquisas.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formA.dart';
import 'package:inventur/pages/recover/changepassword_page.dart';
import 'package:inventur/pages/recover/passwordcod_page.dart';
import 'package:inventur/pages/recover/passwordrecover_page.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formB.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formC.dart';
import 'package:inventur/pages/home/Pesquisador/perfil_pesquisador.dart';
import 'package:inventur/pages/home/Pesquisador/alterarDados-pesquisador.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/meiosDeHospedagem.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/placeholder.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/alimentos_e_bebidas.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InvenTur',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        fontFamily: GoogleFonts.aBeeZee().fontFamily,
      ),
      home: const LoginPage(),
      routes: {
        '/Login': (_) => const LoginPage(),
        '/Register': (_) => RegisterPage(),
        '/AdminHome': (_) => const AdminHomePage(),
        '/RegisterPesquisa': (_) => RegisterPesquisa(),
        '/PassWordRecover': (_) => RecuperarSenha(),
        '/ConfirmarCodigo': (_) => ConfirmarCodigo(),
        '/MudarSenha': (_) => MudarSenha(),
        '/NewPassword': (_) => ConfirmacaoNovaSenha(),
        '/Choose': (_) => Choose(),
        '/PesquisadorHome': (_) => PesquisadorHome(),
        '/Pesquisas': (_) => Pesquisas(),
        '/FormA': (_) => FormularioA(),
        '/FormB': (_) => FormularioB(),
        '/FormC': (_) => FormularioC(),
        '/A': (_) => A(),
        '/PerfilPesquisador': (_) => ContaPesquisador(),
        '/AlterarDados': (_) => AlterarCadastro(),
        '/MeiosDeHospedagem': (_) => MeiosDeHospedagem(),
        '/Placeholder': (_) => PlaceHolder(),
        '/AlimentosEbebidas': (_) => AlimentoseBebidas(),
      },
    );
  }
}
