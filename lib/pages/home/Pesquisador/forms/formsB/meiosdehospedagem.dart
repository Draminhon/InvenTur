import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/estado_model.dart';
import 'package:inventur/models/pais_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/apis/estados.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/sendButton.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/tabela.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/expandedTileYoN.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/apis/paises.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/tables.dart';
import 'package:inventur/pages/widgets/auto_complete_text_field.dart';

class MeiosDeHospedagem extends StatefulWidget {
  MeiosDeHospedagem({super.key});

  @override
  State<MeiosDeHospedagem> createState() => _MeiosDeHospedagemState();
}

class _MeiosDeHospedagemState extends State<MeiosDeHospedagem> {
  final _formKey = GlobalKey<FormState>();
  late Estado? _estadoSelecionado = Estado(id: -1, sigla: '', nome: '');
  late Pais? _paisSelecionado = Pais(nome: '');
  final PesquisaController _pesquisaController = PesquisaController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();
  final Map<String, dynamic> valoresjson = {
    'tipo_formulario': 'Meios de Hospedagem',
    'uf': null,
    'regiao_turistica': null,
    'municipio': null,
    'tipo': null,
    'subtipo': null,
    'razao_social': null,
    'nome_fantasia': null,
    'codigo_CNAE': null,
    'atividade_economica': null,
    'inscricao_municipal': null,
    'nome_da_rede_holding': null,
    'CNPJ': null,
    'natureza': null,
    'tipo_de_organizacao_instituicao': null,
    'inicio_atividade': null,
    'quantidade_funcionarios_permanentes': null,
    'quantidade_funcionarios_temporarios': null,
    'quantidade_funcionarios_com_deficiencia': null,
    'localizacao': null,
    'coordenadas_geograficas_latitude': null,
    'coordenadas_geograficas_longitude': null,
    'endereco_rua_avenida_travessia_caminho_outro': null,
    'endereco_bairro_localidade': null,
    'endereco_distrito': null,
    'endereco_CEP': null,
    'whatsapp': null,
    'instagram': null,
    'email': null,
    'site': null,
    'sinalizacao_de_acesso': null,
    'sinalizacao_turistica': null,
    'proximidades': null,
    'pontos_de_referencia': null,
    'MTur_CADASTUR': null,
    'MTur_outros': null,
    'associacoes_e_sindicatos_do_setor_de_hospedagem': null,
    'associcoes_de_turismo': null,
    'associacoes_comerciais': null,
    'guias_turisticos': null,
    'outros_entidade_guia_turistico': null,
    'segmentos_ou_tipos_de_turismo_em_que_e_especializado': null,
    'tipo_de_diária': null,
    'formas_de_pagamento': null,
    'reservas': null,
    'atendimento_em_lingua_estrangeira': null,
    'informativo impressos': null,
    'periodo': null,
    'horario_segunda_feira_abertura': null,
    'horario_segunda_feira_encerramento': null,
    'horario_terca_feira_abertura': null,
    'horario_terca_feira_encerramento': null,
    'horario_quarta_feira_abertura': null,
    'horario_quarta_feira_encerramento': null,
    'horario_quinta_feira_abertura': null,
    'horario_quinta_feira_encerramento': null,
    'horario_sexta_feira_abertura': null,
    'horario_sexta_feira_encerramento': null,
    'horario_sabado_abertura': null,
    'horario_sabado_encerramento': null,
    'horario_domingo_abertura': null,
    'horario_domingo_encerramento': null,
    'funcionamento_24_horas': null,
    'funcionamento_em_feriados': null,
    'restricoes': null,
    'outras_regras_e_informacoes': null,
    'dados_da_visitacao_ocupacao_ano': null,
    'dados_da_visitacao_ocupacao_na_alta_temporada': null,
    'meses_de_alta_temporada': null,
    'origem_dos_visitantes_turistas': null,
    'origem_dos_turistas_nacionais_estados': null,
    'origem_dos_turistas_internacionais_paises': null,
    'unidades_habitacionais_total_de_uh': null,
    'unidades_habitacionais_total_de_leitos': null,
    'unidades_habitacionais_uh_adaptados_para_pcd': null,
    'produtos_de_higiene_pessoal': null,
    'equipamentos_e_servicos': null,
    'instalacoes_estacionamento': null,
    'estacionamento_capacidade_veiculos': null,
    'estacionamento_numero_automoveis': null,
    'estacionamento_numero_onibus': null,
    'outras_instalacoes_energia_eletrica': null,
    'energia_eletrica_capacidade_KVA': null,
    'outras_instalacoes_gerador_de_emergencia': null,
    'gerador_de_emergencia_capacidade_KVA': null,
    'area_de_alimentacao_restaurante': null,
    'restaurante_capacidade_instalada_por_dia': null,
    'restaurante_capacidade_instalada_por_dia_numero_pessoas_atendidas_sentadas':
        null,
    'restaurante_capacidade_simultanea': null,
    'restaurante_capacidade_simultanea_numero_pessoas_atendidas_sentadas': null,
    'area_de_alimentacao_lanchonete': null,
    'lanchonete_capacidade_instalada_por_dia': null,
    'lanchonete_capacidade_instalada_por_dia_numero_pessoas_atendidas_sentadas':
        null,
    'lanchonete_capacidade_simultanea': null,
    'lanchonete_capacidade_simultanea_numero_pessoas_atendidas_sentadas': null,
    'area_recreacao_e_lazer_instalacoes': null,
    'area_recreacao_e_lazer_outros_espacos_equipamentos_e_atividades': null,
    'area_para_eventos_instalacoes': null,
    'area_para_eventos_servicos': null,
    'area_para_eventos_equipamentos': null,
    'facilidade_e_servicos': null,
    'facilidade_para_executivos': null,
    'protecao_qualificacao_do_esquipamento_espaco': null,
    'protecao_qualificacao_do_esquipamento_espaco_municipal': null,
    'protecao_qualificacao_do_esquipamento_espaco_estadual_distrital': null,
    'protecao_qualificacao_do_esquipamento_espaco_federal': null,
    'protecao_qualificacao_do_esquipamento_espaco_internacional': null,
    'protecao_qualificacao_do_esquipamento_espaco_outras': null,
    'protecao_qualificacao_da_area_ou_edificacao': null,
    'protecao_qualificacao_da_area_ou_edificacao_municipal': null,
    'protecao_qualificacao_da_area_ou_edificacao_estadual_distrital': null,
    'protecao_qualificacao_da_area_ou_edificacao_federal': null,
    'protecao_qualificacao_da_area_ou_edificacao_internacional': null,
    'protecao_qualificacao_da_area_ou_edificacao_outras': null,
    'estado_geral_de_conservacao': null,
    'acessibilidade_possui_alguma_facilidade_para_pcd_ou_mobilidade_reduzida':
        null,
    'acessibilidade_possui_pessoal_capacitado_para_receber_pcd': null,
    'acessibilidade_rota_externa_acessivel': null,
    'acessibilidade_simbolo_internacional_de_acesso': null,
    'acessibilidade_local_de_embarque_e_desembarque': null,
    'acessibilidade_vaga_em_estacionamento': null,
    'acessibilidade_area_de_circulacao_acesso_interno_para_cadeira_de_rodas':
        null,
    'acessibilidade_escada': null,
    'acessibilidade_rampa': null,
    'acessibilidade_piso': null,
    'acessibilidade_elevador': null,
    'acessibilidade_equipamento_motorizado_para_deslocamento_interno': null,
    'acessibilidade_sinalizacao_visual': null,
    'acessibilidade_sinalizacao_tatil': null,
    'acessibilidade_alarme_de_emergencia': null,
    'acessibilidade_comunicacao': null,
    'acessibilidade_balcao_de_atendimento': null,
    'acessibilidade_mobiliário': null,
    'acessibilidade_sanitário': null,
    'acessibilidade_telefone': null,
    'acessibilidade_sinalizacao_indicaiva_de_atendimento_preferencial_para_pessoas_com_deficiencia_ou_mobilidade_reduzida':
        null,
    'acessibilidade_outros': null,
    'observacoes': null,
    'referencias': null,  
    'nome_pesquisador': 'jose',
    'telefone_pesquisador': '12453',
    'email_pesquisador': 'jose@gmail.com',
    'nome_coordenador': 'oihaioo',
    'telefone_coordenador': '4444',
    'email_coordenador': 'ogaio@gmail.com',
  };

final TextEditingController uf = TextEditingController();
final TextEditingController regiao_turistica = TextEditingController();
final TextEditingController municipio = TextEditingController();
final TextEditingController tipo = TextEditingController();
final TextEditingController subtipo = TextEditingController();
final TextEditingController razao_social = TextEditingController();
final TextEditingController nome_fantasia = TextEditingController();
final TextEditingController codigo_CNAE = TextEditingController();
final TextEditingController atividade_economica = TextEditingController();
final TextEditingController inscricao_municipal = TextEditingController();
final TextEditingController nome_da_rede_holding = TextEditingController();
final TextEditingController CNPJ = TextEditingController();
final TextEditingController natureza = TextEditingController();
final TextEditingController tipo_de_organizacao_instituicao = TextEditingController();
final TextEditingController inicio_atividade = TextEditingController();
final TextEditingController quantidade_funcionarios_permanentes = TextEditingController();
final TextEditingController quantidade_funcionarios_temporarios = TextEditingController();
final TextEditingController quantidade_funcionarios_com_deficiencia = TextEditingController();
final TextEditingController localizacao = TextEditingController();
final TextEditingController coordenadas_geograficas_latitude = TextEditingController();
final TextEditingController coordenadas_geograficas_longitude = TextEditingController();
final TextEditingController endereco_rua_avenida_travessia_caminho_outro = TextEditingController();
final TextEditingController endereco_bairro_localidade = TextEditingController();
final TextEditingController endereco_distrito = TextEditingController();
final TextEditingController endereco_CEP = TextEditingController();
final TextEditingController whatsapp = TextEditingController();
final TextEditingController instagram = TextEditingController();
final TextEditingController email = TextEditingController();
final TextEditingController site = TextEditingController();
final TextEditingController sinalizacao_de_acesso = TextEditingController();
final TextEditingController sinalizacao_turistica = TextEditingController();
final TextEditingController proximidades = TextEditingController();
final TextEditingController pontos_de_referencia = TextEditingController();
final TextEditingController MTur_CADASTUR = TextEditingController();
final TextEditingController MTur_outros = TextEditingController();
final TextEditingController associacoes_e_sindicatos_do_setor_de_hospedagem = TextEditingController();
final TextEditingController associcoes_de_turismo = TextEditingController();
final TextEditingController associacoes_comerciais = TextEditingController();
final TextEditingController guias_turisticos = TextEditingController();
final TextEditingController outros_entidade_guia_turistico = TextEditingController();
final TextEditingController segmentos_ou_tipos_de_turismo_em_que_e_especializado = TextEditingController();
final TextEditingController tipo_de_diaria = TextEditingController();
final TextEditingController formas_de_pagamento = TextEditingController();
final TextEditingController reservas = TextEditingController();
final TextEditingController atendimento_em_lingua_estrangeira = TextEditingController();
final TextEditingController informativo_impressos = TextEditingController();
final TextEditingController periodo = TextEditingController();
final TextEditingController horario_segunda_feira_abertura = TextEditingController();
final TextEditingController horario_segunda_feira_encerramento = TextEditingController();
final TextEditingController horario_terca_feira_abertura = TextEditingController();
final TextEditingController horario_terca_feira_encerramento = TextEditingController();
final TextEditingController horario_quarta_feira_abertura = TextEditingController();
final TextEditingController horario_quarta_feira_encerramento = TextEditingController();
final TextEditingController horario_quinta_feira_abertura = TextEditingController();
final TextEditingController horario_quinta_feira_encerramento = TextEditingController();
final TextEditingController horario_sexta_feira_abertura = TextEditingController();
final TextEditingController horario_sexta_feira_encerramento = TextEditingController();
final TextEditingController horario_sabado_abertura = TextEditingController();
final TextEditingController horario_sabado_encerramento = TextEditingController();
final TextEditingController horario_domingo_abertura = TextEditingController();
final TextEditingController horario_domingo_encerramento = TextEditingController();
final TextEditingController funcionamento_24_horas = TextEditingController();
final TextEditingController funcionamento_em_feriados = TextEditingController();
final TextEditingController restricoes = TextEditingController();
final TextEditingController outras_regras_e_informacoes = TextEditingController();
final TextEditingController dados_da_visitacao_ocupacao_ano = TextEditingController();
final TextEditingController dados_da_visitacao_ocupacao_na_alta_temporada = TextEditingController();
final TextEditingController meses_de_alta_temporada = TextEditingController();
final TextEditingController origem_dos_visitantes_turistas = TextEditingController();
final TextEditingController origem_dos_turistas_nacionais_estados = TextEditingController();
final TextEditingController origem_dos_turistas_internacionais_paises = TextEditingController();
final TextEditingController unidades_habitacionais_total_de_uh = TextEditingController();
final TextEditingController unidades_habitacionais_total_de_leitos = TextEditingController();
final TextEditingController unidades_habitacionais_uh_adaptados_para_pcd = TextEditingController();
final TextEditingController produtos_de_higiene_pessoal = TextEditingController();
final TextEditingController equipamentos_e_servicos = TextEditingController();
final TextEditingController instalacoes_estacionamento = TextEditingController();
final TextEditingController estacionamento_capacidade_veiculos = TextEditingController();
final TextEditingController estacionamento_numero_automoveis = TextEditingController();
final TextEditingController estacionamento_numero_onibus = TextEditingController();
final TextEditingController outras_instalacoes_energia_eletrica = TextEditingController();
final TextEditingController energia_eletrica_capacidade_KVA = TextEditingController();
final TextEditingController outras_instalacoes_gerador_de_emergencia = TextEditingController();
final TextEditingController gerador_de_emergencia_capacidade_KVA = TextEditingController();
final TextEditingController area_de_alimentacao_restaurante = TextEditingController();
final TextEditingController restaurante_capacidade_instalada_por_dia = TextEditingController();
final TextEditingController restaurante_capacidade_instalada_por_dia_numero_pessoas_atendidas_sentadas = TextEditingController();
final TextEditingController restaurante_capacidade_simultanea = TextEditingController();
final TextEditingController restaurante_capacidade_simultanea_numero_pessoas_atendidas_sentadas = TextEditingController();
final TextEditingController area_de_alimentacao_lanchonete = TextEditingController();
final TextEditingController lanchonete_capacidade_instalada_por_dia = TextEditingController();
final TextEditingController lanchonete_capacidade_instalada_por_dia_numero_pessoas_atendidas_sentadas = TextEditingController();
final TextEditingController lanchonete_capacidade_simultanea = TextEditingController();
final TextEditingController lanchonete_capacidade_simultanea_numero_pessoas_atendidas_sentadas = TextEditingController();
final TextEditingController area_recreacao_e_lazer_instalacoes = TextEditingController();
final TextEditingController area_recreacao_e_lazer_outros_espacos_equipamentos_e_atividades = TextEditingController();
final TextEditingController area_para_eventos_instalacoes = TextEditingController();
final TextEditingController area_para_eventos_servicos = TextEditingController();
final TextEditingController area_para_eventos_equipamentos = TextEditingController();
final TextEditingController facilidade_e_servicos = TextEditingController();
final TextEditingController facilidade_para_executivos = TextEditingController();
final TextEditingController protecao_qualificacao_do_esquipamento_espaco = TextEditingController();
final TextEditingController protecao_qualificacao_do_esquipamento_espaco_municipal = TextEditingController();
final TextEditingController protecao_qualificacao_do_esquipamento_espaco_estadual_distrital = TextEditingController();
final TextEditingController protecao_qualificacao_do_esquipamento_espaco_federal = TextEditingController();
final TextEditingController protecao_qualificacao_do_esquipamento_espaco_internacional = TextEditingController();
final TextEditingController protecao_qualificacao_do_esquipamento_espaco_outras = TextEditingController();
final TextEditingController protecao_qualificacao_da_area_ou_edificacao = TextEditingController();
final TextEditingController protecao_qualificacao_da_area_ou_edificacao_municipal = TextEditingController();
final TextEditingController protecao_qualificacao_da_area_ou_edificacao_estadual_distrital = TextEditingController();
final TextEditingController protecao_qualificacao_da_area_ou_edificacao_federal = TextEditingController();
final TextEditingController protecao_qualificacao_da_area_ou_edificacao_internacional = TextEditingController();
final TextEditingController protecao_qualificacao_da_area_ou_edificacao_outras = TextEditingController();
final TextEditingController estado_geral_de_conservacao = TextEditingController();
final TextEditingController acessibilidade_possui_alguma_facilidade_para_pcd_ou_mobilidade_reduzida = TextEditingController();
final TextEditingController acessibilidade_possui_pessoal_capacitado_para_receber_pcd = TextEditingController();
final TextEditingController acessibilidade_rota_externa_acessivel = TextEditingController();
final TextEditingController acessibilidade_simbolo_internacional_de_acesso = TextEditingController();
final TextEditingController acessibilidade_local_de_embarque_e_desembarque = TextEditingController();
final TextEditingController acessibilidade_vaga_em_estacionamento = TextEditingController();
final TextEditingController acessibilidade_area_de_circulacao_acesso_interno_para_cadeira_de_rodas = TextEditingController();
final TextEditingController acessibilidade_escada = TextEditingController();
final TextEditingController acessibilidade_rampa = TextEditingController();
final TextEditingController acessibilidade_piso = TextEditingController();
final TextEditingController acessibilidade_elevador = TextEditingController();
final TextEditingController acessibilidade_equipamento_motorizado_para_deslocamento_interno = TextEditingController();
final TextEditingController acessibilidade_sinalizacao_visual = TextEditingController();
final TextEditingController acessibilidade_sinalizacao_tatil = TextEditingController();
final TextEditingController acessibilidade_alarme_de_emergencia = TextEditingController();
final TextEditingController acessibilidade_comunicacao = TextEditingController();
final TextEditingController acessibilidade_balcao_de_atendimento = TextEditingController();
final TextEditingController acessibilidade_mobiliario = TextEditingController();
final TextEditingController acessibilidade_sanitario = TextEditingController();
final TextEditingController acessibilidade_telefone = TextEditingController();
final TextEditingController acessibilidade_sinalizacao_indicaiva_de_atendimento_preferencial_para_pessoas_com_deficiencia_ou_mobilidade_reduzida = TextEditingController();
final TextEditingController acessibilidade_outros = TextEditingController();
final TextEditingController observacoes = TextEditingController();
final TextEditingController referencias = TextEditingController();
final TextEditingController nome_pesquisador = TextEditingController();
final TextEditingController telefone_pesquisador = TextEditingController();
final TextEditingController email_pesquisador = TextEditingController();
final TextEditingController nome_coordenador = TextEditingController();
final TextEditingController telefone_coordenador = TextEditingController();
final TextEditingController email_coordenador = TextEditingController();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pesquisaController.setEstados();
    _pesquisaController.setPaises();
  }

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(hintText: 'Região Turística'),
                          ))
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      left: sizeScreen.width * 0.05,
                      right: sizeScreen.width * 0.1,
                      top: sizeScreen.height * 0.01),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Preencha o campo';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Município'),
                  )),
              textLabel(
                name: 'Tipo:',
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: EdgeInsets.only(left: sizeScreen.width * 0.12),
                child: RadioB(
                  name: 'Hotelaria e apoio',
                  getValue: (newValue) {},
                ),
              ),
              textLabel(name: 'Subtipos:', fontWeight: FontWeight.bold),

              RadioD(
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
                getValue: (String) {},
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
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (String) {},
              ),
              CustomTextField(
                name: 'Nome Fantasia',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (String) {},
              ),
              CustomTextField(
                name: 'Código CNAE',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (String) {},
              ),
              CustomTextField(
                name: 'Atividade econômica',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (String) {},
              ),
              CustomTextField(
                name: 'Inscrição Municipal',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (String) {},
              ),
              CustomTextField(
                name: 'Nome da rede/holding',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (String) {},
              ),
              CustomTextField(
                name: 'CNPJ',
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                getValue: (String) {},
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),

              textLabel(name: 'Natureza:', fontWeight: FontWeight.bold),

              Column(
                children: [
                  RadioD(
                    options: ['pública', 'privada', 'outro'],
                    getValue: (String) {},
                  ),
                ],
              ),

              textLabel(
                  name: 'Tipo de organização/instituição:',
                  fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(
                nomes: [
                  'associação',
                  'sindicato',
                  'cooperativa',
                  'sistema S',
                  'empresa',
                  'outro'
                ],
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
                        getValue: (String) {},
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
                          name: 'Permanentes', fontWeight: FontWeight.bold),
                      SizedBox(
                        width: sizeScreen.width * 0.026,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'n°',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (String) {},
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  ),
                  Row(
                    children: [
                      textLabel(
                          name: 'Temporários', fontWeight: FontWeight.bold),
                      SizedBox(
                        width: sizeScreen.width * 0.038,
                      ),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: 'n°',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (String) {},
                          ))
                    ],
                  ),
                  SizedBox(height: sizeScreen.height * 0.02),
                  Row(
                    children: [
                      textLabel(
                          name: 'Pessoas com\ndefiicência (%)',
                          fontWeight: FontWeight.bold),
                      SizedBox(
                          width: sizeScreen.width * 0.6,
                          //height: sizeScreen.height * 0.07,
                          child: CustomTextField(
                            name: '%',
                            validat: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Preencha o campo';
                              }
                              return null;
                            },
                            getValue: (String) {},
                          ))
                    ],
                  ),
                  SizedBox(
                    height: sizeScreen.height * 0.02,
                  )
                ],
              ),
              textLabel(name: 'Localização:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              RadioD(
                options: ['urbana', 'rural'],
                getValue: (String) {},
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
                    textLabel(name: 'Latitude', fontWeight: FontWeight.bold),
                    SizedBox(
                      width: sizeScreen.width * 0.032,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          name: 'valor',
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          getValue: (String) {},
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    textLabel(name: 'Longitude', fontWeight: FontWeight.bold),
                    SizedBox(
                        width: sizeScreen.width * 0.6,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          name: 'valor',
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          getValue: (String) {},
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
              ]),
              textLabel(name: 'Endereço:', fontWeight: FontWeight.bold),

              CustomTextField(
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'avenida/rua/travessa/caminho/outro',
                getValue: (String) {},
              ),
              CustomTextField(
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'bairro/localidade',
                getValue: (String) {},
              ),
              CustomTextField(
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'distrito',
                getValue: (String) {},
              ),
              CustomTextField(
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'CEP',
                getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '(DD) n°',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: '@',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'e-mail',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'www.endereço.com',
                          getValue: (String) {},
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
                textLabel(name: 'de acessso -', fontWeight: FontWeight.bold),
                SizedBox(
                  width: sizeScreen.width * 0.09,
                ),
                SizedBox(
                    // width: sizeScreen.width * 0.5,
                    //  //height: sizeScreen.height * 0.07,
                    child: ExpansionTileYoN(
                  getValue: (String) {},
                ))
              ]),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              Row(children: [
                textLabel(name: 'turística -', fontWeight: FontWeight.bold),
                SizedBox(
                  width: sizeScreen.width * 0.14,
                ),
                SizedBox(
                    //width: sizeScreen.width * 0.5,
                    //  //height: sizeScreen.height * 0.07,
                    child: ExpansionTileYoN(
                  getValue: (String) {},
                ))
              ]),
              SizedBox(
                height: sizeScreen.height * 0.06,
              ),
              textLabel(name: 'Proximidades:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              //  RadioD(number: 6, options: options)
              const CheckC(
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
              textLabel(
                  name: 'Pontos de referência:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              CustomTextField(
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'ponto de referência',
                getValue: (String) {},
              ),
              SizedBox(
                height: sizeScreen.height * 0.1,
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
                height: sizeScreen.height * 0.05,
              ),

              textLabel(
                name: "Entidade/guia turístico",
                fontWeight: FontWeight.bold,
              ),

              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              textLabel(
                name: "MTur",
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                name: "CADASTUR",
                validat: (p0) {},
                getValue: (p0) {},
              ),
              CustomTextField(
                name: "outros",
                validat: (p0) {},
                getValue: (p0) {},
              ),
              textLabel(
                name: "associações e sindicatos do setor de hospedagem",
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                name: "categoria/tipo/classificação/número",
                validat: (p0) {},
                getValue: (p0) {},
              ),
              textLabel(
                name: "associações de turismo",
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                name: "categoria/tipo/classificação/número",
                validat: (p0) {},
                getValue: (p0) {},
              ),
              textLabel(
                name: "associações comerciais",
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                name: "categoria/tipo/classificação/número",
                validat: (p0) {},
                getValue: (p0) {},
              ),
              textLabel(
                name: "guias turísticos",
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                name: "categoria/tipo/classificação/número",
                validat: (p0) {},
                getValue: (p0) {},
              ),
              textLabel(
                name: "outros",
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                name: "categoria/tipo/classificação/número",
                validat: (p0) {},
                getValue: (p0) {},
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
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
              const SizedBox(
                height: 300,
                child: CheckB(
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
                getValue: (String) {},
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                  name: 'Formas de Pagamento:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(
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
              const CheckC(
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
              const CheckC(nomes: ['Não', 'Inglês', 'Espanhol', 'outro']),
              textLabel(
                  name: 'Informativos impressos:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(nomes: ['Não', 'Inglês', 'Espanhol', 'outro']),
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
                getValue: (String) {},
              ),
              textLabel(name: 'Horário:', fontWeight: FontWeight.bold),
              SizedBox(
                height: sizeScreen.height * 0.01,
              ),

              TabelaHorarios(),

              SizedBox(
                height: sizeScreen.height * 0.01,
              ),
              //TabelaT2(),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              textLabel(
                name: 'Funcionamento 24 horas:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              ExpansionTileYoN(
                getValue: (String) {},
              ),
              textLabel(
                name: 'Funcionamento em feriados:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.03,
              ),
              ExpansionTileYoN(
                getValue: (String) {},
              ),
              textLabel(
                name: 'Restrições:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(
                nomes: ['Crianças', 'Fumantes', 'Animais', 'outro'],
              ),
              textLabel(
                name: 'Outras regras e informações:',
                fontWeight: FontWeight.bold,
              ),

              CustomTextField(
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'Regras e informações',
                getValue: (String) {},
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
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'nº',
                getValue: (String) {},
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'Ocupação na alta temporada nº:',
                fontWeight: FontWeight.bold,
              ),

              CustomTextField(
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: 'nº',
                getValue: (String) {},
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

              const CheckC(
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
              textLabel(
                name: 'Origem dos visitantes/turistas:',
                fontWeight: FontWeight.bold,
              ),
              const CheckC(
                nomes: [
                  'Entorno municipal',
                  'Estadual',
                  'Nacional',
                  'Internacional'
                ],
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
                  textAlign: TextAlign.start,
                  label: "Selecione um estado",
                  onSelected: (option) {
                    _estadoSelecionado =
                        _pesquisaController.getEstadoByNome(option);
                    _pesquisaController.setMunicipios(_estadoSelecionado!.id);
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
                  onSelected: (option) {
                    _estadoSelecionado =
                        _pesquisaController.getEstadoByNome(option);
                    _pesquisaController.setMunicipios(_estadoSelecionado!.id);
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
                  onSelected: (option) {
                    _estadoSelecionado =
                        _pesquisaController.getEstadoByNome(option);
                    _pesquisaController.setMunicipios(_estadoSelecionado!.id);
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
                  onSelected: (option) {
                    _estadoSelecionado =
                        _pesquisaController.getEstadoByNome(option);
                    _pesquisaController.setMunicipios(_estadoSelecionado!.id);
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
                  onSelected: (option) {
                    _estadoSelecionado =
                        _pesquisaController.getEstadoByNome(option);
                    _pesquisaController.setMunicipios(_estadoSelecionado!.id);
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
                  onSelected: (option) {
                    _paisSelecionado =
                        _pesquisaController.getPaisesByNome(option);
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
                  onSelected: (option) {
                    _paisSelecionado =
                        _pesquisaController.getPaisesByNome(option);
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
                  onSelected: (option) {
                    _paisSelecionado =
                        _pesquisaController.getPaisesByNome(option);
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
                  onSelected: (option) {
                    _paisSelecionado =
                        _pesquisaController.getPaisesByNome(option);
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
                  onSelected: (option) {
                    _paisSelecionado =
                        _pesquisaController.getPaisesByNome(option);
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
                        ))
                  ],
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(
                    left: sizeScreen.width * 0.02,
                    top: sizeScreen.height * 0.03,
                    bottom: sizeScreen.height * 0.03),
                child: textLabel(
                  name: 'Produtos de higiene pessoal:',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const CheckC(nomes: [
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
              const CheckC(
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
                    bottom: sizeScreen.height * 0.02),
                child: textLabel(
                  name: 'Instalações:',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: sizeScreen.height * 0.03,
                    bottom: sizeScreen.height * 0.03),
                child: textLabel(
                  name: 'Estacionamento:',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const CheckC(
                nomes: ['Pago', 'Gratuito', 'Coberto', 'Descoberto'],
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
                getValue: (String) {},
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
                        validat: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          return null;
                        },
                        name: 'KVA',
                        getValue: (String) {},
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
                getValue: (String) {},
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
                        validat: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          return null;
                        },
                        name: 'KVA',
                        getValue: (String) {},
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
              const CheckC(
                nomes: [
                  'Não',
                  'Apenas para hóspedes',
                  'Aberto ao público',
                  'Adaptado para PCD'
                ],
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
              const CheckC(
                nomes: [
                  'Não',
                  'Apenas para hóspedes',
                  'Aberto ao público',
                  'Adaptado para PCD'
                ],
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
                          validat: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Preencha o campo';
                            }
                            return null;
                          },
                          name: 'nº',
                          getValue: (String) {},
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
              const CheckC(
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

              textLabel(
                name: 'Outros espaços, equipamentos e atividades:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(
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
              TablesInstalacoes(),
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
              const CheckC(
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
              textLabel(
                name: 'Equipamentos:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(
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

              textLabel(
                name: 'Facilidades e serviços:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(
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
              textLabel(
                name: 'Facilidades para executivos:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(
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
                  getValue: (String) {},
                ))
              ]),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              TabelsEquipamentoEEspaco(),
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
                  getValue: (String) {},
                ))
              ]),
              TabelsEquipamentoEEspaco(),

              SizedBox(
                height: sizeScreen.height * 0.05,
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
                options: ['Muito bom', 'Bom', 'Ruim'],
                getValue: (String) {},
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
                    'Possui alguma facilidade para pessoas com deficiência ou mobilidade reduzida?',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.04,
              ),
              ExpansionTileYoN(
                getValue: (String) {},
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              textLabel(
                name: 'obs: responder às questões seguintes',
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
              const CheckC(
                nomes: [
                  'Não',
                  'Física',
                  'Auditiva',
                  'Visual',
                  'Mental',
                  'Múltipla'
                ],
              ),
              textLabel(
                name: 'Rota externa acessível:',
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeScreen.height * 0.02,
              ),
              const CheckC(
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
              textLabel(
                name: 'Símbolo internacional de acesso:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
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
              textLabel(
                name: 'Local de embarque e desembarque',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: ['Não', 'Sinalizado', 'Com acesso em nível'],
              ),
              textLabel(
                name: 'Vaga em estacionamento:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Sinalizado',
                  'Com acesso em nível',
                  'Alargada para cadeira de rodas',
                  'Rampa de acesso á calçada'
                ],
              ),
              textLabel(
                name:
                    'Área de circulação / acesso interno\npara cadeira de rodas:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Rampa',
                  'Elevador',
                  'Plataforma elevatória',
                  'Porta larga',
                  'Piso regular / antiderrapante'
                ],
              ),
              textLabel(
                name: 'Escada:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Corrimão',
                  'Patamar para descanso',
                  'Sinalização tátil de alerta',
                  'Piso antiderrapante',
                ],
              ),

              textLabel(
                name: 'Rampa:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Corrimão',
                  'Patamar para descanso',
                  'Sinalização tátil de alerta',
                  'Piso antiderrapante',
                  'Inclinação adequada',
                ],
              ),
              textLabel(
                name: 'Piso:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Tátil',
                  'Sem obstáculos',
                  'Antiderrapante/deslizante',
                ],
              ),
              textLabel(
                name: 'Elevador:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Sinalizado em braile',
                  'Dispositivo sonoro',
                  'Dispositivo luminoso',
                  'Sensor eletrônico (porta)'
                ],
              ),
              textLabel(
                name: 'Equipamento motorizado para deslocamento interno:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Cadeira',
                  'Carrinho',
                ],
              ),
              textLabel(
                name: 'Sinalização visual:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
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
              textLabel(
                name: 'Sinalização tátil:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
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
              textLabel(
                name: 'Alarme de emergência:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Sonoro',
                  'Visual',
                  'Vibratório',
                ],
              ),
              textLabel(
                name: 'Comunicação:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Texto informativo em braile',
                  'Texto informativo em fonte ampliada',
                  'Intérprete em libras',
                ],
              ),
              textLabel(
                name: 'Balcão de atendimento:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Rebaixado',
                  'Preferencial para PCD ou com deficiência ou mobilidade reduzida',
                ],
              ),
              textLabel(
                name: 'Mobiliário:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Altura adequada',
                  'Recuo adequado',
                ],
              ),
              textLabel(
                name: 'Sanitário:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
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
              textLabel(
                name: 'Telefone:',
                fontWeight: FontWeight.bold,
              ),

              const CheckC(
                nomes: [
                  'Não',
                  'Altura adequada',
                  'Para surdos (TPS ou TTS)',
                ],
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
                getValue: (String) {},
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
                        validat: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo';
                          }
                          return null;
                        },
                        name: '',
                        getValue: (String) {},
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
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: '',
                getValue: (String) {},
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
                validat: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Preencha o campo';
                  }
                  return null;
                },
                name: '',
                getValue: (String) {},
              ),
              SizedBox(
                height: sizeScreen.height * 0.05,
              ),

              SizedBox(
                height: sizeScreen.height * 0.05,
              ),
              const SendButton(),

              SizedBox(
                height: sizeScreen.height * 0.05,
              )
            ]),
          ),
        ));
  }
}
