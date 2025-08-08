import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/home/Pesquisador/forms/formsB/widgets/checkBox.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customOutro.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/expandedTileYoN.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/multi_auto_complete_form_field.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/radioButton.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/customTextField.dart';
import 'package:inventur/services/admin_service.dart';
import 'package:inventur/services/form_service.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:inventur/utils/validators.dart';
import 'package:dots_indicator/dots_indicator.dart';
final Validators _validators = Validators();
final Map<String, dynamic> valoresJson = {
  'tipo_formulario': 'Informações Básicas do Município',
};

class InformacoesBasicasDoMunicipio extends StatefulWidget {
  const InformacoesBasicasDoMunicipio({super.key});

  @override
  State<InformacoesBasicasDoMunicipio> createState() =>
      _InformacoesBasicasDoMunicipioState();
}

class _InformacoesBasicasDoMunicipioState
    extends State<InformacoesBasicasDoMunicipio> {

       void getInfoUsersInPesquisa() async {
    Map<String, dynamic> info = await getAdminAndPesquisadorInfo();

    valoresJson['nome_pesquisador'] = info['pesquisador']['nome'];
    valoresJson['telefone_pesquisador'] = info['pesquisador']['telefone'];
    valoresJson['email_pesquisador'] = info['pesquisador']['email'];

    valoresJson['nome_coordenador'] = info['coordenador']['nome'];
    valoresJson['telefone_coordenador'] = info['coordenador']['telefone'];
    valoresJson['email_coordenador'] = info['coordenador']['email'];
  }



  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  Map<String, TextEditingController> _infoGeraisControllers = {};

  Map<String, TextEditingController> _caracteristicasControllers = {};

  Map<String, TextEditingController> _legislacaoControllers = {};

  final List<String> _chavesInfoGerais = const [
    'uf', 'regiao_turistica', 'municipio',
    'enderecoPrefeitura', 'bairroPrefeitura', 'cepPrefeitura',
    'numeroPrefeitura',
    'instagramPrefeitura', 'emailPrefeitura', 'sitePrefeitura',
    'cnpjPrefeitura',
    'latitudePrefeitura', 'longitudePrefeitura', 'municipiosLimitrofes',
    'distanciaDaCapital', 'totalFuncionariosPrefeitura',
    'pessoasComDeficienciaPrefeitura',
    'nomeDoPrefeito', 'nomeDasSecretariasEtc',
    'nomeOrgaoOficialTurismo', 
    'enderecoOrgaoOfcTurismo', 'avenidaRuaOfcTurismo',
    'distritoOrgaoOfcTurismo',
    'cepOrgaoOfcTurismo', 'numeroOrgaoOfcTurismo', 'instagramOrgaoOfcTurismo',
    'siteOrgaoOfcTurismo', 'emailOrgaoOfcTurismo',
    'qtdeFuncionariosOrgaoOfcTurismo',
    'qtdeFormacaoSuperiorEmTurismoOrgaoOfcturismo',
    'instanciaGovernancaMunicipal',
    'instanciaGovernancaEstadual', 'instanciaGovernancaRegional',
    'instanciaGovernancaNacional',
    'instanciaGovernancaInternacional', 'instanciaGovernancaOutras',
    'aniversarioMunicipio',
    'santoPadroeiro', 'diaDoSantoPadroeiro', 'feriadoMunicipal01',
    'dataFeriadoMunicipal01', 'dataFeriadoMunicipal02',
    'dataFeriadoMunicipal03',
    'feriadoMunicipal02',
    'feriadoMunicipal03', 'origemDoNome', 'dataFundacao', 'dataEmancipacao',
    'fundadores', 'outrosFatosDeImportanciaHistorica'
  ];
  late List<Widget> pages;

  final List<String> _chavesCaracteristicas = const [
    'areaTotalMunicipio',
        'areaUrbana',
        'areaRural',
        'anoBase',
        'populacaoTotal',
        'populacaoUrbana',
        'populacaoRural',
        'anoBasePopulacao',
        'temperaturaMedia',
        'temperaturaMinima',
        'temperaturaMaxima',
        'altitudeMedia',
        'qtdeDomiciliosAtendidos',
        'empresaResponsavel',
        'esgotoTotalAtendidos',
        'esgotoDomiciliosAtendidos',
        'esgotoRuraisAtendidos',
        'esgotoEntidadeResponsavel',
        'fossaSepticaTotalAtendidos',
        'fossaSepticaDomiciliosAtendidos',
        'fossaSepticaRuraisAtendidos',
        'fossaSepticaEntidadeResponsavel',
        'fossaRudimentarTotalAtendidos',
        'fossaRudimentarDomiciliosAtendidos',
        'fossaRudimentarRuraisAtendidos',
        'fossaRudimentarEntidadeResponsavel',
        'valaTotalAtendidos',
        'valaDomiciliosAtendidos',
        'valaRuraisAtendidos',
        'valaEntidadeResponsavel',
        'estacaoDeTratamentoTotalAtendidos',
        'estacaoDeTratamentoDomiciliosAtendidos',
        'estacaoDeTratamentoRuraisAtendidos',
        'estacaoDeTratamentoEntidadeResponsavel',
        'esgotoTratadoTotalAtendidos',
        'esgotoTratadoDomiciliosAtendidos',
        'esgotoTratadoRuraisAtendidos',
        'esgotoTratadoEntidadeResponsavel',
        'servicoDeEsgotoOutroTotalNome',
        'servicoDeEsgotoOutroTotalAtendidos',
        'servicoDeEsgotoOutroDomiciliosAtendidos',
        'servicoDeEsgotoOutroRuraisAtendidos',
        'servicoDeEsgotoOutroEntidadeResponsavel',
        'capacidadeEmKVA',
        'geradorDeEmergenciaCapacidadeEmKVA',
        'redeUrbanaTotalAbastecido',
        'redeUrbanaEntidadeResponsavel',
        'redeRuralTotalAbastecido',
        'redeRuralEntidadeResponsavel',
        'abastecimentoProprioTotalAtendidos',
        'abastecimentoProprioDomiciliosAtendidos',
        'abastecimentoProprioRuraisAtendidos',
        'abastecimentoProprioEntidadeResponsavel',
        'servicosDeEnergiaOutroTotalNome',
        'servicosDeEnergiaOutroTotalAtendidos',
        'servicosDeEnergiaOutroDomiciliosAtendidos',
        'servicosDeEnergiaOutroEntidadeResponsavel',
        'coletaSeletivaTotalAtendidos',
        'coletaSeletivaDomiciliosAtendidos',
        'coletaSeletivaRuraisAtendidos',
        'coletaSeletivaEntidadeResponsavel',
        'coletaNaoSeletivaTotalAtendidos',
        'coletaNaoSeletivaDomiciliosAtendidos',
        'coletaNaoSeletivaRuraisAtendidos',
        'coletaNaoSeletivaEntidadeResponsavel',
        'coletaSemColetaTotal',
        'coletaSemColetaDomicilios',
        'coletaSemColetaRurais',
        'deposicaoAterroSanitarioTotalAtendidos',
        'deposicaoAterroSanitarioDomiciliosAtendidos',
        'deposicaoAterroSanitarioRuraisAtendidos',
        'deposicaoAterroSanitarioEntidadeResponsavel',
        'deposicaoAterroSanitarioTotalAtendidos',
        'deposicaoAterroSanitarioDomiciliosAtendidos',
        'deposicaoAterroSanitarioRuraisAtendidos',
        'deposicaoAterroSanitarioEntidadeResponsavel',
        'deposicaoACeuAbertoTotalAtendidos',
        'deposicaoACeuAbertoDomiciliosAtendidos',
        'deposicaoACeuAbertoRuraisAtendidos',
        'deposicaoACeuAbertoEntidadeResponsavel',
        'deposicaoOutroTotalNome',
        'deposicaoOutroTotalAtendidos',
        'deposicaoOutroDomiciliosAtendidos',
        'deposicaoOutroEntidadeResponsavel',
        'reciclagemDeAcoTotalReciclado',
        'reciclagemDeAcoEntidadeResponsavel',
        'reciclagemDeAluminioTotalReciclado',
        'reciclagemDeAluminioEntidadeResponsavel',
        'reciclagemDeFerroTotalReciclado',
        'reciclagemDeFerroEntidadeResponsavel',
        'reciclagemOutroNome',
        'reciclagemOutroTotalReciclado',
        'reciclagemOutroEntidadeResponsavel',
        'reciclagemDeBateriasPilhasTotalReciclado',
        'reciclagemDeBateriasPilhasEntidadeResponsavel',
        'reciclagemDeBorrachaTotalReciclado',
        'reciclagemDeBorrachaEntidadeResponsavel',
        'reciclagemDeEletronicosTotalReciclado',
        'reciclagemDeEletronicosEntidadeResponsavel',
        'reciclagemDeEmbalagensLongaVidaTotalReciclado',
        'reciclagemDeEmbalagensLongaVidaEntidadeResponsavel',
        'reciclagemDeEntulhoTotalReciclado',
        'reciclagemDeEntulhoEntidadeResponsavel',
        'reciclagemDeMadeiraTotalReciclado',
        'reciclagemDeMadeiraEntidadeResponsavel',
        'reciclagemDePapelTotalReciclado',
        'reciclagemDePapelEntidadeResponsavel',
        'reciclagemDePlasticoEEmbalagensTotalReciclado',
        'reciclagemDePlasticoEEmbalagensEntidadeResponsavel',
        'reciclagemDeVidroTotalReciclado',
        'reciclagemDeVidroEntidadeResponsavel',
        'reciclagemDeOleoDeCozinhaTotalReciclado',
        'reciclagemDeOleoDeCozinhaEntidadeResponsavel',
        'reciclagemOutrosNome',
        'reciclagemOutrosTotalReciclado',
        'reciclagemOutrosEntidadeResponsavel',
        'divulgacaoImpressaFolder',
        'divulgacaoImpressaRevista',
        'divulgacaoImpressaJornal',
        'divulgacaoImpressaOutros',
        'visitantesAno',
        'visitantesAnoAltaTemporada',
        'origemInternacionalAnoBase',
        'atrativosMaisVisitados'
  ];
  
  final List<String> _chavesLegislacao = const [
    'leiOrganica',
    'ocupacaoDoSolo',
    'planoDeDesenvolvimentoDoTurismo',
    'protecaoAmbiental',
    'apoioACultura',
    'incentivosFiscaisAoTurismo',
    'planoDiretor',
    'fundoMunicipalDeTurismo',
    'legislacaoOutras',
    'observacoes',
    'referencias'
  ];
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (final key in _chavesInfoGerais) {
      _infoGeraisControllers[key] = TextEditingController();
    }

    for (final key in _chavesCaracteristicas) {
      _caracteristicasControllers[key] = TextEditingController();
    }

    for (final key in _chavesLegislacao){
      _legislacaoControllers[key] = TextEditingController();
    }

    getInfoUsersInPesquisa();

    pages = [
      InformacoesGerais(controllers: _infoGeraisControllers),
      Caracteristicas(controllers: _caracteristicasControllers),
      LegislacaoMunicipal(controllers: _legislacaoControllers,)
    ];
  }

  void _preencherDadosParaTeste() {
    _infoGeraisControllers.forEach((key, controller) {
      // Usamos a 'key' para decidir qual dado de teste colocar
      switch (key) {
        // --- Informações da Prefeitura ---
        case 'uf':
          controller.text = 'CE';
          break;
        case 'regiao_turistica':
          controller.text = 'Jericoacoara';
          break;
        case 'municipio':
          controller.text = 'Jijoca';
          break;
        // case 'enderecoPrefeitura':
        //   controller.text = 'Praça da Matriz, 100';
        //   break;
        case 'bairroPrefeitura':
          controller.text = 'Centro';
          break;
        case 'cepPrefeitura':
          controller.text = '12345000'; // O formatador cuida do '12345-000'
          break;
        case 'numeroPrefeitura':
          controller.text =
              '11987654321'; // O formatador cuida do '(11) 98765-4321'
          break;
        case 'instagramPrefeitura':
          controller.text = '@prefeiturateste';
          break;
        case 'emailPrefeitura':
          controller.text = 'gabinete@prefeiturateste.gov.br';
          break;
        case 'sitePrefeitura':
          controller.text = 'www.prefeiturateste.gov.br';
          break;
        case 'cnpjPrefeitura':
          controller.text =
              '00.139.609/0001-46'; // O formatador cuida do '12.345.678/0001-99'
          break;
        case 'latitudePrefeitura':
          controller.text = '-23.550520'; // Ex: São Paulo
          break;
        case 'longitudePrefeitura':
          controller.text = '-46.633308'; // Ex: São Paulo
          break;
        case 'municipiosLimitrofes':
          controller.text = 'Cidadela, Vilaréjo, Outeiro';
          break;
        case 'distanciaDaCapital':
          controller.text = '150 km';
          break;
        case 'totalFuncionariosPrefeitura':
          controller.text = '450';
          break;
        case 'pessoasComDeficienciaPrefeitura':
          controller.text = '15';
          break;
        case 'nomeDoPrefeito':
          controller.text = 'José Almeida Santos';
          break;
        case 'nomeDasSecretariasEtc':
          controller.text =
              'Secretaria de Turismo, Secretaria de Cultura, Secretaria de Obras';
          break;

        // --- Órgão Oficial de Turismo ---
        case 'nomeOrgaoOficialTurismo':
          controller.text = 'Departamento Municipal de Turismo';
          break;
        case 'enderecoOrgaoOfcTurismo':
          controller.text = 'Rua dos Viajantes, 50';
          break;
        case 'avenidaRuaOfcTurismo': // Assumindo ser um complemento
          controller.text = 'Sala 10';
          break;
        case 'distritoOrgaoOfcTurismo':
          controller.text = 'Distrito Turístico';
          break;
        case 'cepOrgaoOfcTurismo':
          controller.text = '12345100';
          break;
        case 'numeroOrgaoOfcTurismo':
          controller.text = '1122223333';
          break;
        case 'instagramOrgaoOfcTurismo':
          controller.text = '@turismocidadeteste';
          break;
        case 'siteOrgaoOfcTurismo':
          controller.text = 'www.turismoteste.com.br';
          break;
        case 'emailOrgaoOfcTurismo':
          controller.text = 'turismo@prefeiturateste.gov.br';
          break;
        case 'qtdeFuncionariosOrgaoOfcTurismo':
          controller.text = '8';
          break;
        case 'qtdeFormacaoSuperiorEmTurismoOrgaoOfcturismo':
          controller.text = '3';
          break;

        // --- Instâncias de Governança ---
        case 'instanciaGovernancaMunicipal':
          controller.text = 'Conselho Municipal de Turismo (COMTUR)';
          break;
        case 'instanciaGovernancaEstadual':
          controller.text = 'Secretaria de Turismo do Estado';
          break;
        case 'instanciaGovernancaRegional':
          controller.text = 'Circuito Turístico Águas da Serra';
          break;
        case 'instanciaGovernancaNacional':
          controller.text = 'Ministério do Turismo';
          break;
        case 'instanciaGovernancaInternacional':
          controller.text = 'Organização Mundial do Turismo (OMT)';
          break;
        case 'instanciaGovernancaOutras':
          controller.text = 'Associação Comercial e Industrial';
          break;

        // --- Datas e Feriados (no formato DD/MM/AAAA para o CustomTextDate) ---
        case 'aniversarioMunicipio':
          controller.text = '29/07/1901'; // Formato correto para a máscara
          break;
        case 'dataFeriadoMunicipal01':
          controller.text = '29/10/1901'; // Formato correto para a máscara
          break;
        case 'dataFeriadoMunicipal02':
          controller.text = '09/07/1901'; // Formato correto para a máscara
          break;
        case 'dataFeriadoMunicipal03':
          controller.text = '19/07/1901'; // Formato correto para a máscara
          break;
        case 'santoPadroeiro':
          controller.text = 'São Sebastião';
          break;
        case 'diaDoSantoPadroeiro':
          controller.text = '20/01/2025'; // Formato correto para a máscara
          break;
        case 'feriadoMunicipal01':
          controller.text = 'Corpus Christi';
          break;
        case 'feriadoMunicipal02':
          controller.text = 'Dia da Consciência Negra';
          break;
        case 'feriadoMunicipal03':
          controller.text = 'Sexta-feira Santa';
          break;

        // --- Dados Históricos ---
        case 'origemDoNome':
          controller.text =
              'O nome da cidade deriva do Tupi-Guarani, significando "rio das pedras".';
          break;
        case 'dataFundacao':
          controller.text = '25/01/1875'; // Formato correto para a máscara
          break;
        case 'dataEmancipacao':
          controller.text = '30/07/1925'; // Formato correto para a máscara
          break;
        case 'fundadores':
          controller.text = 'Bandeirantes da família Bueno de Camargo';
          break;
        case 'outrosFatosDeImportanciaHistorica':
          controller.text =
              'A cidade foi um importante polo cafeeiro no início do século XX e rota de tropeiros.';
          break;

        // Caso algum campo novo seja adicionado e não esteja no switch
        default:
          controller.text = 'Dado de Teste Padrão';
          break;
      }
    });
    
  }

void _preencherDadosParaTeste2() {
      _caracteristicasControllers.forEach((key, controller) {
      // Usamos a 'key' para decidir qual dado de teste colocar
      switch (key) {
        // --- Informações da Prefeitura ---
        case 'uf':
          controller.text = 'CE';
          break;
        case 'areaTotalMunicipio':
          controller.text = '500';
          break;
        case 'areaUrbana':
          controller.text = '50';
          break;
        case 'areaRural':
          controller.text = '450';
          break;
        case 'anoBase':
          controller.text = '2023';
          break;
        case 'populacaoTotal':
          controller.text = '10000';
          break;
        case 'populacaoUrbana':
          controller.text = '8000';
          break;
        case 'populacaoRural':
          controller.text = '2000';
          break;
        case 'anoBasePopulacao':
          controller.text = '2023';
          break;
        case 'temperaturaMedia':
          controller.text = '25.5';
          break;
        case 'temperaturaMinima':
          controller.text = '20.0';
          break;
        case 'temperaturaMaxima':
          controller.text = '32.0';
          break;
        case 'altitudeMedia':
          controller.text = '150';
          break;
        case 'qtdeDomiciliosAtendidos':
          controller.text = '2500';
          break;
        case 'empresaResponsavel':
          controller.text = 'SAAE';
          break;
        case 'esgotoTotalAtendidos':
          controller.text = '1800';
          break;
        case 'esgotoDomiciliosAtendidos':
          controller.text = '1500';
          break;
        case 'esgotoRuraisAtendidos':
          controller.text = '300';
          break;
        case 'esgotoEntidadeResponsavel':
          controller.text = 'SAAE Esgoto';
          break;
        case 'fossaSepticaTotalAtendidos':
          controller.text = '500';
          break;
        case 'fossaSepticaDomiciliosAtendidos':
          controller.text = '400';
          break;
        case 'fossaSepticaRuraisAtendidos':
          controller.text = '100';
          break;
        case 'fossaSepticaEntidadeResponsavel':
          controller.text = 'Privada';
          break;
        case 'fossaRudimentarTotalAtendidos':
          controller.text = '200';
          break;
        case 'fossaRudimentarDomiciliosAtendidos':
          controller.text = '150';
          break;
        case 'fossaRudimentarRuraisAtendidos':
          controller.text = '50';
          break;
        case 'fossaRudimentarEntidadeResponsavel':
          controller.text = 'Própria';
          break;
        case 'valaTotalAtendidos':
          controller.text = '100';
          break;
        case 'valaDomiciliosAtendidos':
          controller.text = '80';
          break;
        case 'valaRuraisAtendidos':
          controller.text = '20';
          break;
        case 'valaEntidadeResponsavel':
          controller.text = 'Nenhuma';
          break;
        case 'estacaoDeTratamentoTotalAtendidos':
          controller.text = '1000';
          break;
        case 'estacaoDeTratamentoDomiciliosAtendidos':
          controller.text = '900';
          break;
        case 'estacaoDeTratamentoRuraisAtendidos':
          controller.text = '100';
          break;
        case 'estacaoDeTratamentoEntidadeResponsavel':
          controller.text = 'SAAE Esgoto';
          break;
        case 'esgotoTratadoTotalAtendidos':
          controller.text = '1000';
          break;
        case 'esgotoTratadoDomiciliosAtendidos':
          controller.text = '900';
          break;
        case 'esgotoTratadoRuraisAtendidos':
          controller.text = '100';
          break;
        case 'esgotoTratadoEntidadeResponsavel':
          controller.text = 'SAAE Esgoto';
          break;
        case 'servicoDeEsgotoOutroTotalNome':
          controller.text = 'Caminhão Limpa-Fossa';
          break;
        case 'servicoDeEsgotoOutroTotalAtendidos':
          controller.text = '50';
          break;
        case 'servicoDeEsgotoOutroDomiciliosAtendidos':
          controller.text = '40';
          break;
        case 'servicoDeEsgotoOutroRuraisAtendidos':
          controller.text = '10';
          break;
        case 'servicoDeEsgotoOutroEntidadeResponsavel':
          controller.text = 'Terceirizada';
          break;
        case 'capacidadeEmKVA':
          controller.text = '50000';
          break;
        case 'geradorDeEmergenciaCapacidadeEmKVA':
          controller.text = '1000';
          break;
        case 'redeUrbanaTotalAbastecido':
          controller.text = '7500';
          break;
        case 'redeUrbanaEntidadeResponsavel':
          controller.text = 'ENEL';
          break;
        case 'redeRuralTotalAbastecido':
          controller.text = '1800';
          break;
        case 'redeRuralEntidadeResponsavel':
          controller.text = 'COELCE';
          break;
        case 'abastecimentoProprioTotalAtendidos':
          controller.text = '500';
          break;
        case 'abastecimentoProprioDomiciliosAtendidos':
          controller.text = '400';
          break;
        case 'abastecimentoProprioRuraisAtendidos':
          controller.text = '100';
          break;
        case 'abastecimentoProprioEntidadeResponsavel':
          controller.text = 'Própria';
          break;
        case 'servicosDeEnergiaOutroTotalNome':
          controller.text = 'Energia Solar';
          break;
        case 'servicosDeEnergiaOutroTotalAtendidos':
          controller.text = '200';
          break;
        case 'servicosDeEnergiaOutroDomiciliosAtendidos':
          controller.text = '150';
          break;
        case 'servicosDeEnergiaOutroEntidadeResponsavel':
          controller.text = 'Empresa Privada';
          break;
        case 'coletaSeletivaTotalAtendidos':
          controller.text = '2000';
          break;
        case 'coletaSeletivaDomiciliosAtendidos':
          controller.text = '1800';
          break;
        case 'coletaSeletivaRuraisAtendidos':
          controller.text = '200';
          break;
        case 'coletaSeletivaEntidadeResponsavel':
          controller.text = 'COOPLIX';
          break;
        case 'coletaNaoSeletivaTotalAtendidos':
          controller.text = '8000';
          break;
        case 'coletaNaoSeletivaDomiciliosAtendidos':
          controller.text = '6000';
          break;
        case 'coletaNaoSeletivaRuraisAtendidos':
          controller.text = '2000';
          break;
        case 'coletaNaoSeletivaEntidadeResponsavel':
          controller.text = 'Prefeitura';
          break;
        case 'coletaSemColetaTotal':
          controller.text = '1000';
          break;
        case 'coletaSemColetaDomicilios':
          controller.text = '500';
          break;
        case 'coletaSemColetaRurais':
          controller.text = '500';
          break;
        case 'deposicaoAterroSanitarioTotalAtendidos':
          controller.text = '7000';
          break;
        case 'deposicaoAterroSanitarioDomiciliosAtendidos':
          controller.text = '6000';
          break;
        case 'deposicaoAterroSanitarioRuraisAtendidos':
          controller.text = '1000';
          break;
        case 'deposicaoAterroSanitarioEntidadeResponsavel':
          controller.text = 'Prefeitura';
          break;
        case 'deposicaoACeuAbertoTotalAtendidos':
          controller.text = '2000';
          break;
        case 'deposicaoACeuAbertoDomiciliosAtendidos':
          controller.text = '1500';
          break;
        case 'deposicaoACeuAbertoRuraisAtendidos':
          controller.text = '500';
          break;
        case 'deposicaoACeuAbertoEntidadeResponsavel':
          controller.text = 'Nenhuma';
          break;
        case 'deposicaoOutroTotalNome':
          controller.text = 'Incinerador';
          break;
        case 'deposicaoOutroTotalAtendidos':
          controller.text = '500';
          break;
        case 'deposicaoOutroDomiciliosAtendidos':
          controller.text = '400';
          break;
        case 'deposicaoOutroEntidadeResponsavel':
          controller.text = 'Privada';
          break;
        case 'reciclagemDeAcoTotalReciclado':
          controller.text = '1500';
          break;
        case 'reciclagemDeAcoEntidadeResponsavel':
          controller.text = 'RECICLAÇO';
          break;
        case 'reciclagemDeAluminioTotalReciclado':
          controller.text = '2000';
          break;
        case 'reciclagemDeAluminioEntidadeResponsavel':
          controller.text = 'COOPLIX';
          break;
        case 'reciclagemDeFerroTotalReciclado':
          controller.text = '3000';
          break;
        case 'reciclagemDeFerroEntidadeResponsavel':
          controller.text = 'RECICLAÇO';
          break;
        case 'reciclagemOutroNome':
          controller.text = 'Pneus';
          break;
        case 'reciclagemOutroTotalReciclado':
          controller.text = '500';
          break;
        case 'reciclagemOutroEntidadeResponsavel':
          controller.text = 'ECOPNEU';
          break;
        case 'reciclagemDeBateriasPilhasTotalReciclado':
          controller.text = '200';
          break;
        case 'reciclagemDeBateriasPilhasEntidadeResponsavel':
          controller.text = 'Prefeitura';
          break;
        case 'reciclagemDeBorrachaTotalReciclado':
          controller.text = '800';
          break;
        case 'reciclagemDeBorrachaEntidadeResponsavel':
          controller.text = 'ECOPNEU';
          break;
        case 'reciclagemDeEletronicosTotalReciclado':
          controller.text = '400';
          break;
        case 'reciclagemDeEletronicosEntidadeResponsavel':
          controller.text = 'Prefeitura';
          break;
        case 'reciclagemDeEmbalagensLongaVidaTotalReciclado':
          controller.text = '100';
          break;
        case 'reciclagemDeEmbalagensLongaVidaEntidadeResponsavel':
          controller.text = 'COOPLIX';
          break;
        case 'reciclagemDeEntulhoTotalReciclado':
          controller.text = '5000';
          break;
        case 'reciclagemDeEntulhoEntidadeResponsavel':
          controller.text = 'Prefeitura';
          break;
        case 'reciclagemDeMadeiraTotalReciclado':
          controller.text = '1200';
          break;
        case 'reciclagemDeMadeiraEntidadeResponsavel':
          controller.text = 'Serralheria';
          break;
        case 'reciclagemDePapelTotalReciclado':
          controller.text = '2500';
          break;
        case 'reciclagemDePapelEntidadeResponsavel':
          controller.text = 'COOPLIX';
          break;
        case 'reciclagemDePlasticoEEmbalagensTotalReciclado':
          controller.text = '3500';
          break;
        case 'reciclagemDePlasticoEEmbalagensEntidadeResponsavel':
          controller.text = 'COOPLIX';
          break;
        case 'reciclagemDeVidroTotalReciclado':
          controller.text = '1800';
          break;
        case 'reciclagemDeVidroEntidadeResponsavel':
          controller.text = 'COOPLIX';
          break;
        case 'reciclagemDeOleoDeCozinhaTotalReciclado':
          controller.text = '300';
          break;
        case 'reciclagemDeOleoDeCozinhaEntidadeResponsavel':
          controller.text = 'COOPLIX';
          break;
        case 'reciclagemOutrosNome':
          controller.text = 'Diversos';
          break;
        case 'reciclagemOutrosTotalReciclado':
          controller.text = '500';
          break;
        case 'reciclagemOutrosEntidadeResponsavel':
          controller.text = 'COOPLIX';
          break;
        case 'divulgacaoImpressaFolder':
          controller.text = 'Sim';
          break;
        case 'divulgacaoImpressaRevista':
          controller.text = 'Sim';
          break;
        case 'divulgacaoImpressaJornal':
          controller.text = 'Não';
          break;
        case 'divulgacaoImpressaOutros':
          controller.text = 'Online';
          break;
        case 'visitantesAno':
          controller.text = '50000';
          break;
        case 'visitantesAnoAltaTemporada':
          controller.text = '20000';
          break;
        case 'origemInternacionalAnoBase':
          controller.text = '1000';
          break;
        case 'atrativosMaisVisitados':
          controller.text = 'Praia, Centro Histórico';
          break;
      }
    });
}
  
  void _preencherDadosParaTeste3() {
    _legislacaoControllers.forEach((key, controller) {
      // Usamos a 'key' para decidir qual dado de teste colocar
      switch (key) {
        // --- Informações da Prefeitura ---
        case 'leiOrganica':
          controller.text = 'Sim';
          break;
        case 'ocupacaoDoSolo':
          controller.text = 'Existe regulamentação para uso e ocupação do solo.';
          break;
        case 'planoDeDesenvolvimentoDoTurismo':
          controller.text = 'Sim';
          break;
        case 'protecaoAmbiental':
          controller.text = 'Código Ambiental Municipal em vigor.';
          break;
        case 'apoioACultura':
          controller.text = 'Plano Municipal de Cultura e Fundo de Cultura ativos.';
          break;
        case 'incentivosFiscaisAoTurismo':
          controller.text = 'Redução de ISS para novas empresas do setor de turismo.';
          break;
        case 'planoDiretor':
          controller.text = 'Sim';
          break;
        case 'fundoMunicipalDeTurismo':
          controller.text = 'Fundo Municipal de Turismo (FUMTUR) ativo.';
          break;
        case 'legislacaoOutras':
          controller.text = 'Lei de proteção do patrimônio histórico.';
          break;
        case 'observacoes':
          controller.text = 'Observações adicionais sobre as legislações em vigor.';
          break;
        case 'referencias':
          controller.text = 'Prefeitura Municipal, Diário Oficial do Município.';
          break;
      }
    });
}
  @override
  void dispose() {
    for (final controller in _infoGeraisControllers.values) {
      controller.dispose();
    }
    for (final controller in _caracteristicasControllers.values) {
      controller.dispose();
    }
    for(final controller in _legislacaoControllers.values){
      controller.dispose();
    }
    super.dispose();
  }

  void _enviarFormulario() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState!.save();

      _infoGeraisControllers.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });

      _caracteristicasControllers.forEach((key, controller) {
          valoresJson[key] = controller.text;
      },);

      _legislacaoControllers.forEach((key, value) {
        valoresJson[key] = value.text;
      },);
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
        print("Formulário finalizado e pronto para enviar!");
        //Navigator.pushNamed(context, '/SendedForm');
        FormService().sendForm(valoresJson, AppConstants.INFO_BASICA_CREATE);
        // _enviarFormulario(); // Você pode chamar sua função de envio aqui
      }

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Formulário enviado com sucesso!')));
    } else {
      _formKey.currentState!.save();
      _caracteristicasControllers.forEach((key, controllers) {
        valoresJson[key] = controllers.text;
      },);
  
      _infoGeraisControllers.forEach((key, controller) {
        valoresJson[key] = controller.text;
      });
      _legislacaoControllers.forEach((key, value) {
        valoresJson[key] = value.text;
      },);
          valoresJson.forEach(
        (key, value) {
          print("$key  - $value");
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Por favor, corrija os erros no formulário.')));
    }
  }

  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: DotsIndicator(dotsCount: pages.length,
          position: currentStep.toDouble(),
          decorator: DotsDecorator(activeColor: Colors.white,
          activeSize: Size(18, 9)
          ),

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
            )),
        bottomNavigationBar:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // Botão Voltar
          if (currentStep > 0)
            TextButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: const Text('VOLTAR'),
            ),
          // Espaçador para alinhar o botão Continuar à direita quando não houver o Voltar
          if (currentStep == 0) const Spacer(),

          // Botão Continuar / Finalizar
          Container(
            height: 160.h,
            width: 550.w,
            margin: EdgeInsets.only(right: 55.h, bottom: 55.h),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 55, 111, 60)),
              onPressed: () {
                _preencherDadosParaTeste();
                _preencherDadosParaTeste2();
                _preencherDadosParaTeste3();
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

class Identificacao extends StatelessWidget {
  final Map<String, TextEditingController> controllers;

  const Identificacao(
      {super.key, required this.onSaved, required this.controllers});
  final void Function(String?) onSaved;
  @override
  Widget build(Object context) {
    // TODO: implement build
    return Column(
      children: [
        UfMunicipioRg(controllers: controllers),

        SizedBox(
          height: 55.h,
        ),
        textLabel(
          name: "Tipo:",
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          height: 35.h,
        ),

        RadioFormField(
            options: ['Caracterização do município'], onSaved: onSaved)

        // RadioD(
        //   validator: (p0) {
        //     if(p0==null || p0.isEmpty){
        //       return 'Por favor, selecione uma opção';
        //     }
        //     return null;
        //   },
        //   options: ["Caracterização do município"],
        //   getValue: (p0) => valoresjson['tipo'] = p0,
        // )
      ],
    );
  }
}

class InformacoesGerais extends StatelessWidget {
  final Map<String, TextEditingController> controllers;

  const InformacoesGerais({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    // TODO: implement build
    final formWidgts = <Widget>[
      Identificacao(
        onSaved: (p0) => valoresJson['tipo'] = p0,
        controllers: controllers,
      ),
      SizedBox(
        height: 65.h,
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
      SizedBox(
        height: 65.h,
      ),
      textLabel(
        name: "Endereço da Prefeitura",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: controllers['enderecoPrefeitura'],
        name: "Avenida/rua/travessa/caminho/outro",
      ),
      CustomTextField(
        controller: controllers['bairroPrefeitura'],
        name: "Bairro",
      ),
      CustomTextField(
        controller: controllers['cepPrefeitura'],
        formatter: [
          FilteringTextInputFormatter.digitsOnly,
          _validators.cepFormatter
        ],
        name: 'CEP',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Whatsapp/Instagram",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        formatter: [
          FilteringTextInputFormatter.digitsOnly,
          _validators.phoneFormatter
        ],
        controller: controllers['numeroPrefeitura'],
        name: 'Número',
      ),
      CustomTextField(
        controller: controllers['instagramPrefeitura'],
        name: 'Instagram',
      ),
      CustomTextField(
        controller: controllers['emailPrefeitura'],
        name: 'E-mail',
      ),
      CustomTextField(
        name: 'Site Prefeitura',
        controller: controllers['sitePrefeitura'],
      ),
      CustomTextField(
        keyboardType: TextInputType.numberWithOptions(),
        controller: controllers['cnpjPrefeitura'],
        name: 'CNPJ',
        validat: _validators.validarCNPJ,
        formatter: [_validators.cnpjFormatter],
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
        formatter: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))],
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
        name: "Municípios Limítrofes",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: controllers['municipiosLimitrofes'],
        name: "Municípios",
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Distância da Capital (km)",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: controllers['distanciaDaCapital'],
        name: "(km)",
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      SizedBox(
        height: 55.w,
      ),
      textLabel(
        name: "Quantidade de Funcionários",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: controllers['totalFuncionariosPrefeitura'],
        name: "Total (nº)",
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        controller: controllers['pessoasComDeficienciaPrefeitura'],
        name: "Pessoas com deficiência (%)",
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Nome do Prefeito",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: controllers['nomeDoPrefeito'],
        name: 'Nome',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Nomes das secretarias, departamentos e outro",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: controllers['nomeDasSecretariasEtc'],
        name: 'Nome(s)',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Nome do Orgão Oficial de Turismo",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: "Nome",
        controller: controllers['nomeOrgaoOficialTurismo'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: "Endereço"),
      CustomTextField(
        controller: controllers['enderecoOrgaoOfcTurismo'],
        name: "Avenida/rua/travessa/caminho/outro",
      ),
      CustomTextField(
        controller: controllers['avenidaRuaOfcTurismo'],
        name: "Bairro/localidade",
      ),
      CustomTextField(
        controller: controllers['distritoOrgaoOfcTurismo'],
        name: "Distrito",
      ),
      CustomTextField(
        controller: controllers['cepOrgaoOfcTurismo'],
        formatter: [
          FilteringTextInputFormatter.digitsOnly,
          _validators.cepFormatter
        ],
        name: 'CEP',
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Número/Instagram",
      ),
      CustomTextField(
        formatter: [
          FilteringTextInputFormatter.digitsOnly,
          _validators.phoneFormatter
        ],
        controller: controllers['numeroOrgaoOfcTurismo'],
        name: 'Número',
      ),
      CustomTextField(
        controller: controllers['instagramOrgaoOfcTurismo'],
        name: 'Instagram',
      ),
      CustomTextField(
        controller: controllers['emailOrgaoOfcTurismo'],
        name: 'E-mail',
      ),
      CustomTextField(
        name: 'Site',
        controller: controllers['siteOrgaoOfcTurismo'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Quantidade de Funcionários",
      ),
      CustomTextField(
        controller: controllers['qtdeFuncionariosOrgaoOfcTurismo'],
        name: "Total (nº)",
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        controller: controllers['qtdeFormacaoSuperiorEmTurismoOrgaoOfcturismo'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        name: "Formação superior em Turismo (nº)",
        keyboardType: TextInputType.numberWithOptions(),
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Instâncias de Governança, Associativas, Parcerias e Outros",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: controllers["instanciaGovernancaMunicipal"],
        name: "Municipal",
      ),
      CustomTextField(
        controller: controllers["instanciaGovernancaEstadual"],
        name: "Estadual",
      ),
      CustomTextField(
        controller: controllers["instanciaGovernancaRegional"],
        name: "Regional",
      ),
      CustomTextField(
        controller: controllers["instanciaGovernancaNacional"],
        name: "Nacional",
      ),
      CustomTextField(
        controller: controllers["instanciaGovernancaInternacional"],
        name: "Internacional",
      ),
      CustomTextField(
        controller: controllers["instanciaGovernancaOutras"],
        name: "Outras",
      ),
      SizedBox(
        height: 55.h,
      ),
      Row(
        children: [
          textLabel(
            name: 'Aniversário \ndo\nMunicípio',
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            width: sizeScreen.width * 0.1,
          ),
          SizedBox(
              width: sizeScreen.width * 0.4,
              //height: sizeScreen.height * 0.07,
              child: CustomTextDate(
                dateController: controllers['aniversarioMunicipio'],
              )),
        ],
      ),
      SizedBox(
        height: 75.h,
      ),
      textLabel(
        name: "Santo(a) Padroeiro(a)",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: "Nome do(a) Santo(a) Padroeiro(a)",
        controller: controllers['santoPadroeiro'],
      ),
      SizedBox(
        height: 55.h,
      ),
      Row(
        children: [
          textLabel(
            name: 'Dia do(a)\nSanto(a)\nPadroeiro(a)',
          ),
          SizedBox(
            width: sizeScreen.width * 0.1,
          ),
          SizedBox(
              width: sizeScreen.width * 0.4,
              //height: sizeScreen.height * 0.07,
              child: CustomTextDate(
                dateController: controllers['diaDoSantoPadroeiro'],
              )),
        ],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Outros feriados municipais",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        name: 'Feriado ',
        controller: controllers['feriadoMunicipal01'],
      ),
      CustomTextDate(
        dateController: controllers['dataFeriadoMunicipal01'],
      ),
      CustomTextField(
        name: 'Feriado',
        controller: controllers['feriadoMunicipal02'],
      ),
      CustomTextDate(
        dateController: controllers['dataFeriadoMunicipal02'],
      ),
      CustomTextField(
        name: 'Feriado',
        controller: controllers['feriadoMunicipal03'],
      ),
      CustomTextDate(
        dateController: controllers['dataFeriadoMunicipal03'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "História do Município",
        fontWeight: FontWeight.bold,
      ),
      CustomTextField(
        controller: controllers['origemDoNome'],
        name: "Origem do Nome",
      ),
      Row(
        children: [
          textLabel(
            name: 'Data \nda\nFundação',
          ),
          SizedBox(
            width: sizeScreen.width * 0.1,
          ),
          SizedBox(
              width: sizeScreen.width * 0.4,
              //height: sizeScreen.height * 0.07,
              child: CustomTextDate(
                dateController: controllers['dataFundacao'],
              )),
        ],
      ),
      SizedBox(
        height: 55.h,
      ),
      Row(
        children: [
          textLabel(
            name: 'Data \nda\nEmancipação',
          ),
          SizedBox(
            width: sizeScreen.width * 0.1,
          ),
          SizedBox(
              width: sizeScreen.width * 0.4,
              //height: sizeScreen.height * 0.07,
              child: CustomTextDate(
                dateController: controllers['dataEmancipacao'],
              )),
        ],
      ),
      CustomTextField(
        controller: controllers['fundadores'],
        name: "Fundadores",
      ),
      CustomTextField(
        controller: controllers['outrosFatosDeImportanciaHistorica'],
        name: "Outros fatos de importância histórica",
      )
    ];

    return SingleChildScrollView(
      child: Column(
        children: formWidgts,
      ),
    );
  }
}

class Caracteristicas extends StatefulWidget {
  final Map<String, TextEditingController> controllers;

  const Caracteristicas({super.key, required this.controllers});

  @override
  State<Caracteristicas> createState() => _CaracteristicasState();
}

class _CaracteristicasState extends State<Caracteristicas> {
  final PesquisaController _pesquisaController = PesquisaController();

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

    // TODO: implement build
    final List<Widget> listaWidgets = [
      Container(
        color: const Color.fromARGB(255, 55, 111, 60),
        height: sizeScreen.height * 0.06,
        width: sizeScreen.width,
        padding: EdgeInsets.only(
            top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
        child: Text(
          'Caracteristicas',
          style: TextStyle(
              color: Colors.white, fontSize: sizeScreen.height * 0.03),
        ),
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Aspectos Gerais',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Área',
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        controller: widget.controllers['areaTotalMunicipio'],
        keyboardType: TextInputType.numberWithOptions(),
        name: "Área Total do Município (km²)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['areaUrbana'],
        name: "Área Urbana (km²)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['areaRural'],
        name: "Área Rural (km²)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['anoBase'],
        name: "Ano-Base",
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'População',
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        controller: widget.controllers['populacaoTotal'],
        keyboardType: TextInputType.numberWithOptions(),
        name: "População Total (nº hab.)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['populacaoUrbana'],
        name: "População Urbana (nº hab.)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['populacaoRural'],
        name: "População Rural (nº hab.)",
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
        controller: widget.controllers['anoBasePopulacao'],
        name: "Ano-Base",
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Temperatura e Chuvas'),
      CustomTextField(
        controller: widget.controllers['temperaturaMedia'],
        name: 'Média (ºC)',
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        controller: widget.controllers['temperaturaMinima'],
        name: 'Mínima (ºC)',
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        formatter: [FilteringTextInputFormatter.digitsOnly],
        controller: widget.controllers['temperaturaMaxima'],
        name: 'Máxima (ºC)',
        keyboardType: TextInputType.numberWithOptions(),
      ),
      SizedBox(
        height: sizeScreen.height * 0.02,
      ),
      textLabel(
        name: 'Meses Mais Frios',
      ),
      SizedBox(
        height: sizeScreen.height * 0.01,
      ),
      CheckboxGroupFormField(
        onSaved: (p0) => valoresJson['mesesMaisFrios'] = p0,
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
      ),
      textLabel(name: 'Meses Mais Quentes'),
      SizedBox(
        height: 55.h,
      ),
      CheckboxGroupFormField(
        onSaved: (p0) => valoresJson['mesesMaisQuentes'] = p0,
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
      ),
      textLabel(name: 'Meses Mais Chuvosos'),
      SizedBox(
        height: 55.h,
      ),
      CheckboxGroupFormField(
        onSaved: (p0) => valoresJson['mesesMaisChuvosos'] = p0,
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
      ),
      textLabel(name: 'Meses Menos Chuvosos'),
      SizedBox(
        height: 55.h,
      ),
      CheckboxGroupFormField(
        onSaved: (p0) => valoresJson['mesesMenosChuvosos'] = p0,
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
      ),
      CustomTextField(
        name: "Altitude Média (em m)",
        controller: widget.controllers['altitudeMedia'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Equipamentos, instalações e serviços públicos",
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: "Abastecimento de Água",
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Tipo de Abastecimento'),
      SizedBox(
        height: 55.h,
      ),
      RadioFormField(
          onSaved: (newValue) => valoresJson['tipoDeAbastecimento'] = newValue,
          options: [
            'Água Não Canalizada',
            'Canalizada de Poço',
            'Canalizada de Nascente',
            'Canalizada de Curso de Água/Barragem',
            'outro'
          ]),
      CustomTextField(
        name: 'Domicílios Atendidos (%)',
        controller: widget.controllers['qtdeDomiciliosAtendidos'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      CustomTextField(
        name: 'Empresa Responsável',
        controller: widget.controllers['empresaResponsavel'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Serviços de Esgoto',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Coleta e Deposição'),
      ConditionalFieldsGroup(
          title: 'Rede de Esgoto',
          jsonKey: 'redeDeEsgoto',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['esgotoTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller: widget.controllers['esgotoDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller: widget.controllers['esgotoRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers['esgotoEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Fossa Séptica',
          jsonKey: 'fossaSeptica',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['fossaSepticaTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller: widget.controllers['fossaSepticaDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller: widget.controllers['fossaSepticaRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers['fossaSepticaEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Fossa Rudimentar',
          jsonKey: 'fossaRudimentar',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['fossaRudimentarTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['fossaRudimentarDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller: widget.controllers['fossaRudimentarRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['fossaRudimentarEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(title: 'Vala', jsonKey: 'vala', children: [
        CustomTextField(
          name: 'Total Atendido (%)',
          controller: widget.controllers['valaTotalAtendidos'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Domicílios Urbanos Atendidos (%)',
          controller: widget.controllers['valaDomiciliosAtendidos'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Domicílios Rurais Atendidos (%)',
          controller: widget.controllers['valaRuraisAtendidos'],
          formatter: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.numberWithOptions(),
        ),
        CustomTextField(
          name: 'Entidade Responsável',
          controller: widget.controllers['valaEntidadeResponsavel'],
        )
      ]),
      ConditionalFieldsGroup(
          title: 'Estação de Tratamento',
          jsonKey: 'estacaoDeTratamento',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['estacaoDeTratamentoTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['estacaoDeTratamentoDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['estacaoDeTratamentoRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['estacaoDeTratamentoEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Esgoto Tratado',
          jsonKey: 'esgotoTratado',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['esgotoTratadoTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['esgotoTratadoDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller: widget.controllers['esgotoTratadoRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['esgotoTratadoEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Outros',
          jsonKey: 'servicoDeEsgotoOutros',
          children: [
            CustomTextField(
              name: 'Nome',
              controller: widget.controllers['servicoDeEsgotoOutroTotalNome'],
            ),
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['servicoDeEsgotoOutroTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['servicoDeEsgotoOutroDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['servicoDeEsgotoOutroRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['servicoDeEsgotoOutroEntidadeResponsavel'],
            )
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Serviços de Energia',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Energia Elétrica'),
      RadioFormField(
          onSaved: (newValue) => valoresJson['energiaEletrica'] = newValue,
          options: ['110 Volts', '220 Volts', '110/220 Volts']),
      CustomTextField(
        name: 'Capacidade em KVA',
        controller: widget.controllers['capacidadeEmKVA'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.numberWithOptions(),
      ),
      ConditionalFieldsGroup(
          title: 'Gerador de Emergẽncia',
          jsonKey: 'geradorDeEmergencia',
          children: [
            CustomTextField(
              name: 'Capacidade em KVA',
              controller:
                  widget.controllers['geradorDeEmergenciaCapacidadeEmKVA'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            )
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Abastecimento de Energia',
        fontWeight: FontWeight.bold,
      ),
      ConditionalFieldsGroup(
          title: 'Rede Urbana',
          jsonKey: 'redeUrbana',
          children: [
            CustomTextField(
              name: 'Total Abastecido (%)',
              controller: widget.controllers['redeUrbanaTotalAbastecido'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers['redeUrbanaEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Rede Rural',
          jsonKey: 'redeRural',
          children: [
            CustomTextField(
              name: 'Total Abastecido (%)',
              controller: widget.controllers['redeRuralTotalAbastecido'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers['redeRuralEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Abastecimento Próprio',
          jsonKey: 'abastecimentoProprio',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['abastecimentoProprioTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['abastecimentoProprioDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['abastecimentoProprioRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['abastecimentoProprioEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Outros',
          jsonKey: 'servicosDeEnergiaOutro',
          children: [
            CustomTextField(
              name: 'Nome',
              controller: widget.controllers['servicosDeEnergiaOutroTotalNome'],
            ),
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['servicosDeEnergiaOutroTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller: widget
                  .controllers['servicosDeEnergiaOutroDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget
                  .controllers['servicosDeEnergiaOutroEntidadeResponsavel'],
            ),
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Serviços de Lixo',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Coleta',
        fontWeight: FontWeight.bold,
      ),
      ConditionalFieldsGroup(
          title: 'Seletiva',
          jsonKey: 'coletaSeletiva',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['coletaSeletivaTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['coletaSeletivaDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller: widget.controllers['coletaSeletivaRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['coletaSeletivaEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Não Seletiva',
          jsonKey: 'coletaNaoSeletiva',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['coletaNaoSeletivaTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['coletaNaoSeletivaDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['coletaNaoSeletivaRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['coletaNaoSeletivaEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Sem Coleta',
          jsonKey: 'coletaSemColeta',
          children: [
            CustomTextField(
              name: 'Total de lixo sem coleta (%)',
              controller: widget.controllers['coletaSemColetaTotal'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios urbanos sem coleta (%)',
              controller: widget.controllers['coletaSemColetaDomicilios'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios rurais sem coleta (%)',
              controller: widget.controllers['coletaSemColetaRurais'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Deposição e tratamento',
        fontWeight: FontWeight.bold,
      ),
      ConditionalFieldsGroup(
          title: 'Aterro Sanitário',
          jsonKey: 'deposicaoAterroSanitario',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['deposicaoAterroSanitarioTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller: widget
                  .controllers['deposicaoAterroSanitarioDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['deposicaoAterroSanitarioRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget
                  .controllers['deposicaoAterroSanitarioEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Compostagem',
          jsonKey: 'deposicaoCompostagem',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['deposicaoAterroSanitarioTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller: widget
                  .controllers['deposicaoAterroSanitarioDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['deposicaoAterroSanitarioRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget
                  .controllers['deposicaoAterroSanitarioEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'A Céu Aberto (lixão)',
          jsonKey: 'deposicaoACeuAberto',
          children: [
            CustomTextField(
              name: 'Total Atendido (%)',
              controller:
                  widget.controllers['deposicaoACeuAbertoTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['deposicaoACeuAbertoDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Rurais Atendidos (%)',
              controller:
                  widget.controllers['deposicaoACeuAbertoRuraisAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['deposicaoACeuAbertoEntidadeResponsavel'],
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Outros',
          jsonKey: 'deposicaoOutro',
          children: [
            CustomTextField(
              name: 'Nome',
              controller: widget.controllers['deposicaoOutroTotalNome'],
            ),
            CustomTextField(
              name: 'Total Atendido (%)',
              controller: widget.controllers['deposicaoOutroTotalAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Domicílios Urbanos Atendidos (%)',
              controller:
                  widget.controllers['deposicaoOutroDomiciliosAtendidos'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.numberWithOptions(),
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['deposicaoOutroEntidadeResponsavel'],
            ),
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Reciclagem',
        fontWeight: FontWeight.bold,
      ),
      ConditionalFieldsGroup(
          title: 'De Aço',
          jsonKey: 'reciclagemDeAco',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemDeAcoTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeAcoEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De Alumínio',
          jsonKey: 'reciclagemDeAluminio',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeAluminioTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeAluminioEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De Ferro',
          jsonKey: 'reciclagemDeFerro',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemDeFerroTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeFerroEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'Outro Metal',
          jsonKey: 'reciclagemOutro',
          children: [
            CustomTextField(
              name: 'Nome',
              controller: widget.controllers['reciclagemOutroNome'],
            ),
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemOutroTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemOutroEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De Baterias e Pilhas',
          jsonKey: 'reciclagemDeBateriasPilhas',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget
                  .controllers['reciclagemDeBateriasPilhasTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget
                  .controllers['reciclagemDeBateriasPilhasEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De Borracha',
          jsonKey: 'reciclagemDeBorracha',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeBorrachaTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeBorrachaEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De Eletrônicos',
          jsonKey: 'reciclagemDeEletronicos',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeEletronicosTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget
                  .controllers['reciclagemDeEletronicosEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De Embalagens\nLonga Vida',
          jsonKey: 'reciclagemDeEmbalagensLongaVida',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget
                  .controllers['reciclagemDeEmbalagensLongaVidaTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers[
                  'reciclagemDeEmbalagensLongaVidaEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De Entulho',
          jsonKey: 'reciclagemDeEntulho',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeEntulhoTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeEntulhoEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De Madeira',
          jsonKey: 'reciclagemDeMadeira',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeMadeiraTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeMadeiraEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De Papel',
          jsonKey: 'reciclagemDePapel',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemDePapelTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDePapelEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De plástico e\nembalagens',
          jsonKey: 'reciclagemDePlasticoEEmbalagens',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget
                  .controllers['reciclagemDePlasticoEEmbalagensTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget.controllers[
                  'reciclagemDePlasticoEEmbalagensEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De Vidro',
          jsonKey: 'reciclagemDeVidro',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemDeVidroTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemDeVidroEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'De Óleo de\nCozinha',
          jsonKey: 'reciclagemDeOleoDeCozinha',
          children: [
            CustomTextField(
              name: 'Total reciclado (%)',
              controller:
                  widget.controllers['reciclagemDeOleoDeCozinhaTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller: widget
                  .controllers['reciclagemDeOleoDeCozinhaEntidadeResponsavel'],
            ),
          ]),
      ConditionalFieldsGroup(
          title: 'Outros',
          jsonKey: 'reciclagemOutros',
          children: [
            CustomTextField(
              name: 'Nome',
              controller: widget.controllers['reciclagemOutrosNome'],
            ),
            CustomTextField(
              name: 'Total reciclado (%)',
              controller: widget.controllers['reciclagemOutrosTotalReciclado'],
              formatter: [FilteringTextInputFormatter.digitsOnly],
            ),
            CustomTextField(
              name: 'Entidade Responsável',
              controller:
                  widget.controllers['reciclagemOutrosEntidadeResponsavel'],
            ),
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Serviços De Comunicação',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Acesso à Internet'),
      SizedBox(
        height: 55.h,
      ),
      RadioFormField(
          onSaved: (newValue) =>
              valoresJson['servicosDeComunicacaoAcessoAInternet'] = newValue,
          options: [
            'A rádio',
            'A cabo',
            'Banda larga',
            'Discada',
            'Wireless',
            '3G'
          ]),
      ConditionalFieldsGroup(
          title: 'Telefonia Móvel',
          jsonKey: 'servicosDeComunicacaoTelefoniaMovel',
          children: [
            SizedBox(
              height: 55.h,
            ),
            textLabel(name: 'Área de Cobertura'),
            RadioFormField(
              options: ['Em Todo Município', 'Em Parte do Município'],
              onSaved: (newValue) =>
                  valoresJson['telefoniaMovelAreaDeCobertura'] = newValue,
            )
          ]),
      ConditionalFieldsGroup(
          title: 'Telefonia Fixa',
          jsonKey: 'servicosDeComunicacaoTelefoniaFixa',
          children: [
            SizedBox(
              height: 55.h,
            ),
            textLabel(name: 'Área de Cobertura'),
            RadioFormField(
              options: ['Em Todo Município', 'Em Parte do Município'],
              onSaved: (newValue) =>
                  valoresJson['telefoniaFixaAreaDeCobertura'] = newValue,
            )
          ]),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Serviços Turísticos',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Promoção Turística',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      ConditionalFieldsGroup(
          title: 'Divulgação Impressa',
          jsonKey: 'promocaoTuristicaDivulgacaoImpressa',
          children: [
            CustomTextField(
              name: 'Folder',
              controller: widget.controllers['divulgacaoImpressaFolder'],
            ),
            CustomTextField(
                name: 'Revista',
                controller: widget.controllers['divulgacaoImpressaRevista']),
            CustomTextField(
                name: 'Jornal',
                controller: widget.controllers['divulgacaoImpressaJornal']),
            CustomTextField(
                name: 'Outros',
                controller: widget.controllers['divulgacaoImpressaOutros'])
          ]),
      ConditionalFieldsGroup(
          title: 'Divulgação Televisiva',
          jsonKey: 'promocaoTuristicaDivulgacaoTelevisiva',
          children: []),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Atendimento ao Visitante',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
        name: 'Atendimento em Língua Estrangeira',
      ),
      SizedBox(
        height: 55.h,
      ),
      RadioFormField(
        options: ['Não', 'Inglês', 'Espanhol', 'outro'],
        onSaved: (newValue) =>
            valoresJson['atendimentoEmLinguaEstrangeira'] = newValue,
      ),
      textLabel(
        name: 'Informativos Impressos',
      ),
      SizedBox(
        height: 55.h,
      ),
      RadioFormField(
        options: ['Não', 'Português', 'Inglês', 'Espanhol', 'outro'],
        onSaved: (newValue) =>
            valoresJson['atendimentoAoVisitanteInformativosImpressos'] =
                newValue,
      ),
      textLabel(
        name: 'Caracterização do Fluxo de Visitantes',
        fontWeight: FontWeight.bold,
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Dados de Visitação'),
      CustomTextField(
        name: 'Visitantes Ano (nº)',
        controller: widget.controllers['visitantesAno'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
      ),
      CustomTextField(
        name: 'Visitantes Alta Temporada (nº)',
        controller: widget.controllers['visitantesAnoAltaTemporada'],
        formatter: [FilteringTextInputFormatter.digitsOnly],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Meses Alta Temporada'),
      SizedBox(
        height: 55.h,
      ),
      CheckboxGroupFormField(
        onSaved: (p0) => valoresJson['mesesAltaTemporada'] = p0,
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
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(name: 'Origem dos Visitantes/Turistas'),
      SizedBox(
        height: 55.h,
      ),
      RadioFormField(
        options: ['Entorno Municipal', 'Estadual', 'Nacional', 'Internacional'],
        onSaved: (newValue) =>
            valoresJson['origemDosVisitantesTuristas'] = newValue,
      ),
      SizedBox(
        height: 55.h,
      ),
      MultiAutocompleteFormField(
        title: 'Origem dos Turistas Nacionais (até 5 estados)',
        label: 'Selecione um Estado',
        fieldCount: 5,
        optionsBuilder: (textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable.empty();
          }
          return _pesquisaController.estados
              .map((e) => e.nome)
              .where((nome) => nome.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ));
        },
        onSaved: (newValue) {
          valoresJson['origemNacional'] = newValue;
        },
        validator: (values) {
          // Exemplo de validação: exigir pelo menos um estado
          if (values == null || values.isEmpty) {
            return 'Por favor, selecione pelo menos um estado.';
          }
          return null;
        },
      ),
      SizedBox(
        height: 55.h,
      ),
      MultiAutocompleteFormField(
        title: 'Origem dos Turistas Internacionais (até 5 países)',
        label: 'Selecione um País',
        optionsBuilder: (textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable.empty();
          }
          return _pesquisaController.paises
              .map((e) => e.nome)
              .where((nome) => nome.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ));
        },
        onSaved: (newValue) {
          valoresJson['origemInternacional'] = newValue;
        },
        validator: (values) {
          if (values == null || values.isEmpty) {
            return 'Por favor, selecione pelo menos um pais.';
          }
          return null;
        },
      ),
      SizedBox(
        height: 55.h,
      ),
      CustomTextField(
        name: 'Ano-base',
        controller: widget.controllers['origemInternacionalAnoBase'],
      ),
      CustomTextField(
        name: 'Atrativos Mais Visitados',
        controller: widget.controllers['atrativosMaisVisitados'],
      ),
      SizedBox(
        height: 55.h,
      ),
      textLabel(
          name:
              'Segmentos ou Tipos de Turismo em que é Especializado (assinalar até 3)'),
      CheckboxGroupFormField(
        options: [
          'Aventura',
          'Ecoturismo',
          'Sol e praia',
          'Rural',
          'Estudos e intercâmbio',
          'Negócios e eventos',
          'Cultural (cívico, étnico, religioso, místico e esotérico)',
          'Náutico',
          'Esporte',
          'Saúde (bem-estar e médico)',
          'Pesca',
          'Não é especializado em nenhum segmento'
        ],
        isLimitedBy3: true,
        onSaved: (newValue) =>
            valoresJson['segmentosTurismoEspecializado'] = newValue,
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        children: listaWidgets,
      ),
    );
  }
}

class LegislacaoMunicipal extends StatelessWidget{
  final Map<String, TextEditingController> controllers;

  const LegislacaoMunicipal({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    
    final List<Widget> listaWidgets = [
       Container(
        color: const Color.fromARGB(255, 55, 111, 60),
        height: sizeScreen.height * 0.06,
        width: sizeScreen.width,
        padding: EdgeInsets.only(
            top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
        child: Text(
          'Legislação Municipal',
          style: TextStyle(
              color: Colors.white, fontSize: sizeScreen.height * 0.03),
        ),
      ),
      SizedBox(height: 55.h,),
      textLabel(name: 'Lei Orgânica', fontWeight: FontWeight.bold,),
      CustomTextField(name: 'tipo/número/data', controller: controllers['leiOrganica'],),

      SizedBox(height: 55.h,),
      textLabel(name: 'Ocupação do Solo', fontWeight: FontWeight.bold,),
      CustomTextField(name: 'tipo/número/data', controller: controllers['ocupacaoDoSolo'],),

      SizedBox(height: 55.h,),
      textLabel(name: 'Plano de Desenvolvimento do Turismo', fontWeight: FontWeight.bold,),
      CustomTextField(name: 'tipo/número/data', controller: controllers['planoDeDesenvolvimentoDoTurismo'],),

      SizedBox(height: 55.h,),
      textLabel(name: 'Proteção Ambiental', fontWeight: FontWeight.bold,),
      CustomTextField(name: 'tipo/número/data', controller: controllers['protecaoAmbiental'],),

      SizedBox(height: 55.h,),
      textLabel(name: 'Apoio à Cultura', fontWeight: FontWeight.bold,),
      CustomTextField(name: 'tipo/número/data', controller: controllers['apoioACultura'],),

      SizedBox(height: 55.h,),
      textLabel(name: 'Incentivos Fiscais ao Turismo', fontWeight: FontWeight.bold,),
      CustomTextField(name: 'tipo/número/data', controller: controllers['incentivosFiscaisAoTurismo'],),

      SizedBox(height: 55.h,),
      textLabel(name: 'Plano Diretor', fontWeight: FontWeight.bold,),
      CustomTextField(name: 'tipo/número/data', controller: controllers['planoDiretor'],),

      SizedBox(height: 55.h,),
      textLabel(name: 'Fundo Municipal de Turismo', fontWeight: FontWeight.bold,),
      CustomTextField(name: 'tipo/número/data', controller: controllers['fundoMunicipalDeTurismo'],),

      SizedBox(height: 55.h,),
      textLabel(name: 'Outras', fontWeight: FontWeight.bold,),
      CustomTextField(name: 'tipo/número/data', controller: controllers['legislacaoOutras'],),

      SizedBox(height: 75.h,),
      Container(
        color: const Color.fromARGB(255, 55, 111, 60),
        height: sizeScreen.height * 0.06,
        width: sizeScreen.width,
        padding: EdgeInsets.only(
            top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
        child: Text(
          'Observações e Referências',
          style: TextStyle(
              color: Colors.white, fontSize: sizeScreen.height * 0.03),
        ),
      ),
      SizedBox(height: 55.h,),
      textLabel(name: 'Observações', fontWeight: FontWeight.bold,),
      CustomTextField(name: '', controller: controllers['observacoes'],),
      textLabel(name: 'Referências', fontWeight: FontWeight.bold,),
      CustomTextField(name: '', controller: controllers['referencias'],),

      SizedBox(height: 75.h,),


    ];


    return SingleChildScrollView(
      child: Column(
        children: listaWidgets,
      ),
    );
  }

}


class ConditionalFieldsGroup extends StatefulWidget {
  final String title;
  final String jsonKey;
  final List<Widget> children;

  const ConditionalFieldsGroup(
      {super.key,
      required this.title,
      required this.jsonKey,
      required this.children});

  @override
  State<ConditionalFieldsGroup> createState() => _ConditionalFieldsGroupState();
}

class _ConditionalFieldsGroupState extends State<ConditionalFieldsGroup> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valoresJson.putIfAbsent(widget.jsonKey, () => 'não');
  }

  @override
  Widget build(BuildContext context) {
    final bool isExpanded = valoresJson[widget.jsonKey] == 'sim';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 55.h,
        ),
        Row(
          children: [
            textLabel(name: widget.title),
            Expanded(
                flex: 2,
                child: ExpansionTileYoN(
                  getValue: (p0) {
                    if (valoresJson[widget.jsonKey] == p0) return;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!mounted) return;
                      setState(() {
                        valoresJson[widget.jsonKey] = p0;
                      });
                    });
                  },
                ))
          ],
        ),
        if (isExpanded) ...widget.children
      ],
    );
  }
}
