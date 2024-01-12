import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  final String nome;
  final String cpf;
  final String email;

  const UserCard({
    super.key,
    required this.nome,
    required this.cpf,
    required this.email
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final List<String> statusItems = ['Aguardando Aprovação', 'Ativo', 'Não Ativo'];
  late String dropValue;

  Color statusColor = Colors.orange;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    dropValue = statusItems.first;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45)
                            ),
                            value: isSelected, 
                            visualDensity: VisualDensity.compact,
                            onChanged: (value) {
                              setState(() {
                                isSelected = value!;
                              });
                            },
                          ),
                          Text(
                            widget.nome,
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
                            widget.cpf,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18
                            ),
                          ),
                          Text(
                            widget.email,
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
                borderRadius: BorderRadius.circular(30)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Status: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ),
                  ),
                  DropdownButton(
                    isDense: true,
                    value: dropValue,
                    underline: Container(),
                    iconEnabledColor: Colors.black,
                    alignment: AlignmentDirectional.centerEnd,
                    items: statusItems.map<DropdownMenuItem<String>>((String status) {
                      return DropdownMenuItem(
                        value: status,
                        child: Text(status)
                      );
                    }).toList(), 
                    onChanged: (value) {
                      setState(() {
                        dropValue = value!;
                        if (dropValue == 'Aguardando Aprovação') statusColor = Colors.orangeAccent[400]!;
                        if (dropValue == 'Ativo') statusColor = Colors.greenAccent[700]!;
                        if (dropValue == 'Não Ativo') statusColor = Colors.redAccent[400]!;
                      });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}