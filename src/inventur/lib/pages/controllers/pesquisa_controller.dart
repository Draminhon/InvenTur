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
  
  final List<String> statusItems = [
    _finished,
    _notStarted,
    _inProgress
  ];

  List<Estado> _estados = [];
  List<Pesquisa> _pesquisas = [];
  List<User> _pesquisadores = [];
  List<Municipio> _municipios = [];

  void setPesquisas() async {
    _pesquisas = [
      Pesquisa(
        codigoIBGE: 11111,
        estado: "CE",
        municipio: "Tianguá",
        dataInicio: "01/01/2024",
        dataTermino: "01/01/2024",
        quantidadeLocais: 23,
        quantidadePesquisadores: 5,
        status: "Não Iniciado"
      ),
      Pesquisa(
        codigoIBGE: 22222,
        estado: "CE",
        municipio: "Viçosa do Ceará",
        dataInicio: "01/01/2024",
        dataTermino: "01/01/2024",
        quantidadeLocais: 23,
        quantidadePesquisadores: 5,
        status: "Não Iniciado"
      ),
      Pesquisa(
        codigoIBGE: 33333,
        estado: "CE",
        municipio: "Tianguá",
        dataInicio: "01/01/2024",
        dataTermino: "01/01/2024",
        quantidadeLocais: 23,
        quantidadePesquisadores: 5,
        status: "Não Iniciado"
      ),
      Pesquisa(
        codigoIBGE: 44444,
        estado: "CE",
        municipio: "Viçosa do Ceará",
        dataInicio: "01/01/2024",
        dataTermino: "01/01/2024",
        quantidadeLocais: 23,
        quantidadePesquisadores: 5,
        status: "Não Iniciado"
      ),
    ];
    notifyListeners();
  }

  set setPesquisadores(List<User> pesquisadores) {
    _pesquisadores = pesquisadores;
  }

  List<Estado> get estados => _estados;
  List<Pesquisa> get pesquisas => _pesquisas;
  List<Municipio> get municipios => _municipios;
  List<User> get pesquisadores => _pesquisadores;
  List<String> get informacoesPesquisa => _informacoesPesquisa;

  Estado? getEstadoByNome(String nome) {
    late Estado? estado;
    
    for (Estado uf in _estados) {
      if (uf.nome == nome) estado = uf;
    }

    return estado;
  }

  Municipio? getMunicipioByNome(String nome) {
    late Municipio? municipio;

    for (Municipio mun in _municipios) {
      if (mun.nome == nome) municipio = mun;
    }

    return municipio;
  }

  void setEstados() async {
    _estados = await _brasilService.fetchEstados();
  }

  void setMunicipios(int uf) async {
    _municipios = await _brasilService.fetchMunicipiosUF(uf);
  }

  void addPesquisa(Pesquisa pesquisa) {
    _pesquisas.add(pesquisa);
    notifyListeners();
  }

  void addUserPesquisa(User user) {
    _pesquisadores.add(user);
    notifyListeners();
  }

  void removeUserPesquisa(User user) {
    _pesquisadores.remove(user);
    notifyListeners();
  }

  void setPesquisaStatus(String status, Pesquisa pesquisa) {
    pesquisa.status = status;
    notifyListeners();
  }

  void deletePesquisa(Pesquisa pesquisa) {
    _pesquisas.remove(pesquisa);
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