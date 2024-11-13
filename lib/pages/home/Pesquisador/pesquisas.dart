import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:inventur/models/rodovia_model.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formA.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formB.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formC.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsA/rodovia_edit.dart';

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
  static Future<List<RodoviaModel>> getRodovias() async {
    var url = Uri.parse(AppConstants.BASE_URI + AppConstants.RODOVIA_GET);
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(utf8.decode(response.bodyBytes));
    return body.map((e) => RodoviaModel.fromJson(e)).toList();
  }

  Future<List<RodoviaModel>> rodoviasFuture = getRodovias();
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(right: 228.48.w),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
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
                child: FutureBuilder<List<RodoviaModel>>(
              future: rodoviasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData) {
                
                  final rodovias = snapshot.data!;
                  if (rodovias.isEmpty) {
                    return const Text("No data avaliable");
                  }
                  return showRodovias(rodovias);
                } else {
                  return const Text("No data avaliable");
                }
              },
            )),
            Divider(
              color: const Color.fromARGB(255, 55, 111, 60),
              indent: 134.4.w,
              endIndent: 134.4.w,
            ),
          ],
        ),
    
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 10, bottom: 150.52.h, left: 15, right: 15),
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

Widget showRodovias(List<RodoviaModel> posts) {
  // ListView Builder to show data in a list
  return SizedBox(
    height: 1500.h,
    child: ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return GestureDetector(
          onTap: () {
            debugPrint(jsonEncode(post));
            Navigator.pushReplacement(context,
             MaterialPageRoute(builder: 
             (context)=> RodoviaEdit(rodoviaModel: post,)));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300,
            ),
            margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 130.w),
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            height: 250.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${post.nomeOficial!} - ${post.tipoFormulario}',
                  style: TextStyle(fontSize: 60.w),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
