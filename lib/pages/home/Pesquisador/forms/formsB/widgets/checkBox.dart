import 'dart:collection';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
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
