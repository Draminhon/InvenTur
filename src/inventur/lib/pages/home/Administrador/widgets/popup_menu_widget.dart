import 'package:flutter/material.dart';

class PopupMenu extends StatefulWidget {
  final List<String> itens;
  final String? tooltip;
  final bool rightIconPosition;
  final IconData popupIcon;

  const PopupMenu({
    super.key,
    this.tooltip,
    this.rightIconPosition = true,
    required this.itens,
    required this.popupIcon,
  });

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem  = widget.itens.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColor
        ),
        borderRadius: BorderRadius.circular(30)
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
          setState(() {
            selectedItem = value;
          });
        },
        child: Row(
          children: [
            widget.rightIconPosition
            ? Icon(
              widget.popupIcon,
              color: Colors.black,
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
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}