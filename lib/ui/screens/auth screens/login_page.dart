import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sistur/legal/termos_texto.dart';
import 'package:sistur/ui/screens/termos/termos_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:sistur/ui/home/Administrador/admin_home_page.dart';
import 'package:sistur/ui/home/Pesquisador/pesquisador_homepage.dart';
import 'package:sistur/ui/widgets/text%20fields/divider_text_widget.dart';
import 'package:sistur/ui/widgets/text%20fields/text_field_widget.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sistur/utils/check_connectivity.dart';
import 'package:sistur/validators/email_validator.dart';
import 'package:sistur/validators/password_validator.dart';
import 'dart:convert';
import 'package:sistur/services/secure_storage_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sistur/models/user_model.dart';
import 'package:sistur/providers/providers.dart';

CheckConnectivity connection = new CheckConnectivity();

Future<String?> getToken() async {
  return await SecureStorageService().read('access_token');
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isConnected = false;

  Future<void> checar() async {
    bool online = await connection.checarConexaoUmaVez();
    print('Conexão: $online');
    if (mounted) {
      setState(() {
        isConnected = online;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checar();
    handleLocationPermission();
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'O serviço de localização está desativado. Por favor, habilite-o nas configurações.')));
      return false;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('A permissão de localização foi negada.')));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'A permissão de localização foi negada permanentemente. Abra as configurações para habilitá-la.')));
      return false;
    }

    return true;
  }

  final _formLoginKey = GlobalKey<FormState>();

  final EmailValidator _emailValidator = EmailValidator();
  final PasswordValidator _passwordValidator = PasswordValidator();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool _isWrong = false;
  // Texto do aviso vermelho: o motivo real da falha (antes era sempre "senha incorreta")
  String _erroLogin = 'E-mail ou senha incorretos';
  bool _isLoading = false;

  /// Mostra os termos em modo obrigatório e registra o aceite no servidor.
  /// Retorna false se o usuário recusar ou se não for possível registrar o aceite.
  Future<bool> _solicitarAceiteDosTermos() async {
    final aceitou = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const TermosPage(exigirAceite: true)),
    );
    if (aceitou != true) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Para usar o SisTur é necessário aceitar os Termos de Uso e a Política de Privacidade.'),
        ));
      }
      return false;
    }
    try {
      await ApiService().post('user/aceitar-termos/', data: {'versao': termosVersao});
      return true;
    } on DioException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.response?.statusCode == 409
              ? 'Há uma nova versão dos termos. Atualize o aplicativo para continuar.'
              : 'Não foi possível registrar o aceite. Verifique a conexão e tente novamente.'),
        ));
      }
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    // if (isConnected == false) {
    //   initApp();
    // }

    Future<void> loginUser(String email, String password) async {
      setState(() {
        _isLoading = true;
        _isWrong = false; // Reseta o estado de erro ao tentar novamente
      });

      try {
        final response = await ApiService().post(
          AppConstants.LOGIN_URI,
          data: {
            'email': email,
            'password': password,
          },
        );
        final secureStorage = SecureStorageService();

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = response.data;
          String accessToken = responseData['access'];
          String refreshToken = responseData['refresh'];
          
          if (responseData['access_exp'] != null) {
            int accessTokenExp = responseData['access_exp'];
            await secureStorage.setInt('access_token_exp', accessTokenExp);
          }
          
          final Map<String, dynamic> user = responseData['user'];

          await secureStorage.write('user_data', json.encode(user));
          await secureStorage.write('access_token', accessToken);
          await secureStorage.write('refresh_token', refreshToken);

          User newUser = User(
            id: user['id'],
            username: user['username'] ?? user['name'] ?? '',
            email: user['email'] ?? '',
            status: user['status'] ?? '',
            accessLevel: user['access_level'] ?? user['acessLevel'] ?? '',
            telefone: user['telefone'] ?? '',
            fotoPerfil: user['foto_perfil'],
          );

          // Tentar baixar e salvar a foto em Base64 para uso offline
          if (newUser.fotoPerfil != null) {
            try {
              final String imageUrl = newUser.fullFotoPerfilUrl!;
              final response = await Dio().get<List<int>>(
                imageUrl,
                options: Options(responseType: ResponseType.bytes),
              );
              if (response.statusCode == 200 && response.data != null) {
                String base64Image = base64Encode(response.data!);
                newUser.fotoPerfilBase64 = base64Image;
                
                // Atualizar o JSON no secure storage para incluir o Base64
                user['foto_perfil_base64'] = base64Image;
                await secureStorage.write('user_data', json.encode(user));
              }
            } catch (e) {
              debugPrint("Erro ao fazer cache da foto de perfil: $e");
            }
          }

          Provider.of<UserProvider>(context, listen: false).setUser(newUser);

          // LGPD: sem o aceite da versão vigente dos termos, o acesso não é liberado
          if (responseData['termos_pendentes'] == true) {
            final aceitou = await _solicitarAceiteDosTermos();
            if (!aceitou) {
              await secureStorage.clearAll(); // encerra a sessão recém-aberta
              return;
            }
          }
          if (!mounted) return;

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return user['access_level'] == 'Pesquisador'
                ? const PesquisadorHome()
                : const AdminHomePage();
          }));
        }
      } on DioException catch (e) {
        final status = e.response?.statusCode;
        final dados = e.response?.data;
        setState(() {
          _isWrong = true;
          if (e.response == null) {
            _erroLogin = 'Sem conexão com o servidor. Verifique sua internet.';
          } else if (status == 429) {
            // Muitas tentativas erradas: o servidor bloqueia o login por 15 minutos
            _erroLogin = dados is Map && dados['error'] != null
                ? dados['error'].toString()
                : 'Muitas tentativas de login. Aguarde 15 minutos ou recupere sua senha.';
          } else if (status == 401 || status == 400) {
            _erroLogin = 'E-mail ou senha incorretos';
          } else {
            _erroLogin = 'Não foi possível entrar agora. Tente novamente em instantes.';
          }
        });
        debugPrint("Erro Dio no login: ${e.message}");
      } catch (e) {
        setState(() {
          _isWrong = true;
          _erroLogin = 'Não foi possível entrar agora. Tente novamente em instantes.';
        });
        debugPrint("Erro genérico no login: $e");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }

    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: SizedBox(
            width: screenSize.width,
            height: screenSize.height - MediaQuery.paddingOf(context).top,
            child: Column(
              children: [
                Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: screenSize.height * 0.35,
                      ),
                    ),
                ),
                _isWrong
                    ? Container(
                        width: 1230.w,
                        padding: EdgeInsets.fromLTRB(50.h, 40.h, 15.h, 40.h),
                        decoration: BoxDecoration(
                            color: Colors.red[200],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: const Color.fromRGBO(229, 115, 115, 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                _erroLogin,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 163, 45, 36),
                                    fontSize: 15),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isWrong = false;
                                  });
                                },
                                icon: Icon(Icons.close))
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formLoginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PasswordTextField(
                          labelText: 'E-mail',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: FontAwesomeIcons.solidEnvelope,
                          validator: (email) {
                            return _emailValidator.validate(email: email);
                          },
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        PasswordTextField(
                          isSecret: true,
                          labelText: 'Senha',
                          controller: _passwordController,
                          prefixIcon: Icons.lock,
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        SizedBox(
                          height: screenSize.height * .07,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  padding: WidgetStateProperty.all(
                                      EdgeInsets.symmetric(
                                          vertical: screenSize.height * 0.012)),
                                  backgroundColor: WidgetStateProperty.all(
                                      const Color.fromARGB(255, 55, 111, 60)),
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.green[600])),
                              onPressed: () {
                                if (_formLoginKey.currentState!.validate()) {
                                  // O servidor também normaliza (espaços e maiúsculas não importam)
                                  final email = _emailController.text.trim().toLowerCase();
                                  final password = _passwordController.text;
                                  loginUser(email, password);
                                }
                              },
                              child: _isLoading == false
                                  ? const Text(
                                      'Entrar',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    )
                                  : Container(
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.white),
                                        ),
                                      ),
                                    )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenSize.height * .015),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/PasswordRecover');
                              },
                              child: const Text(
                                'Esqueceu sua senha?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 55, 111, 60),
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      Color.fromARGB(255, 55, 111, 60),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: DividerText(text: 'Solicite seu Registro')),
                        SizedBox(
                          height: screenSize.height * .07,
                          child: OutlinedButton(
                              style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  side: const WidgetStatePropertyAll(BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 55, 111, 60),
                                  )),
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          vertical: screenSize.height * .012))),
                              onPressed: () {
                                Navigator.pushNamed(context, '/Register');
                              },
                              child: const Text(
                                'Registre-se',
                                style: TextStyle(fontSize: 22),
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
