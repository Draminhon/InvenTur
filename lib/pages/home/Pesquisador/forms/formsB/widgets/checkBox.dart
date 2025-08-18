import 'dart:collection';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';

class CheckB extends StatefulWidget {
  const CheckB({super.key, required this.nomes});
  final List<String> nomes;
  @override
  State<CheckB> createState() => _CheckBState();
}

class _CheckBState extends State<CheckB> {
  late List<bool> isChecked;
  late Queue<int> positions;
  int size = 0;
  @override
  void initState() {
    super.initState();
    isChecked = List.generate(widget.nomes.length, (_) => false);
    positions = Queue<int>();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
     final ScrollController firstController = ScrollController();
    return 
    
    SizedBox(
        //width: sizeScreen.width,
       // height:  0.2.h,
        child: RawScrollbar(
thumbColor: const Color.fromARGB(255, 55, 111, 60),

          controller: firstController,
          thumbVisibility: true,
            child: ListView.builder(
              controller: firstController,
                itemCount: widget.nomes.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    (ListTile(
                        title: Tooltip(
                            message: widget.nomes[index],
                            child: Text(
                              widget.nomes[index],
                             
                            )),
                        leading: Checkbox(
                            value: isChecked[index],
                            onChanged: (bool? value) {
                              setState(() {
                                if (value != null) {
                                  isChecked[index] = value;
                                }
                                if (isChecked[index] == true) {
                                  positions.add(index);
                                  size += 1;
                                } else {
                                  positions.remove(index);
                                  size -= 1;
                                }
                                if (size > 3) {
                                  int first = positions.removeFirst();
                                  isChecked[first] = false;

                                  size -= 1;
                                }
                              });
                            })))
                  ]);
                })));
  }
}

class CheckC extends StatefulWidget {
  const CheckC({super.key, required this.nomes, this.nomesModel, this.nome, this.onChanged });
  final List<String> nomes;
  final List<String>? nomesModel;
    final Function(List<String>)? onChanged;

  final String? nome;
  @override
  State<CheckC> createState() => CheckCState();
}

class CheckCState extends State<CheckC> {
    Map<String, dynamic>? valoresjson = {};

  late List<bool> isChecked;
  late Queue<int> positions;

  int size = 0;
  @override
  void initState() {
    super.initState();
    isChecked = List.generate(widget.nomes.length, (_) => false);
    positions = Queue<int>();
    if(widget.nomesModel != null){
    for(int i = 0; i<widget.nomes.length; i++){
      if(widget.nomesModel!.contains(widget.nomes[i])){
          isChecked[i] = true;
      }
    }}
WidgetsBinding.instance.addPostFrameCallback((_){
    _updateSelectedValues();

});
  }

  List<String> getSelectedValues(){
    List<String> selectedValues = [];
    for(int i = 0; i<isChecked.length; i++){
      if(isChecked[i]){
        selectedValues.add(widget.nomes[i]);
      }
    }
    return selectedValues;
  }

  void _updateSelectedValues(){
    if(widget.onChanged != null){
      widget.onChanged!(getSelectedValues());
    }
  }

    void _onCheckboxChanged(int index, bool? value) {
 
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    final ScrollController firstController = ScrollController();
    return 
    SizedBox(
      width: sizeScreen.width,
      height: widget.nomes.length == 3 ? 500.w : 700.h,
      child: RawScrollbar(
        thumbColor: const Color.fromARGB(255, 55, 111, 60),
        controller: firstController,
        thumbVisibility: true,
        child: ListView.builder(
          
          controller: firstController,
          itemCount: widget.nomes.length,
          itemBuilder: (context, index) {
            return Column(children: [
              ListTile(
                  title: Tooltip(
                      message: widget.nomes[index],
                      child: Text(
                        widget.nomes[index],
                        overflow: TextOverflow.clip,
                        style: TextStyle(fontSize: 60.w),
                      )),
                  leading: Checkbox(
                      
                      value: isChecked[index],
                      onChanged: (bool? value) {
                             setState(() {
      isChecked[index] = value ?? false;
          _updateSelectedValues();

    });

    // Atualiza o callback com os novos valores selecionados
                      })),
                      
              widget.nomes[index] == 'outro' && isChecked[index] == true
                  ?  CustomTextField(name: 'qual?', validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            }, getValue: (String ) {  },)
                  : Container(),
            ]);
          },
        ),
      ),
    );
  }
}

class CheckboxGroupFormField extends StatefulWidget {
  final List<String> options;
  final List<String>? initialValue;
  final FormFieldSetter<List<String>>? onSaved;
  final FormFieldValidator<List<String>>? validator;
  final String? title;
  final bool isLimitedBy3;
  const CheckboxGroupFormField({
    super.key,
    required this.options,
    this.initialValue,
    this.onSaved,
    this.validator,
    this.isLimitedBy3 = false, this.title = ''
  });

  @override
  State<CheckboxGroupFormField> createState() => _CheckboxGroupFormFieldState();
}

class _CheckboxGroupFormFieldState extends State<CheckboxGroupFormField> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
    
  }
  int countMarkd = 0;
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return FormField<List<String>>(
      onSaved: widget.onSaved,
      validator: widget.validator ?? (values) {
            if (values == null || values.isEmpty) {
              return 'Selecione pelo menos uma opção.';
            }
            if (values.contains('outro') &&
                !values.any((v) => v.startsWith('outro:'))) {
              return 'Por favor, especifique a opção "outro".';
            }
            return null; // Válido
          },
      initialValue: widget.initialValue ?? [],
      builder: (FormFieldState<List<String>> field) {
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.title != '' ? SizedBox(
            height: 55.h,
          ) : SizedBox(),
          widget.title != '' ? textLabel(
            name: widget.title!,
            fontWeight: FontWeight.bold,
          ) : SizedBox(),
          widget.title != '' ? SizedBox(
            height: 55.h,
          ) : SizedBox(),
            SizedBox(
              width: sizeScreen.width,
              height: 550.h, 
              child: RawScrollbar(
                controller: _scrollController,
                thumbColor: const Color.fromARGB(255, 55, 111, 60),
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: widget.options.length,
                  itemBuilder: (context, index) {
                    final option = widget.options[index];
                    // O estado 'checked' é derivado diretamente do valor do FormField
                    final bool isChecked = field.value!.contains(option);
             void toggleCheckbox(bool? value) {
                List<String> newValues = List.from(field.value!);
                if (value == true) {
                  newValues.add(option);
                  countMarkd+=1;

                } else {
                  newValues.remove(option);
                  countMarkd-=1;
                }

                if(countMarkd > 3 && widget.isLimitedBy3){
                                newValues.removeAt(0);
                                countMarkd-=1;

                              }
                field.didChange(newValues);
              }
                    return Column(
                      children: [
                        ListTile(
                          onTap: () => toggleCheckbox(!isChecked),
                          title: Tooltip(
                            message: option,
                            child: Text(
                              option,
                              overflow: TextOverflow.clip,
                              // style: TextStyle(fontSize: 60.w),
                            ),
                          ),
                          leading: Checkbox(
                            value: isChecked,

                            onChanged: (bool? value) {
                              // ALTERAÇÃO 4: Lógica de mudança centralizada aqui
                              // Criamos uma nova lista a partir do valor atual do campo
                              List<String> newValues = List.from(field.value!);

                              if (value == true) {
                                // Adiciona o item se for marcado
                                if (!newValues.contains(option)) {
                                  newValues.add(option);
                                }
                                countMarkd+=1;
                                print(countMarkd);

                              } else {

                                // Remove o item se for desmarcado
                                newValues.remove(option);
                                countMarkd-=1;
                                print(countMarkd);

                              }

                              if(countMarkd > 3 && widget.isLimitedBy3){
                                newValues.removeAt(0);
                                countMarkd-=1;

                              }

                              // Notifica o FormField sobre a mudança com a nova lista
                              field.didChange(newValues);
                            },
                          ),
                        ),
                        // Lógica para o campo "outro"
                        if (option == 'outro' && isChecked)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                            child: TextFormField( // Exemplo com TextFormField
                              decoration: const InputDecoration(labelText: 'Qual?'),
                              // ALTERAÇÃO 5: Atualiza o valor do campo "outro"
                              onChanged: (text) {
                                List<String> newValues = List.from(field.value!);
                                // Remove qualquer valor "outro:" antigo para evitar duplicatas
                                newValues.removeWhere((v) => v.startsWith('outro:'));
                                // Adiciona o novo valor com o texto
                                newValues.add('outro: $text');
                                field.didChange(newValues);
                              },
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
            // ALTERAÇÃO 6: Exibe a mensagem de erro vinda do validador do FormField
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