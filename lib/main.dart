import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:inventur/pages/auth/login_page.dart';
import 'package:inventur/pages/auth/register_page.dart';
import 'package:inventur/pages/controllers/rodovia_controller.dart';
import 'package:inventur/pages/home/Administrador/admin_home_page.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsA/rodovia.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsA/sistema_de_seguran%C3%A7a.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/sendButton.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsC/hidrografia.dart';
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
 import 'dart:io';
import 'pages/home/Pesquisador/forms/formsC/zonaCosteira.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/helper/dependencies.dart' as dep;
import 'package:inventur/pages/home/Pesquisador/forms/UpdatedForm';
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


void main() async {
  
 HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // await dep.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.find<RodoviaController>().getRodoviaList();
  
    return ScreenUtilInit(
      builder: (_ , child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'InvenTur',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            surfaceTint: Colors.white,
          ),
          fontFamily: 'AbeeZee',
        ),
        routes: {
          '/Login': (_) => const LoginPage(),
          '/Register': (_) => RegisterPage(),
          '/AdminHome': (_) => const AdminHomePage(),
          '/RegisterPesquisa': (_) => const RegisterPesquisa(),
          '/PassWordRecover': (_) => RecuperarSenha(),
          '/ConfirmarCodigo': (_) => ConfirmarCodigo(),
          '/MudarSenha': (_) => MudarSenha(),
          '/NewPassword': (_) => const ConfirmacaoNovaSenha(),
          '/Choose': (_) => const Choose(),
          '/PesquisadorHome': (_) => const PesquisadorHome(),
          '/Pesquisas': (_) =>    Pesquisas(),
          '/FormA': (_) => const FormularioA(),
          '/FormB': (_) => const FormularioB(),
          '/FormC': (_) => const FormularioC(),
          '/A': (_) => const A(),
          '/PerfilPesquisador': (_) => const ContaPesquisador(),
          '/AlterarDados': (_) => const AlterarCadastro(),
          '/MeiosDeHospedagem': (_) => const MeiosDeHospedagem(),
          '/Placeholder': (_) => const PlaceHolder(),
          '/AlimentosEbebidas': (_) => const AlimentoseBebidas(),
          '/Rodovia': (_) => const Rodovia(),
          '/SistemaDeSeguranca': (_) => const SistemaDeSeguranca(),
          '/ZonaCosteira': (_) => const ZonaCosteira(),
          '/Hidrografia': (_) => const Hidrografia(),
          '/SendedForm': (_) => const SendedFormPage(),
          '/UpdatedForm': (_) => const UpdatedForm(),
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('pt')
        ],   
        home: const LoginPage(),
      ),
      designSize: const Size(1344, 2992),
    );
  }
}
