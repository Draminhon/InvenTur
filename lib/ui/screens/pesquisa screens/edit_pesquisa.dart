import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistur/models/endereco/estado_model.dart';
import 'package:sistur/models/endereco/municipio_model.dart';
import 'package:sistur/models/user_model.dart';
import 'package:sistur/controllers/pesquisa_controller.dart';
import 'package:sistur/ui/widgets/cards/user_pesquisa_card_widget.dart';
import 'package:http/http.dart' as http;
import 'package:sistur/ui/widgets/text%20fields/auto_complete_text_field.dart';
import 'dart:convert';
import 'package:sistur/utils/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPesquisa extends StatefulWidget {
  const EditPesquisa({super.key});

  @override
  State<EditPesquisa> createState() => _EditPesquisaState();
}

class _EditPesquisaState extends State<EditPesquisa>
    with SingleTickerProviderStateMixin {
  bool _tileExpanded = false;
  final Set<User> selectedUsers = {};
  late Estado? _estadoSelecionado = Estado(id: -1, sigla: '', nome: '');
  late Municipio? _municipioSelecionado = Municipio(id: -1, nome: '');
  late int adminId;
  List<User> users = [
    User(
        username: "Fulano Silva da Costa",
        CPF: "789.214.878-02",
        email: "fulanosilva@teste.com",
        status: "Não Ativo",
        accessLevel: 'Pesquisador'),
  ];

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final PesquisaController _pesquisaController = PesquisaController();
  late TextEditingController _inicioController;
  late TextEditingController _terminoController;
  late TextEditingController _codigIbgeController;
  late TextEditingController _municipioController;
  late TextEditingController _estadoController;
  final TextEditingController _nomePesquisador = TextEditingController();
  final TextEditingController _cpfPesquisador = TextEditingController();

  late List<int> _usersIds;
  late int pesquisaId;
  static Future<List<User>> getUsers() async {
    var url = Uri.parse(AppConstants.BASE_URI + AppConstants.GET_USERS);
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    });
    final List body = json.decode(utf8.decode(response.bodyBytes));
    return body.map((e) => User.fromJson(e)).toList();
  }

  Future<List<User>> userFuture = getUsers();

  @override
  void initState() {
    super.initState();
      
    _inicioController = TextEditingController();
    _terminoController = TextEditingController();
    _codigIbgeController = TextEditingController();
    _municipioController = TextEditingController();
    _estadoController = TextEditingController();
    _usersIds = [];
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );

    _scaleAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _pesquisaController.setUsers = users;
    _pesquisaController.setEstados();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    if (args != null) {
      // Atribui as datas apenas se o controlador estiver vazio
      if (_inicioController.text.isEmpty && args.containsKey('data_inicio')) {
        _inicioController.text = args['data_inicio'];
      }
      if (_terminoController.text.isEmpty && args.containsKey('data_termino')) {
        _terminoController.text = args['data_termino'];
      }

      // Atribui outros valores apenas se o controlador estiver vazio
      if (_codigIbgeController.text.isEmpty && args.containsKey('codigoIBGE')) {
        _codigIbgeController.text = args['codigoIBGE'];
      }
      if (_municipioController.text.isEmpty && args.containsKey('municipio')) {
        _municipioController.text = args['municipio'];
      }
      if (_estadoController.text.isEmpty && args.containsKey('estado')) {
        _estadoController.text = args['estado'];
      }
_usersIds.clear();
          selectedUsers.clear();
      _usersIds.addAll(args['pesquisadores']);
      alreadySelectedUsersSection(userId: _usersIds);
          

          
    }
  }

  Future<String> selectDate() async {
    late DateTime? selectedDate;
    final DateTime dateNow = DateTime.now();

    selectedDate = await showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: DateTime(dateNow.year),
      lastDate: DateTime(dateNow.year + 30),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        _animationController.forward();
        return ScaleTransition(
          scale: _scaleAnimation,
          child: child,
        );
      },
    );

    _animationController.reverse();

    if (selectedDate != null) {
      return DateFormat('yyyy-MM-dd').format(selectedDate);
    }
    return '';
  }

  var appbar = AppBar(
    title: const Text('Editar pesquisa'),
    centerTitle: true,
    foregroundColor: const Color.fromARGB(255, 55, 111, 60),
    backgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> createPesquisa(
      String dataInicio,
      String dataTermino,
      String codIBGE,
      String estado,
      String municipio,
      Set<User> selectedUserss) async {
    final url = Uri.parse('${AppConstants.BASE_URI}pesquisa/');
    final prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('user_data');
    Map<String, dynamic> userData = json.decode(userDataString!);
    print("Nome do usuário: ${userData['id']}");

    selectedUsers.forEach((user) {
      print(
          'ID: ${user.id}, CPF: ${user.CPF}, Username: ${user.username}, Email: ${user.email}');
    });
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(<String, dynamic>{
            'admin_id': userData['id'],
            'dataInicio': dataInicio,
            'dataTermino': dataTermino,
            'codigoIBGE': codIBGE,
            'estado': estado,
            'municipio': municipio,
            'pesquisadores': selectedUserss.map((user) => user.id).toList()
          }));

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Pesquisa criada com sucesso!"),
        ));
        Navigator.pop(context);
      } else {
        print('Erro ao criar pesquisa: ${response.body}');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)?.settings.arguments as Map?;

    pesquisaId = args!['id'];
    adminId = args!['admin_id'];
    print(_inicioController.text);
    final Size screenSize = MediaQuery.sizeOf(context);
    final double screenHeight = screenSize.height -
        MediaQuery.paddingOf(context).top -
        appbar.preferredSize.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: appbar,
      body: PageView(
        children: [
          SingleChildScrollView(
            child: Container(
              height: screenHeight,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.end,
                              controller: _inicioController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                filled: true,
                                isCollapsed: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                                labelText: "Data Início",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 55, 111, 60))),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    _inicioController.text = await selectDate();
                                  },
                                  icon: const Icon(
                                    Icons.date_range_rounded,
                                    color: Color.fromARGB(255, 55, 111, 60),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.end,
                              controller: _terminoController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                filled: true,
                                isCollapsed: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                                labelText: "Data Término",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 55, 111, 60))),
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    _terminoController.text =
                                        await selectDate();
                                  },
                                  icon: const Icon(
                                    Icons.date_range_rounded,
                                    color: Color.fromARGB(255, 55, 111, 60),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            child: TextField(
                              textAlign: TextAlign.end,
                              controller: _codigIbgeController,
                              decoration: InputDecoration(
                                filled: true,
                                isCollapsed: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                                labelText: "Código IBGE",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 55, 111, 60))),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Flexible(
                            child: AutocompleteTextField(
                              label: "Estado",
                              controllerAuto: _estadoController,
                              onSelected: (option) {
                                _estadoSelecionado =
                                    _pesquisaController.getEstadoByNome(option);
                                _pesquisaController
                                    .setMunicipios(_estadoSelecionado!.id);
                              },
                              optionsBuilder: (textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable.empty();
                                }
                                return _pesquisaController.estados
                                    .map((e) => e.nome)
                                    .where(
                                      (word) => word.toLowerCase().contains(
                                            textEditingValue.text.toLowerCase(),
                                          ),
                                    );
                              },
                              onChanged: (value) {
                                if (value == '') {
                                  _pesquisaController.municipios.clear();
                                }
                                _estadoController.text = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AutocompleteTextField(
                        label: "Município",
                        controllerAuto: _municipioController,
                        onSelected: (option) {
                          _municipioSelecionado =
                              _pesquisaController.getMunicipioByNome(option);
                          setState(() {
                            _codigIbgeController.text =
                                _municipioSelecionado!.id.toString();
                          });
                        },
                        optionsBuilder: (textEditingValue) {
                          if (textEditingValue.text == '') {
                            return const Iterable.empty();
                          }
                          return _pesquisaController.municipios
                              .map((e) => e.nome)
                              .where(
                                (word) => word.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase(),
                                    ),
                              );
                        },
                        onChanged: (value) {
                          if (value == '') {
                            _codigIbgeController.text = '';
                          }
                          _municipioController.text = value;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                            border: Border.symmetric(
                                horizontal: BorderSide(
                                    color: Color.fromARGB(255, 55, 111, 60)))),
                        child: ExpansionTile(
                          shape: const Border.symmetric(
                              horizontal: BorderSide(
                                  color: Color.fromARGB(255, 55, 111, 60))),
                          childrenPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          title: const Row(
                            children: [
                              Spacer(flex: 2),
                              Text(
                                "Adicionar Pesquisador(es)",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 55, 111, 60),
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                            ],
                          ),
                          trailing: Icon(
                            _tileExpanded
                                ? Icons.remove_rounded
                                : Icons.add_rounded,
                            color: const Color.fromARGB(255, 55, 111, 60),
                            size: 32,
                          ),
                          children: [
                            SizedBox(
                                height: 150.h,
                                child: TextField(
                                  decoration: InputDecoration(
                                    isDense: true,
                                    fillColor: Colors.white,
                                    filled: true,
                                    label: const Text("Procurar por nome"),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 55, 111, 60),
                                          width: 2.0,
                                        )),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromARGB(255, 55, 111, 60),
                                          width: 2.0,
                                        )),
                                    prefixIcon: const Icon(
                                      Icons.search,
                                      color: const Color.fromARGB(
                                          255, 55, 111, 60),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      userFuture = getUsers().then((users) =>
                                          users
                                              .where((user) =>
                                                  user.accessLevel ==
                                                      'Pesquisador' &&
                                                  (user.username
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase()) ??
                                                      false))
                                              .toList());
                                    });
                                  },
                                )),
                            SizedBox(height: 55.h ,),
                            userSearchAndSelectSection(), // Aqui exibimos o campo de busca e os resultados.
                          ],
                          onExpansionChanged: (expanded) {
                            setState(() {
                              _tileExpanded = expanded;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Pesquisadores Selecionados",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 55, 111, 60),
                            ),
                          ),
                        ),
                        selectedUsersSection(),
                      ],
                    ),
                  ),
                  SafeArea(
                    child:  Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: screenSize.height * .06,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                   
                                    backgroundColor: WidgetStateProperty.all(
                                        const Color.fromARGB(255, 55, 111, 60)),
                                    overlayColor: WidgetStateProperty.all(
                                        Colors.green[600])),
                                onPressed: () async {
                                
                                  final success =
                                      await _pesquisaController.atualizarPesquisa(
                                    adminId: adminId,
                                    pesquisaId: pesquisaId,
                                    rawDataInicio: _inicioController.text,
                                    rawDataTermino: _terminoController.text,
                                    codigoIBGE: _codigIbgeController.text,
                                    estado: _estadoController.text,
                                    municipio: _municipioController.text,
                                    selectedUsers: selectedUsers,
                                  );
                                  if (success) {
                                    Navigator.of(context).pop(true);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Erro ao atualizar pesquisa"),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "Confirmar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenSize.height * .03),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: SizedBox(
                              height: screenSize.height * .06,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                               BorderRadius.circular(10))),
                                  
                                    backgroundColor: WidgetStateProperty.all(
                                        const Color.fromARGB(255, 232, 0, 0)),
                                    overlayColor:
                                        WidgetStateProperty.all(Colors.red[500])),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancelar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenSize.height * .03),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userSearchAndSelectSection() {
    return FutureBuilder<List<User>>(
      future: userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          final users = snapshot.data!;
          if (users.isEmpty) {
            return const Text("Nenhum usuário encontrado");
          }
          return showUsers(users);
        } else {
          return const Text("Erro ao carregar usuários");
        }
      },
    );
  }

  Widget selectedUsersSection() {
    return Expanded(
        child: ListView.builder(
      itemCount: selectedUsers.length,
      itemBuilder: (context, index) {
        final user = selectedUsers.elementAt(index);
        return UserPesquisaCardList(
          key: ValueKey(user.id),
          user: user,
          onRemove: (u) async {
            final sucesso = await _pesquisaController.removerPesquisador(
              pesquisaId: pesquisaId,
              userId: u.id!,
            );
            if (sucesso) {
              setState(() {
                selectedUsers.remove(u);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Erro ao remover pesquisador")),
              );
            }
          },
          xIsVisible: true,
        );
      },
    ));
  }

//Retirar esta parte, redundância.
  Future<void> alreadySelectedUsersSection({List<int>? userId}) async {
    userId ??= [];

    print(userId);

    List<User> users = await userFuture;

    // Filtrando os usuários com o mesmo ID do último `userId`
    List<User> filteredUsers = userId!.isNotEmpty
        ? users.where((element) => userId!.contains(element.id)).toList()
        : [];

    filteredUsers.forEach(
      (element) => print(element.id),
    );
    // Verifica se existem usuários filtrados
    if (filteredUsers.isNotEmpty) {
      setState(() {
        selectedUsers.addAll(filteredUsers);
      });
    }
  }
  // Caso nenhum dado seja recebido

  Widget showUsers(List<User> posts) {
    return SizedBox(
      height: 800.h,
      child: ListView.builder(
        itemCount:
            posts.where((post) => post.accessLevel == 'Pesquisador').length,
        itemBuilder: (context, index) {
          final filteredPosts =
              posts.where((post) => post.accessLevel == 'Pesquisador').toList();
          final post = filteredPosts[index];
          final isSelected = selectedUsers.contains(post);
          return GestureDetector(
            onTap: () {
              _pesquisaController.addUserPesquisa(post);

              setState(() {
                if (isSelected) {
                  selectedUsers
                      .remove(post); // Remove se já estiver selecionado
                } else {
                  selectedUsers
                      .add(post); // Adiciona se não estiver selecionado
                }
              });
            },
            child: UserPesquisaCardList(
              user: post,
              isSelected: isSelected,
            ),
          );
        },
      ),
    );
  }
}
