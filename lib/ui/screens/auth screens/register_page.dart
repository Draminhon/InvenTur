import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sistur/legal/termos_texto.dart';
import 'package:sistur/ui/screens/termos/termos_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sistur/ui/screens/auth%20screens/register_confirmation.dart';
import 'package:sistur/ui/widgets/text%20fields/text_field_widget.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sistur/validators/email_validator.dart';
import 'package:sistur/validators/name_validator.dart';
import 'package:sistur/validators/password_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'dart:convert';
import 'package:sistur/services/secure_storage_service.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sistur/providers/providers.dart';
import 'package:dio/dio.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  bool _isLoading = false;

  // Perfil escolhido pelo próprio usuário no cadastro (único meio de criar um administrador)
  String _perfil = 'Pesquisador';

  // Aceite obrigatório dos Termos de Uso e da Política de Privacidade (somente no cadastro)
  bool _aceiteTermos = false;
  late final TapGestureRecognizer _linkTermos = TapGestureRecognizer()..onTap = () => _abrirTermos(0);
  late final TapGestureRecognizer _linkPrivacidade = TapGestureRecognizer()..onTap = () => _abrirTermos(1);

  void _abrirTermos(int aba) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => TermosPage(abaInicial: aba)));
  }

  @override
  void dispose() {
    _linkTermos.dispose();
    _linkPrivacidade.dispose();
    super.dispose();
  }

  final NameValidator _nameValidator = NameValidator();

  final EmailValidator _emailValidator = EmailValidator();

  final PasswordValidator _passwordValidator = PasswordValidator();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordController2 = TextEditingController();
  // Alterar dados: exigida pelo servidor para trocar e-mail ou senha
  final TextEditingController _senhaAtualController = TextEditingController();

  final TextEditingController _telefoneController = TextEditingController();

  final phoneMask = MaskTextInputFormatter(mask: '(##) # ####-####');

  Future<void> registerUser(
      String username, String email, String password, String telefone) async {
    setState(() {
      _isLoading = true;
    });

    FocusScope.of(context).unfocus();

    try {
      final response = await ApiService().post(
        AppConstants.REGISTER_URI,
        data: {
          'username': username,
          'email': email.trim().toLowerCase(),
          'password': password,
          'telefone': telefone,
          'acessLevel': _perfil,
          // Prova do consentimento: o servidor registra a versão aceita e a data/hora
          'aceite_termos': _aceiteTermos,
          'termos_versao': termosVersao,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const RegisterConfimation();
        }));
      }
    } on DioException catch (e) {
      String errorMsg = "Erro ao registrar usuário.";
      if (e.response?.statusCode == 400) {
        errorMsg = "Verifique os dados informados (o e-mail pode já estar em uso).";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg)));
      debugPrint('Erro Dio ao registrar usuário: ${e.message}');
    } catch (e) {
      debugPrint('Erro genérico ao registrar usuário: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future updateUsers(int user, String username, String email,
      String password, String telefone) async {
    void avisar(String texto) => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(texto), backgroundColor: Colors.red[700]));
    // Senha nova: confere a confirmação e o tamanho antes de enviar
    if (password.isNotEmpty) {
      if (password != _passwordController2.text) {
        avisar('As senhas precisam ser iguais!');
        return;
      }
      if (password.length < 8) {
        avisar('A senha deve ter pelo menos 8 caracteres.');
        return;
      }
    }
    try {
      final response = await ApiService().patch(
        'user/$user/',
        data: {
          'username': username,
          'email': email.trim().toLowerCase(),
          'password': password,
          'telefone': telefone,
          'senha_atual': _senhaAtualController.text,
        },
      );

      if (response.statusCode == 200) {
        print('Usuário atualizado com sucesso');
        
        final secureStorage = SecureStorageService();
        String? oldUserDataString = await secureStorage.read('user_data');
        Map<String, dynamic> userData = {};
        if (oldUserDataString != null) {
          userData = jsonDecode(oldUserDataString);
        }

        userData['id'] = user;
        userData['name'] = username;
        userData['username'] = username;
        userData['email'] = email.trim().toLowerCase();
        userData.remove('cpf'); // dados antigos em cache
        userData.remove('CPF');
        userData['telefone'] = telefone;
        
        await secureStorage.write('user_data', jsonEncode(userData));

        // Update global state
        Provider.of<UserProvider>(context, listen: false).updateUser(username, email.trim().toLowerCase(), telefone);

        Navigator.pop(context);
        const snackBar =
            SnackBar(content: Text("Atualização realizada com sucesso!"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } on DioException catch (e) {
      // Mostra o motivo devolvido pelo servidor (ex.: senha atual incorreta, e-mail já cadastrado)
      final dados = e.response?.data;
      String mensagem = e.response == null
          ? 'Falha ao atualizar dados. Verifique sua conexão.'
          : 'Não foi possível atualizar os dados.';
      if (dados is Map && dados.isNotEmpty) {
        final primeiro = dados.values.first;
        mensagem = (primeiro is List && primeiro.isNotEmpty ? primeiro.first : primeiro).toString();
      }
      avisar(mensagem);
      debugPrint('Erro Dio na atualização: ${e.message}');
    } catch (e) {
      debugPrint('Erro genérico na atualização: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final isChange = arguments['is_change'];
    final username = arguments['username'];
    final email = arguments['user_email'];
    final id = arguments['user_id'];
    final telefone = arguments['user_telefone'];
    double paddingBottomTextField = screenSize.height * .015;

    if (isChange == true) {
      _nameController.text = username;
      _emailController.text = email;
      _telefoneController.text = telefone;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey3,
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 150.h),
              reverse: true,
              child: SizedBox(
                width: screenSize.width,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isChange == true ? 'Alterar Dados' : 'Cadastro',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 55, 111, 60),
                              fontSize: 90.h),
                        ),
                        const Text('Preencha os campos com suas informações.'),
                        SizedBox(height: paddingBottomTextField),
                        const Divider(
                          color: const Color.fromARGB(255, 55, 111, 60),
                          thickness: 1.5,
                          endIndent: 30,
                          indent: 30,
                        ),
                        SizedBox(height: paddingBottomTextField),
                        Container(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (isChange != true) ...[
                                  _seletorDePerfil(),
                                  SizedBox(height: paddingBottomTextField),
                                ],
                                const Text('Nome',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: paddingBottomTextField),
                                PasswordTextField(
                                  labelText: 'Insira seu nome completo',
                                  controller: _nameController,
                                  prefixIcon: Icons.person,
                                  validator: (name) {
                                    return _nameValidator.validate(name: name);
                                  },
                                ),
                                SizedBox(height: paddingBottomTextField),
                                const Text('Email',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: paddingBottomTextField),
                                PasswordTextField(
                                  labelText: 'Insira seu email',
                                  controller: _emailController,
                                  prefixIcon: FontAwesomeIcons.solidEnvelope,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (email) {
                                    return _emailValidator.validate(email: email);
                                  },
                                ),
                                SizedBox(height: paddingBottomTextField),
                                const Text(
                                  "Telefone",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: paddingBottomTextField,
                                ),
                                PasswordTextField(
                                    labelText: 'Insira seu telefone',
                                    controller: _telefoneController,
                                    inputFormatters: [phoneMask],
                                    keyboardType: TextInputType.phone,
                                    prefixIcon: FontAwesomeIcons.phone),
                                SizedBox(height: paddingBottomTextField),
                                if (isChange == true) ...[
                                  const Text('Senha atual',
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: paddingBottomTextField),
                                  PasswordTextField(
                                    labelText: 'Necessária para alterar e-mail ou senha',
                                    prefixIcon: Icons.lock_outline,
                                    controller: _senhaAtualController,
                                    isSecret: true,
                                  ),
                                  SizedBox(height: paddingBottomTextField),
                                ],
                                Text(isChange == true ? 'Nova senha' : 'Senha',
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(height: paddingBottomTextField),
                                PasswordTextField(
                                  labelText: isChange == true
                                      ? 'Insira sua nova senha'
                                      : 'Insira sua senha',
                                  prefixIcon: Icons.lock,
                                  controller: _passwordController,
                                  isSecret: true,
                                  validator: (password) {
                                    return _passwordValidator.validate(
                                        password: password);
                                  },
                                ),
                                SizedBox(height: paddingBottomTextField),
                                const Text(
                                  'Confirmar Senha',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: paddingBottomTextField),
                                PasswordTextField(
                                  labelText: 'Confirme sua senha',
                                  prefixIcon: Icons.lock,
                                  controller: _passwordController2,
                                  isSecret: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Insira uma senha válida';
                                    } else if (_passwordController.text !=
                                        _passwordController2.text) {
                                      return 'As senhas precisam ser iguais!';
                                    }
                                    return null;
                                  },
                                ),
                                if (isChange != true) ...[
                                  SizedBox(height: paddingBottomTextField),
                                  _campoAceiteTermos(),
                                ],
                                SizedBox(height: isChange == true ? 50.w : 160.h),
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
                                                  vertical:
                                                      screenSize.height * 0.012)),
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                                  const Color.fromARGB(
                                                      255, 55, 111, 60)),
                                          overlayColor: WidgetStateProperty.all(
                                              Colors.green[600])),
                                      onPressed: () async {
                                        if (isChange == true) {
                                          _formKey.currentState!.save();
        
                                          updateUsers(
                                              id,
                                              _nameController.text,
                                              _emailController.text,
                                              _passwordController.text,
                                              _telefoneController.text);
                                        } else {
                                          if (_formKey.currentState!.validate()) {
                                            _formKey.currentState!.save();
        
                                            final username = _nameController.text;
                                            final email = _emailController.text;
                                            final password =
                                                _passwordController.text;
                                            final telefone = _telefoneController.text;
                                            final result = await registerUser(
                                                username, email, password, telefone);
                                            
        
                                            await Future.delayed(const Duration(
                                                milliseconds: 500));
                                          }
                                        }
                                      },
                                      child: Text(
                                        isChange == true
                                            ? 'Confirmar Alterações'
                                            : 'Solicitar Cadastro',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenSize.height * .03),
                                      )),
                                ),
                                isChange == true
                                    ? SizedBox(
                                        height: 50.w,
                                      )
                                    : SizedBox(),
                                isChange == true
                                    ? SizedBox(
                                        height: screenSize.height * .07,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                shape: WidgetStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10))),
                                                padding: WidgetStateProperty.all(
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            screenSize.height *
                                                                0.012)),
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        Colors.red),
                                                overlayColor:
                                                    WidgetStateProperty.all(
                                                        Colors.green[600])),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Cancelar',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      screenSize.height * .03),
                                            )),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      top: 20,
                      left: 8,
                      child: SafeArea(
                        child: IconButton(
                          tooltip: 'Voltar',
                          style: ButtonStyle(
                              overlayColor:
                                  WidgetStatePropertyAll(Colors.green[100])),
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Color.fromARGB(255, 9, 145, 20),
                          ),
                        ),
                      ),
                    ),
                    if (_isLoading)
                      Positioned(
                        top: 1000.w,
                        left: 600.w,
                        child: AbsorbPointer(
                          absorbing: true,
                          child: Stack(
                            children: [
                              BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  color: Colors.black.withAlpha(5),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withAlpha(5)),
                              ),
                              Center(
                                child: SizedBox(
                                    height: 150.w,
                                    width: 150.w,
                                    child: CircularProgressIndicator()),
                              )
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  /// Checkbox obrigatório: sem o aceite, o formulário não valida e o campo fica vermelho com a mensagem.
  Widget _campoAceiteTermos() {
    const verde = Color.fromARGB(255, 55, 111, 60);
    const estiloLink = TextStyle(color: verde, fontWeight: FontWeight.bold, decoration: TextDecoration.underline);
    return FormField<bool>(
      initialValue: _aceiteTermos,
      validator: (_) => _aceiteTermos ? null : 'Você precisa aceitar os Termos de Uso e a Política de Privacidade.',
      builder: (campo) {
        final erro = campo.hasError;
        return Container(
          padding: const EdgeInsets.fromLTRB(4, 4, 10, 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: erro ? Colors.red : verde.withValues(alpha: 0.4), width: erro ? 1.5 : 1),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Checkbox(
                value: _aceiteTermos,
                activeColor: verde,
                side: BorderSide(color: erro ? Colors.red : verde, width: 2),
                onChanged: (valor) {
                  setState(() => _aceiteTermos = valor ?? false);
                  campo.didChange(valor);
                  if (erro) campo.validate();
                },
              ),
              Expanded(
                child: Text.rich(TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                  children: [
                    const TextSpan(text: 'Li e aceito os '),
                    TextSpan(text: 'Termos de Uso', style: estiloLink, recognizer: _linkTermos),
                    const TextSpan(text: ' e a '),
                    TextSpan(text: 'Política de Privacidade', style: estiloLink, recognizer: _linkPrivacidade),
                    const TextSpan(text: '.'),
                  ],
                )),
              ),
            ]),
            if (erro)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 0, 6),
                child: Text(campo.errorText!, style: const TextStyle(color: Colors.red, fontSize: 12)),
              ),
          ]),
        );
      },
    );
  }


  /// Escolha do perfil no cadastro: Pesquisador (padrão) ou Administrador.
  Widget _seletorDePerfil() {
    const verde = Color.fromARGB(255, 55, 111, 60);
    final ehAdmin = _perfil == 'Administrador';
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text('Perfil', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      SegmentedButton<String>(
        segments: const [
          ButtonSegment(value: 'Pesquisador', label: Text('Pesquisador'), icon: Icon(Icons.person_search_rounded)),
          ButtonSegment(
              value: 'Administrador', label: Text('Administrador'), icon: Icon(Icons.admin_panel_settings_rounded)),
        ],
        selected: {_perfil},
        showSelectedIcon: false,
        onSelectionChanged: (selecao) => setState(() => _perfil = selecao.first),
        style: ButtonStyle(
          backgroundColor:
              WidgetStateProperty.resolveWith((e) => e.contains(WidgetState.selected) ? verde : Colors.white),
          foregroundColor:
              WidgetStateProperty.resolveWith((e) => e.contains(WidgetState.selected) ? Colors.white : verde),
          side: const WidgetStatePropertyAll(BorderSide(color: verde)),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        ehAdmin
            ? 'Administrador: cria e gerencia as próprias pesquisas, forma equipes e acompanha os dados inventariados.'
            : 'Pesquisador: registra os formulários do inventário nas pesquisas às quais se vincular pelo código da pesquisa.',
        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
      ),
    ]);
  }
}
