import 'package:flutter/material.dart';
import 'package:inventur/models/estado_model.dart';
import 'package:inventur/models/municipio_model.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/models/user_model.dart';
import 'package:inventur/services/brasil_service.dart';

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
  
  final List<String> _estados = [];
  final List<String> _municipios = [];
  final List<String> statusItems = [
    _finished,
    _notStarted,
    _inProgress
  ];

  List<User> _usersPesquisas = [];
  List<Pesquisa> _pesquisas = [];

  set setPesquisas(List<Pesquisa> pesquisas) {
    _pesquisas = pesquisas;
    notifyListeners();
  }

  set setUsers(List<User> users) {
    _usersPesquisas = users;
  }

  List<String> get estados => _estados;
  List<String> get municipios => _municipios;
  List<Pesquisa> get pesquisas => _pesquisas;
  List<User> get userPesquisa => _usersPesquisas;
  List<String> get informacoesPesquisa => _informacoesPesquisa;

  void setEstados() async {
    final List<Estado> source = await _brasilService.fetchEstados();

    for (Estado uf in source) {
      _estados.add(uf.nome);
    }
  }

  void setMunicipios(String uf) async {
    final List<Municipio> source = await _brasilService.fetchMunicipiosUF(uf);

    if (_municipios.isNotEmpty) _municipios.clear();

    for (Municipio municipio in source) {
      _municipios.add(municipio.nome);
    }
  }

  void addPesquisa(Pesquisa pesquisa) {
    _pesquisas.add(pesquisa);
    notifyListeners();
  }

  void addUserPesquisa(User user) {
    _usersPesquisas.add(user);
    notifyListeners();
  }

  void removeUserPesquisa(User user) {
    _usersPesquisas.remove(user);
    notifyListeners();
  }

  void setPesquisaStatus(String status, Pesquisa pesquisa) {
    pesquisa.status = status;
    notifyListeners();
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