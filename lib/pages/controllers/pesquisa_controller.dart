import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventur/models/estado_model.dart';
import 'package:inventur/models/municipio_model.dart';
import 'package:inventur/models/pais_model.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/services/brasil_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class PesquisaController extends ChangeNotifier {
  static const String _finished = "Concluído";
  static const String _notStarted = "Não Iniciado";
  static const String _inProgress = "Em Andamento";
  static const List<String> _informacoesPesquisa = [
    "Código IBGE",
    "Estado",
    "Município",
    "Data de Início",
    "Data de Término",
    "Quantidade de\nLocais Cadastrados",
    "Quantidade de\nPesquisadores"
  ];
  
  final BrasilService _brasilService = BrasilService();
  
  final List<String> statusItems = [
    _finished,
    _notStarted,
    _inProgress
  ];

  List<Estado> _estados = [];
  List<Pais> _paises=[];
  List<Pesquisa> _pesquisas = [];
  List<User> _usersPesquisas = [];
  List<Municipio> _municipios = [];

  set setPesquisas(List<Pesquisa> pesquisas) {
    _pesquisas = pesquisas;
    notifyListeners();
  }

  set setUsers(List<User> users) {
    _usersPesquisas = users;
  }

  List<Estado> get estados => _estados;
  List<Pais> get paises => _paises;
  List<Pesquisa> get pesquisas => _pesquisas;
  List<Municipio> get municipios => _municipios;
  List<User> get userPesquisa => _usersPesquisas;
  List<String> get informacoesPesquisa => _informacoesPesquisa;

  Estado? getEstadoByNome(String nome) {
    late Estado? estado;
    
    for (Estado uf in _estados) {
      if (uf.nome == nome) estado = uf;
    }

    return estado;
  }

    void removePesquisa(bool active, Pesquisa pesquisa) async {
    var url =
        Uri.parse('${AppConstants.BASE_URI}/api/v1/pesquisa/update/${pesquisa.id}');

    try {
final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');

      final response =  await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: json.encode({
          'is_active': active
        }),
      );

      if (response.statusCode == 204) {
        print('Usuario deletado com sucesso');
      } else {
        print('Falha ao deletar: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro $e');
    }

    _pesquisas.removeWhere((u) => u.id == pesquisa.id);
    notifyListeners();
  }

static DateTime parseDate(String dateStr) {
  // Remove o sufixo "at ..." se existir
  String cleaned = dateStr.split('at').first.trim();

  // Se a string contém traços, assume o padrão "yyyy-MM-dd"
  if (cleaned.contains('-')) {
    return DateFormat('yyyy-MM-dd').parse(cleaned);
  }
  // Se a string contém barras, assume o padrão "dd/MM/yyyy"
  else if (cleaned.contains('/')) {
    return DateFormat('dd/MM/yyyy').parse(cleaned);
  }
  else {
    throw FormatException('Formato desconhecido para data: $dateStr');
  }
}

Future<bool> atualizarPesquisa({
  required int pesquisaId,
  required int adminId,
  required String rawDataInicio,
  required String rawDataTermino,
  required String codigoIBGE,
  required String estado,
  required String municipio,
  required Set<User> selectedUsers,
}) async {
  var url = Uri.parse('${AppConstants.BASE_URI}/api/v1/pesquisa/$pesquisaId/atualizar/');
  
  // Ajustar as datas caso contenham o formato 'at'
  if (rawDataInicio.contains('at')) {
    rawDataInicio = rawDataInicio.split('at').first.trim();
    rawDataTermino = rawDataTermino.split('at').first.trim();
  }

  try {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    // Converter as datas para o formato correto
    DateTime dtInicio = parseDate(rawDataInicio);
    DateTime dtTermino = parseDate(rawDataTermino);

    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    String dataInicioFormatada = outputFormat.format(dtInicio);
    String dataTerminoFormatada = outputFormat.format(dtTermino);

    // Fazer a requisição PATCH
    var response = await http.patch(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: json.encode({
        'admin': adminId,
        'dataInicio': dataInicioFormatada,
        'dataTermino': dataTerminoFormatada,
        'codigoIBGE': codigoIBGE,
        'estado': estado,
        'municipio': municipio,
        'usuario': selectedUsers.map((user) => user.id).toList(),
      }),
    );

    // Verificar o código de status da resposta
    if (response.statusCode == 200) {
      print("Pesquisa atualizada com sucesso!");
      print("Resposta: ${response.body}");
      final idx = _pesquisas.indexWhere((p) => p.id == pesquisaId);
      if(idx != -1){
        _pesquisas[idx] = _pesquisas[idx].copyWith(
          dataInicio: dataInicioFormatada,
          dataTermino: dataTerminoFormatada,
          codigoIBGE: codigoIBGE,
          estado: estado,
          municipio: municipio,
          pesquisadores: selectedUsers.map((user) => user.id).toList(),
        );
      }
      notifyListeners();
    return true;
      
    } else {
      print("Erro ao atualizar pesquisa. Código de status: ${response.statusCode}");
      print("Resposta do servidor: ${response.body}");
      return false;
    }
  } catch (e) {
    print("Erro ao fazer a requisição: $e");
    return false;
  }
  notifyListeners();
}


  Municipio? getMunicipioByNome(String nome) {
    late Municipio? municipio;

    for (Municipio mun in _municipios) {
      if (mun.nome == nome) municipio = mun;
    }

    return municipio;
  }

  Pais? getPaisesByNome(String nome){
    late Pais? pais;

    for(Pais paiss in _paises){
      if(paiss.nome == nome) pais = paiss;
    }
    return pais;
  }

  void setEstados() async {
    _estados = await _brasilService.fetchEstados();
  }

  void setPaises() async{
    _paises = await _brasilService.fetchPaises();

  }

  void setMunicipios(int uf) async {
    _municipios = await _brasilService.fetchMunicipiosUF(uf);
  }

  void addPesquisa(List<Pesquisa> pesquisas) {
    _pesquisas = pesquisas;
    notifyListeners();
  }



  void addUserPesquisa(User user) {

    if(!_usersPesquisas.any((u) => u.id == user.id)){
      _usersPesquisas.add(user);
    notifyListeners();

    }
  }

  void removeUserPesquisa(User user) {
    _usersPesquisas.remove(user);
    notifyListeners();
  }

  void setPesquisaStatus(String status, Pesquisa pesquisa)async{
    pesquisa.status = status;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');
    var url = Uri.parse(
      '${AppConstants.BASE_URI}/api/v1/pesquisa/status/update/${pesquisa.id}/');

      try{
        await http.patch(
          url,
          headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer $token"
          },
          body: json.encode({
            'status': status
          })
        );
      }catch(e){
        print("Erro ao atualizar o status no banco: $e");
      }
  }

  Color? statusColor(String status) {
    switch (status) {
      case _inProgress:
        return Colors.blue[600];
      case _finished:
        return Colors.green[600];
      case _notStarted:
        return Colors.orange[600];
    }
    return null;
  }
}