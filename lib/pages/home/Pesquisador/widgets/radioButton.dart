import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';

enum opcoes { a, b, c, d, e, f, g, h, i, j }

class RadioB extends StatefulWidget {
  const RadioB({super.key, required this.name, required this.getValue});
  final String name;
  final Function(String) getValue;
  @override
  State<RadioB> createState() => _RadioState();
}

class _RadioState extends State<RadioB> {
  opcoes? _opcoes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text(widget.name),
            leading: Radio<opcoes>(
              value: opcoes.a,
              groupValue: _opcoes,
              onChanged: (opcoes? value) {
                setState(() {
                  _opcoes = value;
                  widget.getValue(widget.name);
                });
              },
              toggleable: true,
            )),
      ],
    );
  }
}

class RadioC extends StatefulWidget {
  final String? indexModel;

  const RadioC(
      {super.key,
      required this.number,
      required this.options,
      required this.getValue,
      this.indexModel});
  final List<String> options;
  final int number;
  final Function(String) getValue;
  @override
  State<RadioC> createState() => _RadioStateC();
}

class _RadioStateC extends State<RadioC> {
  int? _value;
  @override
  void initState() {
    print(widget.indexModel);

    super.initState();
    if (widget.indexModel != null) {
      _value = widget.options.indexOf(widget.indexModel!);
      widget.getValue(widget.indexModel!);
      // widget.getValue(widget.options[i]);
      if (_value == -1) {
        _value = null;
      }
    }
  }

  int? _groupValue;
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    int half = (widget.number / 2).ceil().toInt();
    final sizeScreen = MediaQuery.sizeOf(context);
    List<Widget> radioButtons = [];
    for (var i = 0; i < widget.number; i++) {
      if (i % 2 == 0) {
        radioButtons.add(ListTile(
            dense: true,
            title: Tooltip(
                message: widget.options[i],
                child: Container(
                    //width: sizeScreen.width * 0.4,
                    //height: sizeScreen.height * 0.056,
                    child: Text(widget.options[i],
                        style: TextStyle(fontSize: 70.h),
                        // textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis))),
            leading: Radio<int>(
              value: i,
              groupValue: _value,
              onChanged: i == widget.number
                  ? null
                  : (value) {
                      setState(() {
                        if (value != null) {
                          _value = value;
                        }
                        widget.getValue(widget.options[i]);
                      });
                    },
            )));
      } else {
        radioButtons.add(ListTile(
            dense: true,
            title: Tooltip(
                message: widget.options[i],
                child: Container(
                    //width: sizeScreen.width * 0.4,
                    //  height: sizeScreen.height * 0.056,
                    child: Text(widget.options[i],
                        style: TextStyle(fontSize: 70.h),
                        //textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis))),
            leading: Radio<int>(
              value: i,
              groupValue: _value,
              onChanged: i == widget.number
                  ? null
                  : (value) {
                      setState(() {
                        if (value != null) {
                          _value = value;
                        }
                        widget.getValue(widget.options[i]);
                      });
                    },
            )));
      }
    }
    if (widget.number.isOdd) {
      radioButtons.add(SizedBox(
        height: sizeScreen.height * 0.059,
      ));
    }

    return ExpansionTile(
      trailing: Icon(
        _isExpanded ? Icons.expand_less : Icons.expand_circle_down,
        color: Color.fromARGB(255, 55, 111, 60),
      ),
      collapsedIconColor: Color.fromARGB(255, 55, 111, 60),
      onExpansionChanged: (bool expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      collapsedBackgroundColor: Colors.grey[200],
      tilePadding: EdgeInsets.only(
          left: sizeScreen.width * 0.42, right: sizeScreen.width * 0.1),
      shape: const Border(),
      title: Container(
        child: const Text(
          'opções',
          style: TextStyle(
              color: Color.fromARGB(255, 55, 111, 60),
              fontWeight: FontWeight.bold),
        ),
      ),
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: Column(
              children: radioButtons.take(half).toList(),
            ),
          ),
          Expanded(
            child: Column(
              children: radioButtons.skip(half).toList(),
            ),
          ),
        ]),
        _groupValue == widget.options.indexOf('outro')
            ? CustomTextField(
                name: 'qual?',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (newValue) {
                  widget.getValue('outro: $newValue');
                },
              )
            : Container()
      ],
    );
  }
}

class RadioD extends StatefulWidget {
  const RadioD(
      {super.key,
      required this.options,
      required this.getValue,
      this.indexModel,
      this.validator});
  final List<String> options;
  final String? indexModel;
  final Function(String) getValue;
  final String? Function(String?)? validator;
  @override
  State<RadioD> createState() => RadioStateD();
}

class RadioStateD extends State<RadioD> {
  int? _value;
  opcoes? options = opcoes.a;
  bool _isExpanded = false;
  String? _errorText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.indexModel != null) {
      _value = widget.options.indexOf(widget.indexModel!);
      widget.getValue(widget.indexModel!);
      // widget.getValue(widget.options[i]);
      if (_value == -1) {
        _value = null;
      }
    }
  }

  bool validate() {
    if (widget.validator == null) return true;

    String? selectedValue;
    if (_value != null) {
      selectedValue = widget.options[_value!];
    }

    final String? result = widget.validator!(selectedValue);

    setState(() {
      _errorText = result;
    });

    return _errorText == null;
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return   
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
            trailing: Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_circle_down,
              color: Color.fromARGB(255, 55, 111, 60),
            ),
            collapsedIconColor: Color.fromARGB(255, 55, 111, 60),
            onExpansionChanged: (bool expanded) {
              setState(() {
                _isExpanded = expanded;
              });
            },
            collapsedBackgroundColor: Colors.grey[200],
            shape: Border(),
            title: const Text(
              'OPÇÕES',
              style: TextStyle(
                  color: Color.fromARGB(255, 55, 111, 60),
                  fontWeight: FontWeight.bold),
            ),
            tilePadding: EdgeInsets.only(
                left: sizeScreen.width * 0.42, right: sizeScreen.width * 0.1),
            children: [
              for (int i = 0; i < widget.options.length; i++)
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0,
                  ),
                  child: ListTile(
                      dense: true,
                      title: Text(
                        widget.options[i],
                        style: TextStyle(fontSize: 60.w),
                      ),
                      leading: Radio<int>(
                        value: i,
                        groupValue: _value,
                        onChanged: i == widget.options.length
                            ? null
                            : (value) {
                                setState(() {
                                  _errorText = null;
                                  if (value != i) {
                                    _value = null;
                                  } else {
                                    _value = value;
                                    widget.getValue(widget.options[i]);
                                  }
                                });
                              },
                        toggleable: true,
                      )),
                ),
            ]),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              _errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
            ),
          ),

          
        _value == widget.options.indexOf('outro')
            ? CustomTextField(
                name: 'qual?',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }

                  return null;
                },
                getValue: (newValue) {
                  widget.getValue('outro: $newValue');
                },
              )
            : Container(),
      ],
    );
  }
}

class RadioFormField extends StatefulWidget {
  // Propriedades que seu widget vai receber
  final List<String> options;
  final String? initialValue;
  final FormFieldSetter<String>? onSaved; // Função para salvar o valor
  final FormFieldValidator<String>? validator; // Função de validação

  const RadioFormField({
    super.key,
    required this.options,
    this.initialValue,
    this.onSaved,
    this.validator,
  });

  @override
  State<RadioFormField> createState() => _RadioFormFieldState();
}

class _RadioFormFieldState extends State<RadioFormField> {

  late final TextEditingController _outroController;  
  bool _isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _outroController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
      _outroController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      onSaved: (value) {
        if(widget.onSaved == null) return;

        if(value == 'outro'){
          widget.onSaved!('outro: ${_outroController.text}');
        }else{
          widget.onSaved!(value);
        }
      },
      validator: widget.validator ?? (value) {
            if (value == null) {
              return "Por favor, selecione uma opção";
            }

            if(value =='outro' && _outroController.text.trim().isEmpty){
              return 'Por favor, especifique a opção "outro".';
            }
            return null;
          },
      initialValue: widget.initialValue,
      
      // 3. O `builder` é responsável por construir a UI do seu campo
      builder: (FormFieldState<String> field) {
        // `field` é o estado do nosso campo (tem valor, erro, etc.)
        
        // Função para atualizar o estado do FormField quando uma opção é selecionada
        void onChanged(String? value) {
          field.didChange(value); 
          
          if(value!='outro'){
            _outroController.clear();
          }

        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sua UI de ExpansionTile continua a mesma
            ExpansionTile(
              trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_circle_down,
              color: Color.fromARGB(255, 55, 111, 60)),
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _isExpanded = expanded;
                });
              },
               collapsedIconColor: Color.fromARGB(255, 55, 111, 60),
              title: Text('OPÇÕES', style: TextStyle(
                color: Color.fromARGB(255, 55, 111, 60),
                fontWeight: FontWeight.bold
              ),textAlign: TextAlign.center,
              ),
            collapsedBackgroundColor: Colors.grey[200],
shape: Border(),
              children: [
                for (final option in widget.options)
                  ListTile(
                    title: Text(option),
                    leading: Radio<String>(
                      // Use o valor do FormField para saber qual está selecionado
                      groupValue: field.value,
                      value: option,
                      // Ao mudar, atualize o estado do FormField
                      onChanged: onChanged,
                    ),
                    onTap: () => onChanged(option),
                  ),
              ],
            ),
            
            if (field.value == 'outro')
              Padding(
                padding: const EdgeInsets.only(top: 12.0), // Adiciona um espaçamento
                child: CustomTextField(
                  // Passamos o controller para o CustomTextField
                  controller: _outroController,
                  name: 'Qual?',
                  // A validação principal já está no FormField,
                  // mas podemos manter uma aqui para o feedback imediato.
                  validat: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                ),
              ),


            // 4. Mostra o erro vindo diretamente do estado do FormField
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}