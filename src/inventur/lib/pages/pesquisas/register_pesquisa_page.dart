import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventur/models/estado_model.dart';
import 'package:inventur/models/municipio_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/pesquisas/widgets/user_pesquisa_card_widget.dart';
import 'package:inventur/pages/widgets/auto_complete_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPesquisa extends StatefulWidget {
  const RegisterPesquisa({super.key});

  @override
  State<RegisterPesquisa> createState() => _RegisterPesquisaState();
}

class _RegisterPesquisaState extends State<RegisterPesquisa> with SingleTickerProviderStateMixin {
  bool _tileExpanded = false;

  late Estado? _estadoSelecionado;
  late Municipio? _municipioSelecionado;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final _formPesquisaKey = GlobalKey<FormState>();
  final PesquisaController _pesquisaController = PesquisaController();
  final TextEditingController _inicioController = TextEditingController();
  final TextEditingController _terminoController = TextEditingController();
  final TextEditingController _codigIbgeController = TextEditingController();

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
                                    validator: (value) {
                                      if (value == '') return "Informe a Data de Inicio";
                                      return null;
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
                                    validator: (value) {
                                      if (value == '') return "Informe a Data de Término";
                                      return null;
                                    },
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
                                        _pesquisaController.municipios.clear();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            AutocompleteTextField(
                              label: "Município",
                              onSelected: (option) {
                                _municipioSelecionado = _pesquisaController.getMunicipioByNome(option);
                                setState(() {
                                  _codigIbgeController.text = _municipioSelecionado!.id.toString();
                                });
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
                            ),
                          ],
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
                            AutocompleteTextField(
                              label: "Nome do Pesquisador",
                              onSelected: (option) {
                                
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
                            ),
                            const SizedBox(height: 10),
                            AutocompleteTextField(
                              label: "CPF do Pesquisador",
                              onSelected: (option) {
                                
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
                              inputFormatters: [_cpfMask],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OutlinedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                    ),
                                    side: const MaterialStatePropertyAll(
                                      BorderSide(
                                        color: Color.fromARGB(255, 55, 111, 60)
                                      )
                                    ),
                                    overlayColor: MaterialStatePropertyAll(
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
                                    shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                    ),
                                    side: const MaterialStatePropertyAll(
                                      BorderSide(
                                        color: Color.fromARGB(255, 232, 0, 0)
                                      )
                                    ),
                                    foregroundColor: const MaterialStatePropertyAll(
                                      Color.fromARGB(255, 232, 0, 0)
                                    ),
                                    overlayColor: MaterialStatePropertyAll(
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
                        return _pesquisaController.userPesquisa.isEmpty 
                        ? const Center(
                          child: Text(
                            "Nenhum Pesquisador Adicionado",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                        : ListView.builder(
                          itemCount: _pesquisaController.userPesquisa.length,
                          itemBuilder: (context, index) {
                            return UserPesquisaCard(
                              user: _pesquisaController.userPesquisa[index],
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
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.012
                                  )
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 55, 111, 60)
                                ),
                                overlayColor: MaterialStateProperty.all(
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
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  )
                                ),
                                padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(
                                    vertical: screenSize.height * 0.012
                                  )
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 232, 0, 0)
                                ),
                                overlayColor: MaterialStateProperty.all(
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