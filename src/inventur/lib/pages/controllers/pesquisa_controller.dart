import 'package:flutter/material.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/models/user_model.dart';

class PesquisaController extends ChangeNotifier {
  static const List<String> _informacoesPesquisa = [
    "Código IBGE",
    "Estado",
    "Município",
    "Data de Início",
    "Data de Término",
    "Quantidade de\nLocais Cadastrados",
    "Quantidade de\nPesquisadores"
  ];

  List<UserModel> _usersPesquisas = [];
  List<PesquisaModel> _pesquisas = [];

  set setPesquisas(List<PesquisaModel> pesquisas) {
    _pesquisas = pesquisas;
    notifyListeners();
  }

  set setUsers(List<UserModel> users) {
    _usersPesquisas = users;
  }

  List<PesquisaModel> get pesquisas => _pesquisas;
  List<UserModel> get userPesquisa => _usersPesquisas;
  List<String> get informacoesPesquisa => _informacoesPesquisa;

  void addPesquisa(PesquisaModel pesquisa) {
    _pesquisas.add(pesquisa);
    notifyListeners();
  }

  void addUserPesquisa(UserModel user) {
    _usersPesquisas.add(user);
    notifyListeners();
  }

  void removeUserPesquisa(UserModel user) {
    _usersPesquisas.remove(user);
    notifyListeners();
  }

}