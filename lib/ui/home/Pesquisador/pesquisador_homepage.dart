  import 'package:flutter/material.dart';
import 'package:sistur/ui/widgets/avatar_padrao.dart';
  import 'package:sistur/models/pesquisa_model.dart';
  import 'package:sistur/controllers/user_controller.dart';
  import 'package:sistur/ui/widgets/container_widget.dart';
  import 'package:intl/intl.dart';
  import 'package:sistur/services/admin_service.dart';
  import 'package:sistur/services/offline_login.dart';
  import 'package:sistur/services/sync_service.dart';
  import 'package:sistur/ui/widgets/options_drawer_widget.dart';
  import 'package:sistur/utils/app_constants.dart';
  import 'dart:convert';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:sistur/utils/check_connectivity.dart';
  import 'package:sistur/services/secure_storage_service.dart';
  import 'package:sistur/services/interceptor_service.dart';
  import 'dart:async';
  import 'package:connectivity_plus/connectivity_plus.dart';
  import 'package:provider/provider.dart';
  import 'package:sistur/models/user_model.dart';
  import 'package:sistur/providers/providers.dart';
import 'package:sistur/utils/modals.dart';
import 'package:sistur/ui/widgets/vincular_pesquisa_dialog.dart';





  //   if (refresh != null) {
  //     var url = Uri.parse('${AppConstants.BASE_URI}api/token/refresh/');
  //     var response = await http.post(
  //       url,
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: json.encode({"refresh": refresh}),
  //     );

  //     if (response.statusCode == 200) {
  //       var body = json.decode(response.body);
  //       prefs.setString('access_token', body['access']);
  //       print('Token atualizado com sucesso.');
  //     } else {
  //       print('Erro ao atualizar token: ${response.body}');
  //     }
  //   }
  // }

  class PesquisadorHome extends StatefulWidget {
    const PesquisadorHome({super.key});

    @override
    State<PesquisadorHome> createState() => _PesquisadorHomeState();
  }

// Verde mais claro do botão "Sincronizar Dados" (o verde padrão do projeto é 55,111,60)
const _verdeClaro = Color.fromARGB(255, 92, 158, 98);

  class _PesquisadorHomeState extends State<PesquisadorHome> {
    /// Pesquisas do servidor. Retorna null quando não foi possível consultar (ex.: sem conexão) — só aí a tela
    /// usa o cache offline. Uma lista vazia é uma resposta válida: o pesquisador não tem pesquisas ativas.
    static Future<List<Pesquisa>?> getPesquisas() async {
      try {
        final response = await ApiService().get('pesquisas/usuario/');

        if (response.statusCode == 200) {
          final List<dynamic> data = response.data;
          await _atualizarCachePesquisas(data);
          return data.map((item) => Pesquisa.fromJson(item)).toList();
        } else {
          print("Falha ao carregar pesquisas. Status: ${response.statusCode}");
          return null;
        }
      } catch (e) {
        print("Ocorreu um erro ao buscar as pesquisas: $e");
        return null;
      }
    }

    /// Mantém o cache offline (user_data['pesquisas']) igual à última lista do servidor,
    /// para que pesquisas excluídas ou das quais o usuário saiu não continuem aparecendo offline.
    static Future<void> _atualizarCachePesquisas(List<dynamic> pesquisas) async {
      try {
        final secureStorage = SecureStorageService();
        final userDataString = await secureStorage.read('user_data');
        if (userDataString == null) return;
        final userData = Map<String, dynamic>.from(json.decode(userDataString));
        userData['pesquisas'] = pesquisas;
        await secureStorage.write('user_data', json.encode(userData));
      } catch (e) {
        print("Não foi possível atualizar o cache de pesquisas: $e");
      }
    }

    Future<List<Pesquisa>?> pesquisasFuture = getPesquisas();
    final UserController _userController = UserController();

    int userId = 0;
    String userName = '';
    String userEmail = '';
    String userStatus = '';
    String userTelefone = '';
    Future<void> getUserInfo() async {
      final secureStorage = SecureStorageService();
      String? userDataString = await secureStorage.read('user_data');
      if (userDataString != null) {
        Map<String, dynamic> userData = json.decode(userDataString);
        setState(() {
          userName = userData['name'];
          userEmail = userData['email'];
          userStatus = userData['status'];
          userId = userData['id'];
          userTelefone = userData['telefone'];

          User newUser = User(
            id: userId,
            username: userName,
            email: userEmail,
            status: userStatus,
            accessLevel: userData['acessLevel'] ?? 'Pesquisador',
            telefone: userTelefone,
            fotoPerfil: userData['foto_perfil'],
            fotoPerfilBase64: userData['foto_perfil_base64'],
          );
          Provider.of<UserProvider>(context, listen: false).setUser(newUser);
        });
      }
    }

    late StreamSubscription<List<ConnectivityResult>> connectivitySubscription;
    bool isConnected = false;
    int qtdeBanco = 0;
    List<Pesquisa> pesquisasOff = [];

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      getUserInfo();
      checar();
      getPesquisasOff();
      getQtdeBanco();
      initConnectivity();
      connectivitySubscription =
          Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
      pesquisasFuture = getPesquisas();
      // A fila também é enviada em segundo plano: acompanha o contador sem precisar recarregar a tela
      DataSyncService().pendentes.addListener(_aoMudarPendentes);
    }

    /// A fila mudou (envio silencioso, novo formulário salvo offline...).
    void _aoMudarPendentes() {
      if (!mounted) return;
      final atual = DataSyncService().pendentes.value;
      final enviouAlgo = atual < qtdeBanco;
      setState(() => qtdeBanco = atual);
      // Algo foi enviado em segundo plano: atualiza a "Quantidade de Equipamentos" dos cards, sem diálogo
      // (no envio manual quem recarrega é o próprio botão)
      if (enviouAlgo && !_isSyncing) _recarregarPesquisasSilenciosamente();
    }

    Future<void> _recarregarPesquisasSilenciosamente() async {
      final pesquisas = await getPesquisas();
      if (pesquisas != null && mounted) {
        setState(() {
          pesquisasFuture = Future.value(pesquisas);
        });
      }
    }

    Future<void> getQtdeBanco() async {
      int getqtd = await DataSyncService().getPendingCount();
      if (mounted) {
        setState(() {
          qtdeBanco = getqtd;
        });
      }
    }

    @override
    void didChangeDependencies() {
      // TODO: implement didChangeDependencies
      super.didChangeDependencies();
      getUserInfo();
    }

    @override
    void dispose() {
      DataSyncService().pendentes.removeListener(_aoMudarPendentes);
      connectivitySubscription.cancel();
      super.dispose();
    }

    Future<void> initConnectivity() async {
      final results = await Connectivity().checkConnectivity();
      return _updateConnectionStatus(results);
    }

    Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
      final newConnectionStatus = !results.contains(ConnectivityResult.none);

      if (newConnectionStatus != isConnected) {
        setState(() {
          isConnected = newConnectionStatus;
          print("Status da conexão alterado para: $isConnected");
        });
      }
    }

    CheckConnectivity connection = new CheckConnectivity();

    Future<void> getPesquisasOff() async {
      List<Pesquisa> pesquisas = await getPesquisasOffline();

      setState(() {
        pesquisasOff = pesquisas;
      });
    }

    Future<void> checar() async {
      bool online = await connection.checarConexaoUmaVez();
      print('Conexão: $online');
      setState(() {
        isConnected = online;
      });
    }

    bool _isSyncing = false;

    @override
    Widget build(BuildContext context) {
      final sizeScreen = MediaQuery.sizeOf(context);
      DateTime now = DateTime.now();
      var inputFormat = DateFormat('dd/MM/yyyy');

      var outputFormat = DateFormat('dd/MM/yyyy');

      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          foregroundColor: const Color.fromARGB(255, 55, 111, 60),
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    final user = userProvider.user;
                    return GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: CircleAvatar(
                        backgroundColor: (user.fotoPerfil == null && user.fotoPerfilBase64 == null)
                            ? corFundoAvatarPadrao
                            : Colors.transparent,
                        backgroundImage: user.fotoPerfilBase64 != null
                            ? MemoryImage(base64Decode(user.fotoPerfilBase64!))
                            : (user.fotoPerfil != null
                                ? NetworkImage(user.fullFotoPerfilUrl!)
                                : null) as ImageProvider?,
                        child: (user.fotoPerfil == null &&
                                user.fotoPerfilBase64 == null)
                            ? const IconePerfilPadrao()
                            : null,
                      ),
                    );
                  },
                ),
              );
            },
          ),
          title: Text(
            'Minhas Pesquisas',
            style: TextStyle(
                color: const Color.fromARGB(255, 55, 111, 60),
                fontSize: sizeScreen.width * 0.06),
          ),
          centerTitle: true,
        ),
        drawer: SafeArea(
            child: OptionsDrawer(
          userController: _userController,
        )),
        body: Padding(
            padding: EdgeInsets.only(
              left: sizeScreen.height * 0.02,
              right: sizeScreen.height * 0.02,
            ),
            child: FutureBuilder<List<Pesquisa>?>(
              future: pesquisasFuture,
              builder: (context, snapshot) {
                if (userStatus == 'Aguardando Aprovação') {
                  return Container(
                      margin: EdgeInsets.only(top: 1000.h),
                      padding: EdgeInsets.only(left: 100.w),
                      height: 350.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color.fromARGB(255, 55, 111, 60),
                            width: 10.h,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: const Text(
                          "Você não possui permissão para acessar as pesquisas, contate um administrador.",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ));
                } else {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: const CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    // Resposta do servidor (mesmo vazia) é a fonte da verdade: nunca mostra o cache aqui
                    return showPesquisas(snapshot.data!);
                  } else if (pesquisasOff.isNotEmpty) {
                    // Sem resposta do servidor (offline): usa a última lista sincronizada
                    return showPesquisas(pesquisasOff);
                  } else {
                    return Container(
                        margin: EdgeInsets.only(top: 1000.h),
                        padding: EdgeInsets.only(left: 50.w),
                        height: 350.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color.fromARGB(255, 55, 111, 60),
                              width: 10.h,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: const Text(
                            "Você não está participando de nenhuma pesquisa. Aguarde até que você seja designado para alguma pesquisa.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ));
                  }
                }
              },
            )),
        // Rodapé: "Vincular-se a Pesquisa" e, logo abaixo, "Sincronizar Dados" (quando há envios pendentes e conexão)
        bottomNavigationBar: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (userStatus != 'Aguardando Aprovação')
                // Mesmo estilo do botão "Cadastrar Nova Pesquisa" do administrador (pesquisas_page.dart)
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 5.w, 10, 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 180.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          padding: WidgetStateProperty.all(
                              EdgeInsets.symmetric(vertical: 10.w)),
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 55, 111, 60)),
                          overlayColor:
                              WidgetStateProperty.all(Colors.green[600])),
                      onPressed: () async {
                        final mensagens = ScaffoldMessenger.of(context);
                        final mensagem = await mostrarVincularPesquisa(context);
                        // Vínculo concluído (o modal já fechou): confirma e recarrega a lista
                        if (mensagem != null && mounted) {
                          mensagens.showSnackBar(SnackBar(
                            content: Text(mensagem),
                            backgroundColor: const Color.fromARGB(255, 55, 111, 60),
                            duration: const Duration(seconds: 5),
                          ));
                          setState(() {
                            pesquisasFuture = getPesquisas();
                          });
                        }
                      },
                      child: Text(
                        'Vincular-se a Pesquisa',
                        style: TextStyle(color: Colors.white, fontSize: 80.w),
                      ),
                    ), 
                  ),
                ),
              // Sempre abaixo do "Vincular-se a Pesquisa", em verde mais claro
              if (isConnected && qtdeBanco >= 1)
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 180.w,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          padding: WidgetStateProperty.all(
                              EdgeInsets.symmetric(vertical: 10.w)),
                          backgroundColor: WidgetStateProperty.all(_verdeClaro),
                          overlayColor: WidgetStateProperty.all(
                              const Color.fromARGB(255, 55, 111, 60))),
                      onPressed: _isSyncing
                          ? null
                          : () async {
                              setState(() => _isSyncing = true);
                              ResultadoSync? resultado;
                              try {
                                resultado = await DataSyncService().syncPending();
                                // Após sincronizar, atualiza a contagem de itens pendentes
                                await getQtdeBanco();
                                // e recarrega as pesquisas, para a "Quantidade de Equipamentos" incluir os enviados
                                if (mounted) {
                                  // Corpo em bloco: a forma "=>" devolveria o Future e o setState lança erro
                                  setState(() {
                                    pesquisasFuture = getPesquisas();
                                  });
                                }
                              } finally {
                                if (mounted) {
                                  Modals().showSyncDialog(context, resultado);
                                  setState(() => _isSyncing = false);
                                }
                              }
                            },
                      child: _isSyncing
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2.5))
                          : Text(
                              'Sincronizar Dados ($qtdeBanco)',
                              style: TextStyle(color: Colors.white, fontSize: 80.w),
                            ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }
  }

  Widget showPesquisas(List<Pesquisa> posts) {
    print("a funcao foi chamadaaa");
    final filteredPosts =
        posts.where((post) => post.status != "Não Iniciado").toList();

    if (filteredPosts.isEmpty) {
      // Só o texto, em cinza, no meio da tela (sem caixa)
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Não há pesquisas disponíveis no momento.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ),
      );
    }

    return SizedBox(
      child: ListView.builder(
        itemCount: filteredPosts.length,
        itemBuilder: (context, index) {
          final post = filteredPosts[index];
          final post2 = getPesquisasOffline();
          return GestureDetector(
            onTap: () async {
              try {
                final secureStorage = SecureStorageService();

                if (post.adminEmail != null && post.adminTelefone != null) {
                  final adminUsername =
                      await AdminService.getAdminName(post.adminId!);
                  
                  await secureStorage.write('adminName', adminUsername.toString());
                  await secureStorage.write('adminEmail', post.adminEmail!);
                  await secureStorage.write('adminTelefone', post.adminTelefone!);
                }
              } catch (e) {
                print('Erro ao adicionar dados do administrador no SecureStorage: $e');
              }

              savePesquisaId(post.id!);

              Navigator.pushNamed(context, '/Pesquisas',
                  arguments: {'pesquisa_id': post.id, 'user_id': post.userId});
            },
            child: PesquisaPesquisadorCardWidget(
              pesquisa: post,
            ),
          );
        },
      ),
    );
  }
