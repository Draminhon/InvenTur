import 'package:flutter/material.dart';
import 'package:inventur/models/user_model.dart';

class UserCard extends StatefulWidget {
  final UserModel user;
  final Function? onChanged;

  const UserCard({
    super.key,
    this.onChanged,
    required this.user,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final List<String> statusItems = ['Aguardando Aprovação', 'Ativo', 'Não Ativo'];
  late String dropValue;
  late bool isSelected;
  late Color statusColor;

  @override
  void initState() {
    super.initState();
    dropValue = widget.user.status;
    isSelected = widget.user.isSelected;

    if (dropValue == 'Aguardando Aprovação') statusColor = Colors.orangeAccent[400]!;
    if (dropValue == 'Ativo') statusColor = Colors.greenAccent[700]!;
    if (dropValue == 'Não Ativo') statusColor = Colors.redAccent[400]!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45)
                            ),
                            value: isSelected, 
                            visualDensity: VisualDensity.compact,
                            onChanged: (value) {
                              widget.onChanged!(value);
                              widget.user.isSelected = value!;
                              setState(() {
                                isSelected = value;
                              });
                            },
                          ),
                          Text(
                            widget.user.nome,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 14, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.cpf,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18
                            ),
                          ),
                          Text(
                            widget.user.email,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green[700],
                      )
                    ),
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[700],
                      )
                    ),
                  ],
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14),
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              decoration: BoxDecoration(
                color: statusColor,
                border: Border.all(
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(5)
              ),
              child: PopupMenuButton(
                enableFeedback: true,
                initialValue: dropValue,
                tooltip: 'Status do pesquisador',
                surfaceTintColor: Colors.white,
                itemBuilder: (context) {
                  return statusItems.map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList();
                },
                onSelected: (String value) {
                  dropValue = value;
                  widget.user.status = value;
                  setState(() {
                    if (dropValue == 'Aguardando Aprovação') statusColor = Colors.orangeAccent[400]!;
                    if (dropValue == 'Ativo') statusColor = Colors.greenAccent[700]!;
                    if (dropValue == 'Não Ativo') statusColor = Colors.redAccent[400]!;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Status:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      ),
                    ),
                    Text(
                      dropValue,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}