import 'package:flutter/material.dart';
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

class ContaPesquisador extends StatefulWidget {
  const ContaPesquisador({super.key});

  @override
  State<ContaPesquisador> createState() => _ContaPesquisadorState();
}

class _ContaPesquisadorState extends State<ContaPesquisador> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoadingImage = false;

  String formatCPF(String cpf) {
    if (cpf.length != 11) {
      return cpf;
    }
    return '${cpf.substring(0, 3)}.${cpf.substring(3, 6)}.${cpf.substring(6, 9)}-${cpf.substring(9, 11)}';
  }

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
          body: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    maxRadius: screenSize.height * 0.15,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: user.fotoPerfilBase64 != null
                        ? MemoryImage(base64Decode(user.fotoPerfilBase64!))
                        : (user.fotoPerfil != null
                            ? NetworkImage(_getFullImageUrl(user.fotoPerfil!))
                            : null) as ImageProvider?,
                    child: (user.fotoPerfil == null && user.fotoPerfilBase64 == null)
                        ? Icon(
                            Icons.person,
                            size: screenSize.height * 0.15,
                            color: Colors.grey[600],
                          )
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

  String _getFullImageUrl(String path) {
    if (path.startsWith('http')) return path;
    const String baseUrl = AppConstants.BASE_URI; 
    String url = baseUrl.endsWith('/api/v1/') ? baseUrl.substring(0, baseUrl.length - 8) : baseUrl;
    return '$url$path';
  }
}
