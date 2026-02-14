import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sistur/providers/providers.dart';
import 'package:sistur/ui/forms/formsB/entidades_associativas.dart';
import 'package:sistur/ui/forms/formsB/espacos_de_diversao_e_cultura.dart';
import 'package:sistur/ui/forms/formsB/espacos_para_eventos.dart';
import 'package:sistur/ui/forms/formsB/guiamento_e_conducao_turistica.dart';
import 'package:sistur/ui/forms/formsB/informacoes_turisticas.dart';
import 'package:sistur/ui/forms/formsB/instalacoes_esportivas.dart';
import 'package:sistur/ui/forms/formsB/parques.dart';
import 'package:sistur/ui/forms/formsB/servicos_para_eventos.dart';
import 'package:sistur/ui/forms/formsC/eventos_programados.dart';
import 'package:sistur/ui/forms/formsC/gastronomia_artesanato_trabalhos_manuais.dart';
import 'package:sistur/ui/forms/formsC/unidades_de_conservacao.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:sistur/ui/screens/auth%20screens/login_page.dart';
import 'package:sistur/ui/screens/auth%20screens/register_confirmation.dart';
import 'package:sistur/ui/screens/auth%20screens/register_page.dart';
import 'package:sistur/ui/home/Administrador/admin_home_page.dart';
import 'package:sistur/ui/forms/formsA/comercio_turistico.dart';
import 'package:sistur/ui/forms/formsA/informacoes_basicas_do_municipio.dart';
import 'package:sistur/ui/forms/formsA/locadora_de_imoveis.dart';
import 'package:sistur/ui/forms/formsA/rodovia.dart';
import 'package:sistur/ui/forms/formsA/sistema_de_seguran%C3%A7a.dart';
import 'package:sistur/ui/forms/formsB/agencias_de_turismo.dart';
import 'package:sistur/ui/forms/formsB/meiosdehospedagem.dart';
import 'package:sistur/ui/forms/formsB/outros_tipos_de_acomodacao.dart';
import 'package:sistur/ui/forms/formsB/transporte_turistico.dart';
import 'package:sistur/ui/widgets/widgets/sendButton.dart';
import 'package:sistur/ui/forms/formsC/hidrografia.dart';
import 'package:sistur/ui/screens/updatedForm_screen.dart';
import 'package:sistur/ui/screens/pesquisa%20screens/edit_pesquisa.dart';
import 'package:sistur/ui/screens/pesquisa%20screens/register_pesquisa_page.dart';
import 'package:sistur/ui/screens/password%20recover%20screens/changepasswordsucess_page.dart';
import 'package:sistur/ui/home/Pesquisador/pesquisador_homepage.dart';
import 'package:sistur/ui/home/Pesquisador/pesquisas.dart';
import 'package:sistur/ui/screens/forms%20screens/formA_screen.dart';
import 'package:sistur/ui/screens/password%20recover%20screens/passwordrecover_page.dart';
import 'package:sistur/ui/screens/forms%20screens/formB._screen.dart';
import 'package:sistur/ui/screens/forms%20screens/formC_screen.dart';
import 'package:sistur/ui/widgets/placeholder.dart';
import 'package:sistur/ui/forms/formsB/alimentos_e_bebidas.dart';
import 'package:sistur/ui/screens/sync_page.dart';
import 'package:sistur/services/offline_login.dart';
import 'package:sistur/services/sync_service.dart';
import 'package:sistur/services/temporary.dart';
import 'package:sistur/utils/check_connectivity.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'ui/forms/formsC/zonaCosteira.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {

  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await DataSyncService().init();
  await CheckConnectivity().inicializar();

  // await dep.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initApp();
  }
  @override
  Widget build(BuildContext context) {
    // Get.find<RodoviaController>().getRodoviaList();

    return ScreenUtilInit(
      builder: (_, child) => MaterialApp(
        navigatorKey: navigatorKey,
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
          '/Login': (_) => LoginPage(),
          '/Ver': (_) =>  SyncQueuePage(),
          '/Register': (_) => RegisterPage(),
          '/RegisterConfirmation': (_) => RegisterConfimation(),
          '/AdminHome': (_) => AdminHomePage(),
          '/RegisterPesquisa': (_) => RegisterPesquisa(),
          '/EditPesquisa': (_) => EditPesquisa(),
          '/PasswordRecover': (_) => RecuperarSenha(),
          '/NewPassword': (_) => ConfirmacaoNovaSenha(),
          '/PesquisadorHome': (_) => PesquisadorHome(),
          '/Pesquisas': (_) => Pesquisas(),
          '/FormA': (_) => FormularioA(),
          '/FormB': (_) => FormularioB(),
          '/FormC': (_) => FormularioC(),
          '/A': (_) => A(),
          '/AlterarDados': (_) => RegisterPage(),
          '/MeiosDeHospedagem': (_) => MeiosDeHospedagem(),
          '/Placeholder': (_) => PlaceHolder(),
          '/AlimentosEbebidas': (_) => AlimentosEBebidas(),
          '/Rodovia': (_) => Rodovia(),
          '/SistemaDeSeguranca': (_) => SistemaDeSeguranca(),
          '/ZonaCosteira': (_) => ZonaCosteira(),
          '/Hidrografia': (_) => Hidrografia(),
          '/SendedForm': (_) => SendedFormPage(),
          '/UpdatedForm': (_) => UpdatedForm(),
          '/SyncPage': (_) => SyncPage(),
          '/InfoBasicas': (_) => InformacoesBasicasDoMunicipio(),
          '/ComercioTuristico': (_) => ComercioTuristico(),
          '/LocadoraDeImoveis': (_) => LocadoraDeImoveis(),
          '/OutrasAcomodacoes': (_) => OutrosTiposDeAcomodacao(),
          '/AgenciasDeTurismo': (_) => AgenciasDeTurismo(),
          '/TransporteTuristico': (_) =>  TransporteTuristico(),
          '/EspacoParaEventos': (_) => EspacosParaEventos(),
          '/ServicosParaEventos': (_) => ServicosParaEventos(),
          '/Parques': (_) => Parques(),
          '/EspacosDeDiversao': (_) => EspacosDeDiversaoECultura(),
          '/InformacoesTuristicas': (_) => InformacoesTuristicas(),
          '/EntidadesAssociativas': (_) => EntidadesAssociativas(),
          '/GuiamentoEConducaoTuristica': (_) => GuiamentoEConducaoTurististica(),
          '/InstalacoesEsportivas': (_) => InstalacoesEsportivas(),
          '/UnidadesDeConservacao': (_) => UnidadesDeConservacao(),
          '/EventosProgramados': (_) => EventosProgramados(),
          '/GastronomiaArtesanatoTrabalhosManuais': (_) => GastronomiaArtesanatoTrabalhosManuais()
        },
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [Locale('pt')],
        home: LoginPage(),
      ),
      designSize: Size(1344, 2992),
    );
  }
}
