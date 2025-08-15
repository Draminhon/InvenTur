import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsA/informacoes_basicas_do_municipio.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/fields.dart';
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
    'razaoSocial',
    'nomeFantasia',
    'CNPJ',
    'codigoCNAE',
    'atividadeEconomica',
    'inscricaoMunicipal',
    'nomeDaRedeFranquia',
    'longitudePrefeitura',
    'latitudePrefeitura',
    'avenidaRuaTravessa',
    'bairroLocalidade',
    'distrito',
    'CEP',
    'whatsapp',
    'instagram',
    'email',
    'site',
    'pontosDeReferencia'
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
            decorator: DotsDecorator(
                activeColor: Colors.white, activeSize: Size(18, 9)),
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
          ),
        ),
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
                if(_formKey.currentState!.validate()){
                  _formKey.currentState!.save();

                }else{
                  _formKey.currentState!.save();
                        _identificacaoControllers.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });

      valoresJson.forEach((key, value) => print("$key - $value"),);
                }
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
    final sizeScreen = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Column(
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
            initialValue: '',
            onSaved: (newValue) => valoresJson['tipo'] = newValue,
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
          RadioFormField(
            options: [
              'Loja de artesanato/souvenir',
              'Loja de artigos fotográficos',
              'Antiquário/galeria de arte',
              'outro'
            ],
            onSaved: (newValue) => valoresJson['subtipo'] = newValue,
            initialValue: '',
          ),
          SizedBox(
            height: 55.h,
          ),
          Container(
            color: const Color.fromARGB(255, 55, 111, 60),
            height: sizeScreen.height * 0.06,
            width: sizeScreen.width,
            padding: EdgeInsets.only(
                top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
            child: Text(
              'Informações Gerais',
              style: TextStyle(
                  color: Colors.white, fontSize: sizeScreen.height * 0.03),
            ),
          ),
          CustomTextField(
            name: 'Razão Social',
            controller: controllers['razaoSocial'],
          ),
          CustomTextField(
            name: 'Nome Fantasia',
            controller: controllers['nomeFantasia'],
          ),
          CustomTextField(
            name: 'CNPJ',
            validat: _validators.validarCNPJ,
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [_validators.cnpjFormatter],
            controller: controllers['CNPJ'],
          ),
          CustomTextField(
            name: 'Código CNAE',
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            controller: controllers['codigoCNAE'],
          ),
          CustomTextField(
            name: 'Atividade Econômica',
            controller: controllers['atividadeEconomica'],
          ),
          CustomTextField(
            name: 'Inscrição Municipal',
            controller: controllers['inscricaoMunicipal'],
          ),
          CustomTextField(
            controller: controllers['nomeDaRedeFranquia'],
            name: 'Nome da Rede/Franquia',
          ),
          RadioFormField(
            title: 'Natureza',
            onSaved: (newValue) => valoresJson['natureza'] = newValue,
            options: ['Pública', 'Privada', 'outro'],
            initialValue: '',
          ),
          RadioFormField(
            title: 'Tipo de Organização/Instituição',
            onSaved: (newValue) => valoresJson['tipoDeOrganizacao'] = newValue,
            options: [
              'Associação',
              'Sindicato',
              'Cooperativa',
              'Sistema S',
              'Empresa',
              'outro'
            ],
            initialValue: '',
          ),
          RadioFormField(
            onSaved: (newValue) => valoresJson['localizacao'] = newValue,
            title: 'Localização',
            options: ['Urbana', 'Rural', 'outro'],
            initialValue: '',
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: "Coordenadas Geográficas",
            fontWeight: FontWeight.bold,
          ),
          CustomTextField(
            controller: controllers['longitudePrefeitura'],
            name: 'Longitude',
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [
              FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))
            ],
          ),
          CustomTextField(
            controller: controllers['latitudePrefeitura'],
            name: 'Latitude',
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^-?\d*\.?\d*'),
              ),
            ],
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Endereço',
            fontWeight: FontWeight.bold,
          ),
          CustomTextField(
            name: 'Avenida/Rua/Travessa/Caminho/Outro',
            controller: controllers['avenidaRuaTravessa'],
          ),
          CustomTextField(
            name: 'Bairro/Localidade',
            controller: controllers['bairroLocalidade'],
          ),
          CustomTextField(
            name: 'Distrito',
            controller: controllers['distrito'],
          ),
          CustomTextField(
            name: 'CEP',
            controller: controllers['CEP'],
            formatter: [
              FilteringTextInputFormatter.digitsOnly,
              _validators.cepFormatter
            ],
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Whatsapp/Instagram',
            fontWeight: FontWeight.bold,
          ),
          CustomTextField(
            controller: controllers['whatsapp'],
            name: 'Whatsapp',
            formatter: [
              FilteringTextInputFormatter.digitsOnly,
              _validators.phoneFormatter
            ],
            keyboardType: TextInputType.numberWithOptions(),
          ),
          CustomTextField(name: 'Instagram', controller: controllers['instagram'],),
          CustomTextField(name: 'E-mail', controller: controllers['email'],),
          CustomTextField(name: 'Site', controller: controllers['site'],),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Sinalização',
            fontWeight: FontWeight.bold,
          ),
          ConditionalFieldsGroup(title: 'De Acesso', jsonKey: 'sinalizacaoDeAcesso', children: [], valoresJson: valoresJson,isUpdate: isUpdate,),
          ConditionalFieldsGroup(title: 'Turística', jsonKey: 'sinalizacaoTuristica', children: [], valoresJson: valoresJson, isUpdate: isUpdate,),
          CustomTextField(name: 'Pontos de Referência',controller: controllers['pontosDeReferencia'],),
          SizedBox(
            height: 1000.h,
          ),
        ],
      ),
    );
  }
}
