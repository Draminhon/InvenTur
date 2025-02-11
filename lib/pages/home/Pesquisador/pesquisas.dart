import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:inventur/models/alimentos_bebidas_model.dart';
import 'package:inventur/models/rodovia_model.dart';
import 'package:inventur/models/sistema_de_seguranca_model.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formA.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formB.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formC.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsA/sistema_de_seguranca_edit.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/alimentos_e_bebidas_edit.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsA/rodovia_edit.dart';


Future updateQtdeLocais(int pesquisa, int quantidade) async{

  var url = Uri.parse('${AppConstants.BASE_URI}/api/v1/pesquisa/update/${pesquisa}');

  try{
    var response = await http.patch(url, headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'quantidadeLocais': quantidade
    })
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

class A extends StatefulWidget {
  const A({super.key});

  @override
  State<A> createState() => _A();
}

class _A extends State<A> {
  int _selectedIndex = 0;
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }


  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
          iconSize: 80.h, // Tamanho dos ícones
          selectedLabelStyle:
              TextStyle(fontSize: 60.h), // Tamanho do texto selecionado
          unselectedLabelStyle: TextStyle(fontSize: 50.h), //

          onTap: (pagina) {
            pc.animateToPage(pagina,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease);
          },
        ));
  }
}

class Pesquisas extends StatelessWidget {
  
  Pesquisas({super.key});
 
  @override
  Widget build(BuildContext context) {


  Future<List<Map<String, dynamic>>> getRodovias() async {
            final arguments = ModalRoute.of(context)?.settings.arguments as Map;
        final pesquisaId = arguments['pesquisa_id'];
    var url = Uri.parse('${AppConstants.BASE_URI}/api/v1/equipamentos/?pesquisa_id=$pesquisaId');
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(utf8.decode(response.bodyBytes));
    return body.map((e) => Map<String, dynamic>.from(e)).toList();
  }

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
      backgroundColor:  Colors.white,
      body: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 29.92.h),
                child: Column(
                  children: [
                    Text(
                      'LOCAIS CADASTRADOS',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 55, 111, 60),
                          fontSize: 80.67.w,
                          fontWeight: FontWeight.w500),
                    ),
                    Divider(
                      color: const Color.fromARGB(255, 55, 111, 60),
                      indent: 134.4.w,
                      endIndent: 134.4.w,
                    )
                  ],
                )),
            Center(
                child: SizedBox(
                  height: 1800.h,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                                future: rodoviasFuture,
                                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                  
                    final rodovias = snapshot.data!;
                    if (rodovias.isEmpty) {
                      return const Text("Não há equipamentos inventariados", style: TextStyle(fontWeight: FontWeight.bold),);
                    }
                    return ShowRodoviaAux(posts: rodovias);
                  } else {
                    return const Text("Não há equipamentos inventariados", style: TextStyle(fontWeight: FontWeight.bold));
                  }
                                },
                              ),
                )),
            Divider(
              color: const Color.fromARGB(255, 55, 111, 60),
              indent: 134.4.w,
              endIndent: 134.4.w,
            ),
          ],
        ),
    
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only( bottom: 150.52.h, left: 15, right: 15),
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 80.52.w),
            height: 219.52.h,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    padding: WidgetStateProperty.all(
                        EdgeInsets.symmetric(vertical: 35.904.h)),
                    backgroundColor: WidgetStateProperty.all(
                        const Color.fromARGB(255, 55, 111, 60)),
                    overlayColor: WidgetStateProperty.all(Colors.green[600])),
                onPressed: () => Navigator.pushNamed(context, '/A'),
                child: Text(
                  'inventariar novo equipamento',
                  style: TextStyle(color: Colors.white, fontSize: 65.76.w),
                ))),
      ),
    );
  }
}

class ShowRodoviaAux extends StatefulWidget{
  final List<Map<String, dynamic>> posts;

  const ShowRodoviaAux({super.key, required this.posts});
  @override
  State<ShowRodoviaAux> createState() => _ShowRodoviaAuxState();
}

class _ShowRodoviaAuxState extends State<ShowRodoviaAux> {
  List<Map<String, dynamic>> posts = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    posts = List.from(widget.posts);
  }

  void removePost(int index){
    setState(() {
      posts.removeAt(index);
    });
  }
Widget build(BuildContext context){
  
  return SizedBox(
    height: 1500.h,
    child: ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
         final arguments = ModalRoute.of(context)?.settings.arguments as Map;
        final equipamento = posts[index];
        final isadmin = arguments['is_admin'];
        final tipo = equipamento['tipo'];
        final dados = equipamento['dados'];
            print(posts.length);
           print(equipamento);
        
        return GestureDetector(
          onTap: () {
          updateQtdeLocais(dados['pesquisa'], posts.length);

            if(equipamento['tipo'] == 'Rodovia'){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> RodoviaEdit(rodoviaModel: RodoviaModel.fromJson(equipamento['dados']),)));
            }else if(equipamento['tipo'] == 'SistemaDeSeguranca'){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SistemaDeSegurancaEdit(sistemaModel: SistemaDeSegurancaModel.fromJson(equipamento['dados']),)));

            }else if(equipamento['tipo'] == 'AlimentosEBebidas'){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AlimentoseBebidasEdit(alimentosModel: AlimentosEBebidas.fromJson(equipamento['dados']),)));
            }
          },
          child:  isadmin == true ? Container(
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300,

            ),
            margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 130.w),
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 50.w),
            height: 250.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    '${dados['municipio'] ?? ''} - ${dados['tipo_formulario']}',
                    style: TextStyle(fontSize: 60.w),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 15.w,),
                IconButton(onPressed: () async{
                        final int id = dados['id'];
                        final String nome = dados['tipo_formulario'];
                        print('excluindo: $nome (ID: $id)');
                        var url =
        Uri.parse('${AppConstants.BASE_URI}/api/v1/base/$id/');

    try {
      final response =  await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'is_active': false
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



                  removePost(index);
                }, icon: Icon(Icons.close, color: Colors.red,))
              ],
            ),
          ):
          Container(
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300,

            ),
            margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 130.w),
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 50.w),
            height: 250.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    '${dados['municipio'] ?? ''} - ${dados['tipo_formulario']}',
                    style: TextStyle(fontSize: 60.w),
                    overflow: TextOverflow.ellipsis,
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


