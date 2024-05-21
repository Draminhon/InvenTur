import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventur/models/estado_model.dart';
import 'package:inventur/models/municipio_model.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/pesquisas/widgets/user_pesquisa_card_widget.dart';
import 'package:inventur/pages/widgets/auto_complete_text_field.dart';
import 'package:inventur/validators/date_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPesquisa extends StatefulWidget {
  const RegisterPesquisa({super.key});

  @override
  State<RegisterPesquisa> createState() => _RegisterPesquisaState();
}

class _RegisterPesquisaState extends State<RegisterPesquisa> with SingleTickerProviderStateMixin {
  bool _opened = false;
  bool _tileExpanded = false;

  String statusSelecioando = 'Não Iniciado';

  List<User> users = [
    User(nome: "Fulano Silva da Costa", cpf: "789.214.878-02", email: "fulanosilva@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Ciclano Fonseca Silva", cpf: "584.978.010-80", email: "ciclano@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    User(nome: "Beltrano Alves Oliveira", cpf: "785.441.210-70", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Fulano Silva da Costa", cpf: "789.214.878-02", email: "fulanosilva@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Ciclano Fonseca Silva", cpf: "584.978.010-80", email: "ciclano@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    User(nome: "Beltrano Alves Oliveira", cpf: "785.441.210-70", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Fulano Silva da Costa", cpf: "789.214.878-02", email: "fulanosilva@teste.com", status: "Não Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Ciclano Fonseca Silva", cpf: "584.978.010-80", email: "ciclano@teste.com", status: "Aguardando Aprovação", accessLevel: 'Pesquisador'),
    User(nome: "Beltrano Alves Oliveira", cpf: "785.441.210-70", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
    User(nome: "Tiago Alves de Lima", cpf: "078.369.222-03", email: "beltrano@teste.com", status: "Ativo", accessLevel: 'Pesquisador'),
  ];

  late Estado? _estadoSelecionado;
  late Municipio? _municipioSelecionado;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final _formPesquisaKey = GlobalKey<FormState>();
  final PesquisaController _pesquisaController = PesquisaController();
  final TextEditingController _inicioController = TextEditingController();
  final TextEditingController _terminoController = TextEditingController();
  final TextEditingController _codigIbgeController = TextEditingController();
  final TextEditingController _nomePesquisadorController = TextEditingController();

  final DateValidator _dateValidator = DateValidator();

  final _cpfMask = MaskTextInputFormatter(mask: '###.###.###-##');
  final _dataInicialMask = MaskTextInputFormatter(mask: '##/##/####');
  final _dataFinalMask = MaskTextInputFormatter(mask: '##/##/####');

  Future<String> selectDate() async {
    late DateTime? selectedDate;
    final DateTime dateNow = DateTime.now();
    
    selectedDate =  await showDatePicker(
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
      return DateFormat('dd/MM/yyyy').format(selectedDate);
    }
    return '';
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _pesquisaController.setEstados();
    _pesquisaController.setPesquisadores = users;
  }

  var appbar = AppBar(
    title: const Text('Cadastrar Nova Pesquisa'),
    foregroundColor: const Color.fromARGB(255, 55, 111, 60),
    backgroundColor: Colors.white,
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      Form(
                        key: _formPesquisaKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    textAlign: TextAlign.end,
                                    controller: _inicioController,
                                    inputFormatters: [_dataInicialMask],
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      filled: true,
                                      isCollapsed: true,
                                      labelText: "Data Início",
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                                      ),
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
                                    validator: (date) {
                                      return _dateValidator.validate(date: date);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: TextFormField(
                                    textAlign: TextAlign.end,
                                    controller: _terminoController,
                                    inputFormatters: [_dataFinalMask],
                                    keyboardType: TextInputType.datetime,
                                    decoration: InputDecoration(
                                      filled: true,
                                      isCollapsed: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      labelText: "Data Término",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () async {
                                          _terminoController.text = await selectDate();
                                        },
                                        icon: const Icon(
                                          Icons.date_range_rounded,
                                          color: Color.fromARGB(255, 55, 111, 60),
                                        ),
                                      ),
                                    ),
                                    validator: (date) {
                                      return _dateValidator.validate(date: date);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    textAlign: TextAlign.end,
                                    controller: _codigIbgeController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      filled: true,
                                      isCollapsed: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      labelText: "Código IBGE",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == '') return "Informe o Código IBGE";
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: AutocompleteTextField(
                                    label: "Estado",
                                    onSelected: (option) {
                                      _estadoSelecionado = _pesquisaController.getEstadoByNome(option);
                                      _pesquisaController.setMunicipios(_estadoSelecionado!.id);
                                    },
                                    optionsBuilder: (textEditingValue) {
                                      if (textEditingValue.text == '') {
                                        return const Iterable.empty();
                                      }
                                      return _pesquisaController.estados.map((e) => e.nome).where(
                                        (word) => word.toLowerCase().contains(
                                          textEditingValue.text.toLowerCase(),
                                        ),
                                      );
                                    },
                                    onChanged: (value) {
                                      if (value == '') {
                                        _codigIbgeController.text = '';
                                        _municipioSelecionado = null;
                                        _pesquisaController.municipios.clear();
                                        setState(() {});
                                      }
                                    },
                                    validator: (value) {
                                      if (value == '') return "Informe o Estado";
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            AutocompleteTextField(
                              label: "Município",
                              onStateChanged: (textEditingController) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  if (_pesquisaController.municipios.isEmpty) {
                                    textEditingController.text = '';
                                  }
                                });
                              },
                              onSelected: (option) {
                                _municipioSelecionado = _pesquisaController.getMunicipioByNome(option);
                                _codigIbgeController.text = _municipioSelecionado!.id.toString();
                              },
                              optionsBuilder: (textEditingValue) {
                                if (textEditingValue.text == '') {
                                  return const Iterable.empty();
                                }
                                return _pesquisaController.municipios.map((e) => e.nome).where(
                                  (word) => word.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase(),
                                  ),
                                );
                              },
                              onChanged: (value) {
                                if (value == '') {
                                  _codigIbgeController.text = '';
                                }
                              },
                              validator: (value) {
                                if (value == '') return "Informe o Município";
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: const Color.fromARGB(255, 55, 111, 60),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: PopupMenuButton(
                          enableFeedback: true,
                          color: Colors.white,
                          tooltip: 'Status da Pesquisa',
                          position: PopupMenuPosition.under,
                          // initialValue: _pesquisa.status,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          itemBuilder: (context) {
                            return _pesquisaController.statusItems.map<PopupMenuItem<String>>(
                              (String value) {
                                return PopupMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }
                            ).toList();
                          },
                          onSelected: (String value) {
                            setState(() {
                              // _pesquisaController.setPesquisaStatus(value, _pesquisa);
                              statusSelecioando = value;
                              _opened = !_opened;
                            });
                          },
                          onOpened: () => setState(() {
                            _opened = !_opened;
                          }),
                          onCanceled: () => setState(() {
                            _opened = !_opened;
                          }),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Status',
                                  style: TextStyle(
                                    color: _pesquisaController.statusColor(statusSelecioando),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  statusSelecioando,
                                  style: TextStyle(
                                    color: _pesquisaController.statusColor(statusSelecioando),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Icon(
                                  _opened
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                                  color: _pesquisaController.statusColor(statusSelecioando),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border.symmetric(
                            horizontal: BorderSide(
                              color: Color.fromARGB(255, 55, 111, 60)
                            )
                          )
                        ),
                        child: ExpansionTile(
                          shape: const Border.symmetric(
                            horizontal: BorderSide(
                              color: Color.fromARGB(255, 55, 111, 60)
                            )
                          ),
                          childrenPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          title: const Row(
                            children: [
                              Spacer(flex: 2),
                              Text(
                                "Adicionar Pesquisador(es)",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 55, 111, 60),
                                  fontWeight: FontWeight.bold
                                ),
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
                            LayoutBuilder(
                              builder: (context, constraints) => Autocomplete<String>(
                                optionsBuilder: (textEditingValue) {
                                  if (textEditingValue.text == '') return const Iterable.empty();
                                  return users.map((e) => e.cpf).where(
                                    (word) => word.contains(textEditingValue.text),
                                  );
                                },
                                optionsViewBuilder: (context, onSelected, options) => Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 4,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Container(
                                      width: constraints.biggest.width,
                                      constraints: const BoxConstraints(maxHeight: 200),
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        itemCount: options.length,
                                        separatorBuilder: (context, index) => const Divider(
                                          height: 0,
                                          color: Color.fromARGB(255, 55, 111, 60),
                                        ),
                                        itemBuilder: (context, index) {
                                          final User option = users.where(
                                            (element) => element.cpf == options.elementAt(index)
                                          ).first;
                                          return InkWell(
                                            borderRadius: options.length == 1
                                            ? const BorderRadius.all(Radius.circular(10))
                                            : index == 0
                                              ? const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              )
                                              : index == options.length - 1
                                                ? const BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                )
                                                : null,
                                            onTap: () {
                                              onSelected(option.cpf);
                                              _nomePesquisadorController.text = option.nome;
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 6,
                                                vertical: 10,
                                              ),
                                              child: Text(
                                                "${option.cpf}\n${option.nome}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(255, 55, 111, 60),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                                  return TextField(
                                    focusNode: focusNode,
                                    textAlign: TextAlign.end,
                                    inputFormatters: [_cpfMask],
                                    controller: textEditingController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      isCollapsed: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.all(10),
                                      labelText: "CPF do Pesquisador",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                                      )
                                    ),
                                    onChanged: (value) {
                                      if (value == '') {
                                        _nomePesquisadorController.text = '';
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              readOnly: true,
                              textAlign: TextAlign.end,
                              controller: _nomePesquisadorController,
                              decoration: InputDecoration(
                                filled: true,
                                isCollapsed: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                                labelText: "Nome do Pesquisador",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                    ),
                                    side: const WidgetStatePropertyAll(
                                      BorderSide(
                                        color: Color.fromARGB(255, 55, 111, 60)
                                      )
                                    ),
                                    overlayColor: WidgetStatePropertyAll(
                                      Colors.green[100]
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    children: [
                                      Text(
                                        "Confirmar",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.done_rounded)
                                    ],
                                  ),
                                ),
                                OutlinedButton(
                                  style: ButtonStyle(
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                    ),
                                    side: const WidgetStatePropertyAll(
                                      BorderSide(
                                        color: Color.fromARGB(255, 232, 0, 0)
                                      )
                                    ),
                                    foregroundColor: const WidgetStatePropertyAll(
                                      Color.fromARGB(255, 232, 0, 0)
                                    ),
                                    overlayColor: WidgetStatePropertyAll(
                                      Colors.red[100]
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Row(
                                    children: [
                                      Text(
                                        "Cancelar",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Icon(Icons.clear_rounded)
                                    ],
                                  ),
                                ),
                              ],
                            )
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
                    child: ListenableBuilder(
                      listenable: _pesquisaController,
                      builder: (context, child) {
                        return _pesquisaController.pesquisadores.isEmpty
                        ? const Center(
                          child: Text(
                            "Nenhum Pesquisador Adicionado",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                        : ListView.builder(
                          itemCount: _pesquisaController.pesquisadores.length,
                          itemBuilder: (context, index) {
                            return UserPesquisaCard(
                              user: _pesquisaController.pesquisadores[index],
                              pesquisaController: _pesquisaController,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: screenSize.height * .06,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.012
                                  )
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  const Color.fromARGB(255, 55, 111, 60)
                                ),
                                overlayColor: WidgetStateProperty.all(
                                  Colors.green[600]
                                )
                              ),
                              onPressed: () {
                                if (_formPesquisaKey.currentState!.validate()) {
                                  
                                }
                              },
                              child: Text(
                                "Confirmar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.height * .03
                                ),
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
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.012
                                  )
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  const Color.fromARGB(255, 232, 0, 0)
                                ),
                                overlayColor: WidgetStateProperty.all(
                                  Colors.red[500]
                                )
                              ),
                              onPressed: () {
                                
                              },
                              child: Text(
                                "Cancelar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.height * .03
                                ),
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
}