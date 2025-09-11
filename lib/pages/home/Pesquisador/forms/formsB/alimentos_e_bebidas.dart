import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/forms/alimentos_bebidas_model.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsA/informacoes_basicas_do_municipio.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/fields.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_widget.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/tables.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/services/form_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/utils/validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../widgets/expandedTileYoN.dart';
import 'widgets/checkBox.dart';
import 'widgets/sendButton.dart';

final Validators _validators = Validators();
final Map<String, dynamic> valoresJson = {
  'tipo_formulario': 'Alimentos e bebidas',
};
bool isUpdate = false;

//formulario
class AlimentosEBebidas extends StatefulWidget {
  final AlimentosEBebidasModel? infoModel;
  const AlimentosEBebidas({super.key, this.infoModel});

  @override
  State<AlimentosEBebidas> createState() => _AlimentosEBebidasState();
}

class _AlimentosEBebidasState extends State<AlimentosEBebidas> {

  int currentStep = 0;
  late List<Widget> pages;
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();

  bool isUpdate = false;

  Map<String, TextEditingController>  _informacoesGeralController = {};
  Map<String, TextEditingController>  _funcionamentoControllers = {};
  Map<String, TextEditingController>  _acessibilidadeController = {};

  final List<String> _chavesInfo = const[
    'uf',
    'regiaoTuristica',
    'municipio',
    'razaoSocial',
    'nomeFantasia',
    'CNPJ',
    'codigoCNAE',
    'atividadeEconomica',
    'inscricaoMunicipal',
    'nomeDaRede',
    'inicioDaAtividade',
    'qtdeFuncionariosPermanentes',
    'qtdeFuncionariosTemporarios',
    'qtdeFuncionariosComDeficiencia',
    'longitude',
    'latitude',
    'avenidaRuaEtc',
    'bairroLocalidade',
    'distrito',
    'CEP',
    'whatsapp',
    'instagram',
    'email',
    'distanciasAeroporto',
    'distanciasRodoviaria',
    'distanciasFerroviaria',
    'distanciasMaritima',
    'distanciasMetroviaria',
    'distanciasPontoOnibus',
    'distanciasPontoTaxi',
    'distanciasOutraNome;',
    'distanciasOutra',
    'pontoReferencia', 
  ];
  final List<String> _chavesFun = const[
    'capInstaladaPdia',
    'capInstaladasSentadas',
    'capSimultanea',
    'capSimultaneaSentadas',
    'capacidadeVeiculos',
    'numeroAutomoveis',
    'numeroOnibus',
  ];
  final List<String> _chavesAcessi = const[
    'outrosAcessibilidade',
    'observacoes',
    'referencias',
  ];

  void _preencherDadosParaTeste() {
    if (widget.infoModel != null) {
      final model = widget.infoModel!;
      final modelMap = model.toMap();

      _informacoesGeralController.forEach((key, controller) {
        if (modelMap.containsKey(key)) {
          final valor = modelMap[key];
          controller.text = valor?.toString() ?? '';
        }
      });

      _funcionamentoControllers.forEach(
        (key, value) {
          if (modelMap.containsKey(key)) {
            final valor = modelMap[key];
            value.text = valor?.toString() ?? '';
          }
        },
      );

      _acessibilidadeController.forEach(
        (key, value) {
          if (modelMap.containsKey(key)) {
            final valor = modelMap[key];
            value.text = valor?.toString() ?? '';
          }
        },
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try {
      final argument = ModalRoute.of(context)!.settings.arguments as Map;
      print("ARGUMENTO: $argument");
      if (argument.containsKey('isUpdate')) {
        isUpdate = argument['isUpdate'];
      }
    } catch (e) {
      isUpdate = false;
    }
    print("VARIAVEL IS UPDATE: $isUpdate");
    if (isUpdate) {
      _preencherDadosParaTeste();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfoUsersInPesquisa();
    for (final key in _chavesInfo) {
      _informacoesGeralController[key] = TextEditingController();
    }

    for (final key in _chavesFun) {
      _funcionamentoControllers[key] = TextEditingController();
    }

    for (final key in _chavesAcessi) {
      _acessibilidadeController[key] = TextEditingController();
    }

    pages = [
      InformacaoPage(
        controllers: _informacoesGeralController,
        infoModel: widget.infoModel,
      ),
      FuncionamentoPage(
        controllers: _funcionamentoControllers,
        infoModel: widget.infoModel,
      ),
      ProtecaoPage(
        controllers: _acessibilidadeController,
        infoModel: widget.infoModel,
      ),
    ];
  }

  @override
  void dispose() {
    for (final controller in _informacoesGeralController.values) {
      controller.dispose();
    }
    for (final controller in _funcionamentoControllers.values) {
      controller.dispose();
    }
    for(final controller in _acessibilidadeController.values){
      controller.dispose();
    }
    super.dispose();
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

  void _enviarFormulario() async{
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      _informacoesGeralController.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });
      _funcionamentoControllers.forEach(
        (key, controller) {
          valoresJson[key] = controller.text;
        },
      );
      _acessibilidadeController.forEach(
        (key, value) {
          valoresJson[key] = value.text;
        },
      );
      valoresJson.forEach(
        (key, value) {
          print("$key  - $value");
        },
      );
      if (currentStep < pages.length - 1) {
        // Avança para a próxima página
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        // isUpdate ? FormService().updateForm(widget.infoModel!.id!, valoresJson,AppConstants.INFO_BASICA_CREATE ) :
        isUpdate
            ? FormService().updateForm(widget.infoModel!.id!, valoresJson,
                AppConstants.ALIMENTOS_E_BEBIDAS)
            : FormService()
                .sendForm(valoresJson, AppConstants.ALIMENTOS_E_BEBIDAS);
        print("Formulário finalizado e pronto para enviar!");

        // _enviarFormulario(); // Você pode chamar sua função de envio aqui
      }
    } else {
      _formKey.currentState!.save();
      _informacoesGeralController.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });

      _funcionamentoControllers.forEach((key, controller) {
          valoresJson[key] = controller.text;
        },
      );
      _acessibilidadeController.forEach((key, value) {
          valoresJson[key] = value.text;
        },
      );
      valoresJson.forEach(
        (key, value) {
          print("$key  - $value");
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, corrija os erros no formulário.')));
    }
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
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (value) {
              setState(() {
                currentStep = value;
              });
            },
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
            margin: currentStep > 0
                ? EdgeInsets.only(bottom: 55.h)
                : EdgeInsets.only(bottom: 55.h, right: 55.w),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60)),
              onPressed: () {
                _enviarFormulario();
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

class InformacaoPage extends StatefulWidget {
  final Map<String, TextEditingController> controllers;
  final AlimentosEBebidasModel? infoModel;

  const InformacaoPage({
    super.key,
    required this.controllers,
    this.infoModel,
  });

  @override
  State<InformacaoPage> createState() => _InformacaoPageState();
}


class FuncionamentoPage extends StatefulWidget {
  final AlimentosEBebidasModel? infoModel;

  final Map<String, TextEditingController> controllers;

  const FuncionamentoPage({
    super.key, 
    required this.controllers,
    this.infoModel
  });

  @override
  State<FuncionamentoPage> createState() => _FuncionamentoPageState();
}

/*construção*/

class _InformacaoPageState extends State<InformacaoPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); 
    final sizeScreen = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          ContainerHeader(title: 'Identificação'),
          UfMunicipioRg(controllers: widget.controllers),
          SizedBox(
            height: 55.h,
          ),
          RadioFormField(options:   const [
            'Restaurante',
            'Bar',
            'Lanchonete',
            'Cafeteria',
            'Quiosque',
            'Barraca de praia',
            'Sorveteria',
            'Confeitaria\nPadaria',
            'outro'
          ],),
          SizedBox(
            height: 55.h,
          ),
          ContainerHeaderToBigTexts(title: 'Informações Gerais'),
          SizedBox(
            height: 55.h,
          ),
          CustomTextField(
            name: "Razão Social", 
            controller: widget.controllers['razaoSocial'],
          ),
          CustomTextField(
            name: "Nome Fantasia", 
            controller: widget.controllers['nomeFantasia'],
          ),
          CustomTextField(
            name: 'CNPJ',
            validat: _validators.validarCNPJ,
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [_validators.cnpjFormatter],
            controller: widget.controllers['CNPJ'],
          ),
          CustomTextField(
            name: 'Código CNAE',
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            controller: widget.controllers['codigoCNAE'],
          ),
          CustomTextField(
            name: 'Atividade Econômica',
            controller: widget.controllers['atividadeEconomica'],
          ),
          CustomTextField(
            name: 'Nome da Rede/holding',
            controller: widget.controllers['nomeDaRedeFranquia'],
          ),
          CustomTextField(
            name: 'Inscrição Municipal',
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [FilteringTextInputFormatter.digitsOnly],
            controller: widget.controllers['inscricaoMunicipal'],
          ),
          RadioFormField(
            title: 'Natureza',
            onSaved: (newValue) => valoresJson['natureza'] = newValue,
            options: ['Pública', 'Privada', 'outro'],
            initialValue: isUpdate ? widget.infoModel!.natureza! : '',
          ),
          CheckboxGroupFormField(
            title: 'Tipo de Organização/Instituição',
            onSaved: (newValue) => valoresJson['tipoDeOrganizacaoInstituicao'] = newValue,
            options: [
              'Associação',
              'Sindicato',
              'Cooperativa',
              'Sistema S',
              'Empresa',
              'outro'
            ],
            initialValue: isUpdate ? widget.infoModel!.tipoDeOrganizacaoInstituicao! : [],
          ),
          //formatação inicio da atividade
          Row(
            children: [
              textLabel(
                  name: "Inicio da atividade",
                  fontWeight: FontWeight.bold,
              ),
              SizedBox(
                width: sizeScreen.width * 0.1,
              ),
              Container(
                height: sizeScreen.height * 0.1,
                width: sizeScreen.width * 0.4,
                child: CustomTextDate(
                  dateController: widget.controllers['inicioDaAtividade'],
                ),
              )] 
          ),
          //formatação quantidade de funcionários
          textLabel(
            name: 'Quantidade de Funcionários',
            fontWeight: FontWeight.bold,
          ),
          Row(children: [
              textLabel(name: 'Permanentes'),
              SizedBox(
                width: sizeScreen.width * 0.026,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: 'n°',
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: widget.controllers['qtdeFuncionariosPermanentes'],
                ),
              ),
          ],), 
          Row(children: [
              textLabel(name: 'Temporários '),
              SizedBox(
                width: sizeScreen.width * 0.026,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: 'n°',
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: widget.controllers['qtdeFuncionariosTemporarios'],
                ),
              ),
          ],),
          Row(children: [
              textLabel(name: 'Pessoas com \nDeficiência'),
              SizedBox(
                width: sizeScreen.width * 0.026,
              ),
              SizedBox(
                width: sizeScreen.width * 0.6,
                child: CustomTextField(
                  name: '%',
                  formatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: widget.controllers['qtdeFuncionariosComDeficiencia'],
                ),
              ),
          ],),
          SizedBox(
            height: 20.w,
          ),
          //localização
          RadioFormField(
            onSaved: (newValue) => valoresJson['localizacao'] = newValue,
            title: 'Localização',
            options: ['Urbana', 'Rural'],
            initialValue: isUpdate ? widget.infoModel!.localizacao! : '',
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Coordenadas Geográficas',
            fontWeight: FontWeight.bold,
          ),
          CustomTextField(
            controller: widget.controllers['longitudePrefeitura'],
            name: 'Longitude',
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [
              FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))
            ],
          ),
          CustomTextField(
            controller: widget.controllers['latitudePrefeitura'],
            name: 'Latitude',
            keyboardType: TextInputType.numberWithOptions(),
            formatter: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^-?\d*\.?\d*'),
              ),
            ],
          ),
          textLabel(
            name: 'Endereço:',
            fontWeight: FontWeight.bold,
          ),
          CustomTextField(
            name: 'Avenida/Rua/Travessa/Caminho/Outro',
            controller: widget.controllers['avenidaRuaTravessa'],
          ),
          CustomTextField(
            name: 'Bairro/Localidade',
            controller: widget.controllers['bairroLocalidade'],
          ),
          CustomTextField(
            name: 'Distrito',
            controller: widget.controllers['distrito'],
          ),
          CustomTextField(
            name: 'CEP',
            controller: widget.controllers['CEP'],
            formatter: [
              FilteringTextInputFormatter.digitsOnly,
              _validators.cepFormatter
            ],
          ),
          //contato
          textLabel(
            name: 'Contato:', 
            fontWeight: FontWeight.bold
          ),
          Row(children: [
            textLabel(name: "WhatsApp"),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
              width: sizeScreen.width * 0.6,
              child: CustomTextField(
                name: '(DD) *****-****',
                keyboardType: TextInputType.numberWithOptions(),
                formatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  _validators.phoneFormatter
                ],
                controller: widget.controllers['whatsapp'],
              ),
            ),
            ],
          ),
          Row(children: [
            textLabel(name: "Instagram"),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
              width: sizeScreen.width * 0.6,
              child: CustomTextField(
                name: '@username',
                controller: widget.controllers['instagram'],
              ),
            ),
            ],
          ),
          Row(children: [
            textLabel(name: "E-mail"),
            SizedBox(
              width: sizeScreen.width * 0.17,
            ),
            SizedBox(
              width: sizeScreen.width * 0.6,
              child: CustomTextField(
                name: 'E-mail',
                controller: widget.controllers['email'],
              ),
            ),
            ],
          ),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Sinalização',
            fontWeight: FontWeight.bold,
          ),
          ConditionalFieldsGroup(
            title: 'De Acesso',
            jsonKey: 'sinalizacaoDeAcesso',
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [],
            optionModelValue: isUpdate ? widget.infoModel!.sinalizacaoDeAcesso! : '',
          ),
          ConditionalFieldsGroup(
            title: 'Turística',
            jsonKey: 'sinalizacaoTuristica',
            valoresJson: valoresJson,
            isUpdate: isUpdate,
            children: [],
            optionModelValue: isUpdate ? widget.infoModel!.sinalizacaoTuristica! : '',
          ),
          CheckboxGroupFormField(
            title: 'Proximidades: ',
            onSaved: (newValue) => valoresJson['proximidades'] = newValue,
            options: [
              'Meio de Hospedagem',
              'Shopping',
              'Galeria/rua comercial',
              'Centro de convenções/exposições',
              'Posto de combustível',
              'outro'
            ],
            initialValue: isUpdate ? widget.infoModel!.proximidades! : [],
          ),
          SizedBox(
            height: 30.w,
          ),
          //distancias
          textLabel(
            name: 'Distâncias até:', 
            fontWeight: FontWeight.bold
          ),
          Row(children: [
            textLabel(name: "Aeroporto:"),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
              width: sizeScreen.width * 0.6,
              child: CustomTextField(
                name: '(km)',
                controller: widget.controllers['distanciasAeroporto'],
              ),
            ),
            ],
          ),
          Row(children: [
            textLabel(name: "Estação \nrodoviária:"),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
              width: sizeScreen.width * 0.6,
              child: CustomTextField(
                name: '(km)',
                controller: widget.controllers['distanciasRodoviaria'],
              ),
            ),
            ],
          ),
          Row(children: [
            textLabel(name: "Estação \nferroviária:"),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
              width: sizeScreen.width * 0.6,
              child: CustomTextField(
                name: '(km)',
                controller: widget.controllers['distanciasFerroviaria'],
              ),
            ),
            ],
          ),
          Row(children: [
            textLabel(name: "Estação \nmarítima/\nfluvial:"),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
              width: sizeScreen.width * 0.6,
              child: CustomTextField(
                name: '(km)',
                controller: widget.controllers['distanciasMaritima'],
              ),
            ),
            ],
          ),
          Row(children: [
            textLabel(name: "Estação \nmetroviária:"),
            SizedBox(
              width: sizeScreen.width * 0.05,
            ),
            SizedBox(
              width: sizeScreen.width * 0.6,
              child: CustomTextField(
                name: '(km)',
                controller: widget.controllers['distanciasMetroviaria'],
              ),
            ),
            ],
          ),
          Row(children: [
            textLabel(name: "Ponto de\nônibus:"),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
              width: sizeScreen.width * 0.6,
              child: CustomTextField(
                name: '(km)',
                controller: widget.controllers['distanciasPontoOnibus'],
              ),
            ),
            ],
          ),
          Row(children: [
            textLabel(name: "Ponto de\ntaxi:"),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
              width: sizeScreen.width * 0.6,
              child: CustomTextField(
                name: '(km)',
                controller: widget.controllers['distanciasPontoTaxi'],
              ),
            ),
            ],
          ),
          Row(children: [
            textLabel(name: "Outros:"),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
              width: sizeScreen.width * 0.37,
              child: CustomTextField(
                name: 'nome',
                controller: widget.controllers['distanciasOutraNome;'],
              ),
            ),
             SizedBox(
              width: sizeScreen.width * 0.2,
              child: CustomTextField(
                name: '(km)',
                controller: widget.controllers['distanciasOutra'],
              ),
            ),
            ],
          ),
          textLabel(
            name: 'Ponto de referência:', 
            fontWeight: FontWeight.bold
          ),
          CustomTextField(
            name: 'Ponto de referência',
            controller: widget.controllers['pontoReferencia'],
          ),
          SizedBox(
            height: 55.h,
          ),
          ContainerHeaderToBigTexts(title: 'Cadastro, classificação e outros'),
          SizedBox(
            height: 55.h,
          ),
          TableMtur(

            
          ),
          SizedBox(
            height: 55.h,
          ),
        ],
      ),
    );
  }

}

class _FuncionamentoPageState extends State<FuncionamentoPage> with AutomaticKeepAliveClientMixin {
  @override
    // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final sizeScreen = MediaQuery.sizeOf(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          ContainerHeaderToBigTexts(title: 'funcionamento'),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Estrutura de funcionamento:', 
            fontWeight: FontWeight.bold
          ),
          //pagamentos
          CheckboxGroupFormField(
            title: 'Formas de pagamento: ',
            onSaved: (newValue) => valoresJson['formasDePagamento'] = newValue,
            options: [
              'Dinheiro',
              'Pix',
              'Cartão de Crédito',
              'Cartão de Débito'
            ],
            initialValue: isUpdate ? widget.infoModel!.formasDePagamento! : [],
          ),
          CheckboxGroupFormField(
            title: 'Vendas e Reservas: ',
            onSaved: (newValue) => valoresJson['vendasEReservas'] = newValue,
            options: [
              'Balcão',
              'Whatsapp',
              'Site',
              'Instagram',
              'Outro'
            ],
            initialValue: isUpdate ? widget.infoModel!.vendasEReservas! : [],
          ),
          //atendimento
          textLabel(
            name: 'Atendimento ao público:', 
            fontWeight: FontWeight.bold
          ),
          CheckboxGroupFormField(
            title: 'Atendimento em língua estrangueira: ',
            onSaved: (newValue) => valoresJson['atendimentoEmLinguasEstrangeiras'] = newValue,
            options: [
              'Não',
              'Inglês',
              'Espanhol',
              'Outro'
            ],
            initialValue: isUpdate ? widget.infoModel!.atendimentoEmLinguasEstrangeiras! : [],
          ),
          CheckboxGroupFormField(
            title: 'Informativos impressos: ',
            onSaved: (newValue) => valoresJson['informativosImpressos'] = newValue,
            options: [
              'Não',
              'Inglês',
              'Espanhol',
              'Português',
              'Outro'
            ],
            initialValue: isUpdate ? widget.infoModel!.informativosImpressos! : [],
          ),
          SizedBox(
            height: 55.h,
          ),
          ContainerHeaderToBigTexts(title: 'Regras de funcionamento'),       
          SizedBox(
            height: 55.h,
          ),
          CheckboxGroupFormField(
            title: 'Périodo: ',
            onSaved: (newValue) => valoresJson['periodo'] = newValue,
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
              'Ano inteiro'
            ],
            initialValue: isUpdate ? widget.infoModel!.periodo! : [],
          ),
          textLabel(name: 'Horário'),
          SizedBox(
            height: 55.h,
          ),
          TabelaHorarios(
            onChanged: (p0) => valoresJson['tabelasHorario'] = p0,
            getValue: isUpdate ? widget.infoModel!.tabelasHorario : {},
          ),
          SizedBox(
            height: 55.h,
          ),
          ConditionalFieldsGroup(
              title: 'Funcionamento\n24 Horas',
              jsonKey: 'funcionamento24h',
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              optionModelValue: isUpdate ? widget.infoModel!.funcionamento24h : '',
              children: []),
          ConditionalFieldsGroup(
              title: 'Funcionamento\nem Feriados',
              jsonKey: 'funcionamentoEmFeriados',
              valoresJson: valoresJson,
              optionModelValue:
                isUpdate ? widget.infoModel!.funcionamentoEmFeriados : '',
              isUpdate: isUpdate,
              children: []),
          SizedBox(
            height: 55.h,
          ),
          CheckboxGroupFormField(
            title: 'Restrições: ',
            onSaved: (newValue) => valoresJson['restricoes'] = newValue,
            options: [
              'Crianças', 
              'Fumantes', 
              'Animais', 
              'outro'
            ],
            initialValue: isUpdate ? widget.infoModel!.restricoes! : [],
          ),
          textLabel(
            name: 'Outras regras e informações:',
            fontWeight: FontWeight.bold
          ),
          CustomTextField(
            name: 'Outras Regras e Informações',
            controller: widget.controllers['outrasRegrasEInformacoes'],
          ),
          //capacidade
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Capacidade de atendimento:',
            fontWeight: FontWeight.bold
          ),
          textLabel(
            name: 'Capacidade instalada por dia nº:',
            fontWeight: FontWeight.bold
          ),
          CustomTextField(
            name: 'nº',
            controller: widget.controllers['capInstaladaPdia'],
          ),
          textLabel(
            name: 'Pessoas atendidas sentadas nº:',
            fontWeight: FontWeight.bold
          ),
          CustomTextField(
            name: 'nº',
            controller: widget.controllers['capInstaladasSentadas'],
          ),
          textLabel(
            name: 'Capacidade simultânea nº:',
            fontWeight: FontWeight.bold
          ),
          CustomTextField(
            name: 'nº',
            controller: widget.controllers['capSimultanea'],
          ),
          textLabel(
            name: 'Pessoas atendidas sentadas nº:',
            fontWeight: FontWeight.bold
          ),
          CustomTextField(
            name: 'nº',
            controller: widget.controllers['capSimultaneaSentadas'],
          ),
          SizedBox(
            height: 55.h,
          ),
          //caracteriscas do local
          ContainerHeaderToBigTexts(title: 'Características'),
          SizedBox(
            height: 55.h,
          ),
          textLabel(
            name: 'Instalações',
            fontWeight: FontWeight.bold,
          ),
          //veiculos
          CheckboxGroupFormField(
            title: 'Estacionamento: ',
            onSaved: (newValue) => valoresJson['estacionamento'] = newValue,
            options: [
              'Pago', 
              'Gratuito', 
              'Coberto', 
              'Descoberto'
            ],
            initialValue: isUpdate ? widget.infoModel!.estacionamento! : [],
          ),
          Row(children: [
            textLabel(name: "Capacidade de\n veiculos nº:"),
            SizedBox(
              width: sizeScreen.width * 0.1,
            ),
            SizedBox(
              width: sizeScreen.width * 0.5,
              child:CustomTextField(
                name: '(nº)',
                controller: widget.controllers['capacidadeVeiculos'],
                formatter: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.numberWithOptions(),
              ),
            ),
            ],
          ),
          Row(children: [
            textLabel(name: "Automóveis nº:"),
            SizedBox(
              width: sizeScreen.width * 0.08,
            ),
            SizedBox(
              width: sizeScreen.width * 0.5,
              child:CustomTextField(
                name: '(nº)',
                controller: widget.controllers['numeroAutomoveis'],
                formatter: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.numberWithOptions(),
              ),
            ),
            ],
          ),
          Row(children: [
            textLabel(name: "Ônibus nº:"),
            SizedBox(
              width: sizeScreen.width * 0.18,
            ),
            SizedBox(
              width: sizeScreen.width * 0.5,
              child:CustomTextField(
                name: '(nº)',
                controller: widget.controllers['numeroOnibus'],
                formatter: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.numberWithOptions(),
              ),
            ),
            ],
          ),
          SizedBox(
            height: 55.h,
          ),
          CheckboxGroupFormField(
            title: 'Serviços e Equipamentos: ',
            onSaved: (newValue) => valoresJson['servicosEEquipamentos'] = newValue,
            options: [
              'Música ao vivo',
              'Atendimento a grupos',
              'Ventilador',
              'Adega',
              'Recreação para crianças',
              'Cardápio em língua estrangeira',
              'Música ambiente',
              'Manobrista',
              'Internet sem fio',
              'Área para fumantes',
              'Carta de vinhos',
              'Espaço para eventos',
              'Ar condicionado',
              'Lareira',
              'Área de lazer para crianças',
              'Cardápio em braile',
              'Sanitário próprio',
              'outro',
            ],
            initialValue: isUpdate ? widget.infoModel!.servicosEEquipamentos! : [],
          ),
          CheckboxGroupFormField(
            title: 'Especificação da gastromia pro país: ',
            onSaved: (newValue) => valoresJson['especificacaoDaGastronomiaPorPais'] = newValue,
            options: [
              'Não',
              'Argentina',
              'Coreana',
              'Grega',
              'Judaica',
              'Polonesa',
              'Turca',
              'Alemã',
              'Asiática',
              'Escandinava',
              'Indiana',
              'Libanesa',
              'Portuguesa',
              'Uruguaia',
              'Americana',
              'Brasileira',
              'Espanhola',
              'Italiana',
              'Marroquina',
              'Suíça',
              'Vietnamita',
              'Árabe',
              'Chinesa',
              'Francesa',
              'Japonesa',
              'Mexicana',
              'Tailandesa',
              'outro',
            ],
            initialValue: isUpdate ? widget.infoModel!.especificacaoDaGastronomiaPorPais! : [],
          ),
          CheckboxGroupFormField(
            title: 'Se for brasileira, por região: ',
            onSaved: (newValue) => valoresJson['seForBrasileiraPorRegiao'] = newValue,
            options: [
              'Não',
              'Amazônica',
              'Campeira gaúcha',
              'Capixaba',
              'Goiana',
              'Mineira',
              'Carioca',
              'Nordestina',
              'Pantaneira',
              'Paulista',
              'Outras'
            ],
            initialValue: isUpdate ? widget.infoModel!.seForBrasileiraPorRegiao! : [],
          ),
          CheckboxGroupFormField(
            title: 'Por especialização: ',
            onSaved: (newValue) => valoresJson['porEspecializacao'] = newValue,
            options: [
              'Não',
              'Cachaçaria',
              'Cafeteria',
              'Café colonial',
              'Cervejaria',
              'Churrascaria',
              'Creperia',
              'Tapiocaria',
              'Doceria',
              'Empaderia',
              'Frutos do mar',
              'Grelhados (grill)',
              'Galeteria',
              'Pastelaria',
              'Petisqueria (snack bar)',
              'Pizzaria',
              'Sanduicheria',
              'Sucos',
              'Chás',
              'Whiskeria',
              'Sorveteria',
              'Outros'
            ],
            initialValue: isUpdate ? widget.infoModel!.porEspecializacao! : [],
          ),
          CheckboxGroupFormField(
            title: 'Por tipo de dieta: ',
            onSaved: (newValue) => valoresJson['porTipoDeDieta'] = newValue,
            options: [
              'Não',
              'Macrobiótica',
              'Vegetariana',
              'Natural',
              'Outros'
            ],
            initialValue: isUpdate ? widget.infoModel!.porTipoDeDieta! : [],
          ),
          CheckboxGroupFormField(
            title: 'Por tipo de serviço: ',
            onSaved: (newValue) => valoresJson['porTipoDeServico'] = newValue,
            options: [
              'A la carte',
              'self service por preço fixo',
              'self service por quilo',
              'Rodízio',
              'Rodízio com bufê (buffet)',
              'drive-thru',
              'fast food',
              'delivery',
              'Outros'
            ],
            initialValue: isUpdate ? widget.infoModel!.porTipoDeServico! : [],
          ),
          SizedBox(
            height: 55.h,
          ),        
        ],
      ),
    );
  }
}

class ProtecaoPage extends StatelessWidget{
  final Map<String, TextEditingController> controllers;
  final AlimentosEBebidasModel? infoModel;

  const ProtecaoPage({super.key, required this.controllers, this.infoModel});
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: [
          ContainerHeaderToBigTexts(title: 'Proteção, Qualificação, Certificação, Premiação, destaques e outros'),
          ConditionalFieldsGroup(
              title: 'Do Equipamento/Espaço',
              jsonKey: 'doEquipamento',
              optionModelValue: isUpdate ? infoModel!.doEquipamento : '',
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              children: [
                TabelsEquipamentoEEspaco(
                  getValue: isUpdate ? infoModel!.tabelaEquipamentoEEspaco : {},
                  onChanged: (p0) => valoresJson['tabelaEquipamentoEEspaco'] = p0,
                )
              ]),
          SizedBox(
            height: 35.h,
          ),
          ContainerHeader(title: 'Estado Geral de Conservação'),
          RadioFormField(
            initialValue: isUpdate ? infoModel!.estadoGeralDeConservacao : '',
            onSaved: (newValue) => valoresJson['estadoGeralDeConservacao'] = newValue,
            options: ['Muito Bom', 'Bom', 'Ruim'],
            title: 'Estado Geral de Conservação',
          ),
          SizedBox(
            height: 85.h,
          ),
          SizedBox(
            height: 85.h,
          ),
          ContainerHeader(title: 'Acessibilidade'),
          ConditionalFieldsGroup(
              optionModelValue: isUpdate ? infoModel!.possuiFacilidade : '',
              title:
                  'Possui Alguma Facilidade\npara Pessoas com\nDeficiência\nou Mobilidade Reduzida?',
              jsonKey: 'possuiFacilidade',
              valoresJson: valoresJson,
              isUpdate: isUpdate,
              children: [
                CheckboxGroupFormField(
                  options: [
                    'Não',
                    'Física',
                    'Auditiva',
                    'Visual',
                    'Mental',
                    'Múltipla'
                  ],
                  initialValue: isUpdate ? infoModel!.pessoalCapacitadoParaReceberPCD : [],
                  title:
                      'Pessoal Capacitado Para Receber Pessoas com Deficiência',
                  onSaved: (newValue) =>
                      valoresJson['pessoalCapacitadoParaReceberPCD'] = newValue,
                ),
                CheckboxGroupFormField(
                    title: 'Rota Externa Acessível',
                    onSaved: (newValue) =>
                        valoresJson['rotaExternaAcessivel'] = newValue,
                    initialValue:
                        isUpdate ? infoModel!.rotaExternaAcessivel : [],
                    options: [
                      'Não',
                      'Estacionamento',
                      'Calçada Rebaixada',
                      'Faixa de Pedestre',
                      'Rampa',
                      'Semáforo Sonoro',
                      'Piso Tátil de Alerta',
                      'Piso Regular e Antiderrapante',
                      'Livre de Obstáculos',
                      'outro'
                    ]),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? infoModel!.simboloInternacionalDeAcesso : [],
                    title: 'Símbolo Internacional de Acesso',
                    onSaved: (newValue) =>
                        valoresJson['simboloInternacionalDeAcesso'] = newValue,
                    options: [
                      'Não',
                      'Entrada',
                      'Área Reservada',
                      'Estacionamento',
                      'Área de Embarque e Desembarque',
                      'Sanitário',
                      'Saída de Emergência'
                    ]),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? infoModel!.localDeEmbarqueEDesembarque : [],
                    title: 'Local de Embarque e Desembarque',
                    onSaved: (newValue) =>
                        valoresJson['localDeEmbarqueEDesembarque'] = newValue,
                    options: ['Não', 'Sinalizado', 'Com Acesso em Nível']),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? infoModel!.vagaEmEstacionamento : [],
                    title: 'Vaga em Estacionamento',
                    onSaved: (newValue) =>
                        valoresJson['vagaEmEstacionamento'] = newValue,
                    options: [
                      'Não',
                      'Sinalizada',
                      'Com Acesso em Nível',
                      'Alargada para Cadeira de Rodas',
                      'Rampa de Acesso à Calçada'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.areaDeCirculacaoAcessoInternoParaCadeiraDeRodas : [],
                    title:
                        'Área de Circulação/Acesso Interno para Cadeira de Rodas',
                    onSaved: (newValue) =>
                        valoresJson['areaDeCirculacaoAcessoInternoParaCadeiraDeRodas'] = newValue,
                    options: [
                      'Não',
                      'Rampa',
                      'Elevador',
                      'Plataforma Elevatória',
                      'Com Circulação Entre Mobiliário',
                      'Porta Larga',
                      'Piso Regular/Antiderrapante'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.escada : [],
                    title: 'Escada',
                    onSaved: (newValue) => valoresJson['escada'] = newValue,
                    options: [
                      'Não',
                      'Corrimão',
                      'Patamar para Descanso',
                      'Sinalização Tátil de Alerta',
                      'Piso Antiderrapante'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.rampa : [],
                    title: 'Rampa',
                    onSaved: (newValue) => valoresJson['rampa'] = newValue,
                    options: [
                      'Não',
                      'Corrimão',
                      'Patamar para Descanso',
                      'Piso Antiderrapante',
                      'Sinalização Tátil',
                      'Inclinação Adequada'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.piso : [],
                    title: "Piso",
                    onSaved: (newValue) => valoresJson['piso'] = newValue,
                    options: [
                      'Não',
                      'Tátil',
                      'Sem Obstáculos (tapete ou desnível)',
                      'Antiderrapante/Deslizante'
                    ]),
                CheckboxGroupFormField(
                    title: "Elevador",
                    initialValue: isUpdate ? infoModel!.elevador : [],
                    onSaved: (newValue) => valoresJson['elevador'] = newValue,
                    options: [
                      'Não',
                      'Sinalizado em Braille',
                      'Dispositivo Sonoro',
                      'Dispositivo Luminoso',
                      'Sensor Eletrônico (porta)'
                    ]),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? infoModel!.equipamentoMotorizadoParaDeslocamentoInterno : [],
                    title: 'Equipamento Motorizado para Deslocamento Interno',
                    onSaved: (newValue) =>
                        valoresJson['equipamentoMotorizadoParaDeslocamentoInterno'] = newValue,
                    options: ['Não', 'Cadeira', 'Carrinho']),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.sinalizacaoVisual : [],
                    title: 'Sinalização Visual',
                    onSaved: (newValue) =>
                        valoresJson['sinalizacaoVisual'] = newValue,
                    options: [
                      'Não',
                      'Entrada',
                      'Recepção',
                      'Porta',
                      'Sanitário',
                      'Elevador',
                      'Restaurante',
                      'Área de Lazer',
                      'Área de Resgate'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.sinalizacaoTatil : [],
                    title: "Sinalização Tátil",
                    onSaved: (newValue) =>
                        valoresJson['sinalizacaoTatil'] = newValue,
                    options: [
                      'Não',
                      'Entrada',
                      'Recepção',
                      'Porta',
                      'Sanitário',
                      'Elevador',
                      'Restaurante',
                      'Área de Lazer',
                      'Área de Resgate'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.alarmeDeEmergencia : [],
                    title: "Alarme de Emergência",
                    onSaved: (newValue) =>
                        valoresJson['alarmeDeEmergencia'] = newValue,
                    options: ['Não', 'Sonoro', 'Visual', 'Vibratório']),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.comunicacao : [],
                    title: "Comunicação",
                    onSaved: (newValue) =>
                        valoresJson['comunicacao'] = newValue,
                    options: [
                      'Não',
                      'Texto Informativo em Braille',
                      'Texto Informativo em Fonte Ampliada',
                      'Intérprete em Libras (língua brasileira de sinais)'
                    ]),
                CheckboxGroupFormField(
                    initialValue:
                        isUpdate ? infoModel!.balcaoDeAtendimento : [],
                    title: "Balcão de Atendimento",
                    onSaved: (newValue) =>
                        valoresJson['balcaoDeAtendimento'] = newValue,
                    options: [
                      'Não',
                      'Rebaixamento',
                      'Preferencial para Pessoas com Deficiência ou Mobilidade Reduzida'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.mobiliario : [],
                    title: "Mobiliário",
                    onSaved: (newValue) => valoresJson['mobiliario'] = newValue,
                    options: ['Não', 'Altura Adequada', 'Recuo Adequado']),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.sanitario : [],
                    title: "Sanitário",
                    onSaved: (newValue) => valoresJson['sanitario'] = newValue,
                    options: [
                      'Não',
                      'Barra de Apoio',
                      'Porta Larga Suficiente Para Entrada de Cadeira de Rodas',
                      'Giro para Cadeira de Rodas',
                      'Acesso para Cadeira de Rodas',
                      'Pia Rebaixada',
                      'Espelho Rebaixado ou com Ângulo de Alcance Visual',
                      'Boxe ou Banheira Adaptada',
                      'Torneira Monocomando/Alavanca'
                    ]),
                CheckboxGroupFormField(
                    initialValue: isUpdate ? infoModel!.telefone : [],
                    title: "Telefone",
                    onSaved: (newValue) => valoresJson['telefone'] = newValue,
                    options: [
                      'Não',
                      'Altura Adequada',
                      'Para Surdos (TPS ou TTS)'
                    ]),
                ConditionalFieldsGroup(
                    optionModelValue: isUpdate
                        ? infoModel!.sinalizacaoIndicativa
                        : '',
                    title:
                        'Sinalização Indicativa\nde Atendimento\nPreferencial para Pessoas\ncom Deficiência ou\nMobilidade Reduzida',
                    jsonKey: 'sinalizacaoIndicativa',
                    valoresJson: valoresJson,
                    isUpdate: isUpdate,
                    children: []),
                CustomTextField(
                  name: 'Outras',
                  controller: controllers['outrasAcessibilidade'],
                ),
              ]),
          SizedBox(
            height: 55.h,
          ),
          ContainerHeader(title: 'Observações e Referências'),
          SizedBox(
            height: 55.h,
          ),
          CustomTextField(
            name: 'Observações',
            controller: controllers['observacoes'],
          ),
          CustomTextField(
          name: 'Referências',
          controller: controllers['referencias'],
          )
        ],    
      ),
    );
  }
}
