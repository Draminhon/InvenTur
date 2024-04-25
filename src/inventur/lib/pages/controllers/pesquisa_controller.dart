import 'package:flutter/material.dart';
import 'package:inventur/models/pesquisa_model.dart';

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

  List<PesquisaModel> _pesquisas = [];

  set setPesquisas(List<PesquisaModel> pesquisas) {
    _pesquisas = pesquisas;
    notifyListeners();
  }

  List<String> get informacoesPesquisa => _informacoesPesquisa;
  List<PesquisaModel> get pesquisas => _pesquisas;

  void addPesquisa(PesquisaModel pesquisa) {
    _pesquisas.add(pesquisa);
    notifyListeners();
  }

}