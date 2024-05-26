import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';

class Estados extends StatefulWidget {
  const Estados({super.key});

  @override
  State<Estados> createState() => _EstadosState();
}

class _EstadosState extends State<Estados> {
  List<String> states = [];
  String? selectedState;

  @override
  void initState() {
    super.initState();
    getStates();
  }

  Future<void> getStates() async {
    var response = await http.get(Uri.parse(
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados'));
    var jsonResponse = jsonDecode(response.body);

    setState(() {
      for (var state in jsonResponse) {
        states.add(state['sigla']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return SizedBox(
        width: sizeScreen.width * 0.9,
        child: TextFormField(
          decoration: const InputDecoration(hintText: 'Selecione um estado'),
          onChanged: (value) {
           
          },
        ), );
  }
}
