import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Paises extends StatefulWidget {
  const Paises({super.key});

  @override
  State<Paises> createState() => _PaisesState();
}

class _PaisesState extends State<Paises> {
  List<String> countries = [];
  String? selectedCountry;
  final Dio _dio = Dio();

  @override
  void initState(){
    super.initState();
    getCountries();
  }
  
  Future<void> getCountries() async {
    try {
      final response = await _dio.get('https://servicodados.ibge.gov.br/api/v1/localidades/paises');
      final List jsonResponse = response.data;
      
      setState(() {
        countries = jsonResponse.map<String>((country) => country['nome'] as String).toList();
      });
    } catch (e) {
      print("Erro ao buscar países no widget Paises: $e");
    }
  }

  @override 
  Widget build(BuildContext context) {
  final sizeScreen = MediaQuery.of(context).size;
  return SizedBox(
    width: sizeScreen.width,
    child: DropdownButton<String>(
      isExpanded: true,
      padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.05),
      value: selectedCountry,
      items: countries.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: const Text('Selecione um país'),
      menuMaxHeight: sizeScreen.height * 0.5,
      onChanged: (String? value) {
        setState(() {
          selectedCountry = value;
        });
      },
    ),
  );
}
}