import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Estados extends StatefulWidget {
  const Estados({super.key});

  @override
  State<Estados> createState() => _EstadosState();
}

class _EstadosState extends State<Estados> {
  List<String> states = [];
  String? selectedState;
  final Dio _dio = Dio();

  @override
  void initState(){
    super.initState();
    getStates();
  }
  
  Future<void> getStates() async{
    try {
      final response = await _dio.get('https://servicodados.ibge.gov.br/api/v1/localidades/estados');
      final List jsonResponse = response.data;

      setState(() {
        states = jsonResponse.map<String>((state) => state['sigla'] as String).toList();
      });
    } catch (e) {
      print("Erro ao buscar estados no widget Estados: $e");
    }
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
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: const Text('Selecione um estado'),
      menuMaxHeight: sizeScreen.height * 0.5,
      onChanged: (String? value) {
        setState(() {
          selectedState = value;
        });
      },
    ),
  );
}
}