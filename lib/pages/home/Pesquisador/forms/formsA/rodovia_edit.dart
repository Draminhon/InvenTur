import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/customTextField.dart';
import '../../widgets/expandedTileYoN.dart';
import '../../widgets/radioButton.dart';
import '../formsB/widgets/checkBox.dart';
import '../formsB/widgets/sendButton.dart';
import 'dart:convert';
import 'package:inventur/models/rodovia_model.dart';
import 'package:http/http.dart' as http;

final GlobalKey<CheckCState> checkCKey = GlobalKey<CheckCState>();
final GlobalKey<CheckCState> postoCombustivel = GlobalKey<CheckCState>();
final GlobalKey<CheckCState>  outrosServicos = GlobalKey<CheckCState>();
final GlobalKey<CheckCState> estruturasAoLongoDaVia = GlobalKey<CheckCState>();

class RodoviaEdit extends StatefulWidget {
  final RodoviaModel? rodoviaModel;
   const RodoviaEdit({super.key, this.rodoviaModel});
  @override
  State<RodoviaEdit> createState() => _RodoviaState();
}


class _RodoviaState extends State<RodoviaEdit> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> valoresjson = {
    'tipo_formulario': 'Rodovia',
    'uf': null,
    'regiao_turistica': null,
    'municipio': null,
    'tipo': null,
    'subtipos': null,
    'nome_oficial': null,
    'nome_popular': null,
    'jurisdicao': null,
    'natureza': null,
    'tipo_de_organizacao_instituicao': null,
    'extensao_rodovia_municipio': null,
    'faixas_de_rolamento': null,
    'pavimentacao': null,
    'pedagio': null,
    'municipios_vizinhos_interligados_rodovia': null,
    'inicio_atividade': null,
    'whatsapp': null,
    'instagram': null,
    'sinalizacao_de_acesso': null,
    'sinalizacao_turistica': null,
    'posto_de_combustivel': null,
    'outros_servicos': null,
    'estruturas_ao_longo_da_via': null,
    'poluicao': null,
    'poluicao_especificacao': null,
    'lixo': null,
    'lixo_especificacao': null,
    'desmatamento': null,
    'desmatamento_especificacao': null,
    'queimadas': null,
    'queimadas_especificacao': null,
    'inseguranca': null,
    'inseguranca_especificacao': null,
    'extrativismo': null,
    'extrativismo_especificacao': null,
    'prostituicao': null,
    'prostituicao_especificacao': null,
    'ocupacao_irregular_invasao': null,
    'ocupacao_irregular_invasao_especificacao': null,
    'outras': null,
    'outras_especificacao': null,
    'estado_geral_de_conservacao': null,
    'observacoes': null,
    'referencias': null,
    'nome_pesquisador': null,
    'telefone_pesquisador': null,
    'email_pesquisador': null,
    'nome_coordenador': null,
    'telefone_coordenador': null,
    'email_coordenador': null,
  };

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoFillForm();

  }
    final TextEditingController uf = TextEditingController();
      TextEditingController regiao_turistica = TextEditingController();
    TextEditingController municipio = TextEditingController();
    TextEditingController tipo = TextEditingController();
    TextEditingController subtipos = TextEditingController();
    TextEditingController nome_oficial = TextEditingController();
    TextEditingController nome_popular = TextEditingController();
    TextEditingController jurisdicao = TextEditingController();
    TextEditingController natureza = TextEditingController();
    TextEditingController tipo_de_organizacao_instituicao = TextEditingController();
    TextEditingController extensao_rodovia_municipio = TextEditingController();
    TextEditingController faixas_de_rolamento = TextEditingController();
    TextEditingController pavimentacao = TextEditingController();
    TextEditingController pedagio = TextEditingController();
    TextEditingController municipios_vizinhos_interligados_rodovia = TextEditingController();
    TextEditingController inicio_atividade = TextEditingController();
    TextEditingController whatsapp = TextEditingController();
    TextEditingController instagram = TextEditingController();
    TextEditingController sinalizacao_de_acesso = TextEditingController();
    TextEditingController sinalizacao_turistica = TextEditingController();
    TextEditingController posto_de_combustivel = TextEditingController();
    TextEditingController outros_servicos = TextEditingController();
    TextEditingController estruturas_ao_longo_da_via = TextEditingController();
    TextEditingController poluicao = TextEditingController();
    TextEditingController poluicao_especificacao = TextEditingController();
    TextEditingController lixo = TextEditingController();
    TextEditingController lixo_especificacao = TextEditingController();
    TextEditingController desmatamento = TextEditingController();
    TextEditingController desmatamento_especificacao = TextEditingController();
    TextEditingController queimadas = TextEditingController();
    TextEditingController queimadas_especificacao = TextEditingController();
    TextEditingController inseguranca = TextEditingController();
    TextEditingController inseguranca_especificacao = TextEditingController();
    TextEditingController extrativismo = TextEditingController();
    TextEditingController extrativismo_especificacao = TextEditingController();
    TextEditingController prostituicao = TextEditingController();
    TextEditingController prostituicao_especificacao = TextEditingController();
    TextEditingController ocupacao_irregular_invasao = TextEditingController();
    TextEditingController ocupacao_irregular_invasao_especificacao = TextEditingController();
    TextEditingController outras = TextEditingController();
    TextEditingController outras_especificacao = TextEditingController();
    TextEditingController estado_geral_de_conservacao = TextEditingController();
    TextEditingController observacoes = TextEditingController();
    TextEditingController referencias = TextEditingController();
    TextEditingController nome_pesquisador = TextEditingController();
    TextEditingController telefone_pesquisador = TextEditingController();
    TextEditingController email_pesquisador = TextEditingController();
    TextEditingController nome_coordenador = TextEditingController();
    TextEditingController telefone_coordenador = TextEditingController();
    TextEditingController email_coordenador = TextEditingController();

  void autoFillForm() {
    if(widget.rodoviaModel!.uf != null){
    uf.text = widget.rodoviaModel!.uf!;
    }else{
      uf.text = '';
    }
 if (widget.rodoviaModel!.regiaoTuristica != null) {
  regiao_turistica.text = widget.rodoviaModel!.regiaoTuristica!;
} else {
  regiao_turistica.text = '';
}

if (widget.rodoviaModel!.municipio != null) {
  municipio.text = widget.rodoviaModel!.municipio!;
} else {
  municipio.text = '';
}

if (widget.rodoviaModel!.tipo != null) {
  tipo.text = widget.rodoviaModel!.tipo!;
} else {
  tipo.text = '';
}

if (widget.rodoviaModel!.subtipos != null) {
  subtipos.text = widget.rodoviaModel!.subtipos!;
} else {
  subtipos.text = '';
}

if (widget.rodoviaModel!.nomeOficial != null) {
  nome_oficial.text = widget.rodoviaModel!.nomeOficial!;
} else {
  nome_oficial.text = '';
}

if (widget.rodoviaModel!.nomePopular != null) {
  nome_popular.text = widget.rodoviaModel!.nomePopular!;
} else {
  nome_popular.text = '';
}

if (widget.rodoviaModel!.jurisdicao != null) {
  jurisdicao.text = widget.rodoviaModel!.jurisdicao!;
} else {
  jurisdicao.text = '';
}

if (widget.rodoviaModel!.natureza != null) {
  natureza.text = widget.rodoviaModel!.natureza!;
} else {
  natureza.text = '';
}

// if (widget.rodoviaModel!.tipoDeOrganizacaoInstituicao != null) {
//   tipo_de_organizacao_instituicao.text = widget.rodoviaModel!.tipoDeOrganizacaoInstituicao!;
// } else {
//   tipo_de_organizacao_instituicao.text = '';
// }

if (widget.rodoviaModel!.extensaoRodoviaMunicipio != null) {
  extensao_rodovia_municipio.text = widget.rodoviaModel!.extensaoRodoviaMunicipio!;
} else {
  extensao_rodovia_municipio.text = '';
}

if (widget.rodoviaModel!.faixasDeRolamento != null) {
  faixas_de_rolamento.text = widget.rodoviaModel!.faixasDeRolamento!;
} else {
  faixas_de_rolamento.text = '';
}

if (widget.rodoviaModel!.pavimentacao != null) {
  pavimentacao.text = widget.rodoviaModel!.pavimentacao!;
} else {
  pavimentacao.text = '';
}

if (widget.rodoviaModel!.pedagio != null) {
  pedagio.text = widget.rodoviaModel!.pedagio!;
} else {
  pedagio.text = '';
}

if (widget.rodoviaModel!.municipiosVizinhosInterligadosRodovia != null) {
  municipios_vizinhos_interligados_rodovia.text = widget.rodoviaModel!.municipiosVizinhosInterligadosRodovia!;
} else {
  municipios_vizinhos_interligados_rodovia.text = '';
}

if (widget.rodoviaModel!.inicioAtividade != null) {
  inicio_atividade.text = widget.rodoviaModel!.inicioAtividade!;
} else {
  inicio_atividade.text = '';
}

if (widget.rodoviaModel!.whatsapp != null) {
  whatsapp.text = widget.rodoviaModel!.whatsapp!;
} else {
  whatsapp.text = '';
}

if (widget.rodoviaModel!.instagram != null) {
  instagram.text = widget.rodoviaModel!.instagram!;
} else {
  instagram.text = '';
}

if (widget.rodoviaModel!.sinalizacaoDeAcesso != null) {
  sinalizacao_de_acesso.text = widget.rodoviaModel!.sinalizacaoDeAcesso!;
} else {
  sinalizacao_de_acesso.text = '';
}

if (widget.rodoviaModel!.sinalizacaoTuristica != null) {
  sinalizacao_turistica.text = widget.rodoviaModel!.sinalizacaoTuristica!;
} else {
  sinalizacao_turistica.text = '';
}

// if (widget.rodoviaModel!.postoDeCombustivel != null) {
//   posto_de_combustivel.text = widget.rodoviaModel!.postoDeCombustivel!;
// } else {
//   posto_de_combustivel.text = '';
// }

// if (widget.rodoviaModel!.outrosServicos != null) {
//   outros_servicos.text = widget.rodoviaModel!.outrosServicos!;
// } else {
//   outros_servicos.text = '';
// }

// if (widget.rodoviaModel!.estruturasAoLongoDaVia != null) {
//   estruturas_ao_longo_da_via.text = widget.rodoviaModel!.estruturasAoLongoDaVia!;
// } else {
//   estruturas_ao_longo_da_via.text = '';
// }

if (widget.rodoviaModel!.poluicao != null) {
  poluicao.text = widget.rodoviaModel!.poluicao!;
} else {
  poluicao.text = '';
}

if (widget.rodoviaModel!.poluicaoEspecificacao != null) {
  poluicao_especificacao.text = widget.rodoviaModel!.poluicaoEspecificacao!;
} else {
  poluicao_especificacao.text = '';
}

if (widget.rodoviaModel!.lixo != null) {
  lixo.text = widget.rodoviaModel!.lixo!;
} else {
  lixo.text = '';
}

if (widget.rodoviaModel!.lixoEspecificacao != null) {
  lixo_especificacao.text = widget.rodoviaModel!.lixoEspecificacao!;
} else {
  lixo_especificacao.text = '';
}

if (widget.rodoviaModel!.desmatamento != null) {
  desmatamento.text = widget.rodoviaModel!.desmatamento!;
} else {
  desmatamento.text = '';
}

if (widget.rodoviaModel!.desmatamentoEspecificacao != null) {
  desmatamento_especificacao.text = widget.rodoviaModel!.desmatamentoEspecificacao!;
} else {
  desmatamento_especificacao.text = '';
}

if (widget.rodoviaModel!.queimadas != null) {
  queimadas.text = widget.rodoviaModel!.queimadas!;
} else {
  queimadas.text = '';
}

if (widget.rodoviaModel!.queimadasEspecificacao != null) {
  queimadas_especificacao.text = widget.rodoviaModel!.queimadasEspecificacao!;
} else {
  queimadas_especificacao.text = '';
}

if (widget.rodoviaModel!.inseguranca != null) {
  inseguranca.text = widget.rodoviaModel!.inseguranca!;
} else {
  inseguranca.text = '';
}

if (widget.rodoviaModel!.insegurancaEspecificacao != null) {
  inseguranca_especificacao.text = widget.rodoviaModel!.insegurancaEspecificacao!;
} else {
  inseguranca_especificacao.text = '';
}

if (widget.rodoviaModel!.extrativismo != null) {
  extrativismo.text = widget.rodoviaModel!.extrativismo!;
} else {
  extrativismo.text = '';
}

if (widget.rodoviaModel!.extrativismoEspecificacao != null) {
  extrativismo_especificacao.text = widget.rodoviaModel!.extrativismoEspecificacao!;
} else {
  extrativismo_especificacao.text = '';
}

if (widget.rodoviaModel!.prostituicao != null) {
  prostituicao.text = widget.rodoviaModel!.prostituicao!;
} else {
  prostituicao.text = '';
}

if (widget.rodoviaModel!.prostituicaoEspecificacao != null) {
  prostituicao_especificacao.text = widget.rodoviaModel!.prostituicaoEspecificacao!;
} else {
  prostituicao_especificacao.text = '';
}

if (widget.rodoviaModel!.ocupacaoIrregularInvasao != null) {
  ocupacao_irregular_invasao.text = widget.rodoviaModel!.ocupacaoIrregularInvasao!;
} else {
  ocupacao_irregular_invasao.text = '';
}

if (widget.rodoviaModel!.ocupacaoIrregularInvasaoEspecificacao != null) {
  ocupacao_irregular_invasao_especificacao.text = widget.rodoviaModel!.ocupacaoIrregularInvasaoEspecificacao!;
} else {
  ocupacao_irregular_invasao_especificacao.text = '';
}

if (widget.rodoviaModel!.outras != null) {
  outras.text = widget.rodoviaModel!.outras!;
} else {
  outras.text = '';
}

if (widget.rodoviaModel!.outrasEspecificacao != null) {
  outras_especificacao.text = widget.rodoviaModel!.outrasEspecificacao!;
} else {
  outras_especificacao.text = '';
}

if (widget.rodoviaModel!.estadoGeralDeConservacao != null) {
  estado_geral_de_conservacao.text = widget.rodoviaModel!.estadoGeralDeConservacao!;
} else {
  estado_geral_de_conservacao.text = '';
}

if (widget.rodoviaModel!.observacoes != null) {
  observacoes.text = widget.rodoviaModel!.observacoes!;
} else {
  observacoes.text = '';
}

if (widget.rodoviaModel!.referencias != null) {
  referencias.text = widget.rodoviaModel!.referencias!;
} else {
  referencias.text = '';
}

if (widget.rodoviaModel!.nomePesquisador != null) {
  nome_pesquisador.text = widget.rodoviaModel!.nomePesquisador!;
} else {
  nome_pesquisador.text = '';
}

if (widget.rodoviaModel!.telefonePesquisador != null) {
  telefone_pesquisador.text = widget.rodoviaModel!.telefonePesquisador!;
} else {
  telefone_pesquisador.text = '';
}

if (widget.rodoviaModel!.emailPesquisador != null) {
  email_pesquisador.text = widget.rodoviaModel!.emailPesquisador!;
} else {
  email_pesquisador.text = '';
}

if (widget.rodoviaModel!.nomeCoordenador != null) {
  nome_coordenador.text = widget.rodoviaModel!.nomeCoordenador!;
} else {
  nome_coordenador.text = '';
}

if (widget.rodoviaModel!.telefoneCoordenador != null) {
  telefone_coordenador.text = widget.rodoviaModel!.telefoneCoordenador!;
} else {
  telefone_coordenador.text = '';
}

if (widget.rodoviaModel!.emailCoordenador != null) {
  email_coordenador.text = widget.rodoviaModel!.emailCoordenador!;
} else {
  email_coordenador.text = '';
}
}

@override
void dispose() {
    uf.dispose();
    regiao_turistica.dispose();
    municipio.dispose();
    tipo.dispose();
    subtipos.dispose();
    nome_oficial.dispose();
    nome_popular.dispose();
    jurisdicao.dispose();
    natureza.dispose();
    tipo_de_organizacao_instituicao.dispose();
    extensao_rodovia_municipio.dispose();
    faixas_de_rolamento.dispose();
    pavimentacao.dispose();
    pedagio.dispose();
    municipios_vizinhos_interligados_rodovia.dispose();
    inicio_atividade.dispose();
    whatsapp.dispose();
    instagram.dispose();
    sinalizacao_de_acesso.dispose();
    sinalizacao_turistica.dispose();
    posto_de_combustivel.dispose();
    outros_servicos.dispose();
    estruturas_ao_longo_da_via.dispose();
    poluicao.dispose();
    poluicao_especificacao.dispose();
    lixo.dispose();
    lixo_especificacao.dispose();
    desmatamento.dispose();
    desmatamento_especificacao.dispose();
    queimadas.dispose();
    queimadas_especificacao.dispose();
    inseguranca.dispose();
    inseguranca_especificacao.dispose();
    extrativismo.dispose();
    extrativismo_especificacao.dispose();
    prostituicao.dispose();
    prostituicao_especificacao.dispose();
    ocupacao_irregular_invasao.dispose();
    ocupacao_irregular_invasao_especificacao.dispose();
    outras.dispose();
    outras_especificacao.dispose();
    estado_geral_de_conservacao.dispose();
    observacoes.dispose();
    referencias.dispose();
    nome_pesquisador.dispose();
    telefone_pesquisador.dispose();
    email_pesquisador.dispose();
    nome_coordenador.dispose();
    telefone_coordenador.dispose();
    email_coordenador.dispose();
    super.dispose();
}


  @override
  Widget build(BuildContext context) {
    
    Future<void> updateRodovia(int rodoviaId, Map<String, dynamic> data) async{

      final url = Uri.parse('${AppConstants.BASE_URI}/api/v1/rodovia/update/$rodoviaId');


      try{
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(data),
      );
      if(response.statusCode == 200){
        print("Atualização bem-sucedida");
      }else{
        print("Erro na atualização: ${response.statusCode}");
      }
      }catch(e){
        print('Erro: $e');
      }

    }


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
            child: Column(
              children: [
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
                              controller: uf,
                              validator: (value) {
                                return null;
                              },
                              onSaved: (newValue) {
                                 valoresjson['uf'] = newValue;
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
                              controller: regiao_turistica,
                              validator: (value) {
                                return null;
                              },
                              onSaved: (newValue) {
                                valoresjson['regiao_turistica'] = newValue;
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
                    controller: municipio,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: 'Municipio',
                    ),
                    onSaved: (newValue) {
                      valoresjson['municipio'] = newValue;
                    },
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                const textLabel(name: 'Tipo:'),
                RadioD(
                  options: const ['Rodoviário'],
                  getValue: (newValue) {
                    valoresjson['tipo'] = newValue;
                  },
                  indexModel: widget.rodoviaModel!.tipo,
                ),
                const textLabel(name: 'Subtipos:'),
                RadioD(
                    options: const ['Estação rodoviária'],
                    getValue: (newValue) {
                      valoresjson['subtipos'] = newValue;
                    },
                    indexModel: widget.rodoviaModel!.subtipos,
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
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                CustomTextField(
                    controller: nome_oficial,
                    name: 'Nome Oficial',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['nome_oficial'] = newValue;
                    }),
                CustomTextField(
                  controller: nome_popular,
                    name: 'Nome Popular',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['nome_popular'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'Jurisdição:'),
                RadioD(
                    options: const ['Federal', 'Estadual', 'Municipal'],
                    getValue: (newValue) {
                      valoresjson['jurisdicao'] = newValue;
                    },
                    indexModel: widget.rodoviaModel!.jurisdicao,),
                const textLabel(name: 'Natureza:'),
                RadioD(
                    options: const ['Pública', 'Privada', 'outro'],
                    getValue: (newValue) {
                      valoresjson['natureza'] = newValue;
                    },
                    indexModel: widget.rodoviaModel!.natureza,
                    ),
                const textLabel(name: 'Tipo de organização/Instituição:'),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                 CheckC(
                  key: checkCKey,
                  nomesModel: widget.rodoviaModel!.tipoDeOrganizacaoInstituicao,
                  nomes: const [
                    'Associação',
                    'Sindicato',
                    'Cooperativa',
                    'Sistema',
                    'Empresa',
                    'outro'
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(
                    name: 'Extensão da rodovia no âmbito do município:'),
                CustomTextField(
                  controller:  extensao_rodovia_municipio,
                    name: 'Extensão',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['extensao_rodovia_municipio'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'Faixas de rolamento:'),
                RadioD(
                    options: const [
                      'Duas',
                      'Três',
                      'Quatro',
                      'Mão única',
                      'Mão dupla',
                      'Acostamento'
                    ],
                    getValue: (newValue) {
                      valoresjson['faixas_de_rolamento'] = newValue;
                    },
                    indexModel: widget.rodoviaModel!.faixasDeRolamento,),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'Pavimentação:'),
                RadioD(
                    options: const [
                      'Asfalto',
                      'Concreto',
                      'Paralelepipedo',
                      'Saibro',
                      'Asfalto ecológico',
                      'Chão batido',
                      'outro'
                    ],
                    getValue: (newValue) {
                      valoresjson['pavimentacao'] = newValue;
                    },
                    indexModel: widget.rodoviaModel!.pavimentacao,),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(children: [
                  const textLabel(name: 'Pedágio:'),
                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                        optionModel: widget.rodoviaModel!.pedagio,
                    getValue: (newValue) {
                      valoresjson['pedagio'] = newValue;
                    },
                  ))
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                const textLabel(
                    name: 'Municípios vizinhos interligados por rodovia:'),
                CustomTextField(
                  controller: municipios_vizinhos_interligados_rodovia,
                    name: 'Municípios vizinhos',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['municipios_vizinhos_interligados_rodovia'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(
                  children: [
                    const textLabel(name: 'Início da atividade:'),
                    SizedBox(
                      width: sizeScreen.width * 0.1,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.4,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextDate(getValue: (newValue) {
                          valoresjson['inicio_atividade'] = newValue;
                        }, 
                        dateController: inicio_atividade,))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                const textLabel(name: 'Entidade mantedora:'),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    const textLabel(name: 'Whatsapp'),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: whatsapp,
                          validat: (value) {
                            return null;
                          },
                          name: '(xx) x xxxx-xxxx',
                          getValue: (newValue) {
                            valoresjson['whatsapp'] = newValue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(
                  children: [
                    const textLabel(name: 'Instagram'),
                    SizedBox(
                      width: sizeScreen.width * 0.045,
                    ),
                    SizedBox(
                        width: sizeScreen.width * 0.5,
                        //height: sizeScreen.height * 0.07,
                        child: CustomTextField(
                          controller: instagram,
                          validat: (value) {
                            return null;
                          },
                          name: '@',
                          getValue: (newvalue) {
                            valoresjson['instagram'] = newvalue;
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                const textLabel(name: 'Sinalização:'),
                SizedBox(
                  height: sizeScreen.height * 0.04,
                ),
                Row(children: [
                  const textLabel(name: 'de acessso -'),
                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                        optionModel: widget.rodoviaModel!.sinalizacaoDeAcesso,
                    getValue: (newValue) {
                      valoresjson['sinalizacao_de_acesso'] = newValue;
                    },
                  ))
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                Row(children: [
                  const textLabel(name: 'turística -'),
                  SizedBox(
                    width: sizeScreen.width * 0.14,
                  ),
                  SizedBox(
                      //width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                        optionModel: widget.rodoviaModel!.sinalizacaoTuristica,
                    getValue: (newValue) {
                      valoresjson['sinalizacao_turistica'] = newValue;
                    },
                  ))
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.03,
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
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                const textLabel(
                    name: 'Equipamentos e serviçõs ao longo da rodovia:'),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'Posto de combustível:'),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                CheckC(
                  nomesModel: widget.rodoviaModel!.postoDeCombustivel,
                  key: postoCombustivel,
                  nomes: const ['Álcool', 'Gasolina', 'Diesel'],
                ),
                SizedBox(
                  height: 0.05.h,
                ),
                const textLabel(name: 'Outros serviços:'),
                SizedBox(
                  height: sizeScreen.height * 0.02,
                ),
                CheckC(
                  nomesModel: widget.rodoviaModel!.outrosServicos,
                  key: outrosServicos,
                  nomes: const [
                    'Alimentação',
                    'Hospedagem',
                    'Polícia rodoviária',
                    'Polícia militar',
                    'WiFi livre',
                    'Serviços mecânicos',
                    'Socorro mecânico',
                    'Socorro médico',
                    'Loja de souvenir',
                    'Produtos típicos',
                    'Supermercado',
                    'outro'
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'Estruturas ao longo da via:'),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                CheckC(
                  key: estruturasAoLongoDaVia,
                  nomesModel: widget.rodoviaModel!.estruturasAoLongoDaVia,
                  nomes: const [
                    'Ponte',
                    'Passarela',
                    'Viaduto',
                    'Galeria/túnel',
                    'Atrativo turístico natural',
                    'outro'
                  ],
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                const textLabel(name: 'Questões ambientais/sociais:'),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(children: [
                  const textLabel(name: 'Poluição:'),
                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                        optionModel: widget.rodoviaModel!.poluicao,
                    getValue: (newValue) {
                      valoresjson['poluicao'] = newValue;
                    },
                  ))
                ]),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                CustomTextField(
                  controller: poluicao_especificacao,
                    name: 'Especificação',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['poluicao_especificacao'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(children: [
                  const textLabel(name: 'Lixo:'),
                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                        optionModel: widget.rodoviaModel!.lixo,
                    getValue: (newValue) {
                      valoresjson['lixo'] = newValue;
                    },
                  ))
                ]),
                CustomTextField(
                  controller: lixo_especificacao,
                    name: 'Especificação',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['lixo_especificacao'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(children: [
                  const textLabel(name: 'Desmatamento:'),
                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                        optionModel: widget.rodoviaModel!.desmatamento,
                    getValue: (newValue) {
                      valoresjson['desmatamento'] = newValue;
                    },
                  ))
                ]),
                CustomTextField(
                  controller: desmatamento_especificacao,
                    name: 'Especificação',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['desmatamento_especificacao'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(children: [
                  const textLabel(name: 'Queimadas:'),
                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                        optionModel: widget.rodoviaModel!.queimadas,
                    getValue: (newValue) {
                      valoresjson['queimadas'] = newValue;
                    },
                  ))
                ]),
                CustomTextField(
                  controller: queimadas_especificacao,
                    name: 'Especificação',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['queimadas_especificacao'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(children: [
                  const textLabel(name: 'Insegurança:'),
                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                        optionModel: widget.rodoviaModel!.inseguranca,
                    getValue: (newValue) {
                      valoresjson['inseguranca'] = newValue;
                    },
                  ))
                ]),
                CustomTextField(
                  controller: inseguranca_especificacao,
                    name: 'Especificação',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['inseguranca_especificacao'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(children: [
                  const textLabel(name: 'Extrativismo:'),
                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                        optionModel: widget.rodoviaModel!.extrativismo,
                    getValue: (newValue) {
                      valoresjson['extrativismo'] = newValue;
                    },
                  ))
                ]),
                CustomTextField(
                  controller: extrativismo_especificacao,
                    name: 'Especificação',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['extrativismo_especificacao'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(children: [
                  const textLabel(name: 'Prostituição:'),
                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                        optionModel: widget.rodoviaModel!.prostituicao,
                    getValue: (newValue) {
                      valoresjson['prostituicao'] = newValue;
                    },
                  ))
                ]),
                CustomTextField(
                    controller:prostituicao_especificacao,
                    name: 'Especificação',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['prostituicao_especificacao'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(children: [
                  const textLabel(name: 'Ocupações\nirregulares/invasão'),
                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                        optionModel: widget.rodoviaModel!.ocupacaoIrregularInvasao,
                    getValue: (newValue) {
                      valoresjson['ocupacao_irregular_invasao'] = newValue;
                    },
                  ))
                ]),
                CustomTextField(
                  controller: ocupacao_irregular_invasao_especificacao,
                    name: 'Especificação',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['ocupacao_irregular_invasao_especificacao'] =
                          newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                Row(children: [
                  const textLabel(name: 'Outras:'),

                  SizedBox(
                    width: sizeScreen.width * 0.09,
                  ),
                  SizedBox(
                      // width: sizeScreen.width * 0.5,
                      //  //height: sizeScreen.height * 0.07,
                      child: ExpansionTileYoN(
                       optionModel: widget.rodoviaModel!.outras, 
                    getValue: (newValue) {
                      valoresjson['outras'] = newValue;
                    },
                  ))
                ]),
                CustomTextField(
                  controller: outras_especificacao,
                    name: 'Especificação',
                    validat: (value) {
                      return null;
                    },
                    getValue: (newValue) {
                      valoresjson['outras_especificacao'] = newValue;
                    }),
                SizedBox(
                  height: sizeScreen.height * 0.03,
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
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.03,
                ),
                RadioD(
                    options: const ['Muito bom', 'Bom', 'Ruim'],
                    getValue: (newValue) {
                      valoresjson['estado_geral_de_conservacao'] = newValue;
                    },
                    indexModel: widget.rodoviaModel!.estadoGeralDeConservacao,),
                SizedBox(
                  height: sizeScreen.height * 0.03,
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
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                CustomTextField(
                  controller: observacoes,
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
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                CustomTextField(
                  controller: referencias,
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
                Container(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  height: sizeScreen.height * 0.06,
                  width: sizeScreen.width,
                  padding: EdgeInsets.only(
                      top: sizeScreen.height * 0.008,
                      left: sizeScreen.width * 0.04),
                  child: Text(
                    'Equipe Responsável',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: sizeScreen.height * 0.03),
                  ),
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                const textLabel(
                    name: 'Responsável pelo atendimento (Pesquisador)'),
                CustomTextField(
                  controller: nome_pesquisador,
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '',
                  getValue: (newValue) {
                    valoresjson['nome_pesquisador'] = newValue;
                  },
                ),
                const textLabel(name: 'Telefone'),
                CustomTextField(
                  controller: telefone_pesquisador,
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '',
                  getValue: (newValue) {
                    valoresjson['telefone_pesquisador'] = newValue;
                  },
                ),
                const textLabel(name: 'E-mail'),
                CustomTextField(
                  controller: email_pesquisador,
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '',
                  getValue: (newValue) {
                    valoresjson['email_pesquisador'] = newValue;
                  },
                ),
                const textLabel(
                    name: 'Responsável pelo atendimento (Coordenador)'),
                CustomTextField(
                  controller: nome_coordenador,
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '',
                  getValue: (newValue) {
                    valoresjson['nome_coordenador'] = newValue;
                  },
                ),
                const textLabel(name: 'Telefone'),
                CustomTextField(
                  controller: telefone_coordenador,
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '',
                  getValue: (newValue) {
                    valoresjson['telefone_coordenador'] = newValue;
                  },
                ),
                const textLabel(name: 'E-mail'),
                CustomTextField(
                  controller: email_coordenador,
                  validat: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o campo';
                    }
                    return null;
                  },
                  name: '',
                  getValue: (newValue) {
                    valoresjson['email_coordenador'] = newValue;
                  },
                ),
                SizedBox(
                  height: sizeScreen.height * 0.05,
                ),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                    List<String> selectedValues = checkCKey.currentState!.getSelectedValues();
                      List<String> posto = postoCombustivel.currentState!.getSelectedValues();
                      List<String> outrosServicoss = outrosServicos.currentState!.getSelectedValues();
                      List<String> estruturas = estruturasAoLongoDaVia.currentState!.getSelectedValues();

                      // String selectedValuesStr = selectedValues.join(', ');
                      // String postoStr = posto.join(', ');
                      // String outrosServicosStr = outrosServicoss.join(', ');
                      // String estruturasStr = estruturas.join(', ');
                      
                      valoresjson['tipo_de_organizacao_instituicao'] = selectedValues;
                      valoresjson['posto_de_combustivel'] = posto;
                      valoresjson['outros_servicos'] = outrosServicoss;
                      valoresjson['estruturas_ao_longo_da_via'] = estruturas;
                       if (_formKey.currentState!.validate()) {
                        //  ScaffoldMessenger.of(context).showSnackBar(
                        //      const SnackBar(content: Text('processing data')));
                       
                        _formKey.currentState!.save();
                        updateRodovia(widget.rodoviaModel!.id!, valoresjson);
                   Navigator.pushReplacementNamed(context, '/UpdatedForm');

                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('preencha os dados!')));
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Salvar Edições',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25), // Use um fontSize fixo
                    ),
                    
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            )),
      ),
    );
  }
}
