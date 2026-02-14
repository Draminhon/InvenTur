import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sistur/models/forms/Forms%20C/eventos_programados_model.dart';
import 'package:sistur/models/forms/Forms%20C/gastronomia_artesanato_trabalhos_manuais_model.dart';
import 'package:sistur/models/forms/Forms%20C/unidades_de_conservacao_model.dart';
import 'package:sistur/models/forms/forms%20B/agencia_de_turismo_model.dart';
import 'package:sistur/models/forms/forms%20B/alimentos_bebidas_model.dart';
import 'package:sistur/models/forms/forms%20A/comercio_turistico_model.dart';
import 'package:sistur/models/forms/forms%20A/informacoes_basicas_model.dart';
import 'package:sistur/models/forms/forms%20A/locadora_de_imoveis_model.dart';
import 'package:sistur/models/forms/forms%20B/entidades_associativas_model.dart';
import 'package:sistur/models/forms/forms%20B/espaco_para_eventos_model.dart';
import 'package:sistur/models/forms/forms%20B/espacos_de_diversao_e_cultura_model.dart';
import 'package:sistur/models/forms/forms%20B/guiamento_e_conducao_turisttica_model.dart';
import 'package:sistur/models/forms/forms%20B/informacoes_turisticas_model.dart';
import 'package:sistur/models/forms/forms%20B/instalacoes_esportivas_model.dart';
import 'package:sistur/models/forms/forms%20B/meios_hospedagem_model.dart';
import 'package:sistur/models/forms/forms%20B/outros_tipos_de_acomodacao_model.dart';
import 'package:sistur/models/forms/forms%20A/rodovia_model.dart';
import 'package:sistur/models/forms/forms%20A/sistema_de_seguranca_model.dart';
import 'package:sistur/models/forms/forms%20B/parques_model.dart';
import 'package:sistur/models/forms/forms%20B/servicos_para_eventos_model.dart';
import 'package:sistur/models/forms/forms%20B/transporte_turistico_model.dart';
import 'package:sistur/ui/forms/formsA/comercio_turistico.dart';
import 'package:sistur/ui/forms/formsA/sistema_de_seguran%C3%A7a.dart';
import 'package:sistur/ui/forms/formsB/entidades_associativas.dart';
import 'package:sistur/ui/forms/formsB/espacos_de_diversao_e_cultura.dart';
import 'package:sistur/ui/forms/formsB/espacos_para_eventos.dart';
import 'package:sistur/ui/forms/formsB/guiamento_e_conducao_turistica.dart';
import 'package:sistur/ui/forms/formsB/informacoes_turisticas.dart';
import 'package:sistur/ui/forms/formsB/instalacoes_esportivas.dart';
import 'package:sistur/ui/forms/formsB/parques.dart';
import 'package:sistur/ui/forms/formsB/servicos_para_eventos.dart';
import 'package:sistur/ui/forms/formsC/eventos_programados.dart';
import 'package:sistur/ui/forms/formsC/gastronomia_artesanato_trabalhos_manuais.dart';
import 'package:sistur/ui/forms/formsC/unidades_de_conservacao.dart';
import 'package:sistur/ui/screens/forms%20screens/formA_screen.dart';
import 'package:sistur/ui/screens/forms%20screens/formB._screen.dart';
import 'package:sistur/ui/screens/forms%20screens/formC_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sistur/ui/forms/formsA/informacoes_basicas_do_municipio.dart';
import 'package:sistur/ui/forms/formsA/locadora_de_imoveis.dart';
import 'package:sistur/ui/forms/formsA/rodovia.dart';
import 'package:sistur/ui/forms/formsB/agencias_de_turismo.dart';
import 'package:sistur/ui/forms/formsB/alimentos_e_bebidas.dart';
import 'package:sistur/ui/forms/formsB/meiosdehospedagem.dart';
import 'package:sistur/ui/forms/formsB/outros_tipos_de_acomodacao.dart';
import 'package:sistur/ui/forms/formsB/transporte_turistico.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sistur/utils/check_connectivity.dart';
import 'package:sistur/utils/utils_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Atualiza a quantidade de locais
Future updateQtdeLocais(int pesquisa, int quantidade) async {
  var url = Uri.parse('${AppConstants.BASE_URI}pesquisa/${pesquisa}/');
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('access_token');
  try {
    var response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({'quantidadeLocais': quantidade}),
    );
    if (response.statusCode == 200) {
      print('Quantidade de locais atualizada com sucesso: ${response.body}');
    } else {
      print('Erro ao atualizar: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    print('Erro na requisição: $e');
  }
}

/// Página A com formulário
class A extends StatefulWidget {
  const A({super.key});
  @override
  State<A> createState() => _A();
}

class _A extends State<A> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: pc,
        onPageChanged: setPaginaAtual,
        children: const [FormularioA(), FormularioB(), FormularioC()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 55, 111, 60),
        currentIndex: paginaAtual,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.a,
              color: Colors.white,
            ),
            label: 'Categoria A',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.b,
                color: Colors.white,
              ),
              label: 'Categoria B'),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.c,
                color: Colors.white,
              ),
              label: 'Categoria C')
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        iconSize: 80.h,
        selectedLabelStyle: TextStyle(fontSize: 60.h),
        unselectedLabelStyle: TextStyle(fontSize: 50.h),
        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: const Duration(milliseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}

/// Página de Equipamentos com barra de pesquisa
class Pesquisas extends StatefulWidget {
  const Pesquisas({super.key});
  @override
  _PesquisasState createState() => _PesquisasState();
}

class _PesquisasState extends State<Pesquisas> {
  String _searchQuery = "";
  bool isConnected = true;
  int qtdeBanco = 0;
  final ApiService _apiService = ApiService();
  CheckConnectivity connection = new CheckConnectivity();
  Future<List<Map<String, dynamic>>> getRodovias() async {


    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final pesquisaId = arguments['pesquisa_id'];

    final String path = '/equipamentos/?pesquisa_id=$pesquisaId';

    try {
      final response = await _apiService.get(path);

      if (response.statusCode == 200) {
        final List body = response.data;
        return body.map((e) => Map<String, dynamic>.from(e)).toList();
      } else {
        return [];
      }
    } on DioException catch (e) {
      print("ERRO na chamada com Dio! $e");
      return [];
    } catch (e) {
      // Outros erros
      print("ERRO inesperado! $e");
      return [];
    }
  }

  int qtdebancoPPesquisa = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final isadmin = arguments['is_admin'];
    Future<List<Map<String, dynamic>>> rodoviasFuture = getRodovias();

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(right: 228.48.w),
          )
        ],
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 29.92.h),
            child: Column(
              children: [
                Text(
                  'EQUIPAMENTOS',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 55, 111, 60),
                      fontSize: 80.67.w,
                      fontWeight: FontWeight.w500),
                ),
                Divider(
                  color: const Color.fromARGB(255, 55, 111, 60),
                  indent: 134.4.w,
                  endIndent: 134.4.w,
                ),
              ],
            ),
          ),
          // Barra de pesquisa

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.h),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Pesquisar equipamento...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Lista de equipamentos filtrada
          SizedBox(
            height: 50.h,
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: rodoviasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator()));
                } else if (snapshot.hasData) {
                  final rodovias = snapshot.data!;
                  if (rodovias.isEmpty && isConnected == true) {
                    return const Center(
                      child: Text(
                        "Não há equipamentos inventariados",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  } else if (isConnected == false && qtdebancoPPesquisa >= 1) {
                    return Center(
                        child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "Você possui pendências de sincronização, conecte-se à internet e realize a sincronização",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.justify,
                      ),
                    ));
                  }
                  return ShowRodoviaAux(
                      posts: rodovias, searchQuery: _searchQuery);
                } else {
                  return const Center(
                    child: Text(
                      "Não há equipamentos inventariados",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }
              },
            ),
          ),
          Divider(
            color: const Color.fromARGB(255, 55, 111, 60),
            indent: 134.4.w,
            endIndent: 134.4.w,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: 150.52.w,
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 80.w),
          height: 400.w,
          child: isadmin == true
              ? Container()
              : Column(
                  children: [
                    SizedBox(
                      height: 55.w,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                          vertical: 70.904.h,
                        )),
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(255, 55, 111, 60)),
                        overlayColor:
                            WidgetStateProperty.all(Colors.green[600]),
                      ),
                      onPressed: () => Navigator.pushNamed(context, '/A'),
                      child: Center(
                        child: Text(
                          'inventariar novo equipamento',
                          style:
                              TextStyle(color: Colors.white, fontSize: 65.76.w),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

/// Widget para exibir e filtrar os equipamentos
class ShowRodoviaAux extends StatefulWidget {
  final List<Map<String, dynamic>> posts;
  final String searchQuery;

  const ShowRodoviaAux({
    super.key,
    required this.posts,
    required this.searchQuery,
  });

  @override
  State<ShowRodoviaAux> createState() => _ShowRodoviaAuxState();
}

class _ShowRodoviaAuxState extends State<ShowRodoviaAux> {
  List<Map<String, dynamic>> posts = [];
  final Map<String, dynamic> valoresJ ={};
int usuario = 0;
  @override
  void initState() {
    super.initState();
      UtilsFunctions().getInfoUsersInPesquisa(valoresJ, false).then((value) {
     setState(() {
       usuario = value;
     });
   },);
    posts = List.from(widget.posts);
  }

  void removePost(int index, int pesquisaId) {
    if (mounted) {
      setState(() {
        posts.removeAt(index);
      });
      updateQtdeLocais(pesquisaId, posts.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    print(altura);
    final filteredPosts = posts.where((post) {
      final display = getDisplay(post['dados']).toLowerCase();
      return display.contains(widget.searchQuery.toLowerCase());
    }).toList();

    return SizedBox(
      height: 1500.h,
      child: ListView.builder(
        itemCount: filteredPosts.length,
        itemBuilder: (context, index) {
          final arguments = ModalRoute.of(context)?.settings.arguments as Map;
          final isadmin = arguments['is_admin'];
          final equipamento = filteredPosts[index];
          final dados = equipamento['dados'];
          final Map<String, Widget Function(dynamic data)> pageBuilders = {
            'Rodovia': (data) =>
                Rodovia(infoModel: RodoviaModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Transporte Turistico': (data) => TransporteTuristico(
                infoModel: TransporteTuristicoModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Serviços para Eventos': (data) => ServicosParaEventos(
                hospedagemModel: ServicosParaEventosModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Espaço para Eventos': (data) => EspacosParaEventos(
                hospedagemModel: EspacosParaEventosModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Outros Tipos de Acomodação': (data) => OutrosTiposDeAcomodacao(
                hospedagemModel: OutrosTiposDeAcomodacaoModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Agência de Turismo': (data) => AgenciasDeTurismo(
                infoModel: AgenciasDeTurismoModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'SistemaDeSeguranca': (data) => SistemaDeSeguranca(
                infoModel: SistemaDeSegurancaModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'AlimentosEBebidas': (data) => AlimentosEBebidas(
                infoModel: AlimentosEBebidasModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Meios de Hospedagem': (data) => MeiosDeHospedagem(
                hospedagemModel: MeiosDeHospedagemModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Parques': (data) =>
                Parques(hospedagemModel: ParquesModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Espaços Para Diversão e Cultura': (data) =>
                EspacosDeDiversaoECultura(
                    hospedagemModel:
                        EspacosDeDiversaoECulturaModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Informações Turisticas': (data) => InformacoesTuristicas(
                hospedagemModel: InformacoesTuristicasModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Informações Básicas do Município': (data) =>
                InformacoesBasicasDoMunicipio(
                    infoModel: InformacoesBasicasModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Comércio Turístico': (data) => ComercioTuristico(
                infoModel: ComercioTuristicoModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Locadora de Imóveis': (data) => LocadoraDeImoveis(
                infoModel: LocadoraDeImoveisModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Entidades Associativas e Similares': (data) =>
                EntidadesAssociativas(
                    hospedagemModel: EntidadesAssociativasModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Guiamento e Condução Turística': (data) =>
                GuiamentoEConducaoTurististica(
                    infoModel:
                        GuiamentoEConducaoTurististicaModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Instalações Esportivas': (data) => InstalacoesEsportivas(
                hospedagemModel: InstalacoesEsportivasModel.fromJson(data), isAdmin: isadmin == null ? false : true,),

            'Unidades De Conservação': (data) => UnidadesDeConservacao(
                  hospedagemModel: UnidadesDeConservacaoModel.fromJson(data)
                  , isAdmin: isadmin == null ? false : true,
                ),

            'Eventos Programados': (data) => EventosProgramados(
                  hospedagemModel: EventosProgramadosModel.fromJson(data)
                  , isAdmin: isadmin == null ? false : true,
                ),

            'Gastronomia e Artesanatos': (data) =>
                GastronomiaArtesanatoTrabalhosManuais(
                  hospedagemModel:
                      GastronomiaArtesanatoTrabalhosManuaisModel.fromJson(data)
                      , isAdmin: isadmin == null ? false : true,
                )
          };
        
          return GestureDetector(
            onTap: () {
              updateQtdeLocais(dados['pesquisa'], posts.length);

              final String tipo = equipamento['tipo'];
              final dynamic data = equipamento['dados'];
              print(data);
              final pageBuilder = pageBuilders[tipo];

              if (pageBuilder != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => pageBuilder(data),
                    settings: RouteSettings(arguments: {'isUpdate': true, 'isAdmin': isadmin == null ? false : true}),
                  ),
                );
              } else {
                print('ERRO: Tipo de equipamento desconhecido: $tipo');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Erro: Tipo de formulário desconhecido ($tipo)')),
                );
              }
            },
            child: isadmin == true
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppConstants.MAIN_GREEN,
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 100.w),
                    height: 350.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 100.w),
                        Flexible(
                          child: Center(
                            child: Text(
                              getDisplay(dados),
                              style: TextStyle(
                                fontSize: 55.w,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Tem certeza?"),
                                  content: const Text(
                                      "Você deseja excluir esse equipamento?"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancelar"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        final int id = dados['id'];
                                        final String nome =
                                            dados['tipo_formulario'];
                                        print('excluindo: $nome (ID: $id)');
                                        var url = Uri.parse(
                                            '${AppConstants.BASE_URI}base/$id/');
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        String? token =
                                            prefs.getString('access_token');
                                        try {
                                          final response = await http.patch(
                                            url,
                                            headers: {
                                              'Content-Type':
                                                  'application/json',
                                              "Authorization": "Bearer $token"
                                            },
                                            body: json
                                                .encode({'is_active': false}),
                                          );
                                          if (response.statusCode == 204) {
                                            print(
                                                'Usuário deletado com sucesso');
                                          } else {
                                            print(
                                                'Falha ao deletar: ${response.statusCode}');
                                          }
                                        } catch (e) {
                                          print('Erro $e');
                                        }
                                          removePost(index, dados['pesquisa']);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Excluir",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (usuario != dados['usuario_criador']) ? Colors.grey.shade300 :  Color.fromARGB(255, 51, 131, 59),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 25.h, horizontal: 130.w),
                        constraints: BoxConstraints(
                          minHeight: altura < 900 ? 450.h : 350.h
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            getDisplay(dados),
                            style: TextStyle(fontSize: 55.w,                      color: (usuario == dados['usuario_criador']) ? Colors.white :Colors.black,
 ),

                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}

/// Função auxiliar para montar o texto exibido para cada equipamento
String getDisplay(Map<String, dynamic> dados) {
  final tipoFormulario = dados['tipo_formulario'] ?? '';
  switch (tipoFormulario) {
    case 'Rodovia':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Sistema de Segurança':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Alimentos e bebidas':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Meios de Hospedagem':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Informações Básicas do Município':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Comércio Turístico':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Outros Tipos de Acomodação':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Agência de Turismo':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Transporte Turistico':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Serviço para Eventos':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Espaço para Eventos':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Parques':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Espaços de Diversão e Cultura':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Informações Turísticas':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Locadora de Imóveis':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Entidades Associativas e Similares':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Guiamento E Condução Turística':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Instalações Esportivas':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Unidades de Conservação':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Eventos Programados':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Gastronomia e Artesanato':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';
    case 'Informações Básicas do Município':
      return 'Formulário: $tipoFormulario\nRegião: ${dados['regiao_turistica']}\nPesquisador: ${dados['nome_pesquisador']}';  
    default:
      return '$tipoFormulario\n${dados['tipo'] ?? ''}';
  }
}
