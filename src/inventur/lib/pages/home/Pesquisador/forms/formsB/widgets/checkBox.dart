import 'dart:collection';

import 'package:flutter/material.dart';

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

  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    List<Widget> listT = [];
    for (int i = 0; i < widget.nomes.length; i++) {
      listT.add(ListTile(
          title: Tooltip(
              message: widget.nomes[i],
              child: Text(
                widget.nomes[i],
                overflow: TextOverflow.ellipsis,
              )),
          leading: Checkbox(
              value: isChecked[i],
              onChanged: (bool? value) {
                setState(() {
                  if (value != null) {
                    isChecked[i] = value;
                  }
                  if (isChecked[i] == true) {
                    positions.add(i);
                    size += 1;
                  } else {
                    positions.remove(i);
                    size -= 1;
                  }
                  if (size > 3) {
                    int first = positions.removeFirst();
                    isChecked[first] = false;

                    size -= 1;
                  }
                });
              })));
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(children: [
        SizedBox(
            width: sizeScreen.width * 0.5,
            child: Column(
              children: listT.take(6).toList(),
            ))
      ]),
      Row(
        children: [
          SizedBox(
            width: sizeScreen.width * 0.5,
            child: Column(
              children: listT.skip(6).take(6).toList(),
            ),
          )
        ],
      )
    ]);
  }
}
