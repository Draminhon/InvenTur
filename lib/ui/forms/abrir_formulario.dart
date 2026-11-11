import 'package:flutter/material.dart';
import 'package:sistur/models/forms/Forms%20C/eventos_programados_model.dart';
import 'package:sistur/models/forms/Forms%20C/gastronomia_artesanato_trabalhos_manuais_model.dart';
import 'package:sistur/models/forms/Forms%20C/unidades_de_conservacao_model.dart';
import 'package:sistur/models/forms/forms%20A/comercio_turistico_model.dart';
import 'package:sistur/models/forms/forms%20A/informacoes_basicas_model.dart';
import 'package:sistur/models/forms/forms%20A/locadora_de_imoveis_model.dart';
import 'package:sistur/models/forms/forms%20A/rodovia_model.dart';
import 'package:sistur/models/forms/forms%20A/sistema_de_seguranca_model.dart';
import 'package:sistur/models/forms/forms%20B/agencia_de_turismo_model.dart';
import 'package:sistur/models/forms/forms%20B/alimentos_bebidas_model.dart';
import 'package:sistur/models/forms/forms%20B/entidades_associativas_model.dart';
import 'package:sistur/models/forms/forms%20B/espaco_para_eventos_model.dart';
import 'package:sistur/models/forms/forms%20B/espacos_de_diversao_e_cultura_model.dart';
import 'package:sistur/models/forms/forms%20B/guiamento_e_conducao_turisttica_model.dart';
import 'package:sistur/models/forms/forms%20B/informacoes_turisticas_model.dart';
import 'package:sistur/models/forms/forms%20B/instalacoes_esportivas_model.dart';
import 'package:sistur/models/forms/forms%20B/meios_hospedagem_model.dart';
import 'package:sistur/models/forms/forms%20B/outros_tipos_de_acomodacao_model.dart';
import 'package:sistur/models/forms/forms%20B/parques_model.dart';
import 'package:sistur/models/forms/forms%20B/servicos_para_eventos_model.dart';
import 'package:sistur/models/forms/forms%20B/transporte_turistico_model.dart';
import 'package:sistur/ui/forms/formsA/comercio_turistico.dart';
import 'package:sistur/ui/forms/formsA/informacoes_basicas_do_municipio.dart';
import 'package:sistur/ui/forms/formsA/locadora_de_imoveis.dart';
import 'package:sistur/ui/forms/formsA/rodovia.dart';
import 'package:sistur/ui/forms/formsA/sistema_de_seguran%C3%A7a.dart';
import 'package:sistur/ui/forms/formsB/agencias_de_turismo.dart';
import 'package:sistur/ui/forms/formsB/alimentos_e_bebidas.dart';
import 'package:sistur/ui/forms/formsB/entidades_associativas.dart';
import 'package:sistur/ui/forms/formsB/espacos_de_diversao_e_cultura.dart';
import 'package:sistur/ui/forms/formsB/espacos_para_eventos.dart';
import 'package:sistur/ui/forms/formsB/guiamento_e_conducao_turistica.dart';
import 'package:sistur/ui/forms/formsB/informacoes_turisticas.dart';
import 'package:sistur/ui/forms/formsB/instalacoes_esportivas.dart';
import 'package:sistur/ui/forms/formsB/meiosdehospedagem.dart';
import 'package:sistur/ui/forms/formsB/outros_tipos_de_acomodacao.dart';
import 'package:sistur/ui/forms/formsB/parques.dart';
import 'package:sistur/ui/forms/formsB/servicos_para_eventos.dart';
import 'package:sistur/ui/forms/formsB/transporte_turistico.dart';
import 'package:sistur/ui/forms/formsC/eventos_programados.dart';
import 'package:sistur/ui/forms/formsC/gastronomia_artesanato_trabalhos_manuais.dart';
import 'package:sistur/ui/forms/formsC/unidades_de_conservacao.dart';

/// Telas de formulário indexadas pelo campo "tipo" devolvido por GET equipamentos/?pesquisa_id=.
final Map<String, Widget Function(dynamic dados, bool isAdmin)> _telas = {
  'Rodovia': (d, a) => Rodovia(infoModel: RodoviaModel.fromJson(d), isAdmin: a),
  'Transporte Turistico': (d, a) => TransporteTuristico(infoModel: TransporteTuristicoModel.fromJson(d), isAdmin: a),
  'Serviços para Eventos': (d, a) =>
      ServicosParaEventos(hospedagemModel: ServicosParaEventosModel.fromJson(d), isAdmin: a),
  'Espaço para Eventos': (d, a) => EspacosParaEventos(hospedagemModel: EspacosParaEventosModel.fromJson(d), isAdmin: a),
  'Outros Tipos de Acomodação': (d, a) =>
      OutrosTiposDeAcomodacao(hospedagemModel: OutrosTiposDeAcomodacaoModel.fromJson(d), isAdmin: a),
  'Agência de Turismo': (d, a) => AgenciasDeTurismo(infoModel: AgenciasDeTurismoModel.fromJson(d), isAdmin: a),
  'SistemaDeSeguranca': (d, a) => SistemaDeSeguranca(infoModel: SistemaDeSegurancaModel.fromJson(d), isAdmin: a),
  'AlimentosEBebidas': (d, a) => AlimentosEBebidas(infoModel: AlimentosEBebidasModel.fromJson(d), isAdmin: a),
  'Meios de Hospedagem': (d, a) => MeiosDeHospedagem(hospedagemModel: MeiosDeHospedagemModel.fromJson(d), isAdmin: a),
  'Parques': (d, a) => Parques(hospedagemModel: ParquesModel.fromJson(d), isAdmin: a),
  'Espaços Para Diversão e Cultura': (d, a) =>
      EspacosDeDiversaoECultura(hospedagemModel: EspacosDeDiversaoECulturaModel.fromJson(d), isAdmin: a),
  'Informações Turisticas': (d, a) =>
      InformacoesTuristicas(hospedagemModel: InformacoesTuristicasModel.fromJson(d), isAdmin: a),
  'Informações Básicas do Município': (d, a) =>
      InformacoesBasicasDoMunicipio(infoModel: InformacoesBasicasModel.fromJson(d), isAdmin: a),
  'Comércio Turístico': (d, a) => ComercioTuristico(infoModel: ComercioTuristicoModel.fromJson(d), isAdmin: a),
  'Locadora de Imóveis': (d, a) => LocadoraDeImoveis(infoModel: LocadoraDeImoveisModel.fromJson(d), isAdmin: a),
  'Entidades Associativas e Similares': (d, a) =>
      EntidadesAssociativas(hospedagemModel: EntidadesAssociativasModel.fromJson(d), isAdmin: a),
  'Guiamento e Condução Turística': (d, a) =>
      GuiamentoEConducaoTurististica(infoModel: GuiamentoEConducaoTurististicaModel.fromJson(d), isAdmin: a),
  'Instalações Esportivas': (d, a) =>
      InstalacoesEsportivas(hospedagemModel: InstalacoesEsportivasModel.fromJson(d), isAdmin: a),
  'Unidades De Conservação': (d, a) =>
      UnidadesDeConservacao(hospedagemModel: UnidadesDeConservacaoModel.fromJson(d), isAdmin: a),
  'Eventos Programados': (d, a) => EventosProgramados(hospedagemModel: EventosProgramadosModel.fromJson(d), isAdmin: a),
  'Gastronomia e Artesanatos': (d, a) => GastronomiaArtesanatoTrabalhosManuais(
      hospedagemModel: GastronomiaArtesanatoTrabalhosManuaisModel.fromJson(d), isAdmin: a),
};

/// Monta a tela do formulário de um equipamento já salvo (modo edição), ou null se o [tipo] for desconhecido.
/// Abra-a com `RouteSettings(arguments: {'isUpdate': true, 'isAdmin': isAdmin})`, que é o que os formulários leem.
Widget? construirFormulario(String tipo, dynamic dados, {required bool isAdmin}) => _telas[tipo]?.call(dados, isAdmin);
