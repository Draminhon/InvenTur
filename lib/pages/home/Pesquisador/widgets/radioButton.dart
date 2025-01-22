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
      required this.getValue, this.indexModel});
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
        if(widget.indexModel != null){
    _value = widget.options.indexOf(widget.indexModel!);
    widget.getValue(widget.indexModel!);
     // widget.getValue(widget.options[i]);
        if(_value == -1){
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
         trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_circle_down, color: Color.fromARGB(255, 55, 111, 60),),
          collapsedIconColor: Color.fromARGB(255, 55, 111, 60),
          onExpansionChanged: (bool expanded){
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
          style: TextStyle(color: Color.fromARGB(255, 55, 111, 60), fontWeight: FontWeight.bold),
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
  const RadioD({super.key, required this.options, required this.getValue, this.indexModel});
  final List<String> options;
  final String? indexModel;
  final Function(String) getValue;
  @override
  State<RadioD> createState() => _RadioStateD();
}

class _RadioStateD extends State<RadioD> {
  int? _value;
  opcoes? options = opcoes.a;
    bool _isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.indexModel != null){
    _value = widget.options.indexOf(widget.indexModel!);
    widget.getValue(widget.indexModel!);
     // widget.getValue(widget.options[i]);
        if(_value == -1){
          _value = null;
        }

    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpansionTile(
          trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_circle_down, color: Color.fromARGB(255, 55, 111, 60),),
          collapsedIconColor: Color.fromARGB(255, 55, 111, 60),
          onExpansionChanged: (bool expanded){
            setState(() {
              _isExpanded = expanded;
            });
          },

          collapsedBackgroundColor: Colors.grey[200],
          shape: Border(),
            title: const Text(
              'OPÇÕES',
              style: TextStyle(color: Color.fromARGB(255, 55, 111, 60), fontWeight: FontWeight.bold),
            ),
            tilePadding: EdgeInsets.only(
                left: sizeScreen.width * 0.42, right: sizeScreen.width * 0.1),
            children: [
              for (int i = 0; i < widget.options.length; i++)
              
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, ),
                  child: ListTile(
                      dense: true,
                      title: Text(
                        widget.options[i],
                        style: TextStyle(fontSize: sizeScreen.height * 0.02,   fontWeight: FontWeight.bold),
                      ),
                      leading: Radio<int>(
                        value: i,
                        groupValue: _value,
                        onChanged: i == widget.options.length
                            ? null
                            : (value) {
                                setState(() {
                                  if (value != i) {
                                    _value = null;
                                  }else{
                                    _value = value;
                                  widget.getValue(widget.options[i]);}
                                  
                                });
                              },
                        toggleable: true,
                      )),
                ),
            ]),
           
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
