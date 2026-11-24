import 'package:flutter/material.dart';
import 'package:sistur/ui/widgets/avatar_padrao.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sistur/providers/providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:sistur/utils/app_constants.dart';
import 'dart:convert';
import 'package:sistur/services/secure_storage_service.dart';
import 'package:sistur/ui/widgets/excluir_conta_dialog.dart';

class ContaPesquisador extends StatefulWidget {
  const ContaPesquisador({super.key});

  @override
  State<ContaPesquisador> createState() => _ContaPesquisadorState();
}

class _ContaPesquisadorState extends State<ContaPesquisador> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoadingImage = false;

  Future<void> _pickAndUploadImage(BuildContext context, int userId) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      setState(() {
        _isLoadingImage = true;
      });

      String fileName = image.path.split('/').last;

      FormData formData = FormData.fromMap({
        "foto_perfil":
            await MultipartFile.fromFile(image.path, filename: fileName),
      });

      final response = await ApiService().patch(
        'user/$userId/',
        data: formData,
      );

      if (response.statusCode == 200) {
        if (mounted) {
          final userProvider = Provider.of<UserProvider>(context, listen: false);
          final String newFotoUrl = response.data['foto_perfil'];
          userProvider.user.fotoPerfil = newFotoUrl;
          
          final secureStorage = SecureStorageService();
          String? userDataString = await secureStorage.read('user_data');
          
          // Ler a imagem local para salvar o Base64 em cache para uso offline
          String? base64Image;
          try {
            final bytes = await image.readAsBytes();
            base64Image = base64Encode(bytes);
            userProvider.user.fotoPerfilBase64 = base64Image;
          } catch (e) {
            debugPrint("Erro ao converter imagem em Base64: $e");
          }

          if (userDataString != null) {
            Map<String, dynamic> userData = jsonDecode(userDataString);
            userData['foto_perfil'] = newFotoUrl;
            if (base64Image != null) {
              userData['foto_perfil_base64'] = base64Image;
            }
            await secureStorage.write('user_data', jsonEncode(userData));
          }

          userProvider.notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Foto de perfil atualizada com sucesso!')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar foto: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingImage = false;
        });
      }
    }
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
          // Rolável: evita estouro em telas pequenas
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    maxRadius: screenSize.height * 0.15,
                    backgroundColor: (user.fotoPerfil == null && user.fotoPerfilBase64 == null)
                        ? corFundoAvatarPadrao
                        : Colors.grey[200],
                    backgroundImage: user.fotoPerfilBase64 != null
                        ? MemoryImage(base64Decode(user.fotoPerfilBase64!))
                        : (user.fotoPerfil != null
                            ? NetworkImage(_getFullImageUrl(user.fotoPerfil!))
                            : null) as ImageProvider?,
                    child: (user.fotoPerfil == null && user.fotoPerfilBase64 == null)
                        ? const IconePerfilPadrao()
                        : null,
                  ),
                  _isLoadingImage 
                  ? const CircularProgressIndicator()
                  : Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 55, 111, 60),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () => _pickAndUploadImage(context, user.id!),
                      ),
                    ),
                ],
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
                    ]),
                  )
                ]),
              ),
              SizedBox(
                height: screenSize.height * 0.12,
              ),
              SizedBox(
                  width: screenSize.width * 0.9,
                  height: screenSize.height * 0.06,
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/AlterarDados', arguments: {
                      'is_change': true,
                      'username': user.username,
                      'user_email': user.email,
                      'user_id': user.id,
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
                  )),
              const SizedBox(height: 12),
              // Direito de eliminação (LGPD): o próprio usuário exclui a conta
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: const Color(0xFFC62828)),
                onPressed: () => _excluirConta(context),
                icon: const Icon(Icons.delete_forever_outlined),
                label: const Text('Excluir minha conta'),
              ),
            ],
          ),
          ),
        );
      },
    );
  }

  Future<void> _excluirConta(BuildContext context) async {
    final navegador = Navigator.of(context);
    final mensagens = ScaffoldMessenger.of(context);
    final excluiu = await confirmarExclusaoDeConta(context);
    if (!excluiu) return;
    // Encerra a sessão neste aparelho e volta ao login
    await SecureStorageService().clearAll();
    mensagens.showSnackBar(const SnackBar(content: Text('Sua conta foi excluída e seus dados pessoais foram apagados.')));
    navegador.pushNamedAndRemoveUntil('/Login', (_) => false);
  }

  String _getFullImageUrl(String path) {
    if (path.startsWith('http')) return path;
    const String baseUrl = AppConstants.BASE_URI; 
    String url = baseUrl.endsWith('/api/v1/') ? baseUrl.substring(0, baseUrl.length - 8) : baseUrl;
    return '$url$path';
  }
}
