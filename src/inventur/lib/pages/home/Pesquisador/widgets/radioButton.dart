import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'dart:math' as math;

enum opcoes { a, b, c, d, e, f, g, h, i, j }

class RadioB extends StatefulWidget {
  const RadioB({super.key});

  @override
  State<RadioB> createState() => _RadioState();
}

class _RadioState extends State<RadioB> {
  opcoes? _opcoes = opcoes.a;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text('Hotelaria e de apoio'),
            leading: Radio<opcoes>(
              value: opcoes.a,
              groupValue: _opcoes,
              onChanged: (opcoes? value) {
                setState(() {
                  _opcoes = value;
                });
              },
              toggleable: true,
            )),
      ],
    );
  }
}

class RadioC extends StatefulWidget {
  const RadioC({super.key, required this.number, required this.options});
  final List<String> options;
  final int number;
  @override
  State<RadioC> createState() => _RadioStateC();
}

class _RadioStateC extends State<RadioC> {
  int _groupValue = 0;

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
                        style: TextStyle(fontSize: sizeScreen.height * 0.02),
                        // textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis))),
            leading: Radio<int>(
              value: i,
              groupValue: _groupValue,
              onChanged: i == widget.number
                  ? null
                  : (value) {
                      setState(() {
                        if (value != null) {
                          _groupValue = value;
                        }
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
                        style: TextStyle(fontSize: sizeScreen.height * 0.02),
                        //textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis))),
            leading: Radio<int>(
              value: i,
              groupValue: _groupValue,
              onChanged: i == widget.number
                  ? null
                  : (value) {
                      setState(() {
                        if (value != null) {
                          _groupValue = value;
                        }
                      });
                    },
            )));
      }
    }
 if(widget.number.isOdd){
  radioButtons.add(SizedBox(height: sizeScreen.height * 0.059,));
 }
   return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
]);
  }
}

class RadioD extends StatefulWidget {
  const RadioD({super.key, required this.options});
  final List<String> options;
  
  @override
  State<RadioD> createState() => _RadioStateD();
}

class _RadioStateD extends State<RadioD> {
  int _value = 0;
  opcoes? options = opcoes.a;
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Column(
      children: [
        for (int i = 0; i < widget.options.length; i++)
          ListTile(
              dense: true,
              title: Text(
                widget.options[i],
                style: TextStyle(fontSize: sizeScreen.height * 0.02),
              ),
              leading: Radio<int>(
                value: i,
                groupValue: _value,
                onChanged: i == widget.options.length
                    ? null
                    : (value) {
                        setState(() {
                          if (value != null) {
                            _value = value;
                            print(widget.options[i]);
                          }
                        });
                      },
                toggleable: true,
              )),
        _value == widget.options.indexOf('outro')
            ? CustomTextField(name: 'qual?')
            : Container(),
      ],
    );
  }
}
