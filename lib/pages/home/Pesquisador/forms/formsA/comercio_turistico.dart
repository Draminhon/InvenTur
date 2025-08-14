import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/sizedBox.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/utils/validators.dart';

final Validators _validators = Validators();
final Map<String, dynamic> valoresJson = {
  'tipo_formulario': 'Comércio Turístico',
};
bool isUpdate = false;

class ComercioTuristico extends StatefulWidget {
  const ComercioTuristico({super.key});

  @override
  State<ComercioTuristico> createState() => _ComercioTuristicoState();
}

class _ComercioTuristicoState extends State<ComercioTuristico> {
  int currentStep = 0;

  late List<Widget> pages;

  final _formKey = GlobalKey<FormState>();

  final PageController _pageController = PageController();

  Map<String, TextEditingController> _identificacaoControllers = {};

  final List<String> _chavesIdentificacao = const [
    'uf',
    'regiao_turistica',
    'municipio',
    'tipo',
    'subtipo'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (final key in _chavesIdentificacao) {
      _identificacaoControllers[key] = TextEditingController();
    }

    pages = [
      Identificacao(controllers: _identificacaoControllers),
    ];
  }

  void getInfoUsersInPesquisa() async {
    Map<String, dynamic> info = await getAdminAndPesquisadorInfo();

    valoresJson['nome_pesquisador'] = info['pesquisador']['nome'];
    valoresJson['telefone_pesquisador'] = info['pesquisador']['telefone'];
    valoresJson['email_pesquisador'] = info['pesquisador']['email'];

    valoresJson['nome_coordenador'] = info['coordenador']['nome'];
    valoresJson['telefone_coordenador'] = info['coordenador']['telefone'];
    valoresJson['email_coordenador'] = info['coordenador']['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: DotsIndicator(
          dotsCount: pages.length,
          position: currentStep.toDouble(),
          decorator:
              DotsDecorator(activeColor: Colors.white, activeSize: Size(18, 9)),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 55, 111, 60),
      ),
      backgroundColor: Colors.white,
      body: Form(
          key: _formKey,
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),),
          bottomNavigationBar:
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          // Botão Voltar
          if (currentStep > 0)
            Container(
                          margin: EdgeInsets.only(bottom: 35.h),

              child: TextButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: const Text('VOLTAR'),
              ),
            ),
          // Espaçador para alinhar o botão Continuar à direita quando não houver o Voltar
          if (currentStep == 0) const Spacer(),

          // Botão Continuar / Finalizar
          Container(
            height: 160.h,
            width: 550.w,
            margin: EdgeInsets.only(bottom: 55.h),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60)),
              onPressed: () {
                // _preencherDadosParaTeste();
                // _preencherDadosParaTeste2();
                // _preencherDadosParaTeste3();
                _formKey.currentState!.save();
                _formKey.currentState!.validate();
              },
              child: Text(
                currentStep < pages.length - 1 ? 'CONTINUAR' : 'FINALIZAR',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
    ]));
  }
}

class Identificacao extends StatelessWidget {
  final Map<String, TextEditingController> controllers;
  const Identificacao({
    super.key,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UfMunicipioRg(controllers: controllers),
        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: 'Tipo:',
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 35.h,
        ),
        RadioFormField(
          options: ['Comércio Turístico'],
        ),
        SizedBox(
          height: 35.h,
        ),
        textLabel(
          name: 'Subtipos:',
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 35.h,
        ),
        RadioFormField(options: [
          'Loja de artesanato/souvenir',
          'Loja de artigos fotográficos',
          'Antiquário/galeria de arte',
          'outro'
        ])
      ],
    );
  }
}
