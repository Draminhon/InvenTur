import 'package:flutter/material.dart';

class PopupMenu extends StatefulWidget {
  final String? tooltip;
  final String selectedItem;
  final List<String> itens;
  final IconData popupIcon;
  final Function? onChanged;
  final bool rightIconPosition;

  const PopupMenu({
    super.key,
    this.tooltip,
    this.onChanged,
    this.rightIconPosition = true,
    required this.itens,
    required this.popupIcon,
    required this.selectedItem,
  });

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem  = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: const Color.fromARGB(255, 55, 111, 60),
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: PopupMenuButton(
        tooltip: widget.tooltip,
        initialValue: selectedItem,
        surfaceTintColor: Colors.white,
        itemBuilder: (context) {
          return widget.itens.map<PopupMenuItem<String>>((String value) {
            return PopupMenuItem(
              value: value,
              child: Text(value),
            );
          }).toList();
        },
        onSelected: (String value) {
          widget.onChanged!(value);
          setState(() {
            selectedItem = value;
          });
        },
        child: Row(
          children: [
            widget.rightIconPosition
            ? Icon(
              widget.popupIcon,
              color: const Color.fromARGB(255, 55, 111, 60),
            )
            : Container(),
            SizedBox(
              width: 110,
              child: Text(
                selectedItem,
                overflow: TextOverflow.ellipsis,
                textAlign: widget.rightIconPosition
                ? TextAlign.end
                : TextAlign.start
              ),
            ),
            widget.rightIconPosition
            ? Container()
            : Icon(
              widget.popupIcon,
              color: const Color.fromARGB(255, 55, 111, 60),
            )
          ],
        ),
      ),
    );
  }
}