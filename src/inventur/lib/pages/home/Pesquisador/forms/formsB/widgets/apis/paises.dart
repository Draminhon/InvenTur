import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Paises extends StatefulWidget {
  const Paises({super.key});

  @override
  State<Paises> createState() => _PaisesState();
}

class _PaisesState extends State<Paises> {
  List<String> states = [];
  String? selectedState;
  @override
  void initState(){
    super.initState();
    getStates();
  }
  
  Future<void> getStates() async{
    var response = await http.get(Uri.parse('https://servicodados.ibge.gov.br/api/v1/localidades/paises'));
    var jsonResponse = jsonDecode(response.body);

    setState(() {
for (var state in jsonResponse){
      states.add(state['nome']);
    }});
  }

  @override
  Widget build(BuildContext context) {
  final sizeScreen = MediaQuery.of(context).size;
  return SizedBox(
    width: sizeScreen.width,
    child: DropdownButton<String>(
      isExpanded: true,
       padding: EdgeInsets.symmetric(horizontal:  sizeScreen.width * 0.05),
      value: selectedState,
      items: states.map<DropdownMenuItem<String>>((String value) {
        return 
        DropdownMenuItem<String>(

          value: value,
          child: 
          Text(value),
        );
      }).toList(),
      hint: const Text('Selecione um país'),
      onChanged: (String? value) {
        setState(() {
          selectedState = value;
        });
      },
    ),
  );
}
}