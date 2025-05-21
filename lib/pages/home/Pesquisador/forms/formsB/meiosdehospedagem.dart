import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/endereco/estado_model.dart';
import 'package:inventur/models/forms/meios_hospedagem_model.dart';
import 'package:inventur/models/endereco/pais_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/sendButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/expandedTileYoN.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/tables.dart';
import 'package:inventur/pages/widgets/auto_complete_text_field.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MeiosDeHospedagem extends StatefulWidget {
  final MeiosDeHospedagemModel? hospedagemModel;
  MeiosDeHospedagem({super.key, this.hospedagemModel});

  @override
  State<MeiosDeHospedagem> createState() => _MeiosDeHospedagemState();
}

class _MeiosDeHospedagemState extends State<MeiosDeHospedagem> {



  String pesquisadorNome = '';
  String pesquisadorTelefone = '';
  String pesquisadorEmail = '';


  String  coordenadorNome = '';
  String  coordenadorTelefone= '';
  String  coordenadorEmail= '';

  void getInfoUsersInPesquisa() async{
    Map<String, dynamic> info = await getAdminAndPesquisadorInfo();

     pesquisadorNome = info['pesquisador']['nome'];
     pesquisadorTelefone = info['pesquisador']['telefone'];
     pesquisadorEmail = info['pesquisador']['email'];

     coordenadorNome = info['coordenador']['nome'];
     coordenadorEmail = info['coordenador']['telefone'];
     coordenadorTelefone = info['coordenador']['email'];     
  }





  Future<void> sendForm(Map<String, dynamic> valoresjson) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    final url =
        Uri.parse(AppConstants.BASE_URI + '/api/v1/meiosdehospedagem/create/');
    int? pesquisa_id = await getPesquisaId();

    try {
      valoresjson['pesquisa'] = pesquisa_id;
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(valoresjson));
      if (response.statusCode == 201) {
        debugPrint("Formulário enviado com sucesso!");
      } else {
        debugPrint("ERRO AO ENVIAR O FORMULÁRIO: ${response.body}");
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  Future<void> update(
      int sistemaId, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    final url = Uri.parse(
        '${AppConstants.BASE_URI}/api/v1/meiosdehospedagem/update/$sistemaId');

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Bearer $token",
        },
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        print("Atualização bem-sucedida");
      } else {
        print("Erro na atualização: ${response.statusCode}");
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

  final _formKey = GlobalKey<FormState>();

  late Estado? _estadoSelecionado = Estado(id: -1, sigla: '', nome: '');
  late Pais? _paisSelecionado = Pais(nome: '');
  final PesquisaController _pesquisaController = PesquisaController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();

  bool isUpdate = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      final argument = ModalRoute.of(context)!.settings.arguments as Map;
      if (argument.containsKey('isUpdate')) {
        isUpdate = argument['isUpdate'];
      }
    } catch (e) {
      isUpdate = false;
    }
  }

  final Map<String, dynamic> valoresjson = {
    'tipo_formulario': 'Meios de Hospedagem',
    // 'uf': null,
    // 'regiao_turistica': null,
    // 'municipio': null,
    // 'tipo': null,
    // 'subtipo': null,
    // 'razao_social': null,
    // 'nome_fantasia': null,
    // 'codigo_CNAE': null,
    // 'atividade_economica': null,
    // 'inscricao_municipal': null,
    // 'nome_da_rede_holding': null,
    // 'CNPJ': null,
    // 'natureza': null,
    // 'tipo_de_organizacao_instituicao': null,
    // 'inicio_atividade': null,
    // 'quantidade_funcionarios_permanentes': null,
    // 'quantidade_funcionarios_temporarios': null,
    // 'quantidade_funcionarios_com_deficiencia': null,
    // 'localizacao': null,
    // 'coordenadas_geograficas_latitude': null,
    // 'coordenadas_geograficas_longitude': null,
    // 'endereco_rua_avenida_travessia_caminho_outro': null,
    // 'endereco_bairro_localidade': null,
    // 'endereco_distrito': null,
    // 'endereco_CEP': null,
    // 'whatsapp': null,
    // 'instagram': null,
    // 'email': null,
    // 'site': null,
    // 'sinalizacao_de_acesso': null,
    // 'sinalizacao_turistica': null,
    // 'proximidades': null,
    // 'pontos_de_referencia': null,
    // 'MTur_CADASTUR': null,
    // 'MTur_outros': null,
    // 'associacoes_e_sindicatos_do_setor_de_hospedagem': null,
    // 'associcoes_de_turismo': null,
    // 'associacoes_comerciais': null,
    // 'guias_turisticos': null,
    // 'outros_entidade_guia_turistico': null,
    // 'segmentos_ou_tipos_de_turismo_em_que_e_especializado': null,
    // 'tipo_de_diária': null,
    // 'formas_de_pagamento': null,
    // 'reservas': null,
    // 'atendimento_em_lingua_estrangeira': null,
    // 'informativo impressos': null,
    // 'periodo': null,
    // 'horario_segunda_feira_abertura': null,
    // 'horario_segunda_feira_encerramento': null,
    // 'horario_terca_feira_abertura': null,
    // 'horario_terca_feira_encerramento': null,
    // 'horario_quarta_feira_abertura': null,
    // 'horario_quarta_feira_encerramento': null,
    // 'horario_quinta_feira_abertura': null,
    // 'horario_quinta_feira_encerramento': null,
    // 'horario_sexta_feira_abertura': null,
    // 'horario_sexta_feira_encerramento': null,
    // 'horario_sabado_abertura': null,
    // 'horario_sabado_encerramento': null,
    // 'horario_domingo_abertura': null,
    // 'horario_domingo_encerramento': null,
    // 'funcionamento_24_horas': null,
    // 'funcionamento_em_feriados': null,
    // 'restricoes': null,
    // 'outras_regras_e_informacoes': null,
    // 'dados_da_visitacao_ocupacao_ano': null,
    // 'dados_da_visitacao_ocupacao_na_alta_temporada': null,
    // 'meses_de_alta_temporada': null,
    // 'origem_dos_visitantes_turistas': null,
    // 'origem_dos_turistas_nacionais_estados': null,
    // 'origem_dos_turistas_internacionais_paises': null,
    // 'unidades_habitacionais_total_de_uh': null,
    // 'unidades_habitacionais_total_de_leitos': null,
    // 'unidades_habitacionais_uh_adaptados_para_pcd': null,
    // 'produtos_de_higiene_pessoal': null,
    // 'equipamentos_e_servicos': null,
    // 'instalacoes_estacionamento': null,
    // 'estacionamento_capacidade_veiculos': null,
    // 'estacionamento_numero_automoveis': null,
    // 'estacionamento_numero_onibus': null,
    // 'outras_instalacoes_energia_eletrica': null,
    // 'energia_eletrica_capacidade_KVA': null,
    // 'outras_instalacoes_gerador_de_emergencia': null,
    // 'gerador_de_emergencia_capacidade_KVA': null,
    // 'area_de_alimentacao_restaurante': null,
    // 'restaurante_capacidade_instalada_por_dia': null,
    // 'restaurante_capacidade_instalada_por_dia_numero_pessoas_atendidas_sentadas':
    //     null,
    // 'restaurante_capacidade_simultanea': null,
    // 'restaurante_capacidade_simultanea_numero_pessoas_atendidas_sentadas': null,
    // 'area_de_alimentacao_lanchonete': null,
    // 'lanchonete_capacidade_instalada_por_dia': null,
    // 'lanchonete_capacidade_instalada_por_dia_numero_pessoas_atendidas_sentadas':
    //     null,
    // 'lanchonete_capacidade_simultanea': null,
    // 'lanchonete_capacidade_simultanea_numero_pessoas_atendidas_sentadas': null,
    // 'area_recreacao_e_lazer_instalacoes': null,
    // 'area_recreacao_e_lazer_outros_espacos_equipamentos_e_atividades': null,
    // 'area_para_eventos_instalacoes': null,
    // 'area_para_eventos_servicos': null,
    // 'area_para_eventos_equipamentos': null,
    // 'facilidade_e_servicos': null,
    // 'facilidade_para_executivos': null,
    // 'protecao_qualificacao_do_esquipamento_espaco': null,
    // 'protecao_qualificacao_do_esquipamento_espaco_municipal': null,
    // 'protecao_qualificacao_do_esquipamento_espaco_estadual_distrital': null,
    // 'protecao_qualificacao_do_esquipamento_espaco_federal': null,
    // 'protecao_qualificacao_do_esquipamento_espaco_internacional': null,
    // 'protecao_qualificacao_do_esquipamento_espaco_outras': null,
    // 'protecao_qualificacao_da_area_ou_edificacao': null,
    // 'protecao_qualificacao_da_area_ou_edificacao_municipal': null,
    // 'protecao_qualificacao_da_area_ou_edificacao_estadual_distrital': null,
    // 'protecao_qualificacao_da_area_ou_edificacao_federal': null,
    // 'protecao_qualificacao_da_area_ou_edificacao_internacional': null,
    // 'protecao_qualificacao_da_area_ou_edificacao_outras': null,
    // 'estado_geral_de_conservacao': null,
    // 'acessibilidade_possui_alguma_facilidade_para_pcd_ou_mobilidade_reduzida':
    //     null,
    // 'acessibilidade_possui_pessoal_capacitado_para_receber_pcd': null,
    // 'acessibilidade_rota_externa_acessivel': null,
    // 'acessibilidade_simbolo_internacional_de_acesso': null,
    // 'acessibilidade_local_de_embarque_e_desembarque': null,
    // 'acessibilidade_vaga_em_estacionamento': null,
    // 'acessibilidade_area_de_circulacao_acesso_interno_para_cadeira_de_rodas':
    //     null,
    // 'acessibilidade_escada': null,
    // 'acessibilidade_rampa': null,
    // 'acessibilidade_piso': null,
    // 'acessibilidade_elevador': null,
    // 'acessibilidade_equipamento_motorizado_para_deslocamento_interno': null,
    // 'acessibilidade_sinalizacao_visual': null,
    // 'acessibilidade_sinalizacao_tatil': null,
    // 'acessibilidade_alarme_de_emergencia': null,
    // 'acessibilidade_comunicacao': null,
    // 'acessibilidade_balcao_de_atendimento': null,
    // 'acessibilidade_mobiliário': null,
    // 'acessibilidade_sanitário': null,
    // 'acessibilidade_telefone': null,
    // 'acessibilidade_sinalizacao_indicaiva_de_atendimento_preferencial_para_pessoas_com_deficiencia_ou_mobilidade_reduzida':
    //     null,
    // 'acessibilidade_outros': null,
    // 'observacoes': null,
    // 'referencias': null,

  };

//Implementar o Map para os controllers

  final Map<String, TextEditingController> controllers = {};

  TextEditingController getController(String key) {
    controllers[key] ??= TextEditingController();
    return controllers[key]!;
  }

  void autoFillForm() {
    // Verifica se o controlador existe no Map antes de preencher
    void fillIfExists(String key, String value) {
      getController(key).text = value;
    }

    if (widget.hospedagemModel != null) {
      fillIfExists('uf', widget.hospedagemModel!.uf!);
      fillIfExists('rg', widget.hospedagemModel!.regiaoTuristica!);
      fillIfExists('municipio', widget.hospedagemModel!.municipio!);
      fillIfExists('razao social', widget.hospedagemModel!.razaoSocial!);
      fillIfExists('nome fantasia', widget.hospedagemModel!.nomeFantasia!);
      fillIfExists('CNPJ', widget.hospedagemModel!.CNPJ!);
      fillIfExists('codigo CNAE', widget.hospedagemModel!.codigoCNAE!);
      
      fillIfExists('estado01', widget.hospedagemModel!.estadosTuristas![0]);
      fillIfExists('estado02', widget.hospedagemModel!.estadosTuristas![1]);
      fillIfExists('estado03', widget.hospedagemModel!.estadosTuristas![2]);
      fillIfExists('estado04', widget.hospedagemModel!.estadosTuristas![3]);
      fillIfExists('estado05', widget.hospedagemModel!.estadosTuristas![4]);
      fillIfExists('pais01', widget.hospedagemModel!.paisesTuristas![0]);
      fillIfExists('pais02', widget.hospedagemModel!.paisesTuristas![1]);
      fillIfExists('pais03', widget.hospedagemModel!.paisesTuristas![2]);
      fillIfExists('pais04', widget.hospedagemModel!.paisesTuristas![3]);
      fillIfExists('pais05', widget.hospedagemModel!.paisesTuristas![4]);

      fillIfExists(
          'atividade economica', widget.hospedagemModel!.atividadeEconomica!);
      fillIfExists(
          'inscricao municipal', widget.hospedagemModel!.inscricaoMunicipal!);
      fillIfExists('nome da rede', widget.hospedagemModel!.nomeDaRede!);
      fillIfExists(
          'inicio da atividade', widget.hospedagemModel!.inicioDaAtividade!);
      fillIfExists('funcionarios permanentes',
          widget.hospedagemModel!.qtdeFuncionariosPermanentes!.toString());
      fillIfExists('funcionarios temporarios',
          widget.hospedagemModel!.qtdeFuncionariosTemporarios!.toString());
      fillIfExists('pessoas com deficiencia',
          widget.hospedagemModel!.qtdeFuncionarisComDeficiencia!.toString());
      fillIfExists('latitude', widget.hospedagemModel!.latitude.toString());
      fillIfExists('longitute', widget.hospedagemModel!.longitute.toString());
      fillIfExists('avenida rua', widget.hospedagemModel!.avenidaRuaEtc!);
      fillIfExists(
          'bairro localidade', widget.hospedagemModel!.bairroLocalidade!);
      fillIfExists('distrito', widget.hospedagemModel!.distrito!);
      fillIfExists('CEP', widget.hospedagemModel!.CEP!);
      fillIfExists('whatsapp', widget.hospedagemModel!.whatsapp!);
      fillIfExists('instagram', widget.hospedagemModel!.instagram!);
      fillIfExists('email', widget.hospedagemModel!.email!);
      fillIfExists('site', widget.hospedagemModel!.site!);
      fillIfExists(
          'pontos de referencia', widget.hospedagemModel!.pontosDeReferencia!);
      fillIfExists('regras e informacoes',
          widget.hospedagemModel!.outrasRegrasEInformacoes!);
      fillIfExists('ocupação ano n', widget.hospedagemModel!.nAnoOcupacao!);
      fillIfExists('ocupacao alta temporada n',
          widget.hospedagemModel!.nOcupacaoAltaTemporada!);
      fillIfExists(
          'total de UH', widget.hospedagemModel!.nTotalDeUH!.toString());
      fillIfExists('total de leitos',
          widget.hospedagemModel!.nTotalDeLeitos!.toString());
      fillIfExists('uh adaptados para pcd',
          widget.hospedagemModel!.nUhAdaptadasParaPCD!.toString());
      fillIfExists('capacidade de veiculos',
          widget.hospedagemModel!.nCapacidadeDeVeiculos!.toString());
      fillIfExists('capacidade automoveis',
          widget.hospedagemModel!.nAutomoveis!.toString());
      fillIfExists('onibus', widget.hospedagemModel!.nOnibus!.toString());
      fillIfExists('capacidade em KVA',
          widget.hospedagemModel!.capacidadeEmKVA!.toString());
      fillIfExists('gerador capacidade em KVA',
          widget.hospedagemModel!.geradorCapacidadeEmKVA!);
      fillIfExists('capacidade instalada por dia',
          widget.hospedagemModel!.nCapacidadeInstaladaPorDia!.toString());
      fillIfExists('pessoas atendidas sentadas',
          widget.hospedagemModel!.nPessoasAtendidasSentadas!.toString());
      fillIfExists('capacidade simultanea',
          widget.hospedagemModel!.nCapacidadeSimultanea!.toString());
      fillIfExists(
          'capacidade simultanea pessoas atendidas sentadas',
          widget.hospedagemModel!.nPessoasAtendidasSentadasSimultanea!
              .toString());
      fillIfExists(
          'lanchonete capacidade instalada por dia',
          widget.hospedagemModel!.lanchoneteCapacidadeInstaladaPorDia!
              .toString());
      fillIfExists(
          'lanchonete capacidade pessoas atendidas sentadas',
          widget.hospedagemModel!.lanchoneteCapacidadePessoasAtendidasSentadas!
              .toString());
      fillIfExists('lanchonete capacidade simultanea',
          widget.hospedagemModel!.lanchoneteCapacidadeSimultanea!.toString());
      fillIfExists(
          'lanchonete pessoas atendidas sentadas simultanea',
          widget.hospedagemModel!.lanchoneteCapacidadeSentadasSimultanea!
              .toString());
      fillIfExists('outros', widget.hospedagemModel!.outros!);
      fillIfExists('observacoes', widget.hospedagemModel!.observacoes!);
      fillIfExists('referencias', widget.hospedagemModel!.referencias!);
    }
  }


  
  late List<String> _estadosSelecionados;
  late List<String> _paisesSelecionados;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pesquisaController.setEstados();
    _pesquisaController.setPaises();


  try{
   _estadosSelecionados = widget.hospedagemModel!.estadosTuristas!;
   _paisesSelecionados = widget.hospedagemModel!.paisesTuristas!;
  }catch(e){
    _estadosSelecionados = [];
    _paisesSelecionados = [];
  }



  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllers.forEach((key, controllers) => controllers.dispose());
  }

  @override
  Widget build(BuildContext context) {
    getInfoUsersInPesquisa();
    if (isUpdate == true) autoFillForm();
    
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 55, 111, 60),
          title: const Text(
            'Identificação',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.05,
                      left: sizeScreen.width * 0.05),
                  child: Row(
                    children: [
                      SizedBox(
                          width: sizeScreen.width * 0.3,
                          height: sizeScreen.height * 0.045,
                          child: TextFormField(
                            controller: getController('uf'),
                            onSaved: (newValue) => valoresjson['uf'] = newValue,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'UF',
                            ),
                          )),
                      SizedBox(
                        width: sizeScreen.width * 0.09,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.5,
                          height: sizeScreen.height * 0.045,
                          child: TextFormField(
                            onSaved: (newValue) =>
                                valoresjson['regiao_turistica'] = newValue,
                            controller: getController('rg'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Região Turística'),
                          ))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      left: sizeScreen.width * 0.05,
                      right: sizeScreen.width * 0.1,
                      top: sizeScreen.height * 0.01),
                  child: TextFormField(
                    controller: getController('municipio'),
                    onSaved: (newValue) => valoresjson['municipio'] = newValue,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Município'),
                  )),
              SizedBox(height: 50.w),
              textLabel(
                name: 'Tipo:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 25.w,
              ),
              RadioD(
                options: ['Hotelaria e apoio'],
                getValue: (newValue) {
                  valoresjson['tipo'] = newValue;
                },
                indexModel:
                    isUpdate == true ? widget.hospedagemModel!.tipo : "",
              ),
              SizedBox(
                height: 25.w,
              ),
              textLabel(name: 'Subtipos:', fontWeight: FontWeight.bold),
              SizedBox(
                height: 25.w,
              ),

              RadioD(
                indexModel:
                    isUpdate == true ? widget.hospedagemModel!.subtipo : "",
                options: [
                  'Hotel',
                  'Hotel histórico',
                  'Pousada',
                  'Resort',
                  'Hotel Fazenda',
                  'Flat/apart-hotel',
                  'Cama e café',
                  'Albergue',
                  'Motel',
                  'Pensão',
                  'Alojamento de floresta',
                  'Colônia de férias',
                  'Estalagem/ Hospedaria',
                  'Alojamento Coletivo',
                  'Hospedagem conventual (Mosteiro/Seminário/Convento',
                  'Hospedagem Familiar',
                  'Hotel de trânsito',
                  'Spa'
                ],
                getValue: (newValue) {
                  valoresjson['subtipo'] = newValue;
                },
              ),

              SizedBox(height: 100.w),

              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.06,
                width: sizeScreen.width,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Informações Gerais',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),

              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CustomTextField(
                name: 'Razão Social',
                controller: getController('razao social'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['razaoSocial'] = newValue;
                },
              ),
              CustomTextField(
                controller: getController('nome fantasia'),
                name: 'Nome Fantasia',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['nomeFantasia'] = newValue;
                },
              ),
              CustomTextField(
                controller: getController('codigo CNAE'),
                name: 'Código CNAE',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['codigoCNAE'] = newValue;
                },
              ),
              CustomTextField(
                controller: getController('atividade economica'),
                name: 'Atividade econômica',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['atividadeEconomica'] = newValue;
                },
              ),
              CustomTextField(
                controller: getController('inscricao municipal'),
                name: 'Inscrição Municipal',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['inscricaoMunicipal'] = newValue;
                },
              ),
              CustomTextField(
                controller: getController('nome da rede'),
                name: 'Nome da rede/holding',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['nomeDaRede'] = newValue;
                },
              ),
              CustomTextField(
                name: 'CNPJ',
                controller: getController('CNPJ'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (newValue) {
                  valoresjson['CNPJ'] = newValue;
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),

              textLabel(name: 'Natureza:', fontWeight: FontWeight.bold),
              SizedBox(
                height: 50.w,
              ),
              Column(
                children: [
                  RadioD(
                    indexModel: isUpdate == true
                        ? widget.hospedagemModel!.natureza
                        : "",
                    options: ['pública', 'privada', 'outro'],
                    getValue: (newValue) {
                      valoresjson['natureza'] = newValue;
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                  name: 'Tipo de organização/instituição:',
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                onChanged: (p0) => valoresjson['tipoDeOrganizacao'] = p0,
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.tipoDeOrganizacao
                    : [],
                nomes: [
                  'associação',
                  'sindicato',
                  'cooperativa',
                  'sistema S',
                  'empresa',
                  'outro'
                ],
              ),
              SizedBox(
                height: 25.w,
              ),
              Row(
                children: [
                  textLabel(
                      name: 'Início da atividade:',
                      fontWeight: FontWeight.bold),
                  SizedBox(
                    width: sizeScreen.width * 0.1,
                  ),
                  SizedBox(
                      width: sizeScreen.width * 0.4,
                      //height: sizeScreen.height * 0.07,
                      child: CustomTextDate(
                        dateController: getController('inicio da atividade'),
                        getValue: (newValue) {
                          valoresjson['inicioDaAtividade'] = newValue;
                        },
                      ))
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              textLabel(
                  name: 'Quantidade de Funcionários:',
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      textLabel(
                        name: 'Permanentes',
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.026,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            controller:
                                getController('funcionarios permanentes'),
                            name: 'n°',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['qtdeFuncionariosPermanentes'] =
                                  newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  Row(
                    children: [
                      textLabel(
                        name: 'Temporários',
                      ),
                      SizedBox(
                        width: sizeScreen.width * 0.038,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            controller:
                                getController('funcionarios temporarios'),
                            name: 'n°',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['qtdeFuncionariosTemporarios'] =
                                  newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(height: sizeScreen.height * 0.02),
                  Row(
                    children: [
                      textLabel(
                        name: 'Pessoas com\ndefiicência (%)',
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            controller:
                                getController('pessoas com deficiencia'),
                            name: '%',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (newValue) {
                              valoresjson['qtdeFuncionarisComDeficiencia'] =
                                  newValue;
                            },
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  )
                ],
              ),
              SizedBox(
                height: 25.w,
              ),
              textLabel(name: 'Localização:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioD(
                indexModel:
                    isUpdate == true ? widget.hospedagemModel!.localizacao : "",
                options: ['urbana', 'rural'],
                getValue: (newValue) {
                  valoresjson['localizacao'] = newValue;
                },
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                  name: 'Coordenadas Geográficas:',
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Column(children: [
                Row(
                  children: [
                    textLabel(
                      name: 'Latitude',
                    ),
                    SizedBox(
                      width: sizeScreen.width * 0.032,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('latitude'),
                          name: 'valor',
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          getValue: (newValue) {
                            valoresjson['latitude'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(
                      name: 'Longitude',
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('longitute'),
                          name: 'valor',
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          getValue: (newValue) {
                            valoresjson['longitute'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
              ]),
              textLabel(name: 'Endereço:', fontWeight: FontWeight.bold),

              CustomTextField(
                controller: getController('avenida rua'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'avenida/rua/travessa/caminho/outro',
                getValue: (newValue) {
                  valoresjson['avenidaRuaEtc'] = newValue;
                },
              ),
              CustomTextField(
                controller: getController('bairro localidade'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'bairro/localidade',
                getValue: (newValue) {
                  valoresjson['bairroLocalidade'] = newValue;
                },
              ),
              CustomTextField(
                controller: getController('distrito'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'distrito',
                getValue: (newValue) {
                  valoresjson['distrito'] = newValue;
                },
              ),
              CustomTextField(
                controller: getController('CEP'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'CEP',
                getValue: (newValue) {
                  valoresjson['CEP'] = newValue;
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              Column(children: [
                Row(
                  children: [
                    textLabel(name: 'Whatsapp', fontWeight: FontWeight.bold),
                    SizedBox(
                      width: sizeScreen.width * 0.03,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('whatsapp'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '(DD) n°',
                          getValue: (newValue) {
                            valoresjson['whatsapp'] = newValue;
                          },
                        ))
                  ],
                ),
                Row(
                  children: [
                    textLabel(name: 'Instagram', fontWeight: FontWeight.bold),
                    SizedBox(
                      width: sizeScreen.width * 0.03,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('instagram'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '@',
                          getValue: (newValue) {
                            valoresjson['instagram'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(
                  children: [
                    textLabel(name: 'E-mail', fontWeight: FontWeight.bold),
                    SizedBox(
                      width: sizeScreen.width * 0.03,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('email'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'e-mail',
                          getValue: (newValue) {
                            valoresjson['email'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(name: 'Site', fontWeight: FontWeight.bold),
                    SizedBox(
                      width: sizeScreen.width * 0.05,
                    ),
                    SizedBox(
                      width: sizeScreen.width * 0.045,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('site'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'www.endereço.com',
                          getValue: (newValue) {
                            valoresjson['site'] = newValue;
                          },
                        ))
                  ],
                ),
              ]),
              SizedBox(
                height: sizeScreen.height * 0.06,
              ),
              textLabel(name: 'Sinalização:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Row(children: [
                textLabel(
                  name: 'de acessso -',
                ),
                SizedBox(
                  width: sizeScreen.width * 0.09,
                ),
                SizedBox(
                    // width: sizeScreen.width * 0.5,
                    //  //height: sizeScreen.height * 0.07,
                    child: ExpansionTileYoN(
                  optionModel: isUpdate == true
                      ? widget.hospedagemModel!.sinalizacaoDeAcesso
                      : "não",
                  getValue: (newValue) {
                    valoresjson['sinalizacaoDeAcesso'] = newValue;
                  },
                ))
              ]),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Row(children: [
                textLabel(
                  name: 'turística -',
                ),
                SizedBox(
                  width: sizeScreen.width * 0.14,
                ),
                SizedBox(
                    //width: sizeScreen.width * 0.5,
                    //  //height: sizeScreen.height * 0.07,
                    child: ExpansionTileYoN(
                  optionModel: isUpdate == true
                      ? widget.hospedagemModel!.sinalizacaoTuristica
                      : "não",
                  getValue: (newValue) {
                    valoresjson['sinalizacaoTuristica'] = newValue;
                  },
                ))
              ]),
              SizedBox(
                height: 90.w,
              ),
              textLabel(name: 'Proximidades:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              //  RadioD(number: 6, options: options)
              CheckC(
                onChanged: (p0) => valoresjson['proximidades'] = p0,
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.proximidades
                    : [],
                nomes: [
                  'Restaurante',
                  'Centro de Convenções exposições',
                  'Shopping',
                  'Bar/Lanchconete',
                  'Posto de combustível',
                  'Galeria/rua comercial',
                  'outro'
                ],
              ),

              SizedBox(
                height: 50.w,
              ),
              textLabel(
                  name: 'Pontos de referência:', fontWeight: FontWeight.bold),
              SizedBox(
                height: 20.w,
              ),
              CustomTextField(
                controller: getController('pontos de referencia'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'ponto de referência',
                getValue: (newValue) {
                  valoresjson['pontosDeReferencia'] = newValue;
                },
              ),
              SizedBox(
                height: 100.w,
              ),

              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.1,
                width: sizeScreen.width,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Cadastro, classificação e outros',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: 50.w,
              ),

              textLabel(
                name: "Entidade/guia turístico",
                fontWeight: FontWeight.bold,
              ),

              TableMtur(
                getValues:
                    isUpdate == true ? widget.hospedagemModel!.tabelaMTUR : {},
                onChanged: (p0) {
                  setState(() {
                    valoresjson['tabelaMTUR'] = p0;
                  });
                },
              ),
              SizedBox(
                height: 50.w,
              ),
              Center(
                child: textLabel(
                  name:
                      '       Segmentos ou tipos de turismo\nem que é especializado (assinalar até 3):',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              SizedBox(
                height: 300,
                child: CheckC(
                  nomesModel: isUpdate == true
                      ? widget.hospedagemModel!.segmentosOuTurismoEspecializado
                      : [],
                  onChanged: (p0) =>
                      valoresjson['segmentosOuTurismoEspecializado'] = p0,
                  nomes: [
                    'Aventura',
                    'Ecoturismo',
                    'Rural',
                    'Estudos e intercâmbio',
                    'Cultural\n(cívico, étnico,\nreligioso, místico e\nesotérico)',
                    'náutico',
                    'Saúde\n(Bem estar e médico)',
                    'Pesca',
                    'Sol e praia',
                    'Negócios eeventos',
                    'Esporte',
                    'Não é\nespecializado em nenhum segmento'
                  ],
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.06,
                width: sizeScreen.width,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Funcionamento',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Estrutura de funcionamento:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              textLabel(name: 'Tipo de diária:', fontWeight: FontWeight.bold),

              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              RadioD(
                options: [
                  'Sem Alimentação',
                  'Café da manhã',
                  'Meia Pensão',
                  'Pensão Completa',
                  'Tudo incluído'
                ],
                getValue: (newValue) {
                  valoresjson['tipoDeDiaria'] = newValue;
                },
                indexModel: isUpdate == true
                    ? widget.hospedagemModel!.tipoDeDiaria
                    : "",
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                  name: 'Formas de Pagamento:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.formasDePagamento
                    : [],
                onChanged: (p0) => valoresjson['formasDePagamento'] = p0,
                nomes: [
                  'Dinheiro',
                  'Pix',
                  'Cartão de Crédito',
                  'Cartão de Débito'
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(name: 'Reservas:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.reservas : [],
                onChanged: (p0) => valoresjson['reservas'] = p0,
                nomes: [
                  'Balcão',
                  'Whatsapp',
                  'Instagram',
                  'Site',
                  'Agência de turismo',
                  'Antecipado'
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                  name: 'Atendimento ao público:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.04,
              ),

              textLabel(
                  name: 'Atendimento em língua estrangeira:',
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                  nomesModel: isUpdate == true
                      ? widget.hospedagemModel!.atendimentoEmLinguaEstrangeira
                      : [],
                  onChanged: (p0) =>
                      valoresjson['atendimentoEmLinguaEstrangeira'] = p0,
                  nomes: ['Não', 'Inglês', 'Espanhol', 'outro']),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                  name: 'Informativos impressos:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                  nomesModel: isUpdate == true
                      ? widget.hospedagemModel!.informativosImpressos
                      : [],
                  onChanged: (p0) => valoresjson['informativosImpressos'] = p0,
                  nomes: ['Não', 'Inglês', 'Espanhol', 'outro']),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.06,
                width: sizeScreen.width,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Regras de Funcionamento',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(name: 'Período:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioC(
                indexModel:
                    isUpdate == true ? widget.hospedagemModel!.periodo : "",
                number: 13,
                options: [
                  'Janeiro',
                  'Fevereiro',
                  'Março',
                  'Abril',
                  'Maio',
                  'Junho',
                  'Julho',
                  'Agosto',
                  'Setembro',
                  'Outubro',
                  'Novembro',
                  'Dezembro',
                  'Ano Inteiro'
                ],
                getValue: (newValue) {
                  valoresjson['periodo'] = newValue;
                },
              ),
              SizedBox(
                height: 30.w,
              ),
              textLabel(name: 'Horário:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.01,
              ),

              TabelaHorarios(
                getValue: isUpdate == true
                    ? widget.hospedagemModel!.tabelasHorario
                    : {},
                onChanged: (p0) {
                  setState(() {
                    valoresjson['tabelasHorario'] = p0;
                  });
                },
              ),

              SizedBox(
                height: sizeScreen.height * 0.01,
              ),
              //TabelaT2(),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Funcionamento 24 horas:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              ExpansionTileYoN(
                optionModel: isUpdate == true
                    ? widget.hospedagemModel!.funcionamento24h
                    : "não",
                getValue: (newValue) {
                  valoresjson['funcionamento24h'] = newValue;
                },
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Funcionamento em feriados:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              ExpansionTileYoN(
                optionModel: isUpdate == true
                    ? widget.hospedagemModel!.funcionamentoEmFeriados
                    : "não",
                getValue: (newValue) {
                  valoresjson['funcionamentoEmFeriados'] = newValue;
                },
              ),
              SizedBox(
                height: 25.w,
              ),
              textLabel(
                name: 'Restrições:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.restricoes : [],
                onChanged: (p0) => valoresjson['restricoes'] = p0,
                nomes: ['Crianças', 'Fumantes', 'Animais', 'outro'],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Outras regras e informações:',
                fontWeight: FontWeight.bold,
              ),

              CustomTextField(
                controller: getController('regras e informacoes'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'Regras e informações',
                getValue: (newValue) {
                  valoresjson['outrasRegrasEInformacoes'] = newValue;
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Dados da visitação:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Ocupação ano nº:',
                fontWeight: FontWeight.bold,
              ),

              CustomTextField(
                controller: getController('ocupação ano n'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'nº',
                getValue: (newValue) {
                  valoresjson['nAnoOcupacao'] = newValue;
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Ocupação na alta temporada nº:',
                fontWeight: FontWeight.bold,
              ),

              CustomTextField(
                controller: getController('ocupacao alta temporada n'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'nº',
                getValue: (newValue) {
                  valoresjson['nOcupacaoAltaTemporada'] = newValue;
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Meses de alta temporada:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.01,
              ),

              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.mesesAltaTemporada
                    : [],
                onChanged: (p0) => valoresjson['mesesAltaTemporada'] = p0,
                nomes: [
                  'Janeiro',
                  'Fevereiro',
                  'Março',
                  'Abril',
                  'Maio',
                  'Junho',
                  'Julho',
                  'Agosto',
                  'Setembro',
                  'Outubro',
                  'Novembro',
                  'Dezembro',
                  'Ano Inteiro'
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Origem dos visitantes/turistas:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 25.w,
              ),
              CheckC(
                onChanged: (p0) => valoresjson['origemDosVisitantes'] = p0,
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.origemDosVisitantes
                    : [],
                nomes: [
                  'Entorno municipal',
                  'Estadual',
                  'Nacional',
                  'Internacional'
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Origem dos turistas nacionais\n(Até 5 estados)',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              SizedBox(
                width: 1250.w,
                child: AutocompleteTextField(
                  controllerAuto: getController('estado01'),
                  textAlign: TextAlign.start,
                  label: "Selecione um estado",
                  onSelected: (option) {
                    _estadoSelecionado =
                        _pesquisaController.getEstadoByNome(option);
                    _pesquisaController.setMunicipios(_estadoSelecionado!.id);
                    if (_estadosSelecionados.length < 5) {
                      _estadosSelecionados.add(_estadoSelecionado!.nome);
                    } else {
                      _estadosSelecionados.removeAt(0);
                      _estadosSelecionados.insert(0, _estadoSelecionado!.nome);
                    }
                  },
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable.empty();
                    }
                    return _pesquisaController.estados.map((e) => e.nome).where(
                          (word) => word.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                        );
                  },
                  onChanged: (value) {
                    _estadoController.text = value;
                  },
                ),
              ),
              SizedBox(
                height: 40.h,
              ),

              SizedBox(
                width: 1250.w,
                child: AutocompleteTextField(
                  controllerAuto: getController('estado02'),
                  textAlign: TextAlign.start,
                  label: "Selecione um estado",
                  onSelected: (option) {
                    _estadoSelecionado =
                        _pesquisaController.getEstadoByNome(option);
                    _pesquisaController.setMunicipios(_estadoSelecionado!.id);
                    if (_estadosSelecionados.length < 5) {
                      _estadosSelecionados.add(_estadoSelecionado!.nome);
                    } else {
                      _estadosSelecionados.removeAt(1);
                      _estadosSelecionados.insert(1, _estadoSelecionado!.nome);
                    }
                  },
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable.empty();
                    }
                    return _pesquisaController.estados.map((e) => e.nome).where(
                          (word) => word.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                        );
                  },
                  onChanged: (value) {
                    _estadoController.text = value;
                  },
                ),
              ),
              SizedBox(
                height: 40.h,
              ),

              SizedBox(
                width: 1250.w,
                child: AutocompleteTextField(
                  textAlign: TextAlign.start,
                  label: "Selecione um estado",
                  controllerAuto: getController('estado03'),
                  onSelected: (option) {
                    _estadoSelecionado =
                        _pesquisaController.getEstadoByNome(option);
                    _pesquisaController.setMunicipios(_estadoSelecionado!.id);
                    if (_estadosSelecionados.length < 5) {
                      _estadosSelecionados.add(_estadoSelecionado!.nome);
                    } else {
                      _estadosSelecionados.removeAt(2);
                      _estadosSelecionados.insert(2, _estadoSelecionado!.nome);
                    }
                  },
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable.empty();
                    }
                    return _pesquisaController.estados.map((e) => e.nome).where(
                          (word) => word.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                        );
                  },
                  onChanged: (value) {
                    _estadoController.text = value;
                  },
                ),
              ),
              SizedBox(
                height: 40.h,
              ),

              SizedBox(
                width: 1250.w,
                child: AutocompleteTextField(
                  controllerAuto: getController('estado04'),
                  textAlign: TextAlign.start,
                  label: "Selecione um estado",
                  onSelected: (option) {
                    _estadoSelecionado =
                        _pesquisaController.getEstadoByNome(option);
                    _pesquisaController.setMunicipios(_estadoSelecionado!.id);
                    if (_estadosSelecionados.length < 5) {
                      _estadosSelecionados.add(_estadoSelecionado!.nome);
                    } else {
                      _estadosSelecionados.removeAt(3);
                      _estadosSelecionados.insert(3, _estadoSelecionado!.nome);
                    }
                  },
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable.empty();
                    }
                    return _pesquisaController.estados.map((e) => e.nome).where(
                          (word) => word.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                        );
                  },
                  onChanged: (value) {
                    _estadoController.text = value;
                  },
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                width: 1250.w,
                child: AutocompleteTextField(
                  textAlign: TextAlign.start,
                  label: "Selecione um estado",
                  controllerAuto: getController('estado05'),
                  onSelected: (option) {
                    _estadoSelecionado =
                        _pesquisaController.getEstadoByNome(option);
                    _pesquisaController.setMunicipios(_estadoSelecionado!.id);
                    if (_estadosSelecionados.length < 5) {
                      _estadosSelecionados.add(_estadoSelecionado!.nome);
                    } else {
                      _estadosSelecionados.removeAt(4);
                      _estadosSelecionados.insert(4, _estadoSelecionado!.nome);
                    }
                  },
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable.empty();
                    }
                    return _pesquisaController.estados.map((e) => e.nome).where(
                          (word) => word.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                        );
                  },
                  onChanged: (value) {
                    _estadoController.text = value;
                  },
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Origem dos turistas internacionais\n(Até 5 Países)',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 40.h,
              ),

              SizedBox(
                width: 1250.w,
                child: AutocompleteTextField(
                  textAlign: TextAlign.start,
                  label: "Selecione um país",
                  controllerAuto: getController('pais01'),
                  onSelected: (option) {
                    _paisSelecionado =
                        _pesquisaController.getPaisesByNome(option);
                    if (_paisesSelecionados.length < 5) {
                      _paisesSelecionados.add(_paisSelecionado!.nome);
                    } else {
                      _paisesSelecionados.removeAt(0);
                      _paisesSelecionados.insert(0, _paisSelecionado!.nome);
                    }
                  },
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable.empty();
                    }
                    return _pesquisaController.paises.map((e) => e.nome).where(
                          (word) => word.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                        );
                  },
                  onChanged: (value) {
                    _paisController.text = value;
                  },
                ),
              ),

              SizedBox(
                height: 40.h,
              ),

              SizedBox(
                width: 1250.w,
                child: AutocompleteTextField(
                  textAlign: TextAlign.start,
                  label: "Selecione um país",
                  controllerAuto: getController('pais02'),
                  onSelected: (option) {
                    _paisSelecionado =
                        _pesquisaController.getPaisesByNome(option);
                    if (_paisesSelecionados.length < 5) {
                      _paisesSelecionados.add(_paisSelecionado!.nome);
                    } else {
                      _paisesSelecionados.removeAt(1);
                      _paisesSelecionados.insert(1, _paisSelecionado!.nome);
                    }
                  },
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable.empty();
                    }
                    return _pesquisaController.paises.map((e) => e.nome).where(
                          (word) => word.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                        );
                  },
                  onChanged: (value) {
                    _paisController.text = value;
                  },
                ),
              ),
              SizedBox(
                height: 40.h,
              ),

              SizedBox(
                width: 1250.w,
                child: AutocompleteTextField(
                  controllerAuto: getController('pais03'),
                  textAlign: TextAlign.start,
                  label: "Selecione um país",
                  onSelected: (option) {
                    _paisSelecionado =
                        _pesquisaController.getPaisesByNome(option);
                    if (_paisesSelecionados.length < 5) {
                      _paisesSelecionados.add(_paisSelecionado!.nome);
                    } else {
                      _paisesSelecionados.removeAt(2);
                      _paisesSelecionados.insert(2, _paisSelecionado!.nome);
                    }
                  },
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable.empty();
                    }
                    return _pesquisaController.paises.map((e) => e.nome).where(
                          (word) => word.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                        );
                  },
                  onChanged: (value) {
                    _paisController.text = value;
                  },
                ),
              ),
              SizedBox(
                height: 40.h,
              ),

              SizedBox(
                width: 1250.w,
                child: AutocompleteTextField(
                  controllerAuto: getController('pais04'),
                  textAlign: TextAlign.start,
                  label: "Selecione um país",
                  onSelected: (option) {
                    _paisSelecionado =
                        _pesquisaController.getPaisesByNome(option);
                    if (_paisesSelecionados.length < 5) {
                      _paisesSelecionados.add(_paisSelecionado!.nome);
                    } else {
                      _paisesSelecionados.removeAt(3);
                      _paisesSelecionados.insert(3, _paisSelecionado!.nome);
                    }
                  },
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable.empty();
                    }
                    return _pesquisaController.paises.map((e) => e.nome).where(
                          (word) => word.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                        );
                  },
                  onChanged: (value) {
                    _paisController.text = value;
                  },
                ),
              ),
              SizedBox(
                height: 40.h,
              ),

              SizedBox(
                width: 1250.w,
                child: AutocompleteTextField(
                  textAlign: TextAlign.start,
                  label: "Selecione um país",
                  controllerAuto: getController('pais05'),
                  onSelected: (option) {
                    _paisSelecionado =
                        _pesquisaController.getPaisesByNome(option);
                    if (_paisesSelecionados.length < 5) {
                      _paisesSelecionados.add(_paisSelecionado!.nome);
                    } else {
                      _paisesSelecionados.removeAt(4);
                      _paisesSelecionados.insert(4, _paisSelecionado!.nome);
                    }
                  },
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable.empty();
                    }
                    return _pesquisaController.paises.map((e) => e.nome).where(
                          (word) => word.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                        );
                  },
                  onChanged: (value) {
                    _paisController.text = value;
                  },
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.06,
                width: sizeScreen.width,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Características',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),

              textLabel(
                name: 'Unidades habitacionais (UH):',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),

              Column(children: [
                Row(
                  children: [
                    textLabel(name: 'Total de UH nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.055,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('total de UH'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['nTotalDeUH'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(name: 'Total de leitos nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.005,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('total de leitos'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['nTotalDeLeitos'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(name: 'Uh adaptadas\npara PCD nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.071,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('uh adaptados para pcd'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['nUhAdaptadasParaPCD'] = newValue;
                          },
                        ))
                  ],
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.03, bottom: 20.w),
                child: textLabel(
                  name: 'Produtos de higiene pessoal:',
                  fontWeight: FontWeight.bold,
                ),
              ),
              CheckC(
                  nomesModel: isUpdate == true
                      ? widget.hospedagemModel!.produtosHigienePessoal
                      : [],
                  onChanged: (p0) => valoresjson['produtosHigienePessoal'] = p0,
                  nomes: [
                    'Shampoo',
                    'Toalha',
                    'Condicionador',
                    'Roupão de banho',
                    'Sabonete',
                    'Touca',
                    'Creme dental',
                    'Chinelo',
                    'Loção',
                    'outro'
                  ]),
              Padding(
                padding: EdgeInsets.only(
                    left: sizeScreen.width * 0.005,
                    top: sizeScreen.height * 0.02,
                    bottom: sizeScreen.height * 0.02),
                child: textLabel(
                  name: 'Equipamentos e Serviços:',
                  fontWeight: FontWeight.bold,
                ),
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.equipamentosEServicos
                    : [],
                onChanged: (p0) => valoresjson['equipamentosEServicos'] = p0,
                nomes: [
                  'TV',
                  'Internet',
                  'Ar-Condicionado',
                  'Cama King Size',
                  'Cama Queen Size',
                  'Panelas e louças',
                  'Micro-ondas',
                  'Forno Elétrico',
                  'Cofre',
                  'Academia',
                  'Hidromassagem',
                  'Sauna seca',
                  'Room - service',
                  'Room service 24h',
                  'Controle de Iluminação',
                  'Luminária para leitura',
                  'outro'
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: sizeScreen.width * 0.05,
                  top: sizeScreen.height * 0.02,
                ),
                child: textLabel(
                  name: 'Instalações:',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.03, bottom: 20.w),
                child: textLabel(
                  name: 'Estacionamento:',
                  fontWeight: FontWeight.bold,
                ),
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.estacionamento
                    : [],
                onChanged: (p0) => valoresjson['estacionamento'] = p0,
                nomes: ['Pago', 'Gratuito', 'Coberto', 'Descoberto'],
              ),
              SizedBox(
                height: 50.w,
              ),
              Column(children: [
                Row(
                  children: [
                    textLabel(
                      name: 'Capacidade de\nveículos nº',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: sizeScreen.width * 0.01,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('capacidade de veiculos'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['nCapacidadeDeVeiculos'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(
                      name: 'Automóveis nº',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: sizeScreen.width * 0.005,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('capacidade automoveis'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['nAutomoveis'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(
                      name: 'Ônibus nº',
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      width: sizeScreen.width * 0.1,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('onibus'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['nOnibus'] = newValue;
                          },
                        ))
                  ],
                ),
              ]),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              textLabel(
                name: 'Outras instalações e estruturas:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Energia  elétrica:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioD(
                options: ['110 volts', '220 volts', '110/220 volts'],
                indexModel: isUpdate == true
                    ? widget.hospedagemModel!.energiaEletrica
                    : "",
                getValue: (newValue) {
                  valoresjson['energiaEletrica'] = newValue;
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Row(
                children: [
                  textLabel(
                    name: 'Capacidade\nem KVA',
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: sizeScreen.width * 0.005,
                  ),
                  SizedBox(
                      width: sizeScreen.width * 0.6,
                      //height: sizeScreen.height * 0.07,
                      child: CustomTextField(
                        controller: getController('capacidade em KVA'),
                        validat: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          return null;
                        },
                        name: 'KVA',
                        getValue: (newValue) {
                          valoresjson['capacidadeEmKVA'] = newValue;
                        },
                      ))
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Gerador de emergência:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.032,
              ),
              ExpansionTileYoN(
                optionModel: isUpdate == true
                    ? widget.hospedagemModel!.geradorDeEmergencia
                    : "não",
                getValue: (newValue) {
                  valoresjson['geradorDeEmergencia'] = newValue;
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Row(
                children: [
                  textLabel(
                    name: 'Capacidade\nem KVA',
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: sizeScreen.width * 0.005,
                  ),
                  SizedBox(
                      width: sizeScreen.width * 0.6,
                      //height: sizeScreen.height * 0.07,
                      child: CustomTextField(
                        controller: getController('gerador capacidade em KVA'),
                        validat: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          return null;
                        },
                        name: 'KVA',
                        getValue: (newValue) {
                          valoresjson['geradorCapacidadeEmKVA'] = newValue;
                        },
                      ))
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              textLabel(
                name: 'Área de alimentação:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Restaurante:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.restaurante : [],
                onChanged: (p0) => valoresjson['restaurante'] = p0,
                nomes: [
                  'Não',
                  'Apenas para hóspedes',
                  'Aberto ao público',
                  'Adaptado para PCD'
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Capacidade de atendimento:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Column(children: [
                Row(
                  children: [
                    textLabel(name: 'Capacidade\nInstalada\npor dia nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.01,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller:
                              getController('capacidade instalada por dia'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['nCapacidadeInstaladaPorDia'] =
                                newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.005,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller:
                              getController('pessoas atendidas sentadas'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['nPessoasAtendidasSentadas'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(name: 'Capacidade\nsimultânea nº'),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController('capacidade simultanea'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['nCapacidadeSimultanea'] = newValue;
                          },
                        ))
                  ],
                ),
                Row(
                  children: [
                    textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController(
                              'capacidade simultanea pessoas atendidas sentadas'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['nPessoasAtendidasSentadasSimultanea'] =
                                newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                textLabel(
                  name: 'Lanchonete:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
              ]),
              CheckC(
                onChanged: (p0) => valoresjson['lanchonete'] = p0,
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.lanchonete : [],
                nomes: [
                  'Não',
                  'Apenas para hóspedes',
                  'Aberto ao público',
                  'Adaptado para PCD'
                ],
              ),
              SizedBox(
                height: 25.w,
              ),
              Column(children: [
                Row(
                  children: [
                    textLabel(name: 'Capacidade\nInstalada\npor dia nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.01,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController(
                              'lanchonete capacidade instalada por dia'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['lanchoneteCapacidadeInstaladaPorDia'] =
                                newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
                    SizedBox(
                      width: sizeScreen.width * 0.005,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController(
                              'lanchonete capacidade pessoas atendidas sentadas'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson[
                                    'lanchoneteCapacidadePessoasAtendidasSentadas'] =
                                newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(name: 'Capacidade\nsimultânea nº'),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller:
                              getController('lanchonete capacidade simultanea'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson['lanchoneteCapacidadeSimultanea'] =
                                newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(name: 'Pessoas\natendidas\nsentadas nº'),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: getController(
                              'lanchonete pessoas atendidas sentadas simultanea'),
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (newValue) {
                            valoresjson[
                                    'lanchoneteCapacidadeSentadasSimultanea'] =
                                newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
              ]),
              textLabel(
                name: 'Área de recreação e lazer:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Instalações e espaços:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.instalacaoEEspacos
                    : [],
                onChanged: (p0) => valoresjson['instalacaoEEspacos'] = p0,
                nomes: [
                  'Piscina',
                  'Toboágua',
                  'Quadra de tênis',
                  'Área verde',
                  'Piscina aquecida',
                  'Parque infantil',
                  'Campo de futebol',
                  'Lago paronâmico',
                  'Piscina infantil',
                  'Clube infantil',
                  'Campo de golfe',
                  'Bar na piscina',
                  'Quadra poliesportiva',
                  'Pista de cooper',
                  'outro'
                ],
              ),
              SizedBox(
                height: 25.w,
              ),
              textLabel(
                name: 'Outros espaços, equipamentos e atividades:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.outrosEspacosEAtividades
                    : [],
                onChanged: (p0) => valoresjson['outrosEspacosEAtividades'] = p0,
                nomes: [
                  'Observação da fauna',
                  'Visita a produção agrícola',
                  'Atividades pedagógicas',
                  'Atividades Programadas para adultos',
                  'Passeios em barcos e lanchas',
                  'Realização de cursos, seminários, feiras',
                  'Competições de pesca',
                  'Equipamento para mergulho',
                  'Tirolesa',
                  'Cicloturismo / Atividade com bicicleta',
                  'Mergulho livre',
                  'Banana boat',
                  'Mini zoo',
                  'Horta',
                  'Peregrinação e romarias',
                  'Venda de souvenir e produtos típicos',
                  'Observação de flora',
                  'Degustação gastronômica',
                  'Atividades programadas para crianças',
                  'atividades equestres',
                  'Passeios em embarcações alugadas',
                  'Realização de eventos (Esportivos, Sociais, Culturais)',
                  'Pesca amadora',
                  'Pedalinhos',
                  'Arvorismo',
                  'Caminhadas / trilha interpretativas',
                  'Esqui aquático',
                  'Jet ski',
                  'Fazendinha',
                  'Centro equestre',
                  'Retiros espirituais',
                  'outro'
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Área para eventos:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.04,
              ),
              textLabel(
                name: 'Instalações:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.04,
              ),
              TablesInstalacoes(
                getValue: isUpdate == true
                    ? widget.hospedagemModel!.tabelaInstalacoes
                    : {},
                onChanged: (p0) {
                  setState(() {
                    valoresjson['tabelaInstalacoes'] = p0;
                  });
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Serviços:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.servicos : [],
                onChanged: (p0) => valoresjson['servicos'] = p0,
                nomes: [
                  'Realização de eventos próprios',
                  'Aluguel de equipamentos',
                  'Aluguel de espaço para terceiros',
                  'Serviços de alimentação',
                  'Organização de eventos',
                  'Serviços de som',
                  'outro',
                ],
              ),
              SizedBox(
                height: 30.w,
              ),
              textLabel(
                name: 'Equipamentos:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.equipamentos
                    : [],
                onChanged: (p0) => valoresjson['equipamentos'] = p0,
                nomes: [
                  'Internet',
                  'Elevador',
                  'Poltronas',
                  'Tv com canal aberto',
                  'Projetor',
                  'Computador',
                  'Equipamento de tradução simultânea',
                  'Parabólica',
                  'Ar condicionado central',
                  'Palco',
                  'outro'
                ],
              ),
              SizedBox(
                height: 30.w,
              ),
              textLabel(
                name: 'Facilidades e serviços:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.facilidadesEServicos
                    : [],
                onChanged: (p0) => valoresjson['facilidadesEServicos'] = p0,
                nomes: [
                  'Adaptador de voltagem',
                  'Impressora',
                  'Micro - ondas',
                  'Adega climatizada',
                  'Loja de conveniência',
                  'Cofre ',
                  'Agência de turismo',
                  'Heliponto',
                  'Lavanderia',
                  'Serviço de babá',
                  'Auditório',
                  'Sala de imprensa',
                  'Salão de beleza',
                  'Passeios e guias',
                  'Ar condicionado',
                  'Centra telefônica',
                  'Internet',
                  'Circuito interno de TV',
                  'Churrasqueira',
                  'Barbearia',
                  'Farmácia',
                  'Guarda - volume',
                  'Locadora de veículos',
                  'Embarcações',
                  'Serviços de copa',
                  'Serviço médico',
                  'Sala de reuniões',
                  'Sala de ginástica',
                  'Salão de jogos',
                  'Câmbio',
                  'Ventilador',
                  'Telefone',
                  'Internet sem fio',
                  'Forno elétrico',
                  'Bar',
                  'Lojas',
                  'Caixa eletrônico',
                  'Informações turísticas',
                  'Traslados',
                  'Manobrista',
                  'Serviço bilíngue',
                  'Elevador',
                  'Sala de convenções',
                  'Equipamento de ginástica',
                  'Exposição de arte/artesanato',
                  'outro'
                ],
              ),
              SizedBox(
                height: 30.w,
              ),
              textLabel(
                name: 'Facilidades para executivos:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.facilidadesParaExecutivos
                    : [],
                onChanged: (p0) =>
                    valoresjson['facilidadesParaExecutivos'] = p0,
                nomes: [
                  'Apartamentos em andares especiais',
                  'Café da manhã em ambiente privativo',
                  'Jornais diários no apartamento',
                  'Acesso á internet sem fio',
                  'Acesso a internet em áreas comuns',
                  'Impressora',
                  'Datashow',
                  'Sla de reunião',
                  'Serviço de café',
                  'Guarda de mala em consignação',
                  'Lustro e graxa para os sapatos',
                  'Check in e check out expresso em ambiente diferenciado',
                  'Early check in e late check out conforme disponibilidade',
                  'Acesso á internet banda larga',
                  'Acesso a internet na UH',
                  'Computador ',
                  'fax',
                  'Máquina de fotocópia',
                  'Serviço de chá',
                  'Refrigerante / sucos',
                  'Lavagem e passagem de roupa no período noturno',
                  'outro'
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.15,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Proteção, Qualificação, Certificação, Premiação, destaques e outros',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Row(children: [
                textLabel(
                  name: 'Do equipamento/espaço:',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  width: sizeScreen.width * 0.04,
                ),
                SizedBox(
                    // width: sizeScreen.width * 0.5,
                    //  //height: sizeScreen.height * 0.07,
                    child: ExpansionTileYoN(
                  optionModel: isUpdate == true
                      ? widget.hospedagemModel!.doEquipamentoEspaco
                      : "não",
                  getValue: (newValue) {
                    valoresjson['doEquipamentoEspaco'] = newValue;
                  },
                ))
              ]),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              TabelsEquipamentoEEspaco(
                getValue: isUpdate == true
                    ? widget.hospedagemModel!.tabelaEquipamentoEEspaco
                    : {},
                onChanged: (p0) {
                  setState(() {
                    valoresjson['tabelaEquipamentoEEspaco'] = p0;
                  });
                },
              ),
              SizedBox(
                height: 100.w,
              ),
              Row(children: [
                textLabel(
                  name:
                      'Da área ou edificação \nem que está\nlocalizado / Instalado',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  width: sizeScreen.width * 0.04,
                ),
                SizedBox(
                    // width: sizeScreen.width * 0.5,
                    //  //height: sizeScreen.height * 0.07,
                    child: ExpansionTileYoN(
                  optionModel: isUpdate == true
                      ? widget.hospedagemModel!
                          .daAreaOuEdificacaoEmQueEstaLocalizado
                      : "não",
                  getValue: (newValue) {
                    valoresjson['daAreaOuEdificacaoEmQueEstaLocalizado'] =
                        newValue;
                  },
                ))
              ]),
              SizedBox(
                height: 100.w,
              ),
              TabelsEquipamentoEEspaco(
                getValue: isUpdate == true
                    ? widget.hospedagemModel!.tabelaEquipamentoEEspaco2
                    : {},
                onChanged: (p0) {
                  setState(() {
                    valoresjson['tabelaEquipamentoEEspaco2'] = p0;
                  });
                },
              ),

              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.06,
                width: sizeScreen.width,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Estado geral de conservação',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              RadioD(
                indexModel: isUpdate == true
                    ? widget.hospedagemModel!.estadoGeralDeConservacao
                    : "",
                options: ['Muito bom', 'Bom', 'Ruim'],
                getValue: (newValue) {
                  valoresjson['estadoGeralDeConservacao'] = newValue;
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.06,
                width: sizeScreen.width,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Acessibilidade',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name:
                    'Possui alguma facilidade para pessoas  com deficiência ou mobilidade reduzida?',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.04,
              ),
              ExpansionTileYoN(
                optionModel: isUpdate == true
                    ? widget.hospedagemModel!.possuiFacilidade
                    : "não",
                getValue: (newValue) {
                  valoresjson['possuiFacilidade'] = newValue;
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'obs: caso sim, responder às questões seguintes',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Pessoal capacitado para receber PCD:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.pessoalCapacitadoParaReceberPCD
                    : [],
                onChanged: (p0) =>
                    valoresjson['pessoalCapacitadoParaReceberPCD'] = p0,
                nomes: [
                  'Não',
                  'Física',
                  'Auditiva',
                  'Visual',
                  'Mental',
                  'Múltipla'
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Rota externa acessível:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.rotaExternaAcessivel
                    : [],
                onChanged: (p0) => valoresjson['rotaExternaAcessivel'] = p0,
                nomes: [
                  'Não',
                  'Estacionamento',
                  'Calçada rebaixada',
                  'Faixa de pedestre',
                  'Rampa',
                  'Semáforo sonoro',
                  'Piso tátil de alerta',
                  'Piso regular antiderrapante',
                  'Livre de obstáculos',
                  'outro'
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Símbolo internacional de acesso:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),

              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.simboloInternacionalDeAcesso
                    : [],
                onChanged: (p0) =>
                    valoresjson['simboloInternacionalDeAcesso'] = p0,
                nomes: [
                  'Não',
                  'Entrada',
                  'Área reservada',
                  'Estacionamento',
                  'Área de embarque e desembarque',
                  'Sanitário',
                  'Saída de emergência',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Local de embarque e desembarque',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.localDeEmbarqueEDesembarque
                    : [],
                onChanged: (p0) =>
                    valoresjson['localDeEmbarqueEDesembarque'] = p0,
                nomes: ['Não', 'Sinalizado', 'Com acesso em nível'],
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Vaga em estacionamento:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 50.w),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.vagaEmEstacionamento
                    : [],
                onChanged: (p0) => valoresjson['vagaEmEstacionamento'] = p0,
                nomes: [
                  'Não',
                  'Sinalizado',
                  'Com acesso em nível',
                  'Alargada para cadeira de rodas',
                  'Rampa de acesso á calçada'
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name:
                    'Área de circulação / acesso interno\npara cadeira de rodas:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.areaDeCirculacaoAcessoInterno
                    : [],
                onChanged: (p0) =>
                    valoresjson['areaDeCirculacaoAcessoInterno'] = p0,
                nomes: [
                  'Não',
                  'Rampa',
                  'Elevador',
                  'Plataforma elevatória',
                  'Porta larga',
                  'Piso regular / antiderrapante'
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Escada:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.escada : [],
                onChanged: (p0) => valoresjson['escada'] = p0,
                nomes: [
                  'Não',
                  'Corrimão',
                  'Patamar para descanso',
                  'Sinalização tátil de alerta',
                  'Piso antiderrapante',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Rampa:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.rampa : [],
                onChanged: (p0) => valoresjson['rampa'] = p0,
                nomes: [
                  'Não',
                  'Corrimão',
                  'Patamar para descanso',
                  'Sinalização tátil de alerta',
                  'Piso antiderrapante',
                  'Inclinação adequada',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Piso:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.piso : [],
                onChanged: (p0) => valoresjson['piso'] = p0,
                nomes: [
                  'Não',
                  'Tátil',
                  'Sem obstáculos',
                  'Antiderrapante/deslizante',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Elevador:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.elevador : [],
                onChanged: (p0) => valoresjson['elevador'] = p0,
                nomes: [
                  'Não',
                  'Sinalizado em braile',
                  'Dispositivo sonoro',
                  'Dispositivo luminoso',
                  'Sensor eletrônico (porta)'
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Equipamento motorizado para deslocamento interno:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!
                        .equipamentoMotorizadoParaDeslocamentoInterno
                    : [],
                onChanged: (p0) => valoresjson[
                    'equipamentoMotorizadoParaDeslocamentoInterno'] = p0,
                nomes: [
                  'Não',
                  'Cadeira',
                  'Carrinho',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Sinalização visual:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.sinalizacaoVisual
                    : [],
                onChanged: (p0) => valoresjson['sinalizacaoVisual'] = p0,
                nomes: [
                  'Não',
                  'Entrada',
                  'Recepção',
                  'Porta',
                  'Sanitário',
                  'Elevador',
                  'Restaurante',
                  'Área de lazer',
                  'Área de resgate',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Sinalização tátil:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.sinalizacaoTatil
                    : [],
                onChanged: (p0) => valoresjson['sinalizacaoTatil'] = p0,
                nomes: [
                  'Não',
                  'Entrada',
                  'Recepção',
                  'Porta',
                  'Sanitário',
                  'Elevador',
                  'Restaurante',
                  'Área de lazer',
                  'Área de resgate',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Alarme de emergência:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.alarmeDeEmergencia
                    : [],
                onChanged: (p0) => valoresjson['alarmeDeEmergencia'] = p0,
                nomes: [
                  'Não',
                  'Sonoro',
                  'Visual',
                  'Vibratório',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Comunicação:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.comunicacao : [],
                onChanged: (p0) => valoresjson['comunicacao'] = p0,
                nomes: [
                  'Não',
                  'Texto informativo em braile',
                  'Texto informativo em fonte ampliada',
                  'Intérprete em libras',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Balcão de atendimento:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel: isUpdate == true
                    ? widget.hospedagemModel!.balcaoDeAtendimento
                    : [],
                onChanged: (p0) => valoresjson['balcaoDeAtendimento'] = p0,
                nomes: [
                  'Não',
                  'Rebaixado',
                  'Preferencial para PCD ou com deficiência ou mobilidade reduzida',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Mobiliário:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                onChanged: (p0) => valoresjson['mobiliario'] = p0,
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.mobiliario : [],
                nomes: [
                  'Não',
                  'Altura adequada',
                  'Recuo adequado',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Sanitário:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                onChanged: (p0) => valoresjson['sanitario'] = p0,
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.sanitario : [],
                nomes: [
                  'Não',
                  'Porta larga suficiente para entrada de cadeira de rodas ',
                  'Acesso para cadeira de rodas',
                  'Espelho rebaixado ou com ângulo de alcance visual',
                  'Torneira monocomando / alavanca',
                  'Barra de apoio',
                  'Giro para cadeira de rodas',
                  'Pia rebaixada',
                  'Boxe ou banheira daptada',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name: 'Telefone:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 50.w,
              ),
              CheckC(
                nomesModel:
                    isUpdate == true ? widget.hospedagemModel!.telefone : [],
                onChanged: (p0) => valoresjson['telefone'] = p0,
                nomes: [
                  'Não',
                  'Altura adequada',
                  'Para surdos (TPS ou TTS)',
                ],
              ),
              SizedBox(
                height: 50.w,
              ),
              textLabel(
                name:
                    'Sinalização indicativa de atendimento preferencial para pessoas com deficiência ou mobilidade reduzida:',
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 50,
              ),

              ExpansionTileYoN(
                optionModel: isUpdate == true
                    ? widget.hospedagemModel!.sinalizacaoIndicativa
                    : "não",
                getValue: (newValue) {
                  valoresjson['sinalizacaoIndicativa'] = newValue;
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              Row(
                children: [
                  textLabel(
                    name: 'Outros',
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    width: sizeScreen.width * 0.1,
                  ),
                  SizedBox(
                      width: sizeScreen.width * 0.6,
                      //eight: sizeScreen.height * 0.07,
                      child: CustomTextField(
                        controller: getController('outros'),
                        validat: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          return null;
                        },
                        name: '',
                        getValue: (newValue) {
                          valoresjson['outros'] = newValue;
                        },
                      ))
                ],
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.06,
                width: sizeScreen.width,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Observações',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              CustomTextField(
                controller: getController('observacoes'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: '',
                getValue: (newValue) {
                  valoresjson['observacoes'] = newValue;
                },
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),

              Container(
                color: const Color.fromARGB(255, 55, 111, 60),
                height: sizeScreen.height * 0.06,
                width: sizeScreen.width,
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.008,
                    left: sizeScreen.width * 0.04),
                child: Text(
                  'Referências',
                  style: TextStyle(
                      color: Colors.white, fontSize: sizeScreen.height * 0.03),
                ),
              ),
              CustomTextField(
                controller: getController('referencias'),
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: '',
                getValue: (newValue) {
                  valoresjson['referencias'] = newValue;
                },
              ),

              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              SendButton(
                onPressed: () {
                   valoresjson['estadosTuristas'] = _estadosSelecionados;
                  valoresjson['paisesTuristas'] = _paisesSelecionados;

                  valoresjson['nome_pesquisador'] = pesquisadorNome;
                      valoresjson['telefone_pesquisador'] = pesquisadorTelefone;
                      valoresjson['email_pesquisador'] = pesquisadorEmail;
                      valoresjson['nome_coordenador'] = coordenadorNome;
                      valoresjson['telefone_coordenador'] = coordenadorTelefone;
                      valoresjson['email_coordenador'] = coordenadorEmail;
                  _formKey.currentState!.save();

                  isUpdate == true? update(widget.hospedagemModel!.id!, valoresjson):sendForm(valoresjson);
              
                  isUpdate == false? Navigator.pushReplacementNamed(context, '/SendedForm') : Navigator.pushReplacementNamed(context, '/UpdatedForm');
                },
              ),

              SizedBox(
                height: sizeScreen.height * 0.05,
              )
            ]),
          ),
        ));
  }
}
