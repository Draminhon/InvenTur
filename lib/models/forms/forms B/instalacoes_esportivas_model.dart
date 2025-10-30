class InstalacoesEsportivasModel {
  int? id;
  String? tipoFormulario;
  String? uf;
  String? regiaoTuristica;
  String? municipio;
  String? tipo;
  String? observacoes;
  String? referencias;
  String? nomePesquisador;
  String? telefonePesquisador;
  String? emailPesquisador;
  String? nomeCoordenador;
  String? telefoneCoordenador;
  String? emailCoordenador;

  // Sinalizações e funcionamento
  String? sinalizacaoDeAcesso;
  String? sinalizacaoTuristica;
  String? funcionamento24h;
  String? funcionamentoEmFeriados;
  String? geradorDeEmergencia;

  // Infraestrutura e localização do equipamento/edificação
  String? doEquipamentoEspaco;
  String? daAreaOuEdificacaoEmQueEstaLocalizado;
  String? possuiFacilidade;
  String? sinalizacaoIndicativa;
  List<String>? tipoDeOrganizacao;
  List<String>? proximidades;

  // Dados relacionados ao turismo e pagamentos
  List<String>? segmentosOuTurismoEspecializado;
  List<String>? formasDePagamento;
  List<String>? reservas;
  List<String>? atendimentoEmLinguaEstrangeira;
  List<String>? informativosImpressos;
  List<String>? restricoes;
  List<String>? mesesAltaTemporada;
  List<String>? origemDosVisitantes;

  // Produtos e serviços
  List<String>? estacionamento;
  List<String>? restaurante;
  List<String>? lanchonete;
  List<String>? instalacaoEEspacos;
  List<String>? outrosEspacosEAtividades;
  List<String>? servicos;
  List<String>? equipamentos;
  List<String>? facilidadesEServicos;
  List<String>? facilidadesParaExecutivos;
  List<String>? pessoalCapacitadoParaReceberPCD;

  // Acessibilidade
  List<String>? rotaExternaAcessivel;
  List<String>? simboloInternacionalDeAcesso;
  List<String>? localDeEmbarqueEDesembarque;
  List<String>? vagaEmEstacionamento;
  List<String>? areaDeCirculacaoAcessoInterno;
  List<String>? escada;
  List<String>? rampa;
  List<String>? piso;
  List<String>? elevador;
  List<String>? equipamentoMotorizadoParaDeslocamentoInterno;
  List<String>? sinalizacaoVisual;
  List<String>? sinalizacaoTatil;
  List<String>? alarmeDeEmergencia;
  List<String>? comunicacao;
  List<String>? balcaoDeAtendimento;
  List<String>? mobiliario;
  List<String>? sanitario;
  List<String>? telefone;

  // Classificação e localização do meio de hospedagem
  List<String>? subtipo;
  String? natureza;
  String? localizacao;
  String? tipoDeDiaria;
  List<String>? periodo;
  Map<String, dynamic>? tabelasHorario;
  String? energiaEletrica;
  String? estadoGeralDeConservacao;

  // Dados de turismo e localização geográfica
  List<String>? estadosTuristas;
  List<String>? paisesTuristas;

  // Dados empresariais
  String? razaoSocial;
  String? nomeFantasia;
  String? codigoCNAE;
  String? atividadeEconomica;
  String? inscricaoMunicipal;
  String? nomeDaRede;
  String? CNPJ;
  String? inicioDaAtividade;

  // Dados de quantitativos e capacidade
  String? qtdeFuncionariosPermanentes;
  String? qtdeFuncionariosTemporarios;
  String? qtdeFuncionarisComDeficiencia;
  String? latitude;
  String? longitude;

  // Endereço e contato
  String? avenidaRuaEtc;
  String? bairroLocalidade;
  String? distrito;
  String? CEP;
  String? whatsapp;
  String? instagram;
  String? email;
  String? site;
  String? pontosDeReferencia;

  // Dados de tabelas e informações adicionais
  Map<String, dynamic>? tabelaMTUR;
  String? outrasRegrasEInformacoes;
  String? nAnoOcupacao;
  String? nOcupacaoAltaTemporada;
  String? nTotalDeUH;
  String? nTotalDeLeitos;
  String? nUhAdaptadasParaPCD;
  String? nCapacidadeDeVeiculos;
  String? nAutomoveis;
  String? nOnibus;
  String? capacidadeEmKVA;
  String? geradorCapacidadeEmKVA;
  String? nCapacidadeInstaladaPorDia;
  String? nPessoasAtendidasSentadas;
  String? nCapacidadeSimultanea;
  String? nPessoasAtendidasSentadasSimultanea;
  String? lanchoneteCapacidadeInstaladaPorDia;
  String? lanchoneteCapacidadePessoasAtendidasSentadas;
  String? lanchoneteCapacidadeSimultanea;
  String? lanchoneteCapacidadeSentadasSimultanea;
  Map<String, dynamic>? tabelaInstalacoes;
  Map<String, dynamic>? tabelaEquipamentoEEspaco;
  Map<String, dynamic>? tabelaEquipamentoEEspaco2;
  String? outros;
  String? outrasAcessibilidade;

  String? entidadeManetedora;
  String? entidadeManetedoraEmail;
  String? entidadeManetedoraSite;
  String? entradaGratuita;
  String? entradaPaga;
  List<String>? outrasInstalacoes;
  List<String>? equipamentosEServicos;

  List<String>? modalidadesPraticadasGinasio;
  String? ginasioAreaCoberta;
  String? ginasioPoliesportivo;
  String? pistaDeSkateTipoDePista;
  String? vooLivreDecolagem;
  String? melhorEpoca;
  String? piscinaAreaCoberta;
  String? piscinaTrampolim;
  String? capacidadeEspectadoresTotal;
  String? capacidadeEspectadoresArquibancada;
  String? capacidadeEspectadoresCamarotes;
  String? capacidadeEspectadoresCadeirasCativas;
  String? capacidadeEspectadoresTribunasDeHonra;
  String? capacidadeEspectadoresArquibancadasCobertas;
  String? capacidadeEspectadoresOutrasCategorias;
  String? ginasioTipoDePiso;
  String? ginasioComprimento;
  String? campoDeFutebolTipoDePiso;
  String? campoDeFutebolComprimento;
  String? campoDeFutebolAreaCoberta;
  String? campoDeFutebolQuantidade;
  String? autodromoComprimentoDaPista;
  String? autodromoQuantidadeDePistas;
  String? hipodromoTipoDePiso;
  String? hipodromoComprimentoDaPista;
  String? hipodromoQuantidadeDePistas;
  String? pistaDeBolicheComprimentoDaPista;
  String? pistaDeBolicheQuantidadeDePistas;
  String? pistaDeSkateComprimentoDaPista;
  String? pistaDeSkateAreaDaPista;
  String? pistaDeSkateQuantidadeDePistas;
  String? vooLivreTipoDeVoo;
  String? vooLivreAltitude;
  String? vooLivreDesnivel;
  String? vooLivreQuadrante;
  String? vooLivreWaypoint;
  String? vooLivrePouso;
  String? piscinaComprimento;
  String? piscinaProfundidade;
  String? piscinaLargura;
  String? piscinaQuantidade;
  String? piscinaOutroEquipamento;
  String? outrasOutras;
  String? caracteristicasEspecificas;
  InstalacoesEsportivasModel(
      {this.modalidadesPraticadasGinasio,
      this.ginasioAreaCoberta,
      this.ginasioPoliesportivo,
      this.pistaDeSkateTipoDePista,
      this.vooLivreDecolagem,
      this.melhorEpoca,
      this.piscinaAreaCoberta,
      this.piscinaTrampolim,
      this.capacidadeEspectadoresTotal,
      this.capacidadeEspectadoresArquibancada,
      this.capacidadeEspectadoresCamarotes,
      this.capacidadeEspectadoresCadeirasCativas,
      this.capacidadeEspectadoresTribunasDeHonra,
      this.capacidadeEspectadoresArquibancadasCobertas,
      this.capacidadeEspectadoresOutrasCategorias,
      this.ginasioTipoDePiso,
      this.ginasioComprimento,
      this.campoDeFutebolTipoDePiso,
      this.campoDeFutebolComprimento,
      this.campoDeFutebolAreaCoberta,
      this.campoDeFutebolQuantidade,
      this.autodromoComprimentoDaPista,
      this.autodromoQuantidadeDePistas,
      this.hipodromoTipoDePiso,
      this.hipodromoComprimentoDaPista,
      this.hipodromoQuantidadeDePistas,
      this.pistaDeBolicheComprimentoDaPista,
      this.pistaDeBolicheQuantidadeDePistas,
      this.pistaDeSkateComprimentoDaPista,
      this.pistaDeSkateAreaDaPista,
      this.pistaDeSkateQuantidadeDePistas,
      this.vooLivreTipoDeVoo,
      this.vooLivreAltitude,
      this.vooLivreDesnivel,
      this.vooLivreQuadrante,
      this.vooLivreWaypoint,
      this.vooLivrePouso,
      this.piscinaComprimento,
      this.piscinaProfundidade,
      this.piscinaLargura,
      this.piscinaQuantidade,
      this.piscinaOutroEquipamento,
      this.outrasOutras,
      this.caracteristicasEspecificas,
      this.id,
      this.tipoFormulario,
      this.uf,
      this.regiaoTuristica,
      this.entidadeManetedora,
      this.entidadeManetedoraEmail,
      this.entidadeManetedoraSite,
      this.municipio,
      this.tipo,
      this.observacoes,
      this.referencias,
      this.nomePesquisador,
      this.telefonePesquisador,
      this.emailPesquisador,
      this.nomeCoordenador,
      this.telefoneCoordenador,
      this.emailCoordenador,
      this.entradaGratuita,
      this.entradaPaga,
      this.sinalizacaoDeAcesso,
      this.sinalizacaoTuristica,
      this.funcionamento24h,
      this.funcionamentoEmFeriados,
      this.geradorDeEmergencia,
      this.doEquipamentoEspaco,
      this.daAreaOuEdificacaoEmQueEstaLocalizado,
      this.possuiFacilidade,
      this.sinalizacaoIndicativa,
      this.tipoDeOrganizacao,
      this.proximidades,
      this.segmentosOuTurismoEspecializado,
      this.formasDePagamento,
      this.reservas,
      this.atendimentoEmLinguaEstrangeira,
      this.informativosImpressos,
      this.restricoes,
      this.mesesAltaTemporada,
      this.origemDosVisitantes,
      this.outrasInstalacoes,
      this.equipamentosEServicos,
      this.estacionamento,
      this.restaurante,
      this.lanchonete,
      this.instalacaoEEspacos,
      this.outrosEspacosEAtividades,
      this.servicos,
      this.equipamentos,
      this.facilidadesEServicos,
      this.facilidadesParaExecutivos,
      this.pessoalCapacitadoParaReceberPCD,
      this.rotaExternaAcessivel,
      this.simboloInternacionalDeAcesso,
      this.localDeEmbarqueEDesembarque,
      this.vagaEmEstacionamento,
      this.areaDeCirculacaoAcessoInterno,
      this.escada,
      this.rampa,
      this.piso,
      this.elevador,
      this.equipamentoMotorizadoParaDeslocamentoInterno,
      this.sinalizacaoVisual,
      this.sinalizacaoTatil,
      this.alarmeDeEmergencia,
      this.comunicacao,
      this.balcaoDeAtendimento,
      this.mobiliario,
      this.sanitario,
      this.telefone,
      this.subtipo,
      this.natureza,
      this.localizacao,
      this.tipoDeDiaria,
      this.periodo,
      this.tabelasHorario,
      this.energiaEletrica,
      this.estadoGeralDeConservacao,
      this.estadosTuristas,
      this.paisesTuristas,
      this.razaoSocial,
      this.nomeFantasia,
      this.codigoCNAE,
      this.atividadeEconomica,
      this.inscricaoMunicipal,
      this.nomeDaRede,
      this.CNPJ,
      this.inicioDaAtividade,
      this.qtdeFuncionariosPermanentes,
      this.qtdeFuncionariosTemporarios,
      this.qtdeFuncionarisComDeficiencia,
      this.latitude,
      this.longitude,
      this.avenidaRuaEtc,
      this.bairroLocalidade,
      this.distrito,
      this.CEP,
      this.whatsapp,
      this.instagram,
      this.email,
      this.site,
      this.pontosDeReferencia,
      this.tabelaMTUR,
      this.outrasRegrasEInformacoes,
      this.nAnoOcupacao,
      this.nOcupacaoAltaTemporada,
      this.nTotalDeUH,
      this.nTotalDeLeitos,
      this.nUhAdaptadasParaPCD,
      this.nCapacidadeDeVeiculos,
      this.nAutomoveis,
      this.nOnibus,
      this.capacidadeEmKVA,
      this.geradorCapacidadeEmKVA,
      this.nCapacidadeInstaladaPorDia,
      this.nPessoasAtendidasSentadas,
      this.nCapacidadeSimultanea,
      this.nPessoasAtendidasSentadasSimultanea,
      this.lanchoneteCapacidadeInstaladaPorDia,
      this.lanchoneteCapacidadePessoasAtendidasSentadas,
      this.lanchoneteCapacidadeSimultanea,
      this.lanchoneteCapacidadeSentadasSimultanea,
      this.tabelaInstalacoes,
      this.tabelaEquipamentoEEspaco,
      this.tabelaEquipamentoEEspaco2,
      this.outros,
      this.outrasAcessibilidade});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo_formulario': tipoFormulario,
      'uf': uf,
      'modalidadesPraticadasGinasio': modalidadesPraticadasGinasio,
      'ginasioAreaCoberta': ginasioAreaCoberta,
      'ginasioPoliesportivo': ginasioPoliesportivo,
      'pistaDeSkateTipoDePista': pistaDeSkateTipoDePista,
      'vooLivreDecolagem': vooLivreDecolagem,
      'melhorEpoca': melhorEpoca,
      'piscinaAreaCoberta': piscinaAreaCoberta,
      'piscinaTrampolim': piscinaTrampolim,
      'capacidadeEspectadoresTotal': capacidadeEspectadoresTotal,
      'capacidadeEspectadoresArquibancada': capacidadeEspectadoresArquibancada,
      'capacidadeEspectadoresCamarotes': capacidadeEspectadoresCamarotes,
      'capacidadeEspectadoresCadeirasCativas':
          capacidadeEspectadoresCadeirasCativas,
      'capacidadeEspectadoresTribunasDeHonra':
          capacidadeEspectadoresTribunasDeHonra,
      'capacidadeEspectadoresArquibancadasCobertas':
          capacidadeEspectadoresArquibancadasCobertas,
      'capacidadeEspectadoresOutrasCategorias':
          capacidadeEspectadoresOutrasCategorias,
      'ginasioTipoDePiso': ginasioTipoDePiso,
      'ginasioComprimento': ginasioComprimento,
      'campoDeFutebolTipoDePiso': campoDeFutebolTipoDePiso,
      'campoDeFutebolComprimento': campoDeFutebolComprimento,
      'campoDeFutebolAreaCoberta': campoDeFutebolAreaCoberta,
      'campoDeFutebolQuantidade': campoDeFutebolQuantidade,
      'autodromoComprimentoDaPista': autodromoComprimentoDaPista,
      'autodromoQuantidadeDePistas': autodromoQuantidadeDePistas,
      'hipodromoTipoDePiso': hipodromoTipoDePiso,
      'hipodromoComprimentoDaPista': hipodromoComprimentoDaPista,
      'hipodromoQuantidadeDePistas': hipodromoQuantidadeDePistas,
      'pistaDeBolicheComprimentoDaPista': pistaDeBolicheComprimentoDaPista,
      'pistaDeBolicheQuantidadeDePistas': pistaDeBolicheQuantidadeDePistas,
      'pistaDeSkateComprimentoDaPista': pistaDeSkateComprimentoDaPista,
      'pistaDeSkateAreaDaPista': pistaDeSkateAreaDaPista,
      'pistaDeSkateQuantidadeDePistas': pistaDeSkateQuantidadeDePistas,
      'vooLivreTipoDeVoo': vooLivreTipoDeVoo,
      'vooLivreAltitude': vooLivreAltitude,
      'vooLivreDesnivel': vooLivreDesnivel,
      'vooLivreQuadrante': vooLivreQuadrante,
      'vooLivreWaypoint': vooLivreWaypoint,
      'vooLivrePouso': vooLivrePouso,
      'piscinaComprimento': piscinaComprimento,
      'piscinaProfundidade': piscinaProfundidade,
      'piscinaLargura': piscinaLargura,
      'piscinaQuantidade': piscinaQuantidade,
      'piscinaOutroEquipamento': piscinaOutroEquipamento,
      'outrasOutras': outrasOutras,
      'caracteristicasEspecificas': caracteristicasEspecificas,
      'entradaGratuita': entradaGratuita,
      'entradaPaga': entradaPaga,
      'regiao_turistica': regiaoTuristica,
      'entidadeManetedora': entidadeManetedora,
      'entidadeManetedoraEmail': entidadeManetedoraEmail,
      'entidadeManetedoraSite': entidadeManetedoraSite,
      'municipio': municipio,
      'tipo': tipo,
      'observacoes': observacoes,
      'referencias': referencias,
      'nome_pesquisador': nomePesquisador,
      'telefone_pesquisador': telefonePesquisador,
      'email_pesquisador': emailPesquisador,
      'nome_coordenador': nomeCoordenador,
      'telefone_coordenador': telefoneCoordenador,
      'email_coordenador': emailCoordenador,
      'sinalizacaoDeAcesso': sinalizacaoDeAcesso,
      'sinalizacaoTuristica': sinalizacaoTuristica,
      'funcionamento24h': funcionamento24h,
      'funcionamentoEmFeriados': funcionamentoEmFeriados,
      'geradorDeEmergencia': geradorDeEmergencia,
      'doEquipamentoEspaco': doEquipamentoEspaco,
      'daAreaOuEdificacaoEmQueEstaLocalizado':
          daAreaOuEdificacaoEmQueEstaLocalizado,
      'possuiFacilidade': possuiFacilidade,
      'sinalizacaoIndicativa': sinalizacaoIndicativa,
      'tipoDeOrganizacao': tipoDeOrganizacao,
      'proximidades': proximidades,
      'segmentosOuTurismoEspecializado': segmentosOuTurismoEspecializado,
      'formasDePagamento': formasDePagamento,
      'reservas': reservas,
      'atendimentoEmLinguaEstrangeira': atendimentoEmLinguaEstrangeira,
      'informativosImpressos': informativosImpressos,
      'restricoes': restricoes,
      'mesesAltaTemporada': mesesAltaTemporada,
      'origemDosVisitantes': origemDosVisitantes,
      'outrasInstalacoes': outrasInstalacoes,
      'equipamentosEServicos': equipamentosEServicos,
      'estacionamento': estacionamento,
      'restaurante': restaurante,
      'lanchonete': lanchonete,
      'instalacaoEEspacos': instalacaoEEspacos,
      'outrosEspacosEAtividades': outrosEspacosEAtividades,
      'servicos': servicos,
      'equipamentos': equipamentos,
      'facilidadesEServicos': facilidadesEServicos,
      'facilidadesParaExecutivos': facilidadesParaExecutivos,
      'pessoalCapacitadoParaReceberPCD': pessoalCapacitadoParaReceberPCD,
      'rotaExternaAcessivel': rotaExternaAcessivel,
      'simboloInternacionalDeAcesso': simboloInternacionalDeAcesso,
      'localDeEmbarqueEDesembarque': localDeEmbarqueEDesembarque,
      'vagaEmEstacionamento': vagaEmEstacionamento,
      'areaDeCirculacaoAcessoInterno': areaDeCirculacaoAcessoInterno,
      'escada': escada,
      'rampa': rampa,
      'piso': piso,
      'elevador': elevador,
      'equipamentoMotorizadoParaDeslocamentoInterno':
          equipamentoMotorizadoParaDeslocamentoInterno,
      'sinalizacao_visual': sinalizacaoVisual,
      'sinalizacaoTatil': sinalizacaoTatil,
      'alarmeDeEmergencia': alarmeDeEmergencia,
      'comunicacao': comunicacao,
      'balcaoDeAtendimento': balcaoDeAtendimento,
      'mobiliario': mobiliario,
      'sanitario': sanitario,
      'telefone': telefone,
      'subtipo': subtipo,
      'natureza': natureza,
      'localizacao': localizacao,
      'tipoDeDiaria': tipoDeDiaria,
      'periodo': periodo,
      'tabelasHorario': tabelasHorario,
      'energiaEletrica': energiaEletrica,
      'estadoGeralDeConservacao': estadoGeralDeConservacao,
      'estadosTuristas': estadosTuristas,
      'paisesTuristas': paisesTuristas,
      'razaoSocial': razaoSocial,
      'nomeFantasia': nomeFantasia,
      'codigoCNAE': codigoCNAE,
      'atividadeEconomica': atividadeEconomica,
      'inscricaoMunicipal': inscricaoMunicipal,
      'nomeDaRede': nomeDaRede,
      'CNPJ': CNPJ,
      'inicioDaAtividade': inicioDaAtividade,
      'qtdeFuncionariosPermanentes': qtdeFuncionariosPermanentes,
      'qtdeFuncionariosTemporarios': qtdeFuncionariosTemporarios,
      'qtdeFuncionarisComDeficiencia': qtdeFuncionarisComDeficiencia,
      'latitude': latitude,
      'longitude': longitude,
      'avenidaRuaEtc': avenidaRuaEtc,
      'bairroLocalidade': bairroLocalidade,
      'distrito': distrito,
      'CEP': CEP,
      'whatsapp': whatsapp,
      'instagram': instagram,
      'email': email,
      'site': site,
      'pontosDeReferencia': pontosDeReferencia,
      'tabelaMTUR': tabelaMTUR,
      'outrasRegrasEInformacoes': outrasRegrasEInformacoes,
      'nAnoOcupacao': nAnoOcupacao,
      'nOcupacaoAltaTemporada': nOcupacaoAltaTemporada,
      'nTotalDeUH': nTotalDeUH,
      'nTotalDeLeitos': nTotalDeLeitos,
      'nUhAdaptadasParaPCD': nUhAdaptadasParaPCD,
      'nCapacidadeDeVeiculos': nCapacidadeDeVeiculos,
      'nAutomoveis': nAutomoveis,
      'nOnibus': nOnibus,
      'capacidadeEmKVA': capacidadeEmKVA,
      'geradorCapacidadeEmKVA': geradorCapacidadeEmKVA,
      'nCapacidadeInstaladaPorDia': nCapacidadeInstaladaPorDia,
      'nPessoasAtendidasSentadas': nPessoasAtendidasSentadas,
      'nCapacidadeSimultanea': nCapacidadeSimultanea,
      'nPessoasAtendidasSentadasSimultanea':
          nPessoasAtendidasSentadasSimultanea,
      'lanchoneteCapacidadeInstaladaPorDia':
          lanchoneteCapacidadeInstaladaPorDia,
      'lanchoneteCapacidadePessoasAtendidasSentadas':
          lanchoneteCapacidadePessoasAtendidasSentadas,
      'lanchoneteCapacidadeSimultanea': lanchoneteCapacidadeSimultanea,
      'lanchoneteCapacidadeSentadasSimultanea':
          lanchoneteCapacidadeSentadasSimultanea,
      'tabelaInstalacoes': tabelaInstalacoes,
      'tabelaEquipamentoEEspaco': tabelaEquipamentoEEspaco,
      'tabelaEquipamentoEEspaco2': tabelaEquipamentoEEspaco2,
      'outros': outros,
      'outrasAcessibilidade': outrasAcessibilidade
    };
  }

  InstalacoesEsportivasModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entradaGratuita = json['entradaGratuita'];
    entradaPaga = json['entradaPaga'];
    tipoFormulario = json['tipo_formulario'];
    uf = json['uf'];
    regiaoTuristica = json['regiao_turistica'];
    municipio = json['municipio'];
    tipo = json['tipo'];
    observacoes = json['observacoes'];
    entidadeManetedora = json['entidadeManetedora'];
    entidadeManetedoraEmail = json['entidadeManetedoraEmail'];
    entidadeManetedoraSite = json['entidadeManetedoraSite'];
    referencias = json['referencias'];
    nomePesquisador = json['nome_pesquisador'];
    telefonePesquisador = json['telefone_pesquisador'];
    emailPesquisador = json['email_pesquisador'];
    nomeCoordenador = json['nome_coordenador'];
    telefoneCoordenador = json['telefone_coordenador'];
    emailCoordenador = json['email_coordenador'];
    modalidadesPraticadasGinasio =
        List<String>.from(json['modalidadesPraticadasGinasio'] ?? []);
    ginasioAreaCoberta = json['ginasioAreaCoberta'];
    ginasioPoliesportivo = json['ginasioPoliesportivo'];
    pistaDeSkateTipoDePista = json['pistaDeSkateTipoDePista'];
    vooLivreDecolagem = json['vooLivreDecolagem'];
    melhorEpoca = json['melhorEpoca'];
    piscinaAreaCoberta = json['piscinaAreaCoberta'];
    piscinaTrampolim = json['piscinaTrampolim'];
    capacidadeEspectadoresTotal = json['capacidadeEspectadoresTotal'];
    capacidadeEspectadoresArquibancada =
        json['capacidadeEspectadoresArquibancada'];
    capacidadeEspectadoresCamarotes = json['capacidadeEspectadoresCamarotes'];
    capacidadeEspectadoresCadeirasCativas =
        json['capacidadeEspectadoresCadeirasCativas'];
    capacidadeEspectadoresTribunasDeHonra =
        json['capacidadeEspectadoresTribunasDeHonra'];
    capacidadeEspectadoresArquibancadasCobertas =
        json['capacidadeEspectadoresArquibancadasCobertas'];
    capacidadeEspectadoresOutrasCategorias =
        json['capacidadeEspectadoresOutrasCategorias'];
    ginasioTipoDePiso = json['ginasioTipoDePiso'];
    ginasioComprimento = json['ginasioComprimento'];
    campoDeFutebolTipoDePiso = json['campoDeFutebolTipoDePiso'];
    campoDeFutebolComprimento = json['campoDeFutebolComprimento'];
    campoDeFutebolAreaCoberta = json['campoDeFutebolAreaCoberta'];
    campoDeFutebolQuantidade = json['campoDeFutebolQuantidade'];
    autodromoComprimentoDaPista = json['autodromoComprimentoDaPista'];
    autodromoQuantidadeDePistas = json['autodromoQuantidadeDePistas'];
    hipodromoTipoDePiso = json['hipodromoTipoDePiso'];
    hipodromoComprimentoDaPista = json['hipodromoComprimentoDaPista'];
    hipodromoQuantidadeDePistas = json['hipodromoQuantidadeDePistas'];
    pistaDeBolicheComprimentoDaPista = json['pistaDeBolicheComprimentoDaPista'];
    pistaDeBolicheQuantidadeDePistas = json['pistaDeBolicheQuantidadeDePistas'];
    pistaDeSkateComprimentoDaPista = json['pistaDeSkateComprimentoDaPista'];
    pistaDeSkateAreaDaPista = json['pistaDeSkateAreaDaPista'];
    pistaDeSkateQuantidadeDePistas = json['pistaDeSkateQuantidadeDePistas'];
    vooLivreTipoDeVoo = json['vooLivreTipoDeVoo'];
    vooLivreAltitude = json['vooLivreAltitude'];
    vooLivreDesnivel = json['vooLivreDesnivel'];
    vooLivreQuadrante = json['vooLivreQuadrante'];
    vooLivreWaypoint = json['vooLivreWaypoint'];
    vooLivrePouso = json['vooLivrePouso'];
    piscinaComprimento = json['piscinaComprimento'];
    piscinaProfundidade = json['piscinaProfundidade'];
    piscinaLargura = json['piscinaLargura'];
    piscinaQuantidade = json['piscinaQuantidade'];
    piscinaOutroEquipamento = json['piscinaOutroEquipamento'];
    outrasOutras = json['outrasOutras'];
    caracteristicasEspecificas = json['caracteristicasEspecificas'];
    sinalizacaoDeAcesso = json['sinalizacaoDeAcesso'];
    sinalizacaoTuristica = json['sinalizacaoTuristica'];
    funcionamento24h = json['funcionamento24h'];
    funcionamentoEmFeriados = json['funcionamentoEmFeriados'];
    geradorDeEmergencia = json['geradorDeEmergencia'];
    doEquipamentoEspaco = json['doEquipamentoEspaco'];
    daAreaOuEdificacaoEmQueEstaLocalizado =
        json['daAreaOuEdificacaoEmQueEstaLocalizado'];
    possuiFacilidade = json['possuiFacilidade'];
    sinalizacaoIndicativa = json['sinalizacaoIndicativa'];
    tipoDeOrganizacao = json['tipoDeOrganizacao'] != null
        ? List<String>.from(json['tipoDeOrganizacao'] ?? [])
        : null;
    proximidades = json['proximidades'] != null
        ? List<String>.from(json['proximidades'] ?? [])
        : null;
    segmentosOuTurismoEspecializado =
        List<String>.from(json['segmentosOuTurismoEspecializado'] ?? []);
    formasDePagamento = List<String>.from(json['formasDePagamento'] ?? []);
    reservas = List<String>.from(json['reservas'] ?? []);
    atendimentoEmLinguaEstrangeira =
        List<String>.from(json['atendimentoEmLinguaEstrangeira'] ?? []);
    informativosImpressos =
        List<String>.from(json['informativosImpressos'] ?? []);
    restricoes = List<String>.from(json['restricoes'] ?? []);
    mesesAltaTemporada = List<String>.from(json['mesesAltaTemporada'] ?? []);
    origemDosVisitantes = List<String>.from(json['origemDosVisitantes'] ?? []);
    outrasInstalacoes = List<String>.from(json['outrasInstalacoes'] ?? []);
    equipamentosEServicos =
        List<String>.from(json['equipamentosEServicos'] ?? []);
    estacionamento = List<String>.from(json['estacionamento'] ?? []);
    restaurante = List<String>.from(json['restaurante'] ?? []);
    lanchonete = List<String>.from(json['lanchonete'] ?? []);
    instalacaoEEspacos = List<String>.from(json['instalacaoEEspacos'] ?? []);
    outrosEspacosEAtividades =
        List<String>.from(json['outrosEspacosEAtividades'] ?? []);
    servicos = List<String>.from(json['servicos'] ?? []);
    equipamentos = List<String>.from(json['equipamentos'] ?? []);
    facilidadesEServicos =
        List<String>.from(json['facilidadesEServicos'] ?? []);
    facilidadesParaExecutivos =
        List<String>.from(json['facilidadesParaExecutivos'] ?? []);
    pessoalCapacitadoParaReceberPCD =
        List<String>.from(json['pessoalCapacitadoParaReceberPCD'] ?? []);
    rotaExternaAcessivel =
        List<String>.from(json['rotaExternaAcessivel'] ?? []);
    simboloInternacionalDeAcesso =
        List<String>.from(json['simboloInternacionalDeAcesso'] ?? []);
    localDeEmbarqueEDesembarque =
        List<String>.from(json['localDeEmbarqueEDesembarque'] ?? []);
    vagaEmEstacionamento =
        List<String>.from(json['vagaEmEstacionamento'] ?? []);
    areaDeCirculacaoAcessoInterno =
        List<String>.from(json['areaDeCirculacaoAcessoInterno'] ?? []);
    escada = List<String>.from(json['escada'] ?? []);
    rampa = List<String>.from(json['rampa'] ?? []);
    piso = List<String>.from(json['piso'] ?? []);
    elevador = List<String>.from(json['elevador'] ?? []);
    equipamentoMotorizadoParaDeslocamentoInterno = List<String>.from(
        json['equipamentoMotorizadoParaDeslocamentoInterno'] ?? []);
    sinalizacaoVisual = List<String>.from(json['sinalizacaoVisual'] ?? []);
    sinalizacaoTatil = List<String>.from(json['sinalizacaoTatil'] ?? []);
    alarmeDeEmergencia = List<String>.from(json['alarmeDeEmergencia'] ?? []);
    comunicacao = List<String>.from(json['comunicacao'] ?? []);
    balcaoDeAtendimento = List<String>.from(json['balcaoDeAtendimento'] ?? []);
    mobiliario = List<String>.from(json['mobiliario'] ?? []);
    sanitario = List<String>.from(json['sanitario'] ?? []);
    telefone = List<String>.from(json['telefone'] ?? []);
    subtipo = List<String>.from(json['subtipo'] ?? []);
    natureza = json['natureza'];
    localizacao = json['localizacao'];
    tipoDeDiaria = json['tipoDeDiaria'];
    periodo = List<String>.from(json['periodo'] ?? []);
    tabelasHorario = Map<String, dynamic>.from(json['tabelasHorario'] ?? {});
    energiaEletrica = json['energiaEletrica'];
    estadoGeralDeConservacao = json['estadoGeralDeConservacao'];
    estadosTuristas = List<String>.from(json['estadosTuristas'] ?? []);
    paisesTuristas = List<String>.from(json['paisesTuristas'] ?? []);
    razaoSocial = json['razaoSocial'];
    nomeFantasia = json['nomeFantasia'];
    codigoCNAE = json['codigoCNAE'];
    atividadeEconomica = json['atividadeEconomica'];
    inscricaoMunicipal = json['inscricaoMunicipal'];
    nomeDaRede = json['nomeDaRede'];
    CNPJ = json['CNPJ'];
    inicioDaAtividade = json['inicioDaAtividade'];
    qtdeFuncionariosPermanentes = json['qtdeFuncionariosPermanentes'];
    qtdeFuncionariosTemporarios = json['qtdeFuncionariosTemporarios'];
    qtdeFuncionarisComDeficiencia = json['qtdeFuncionarisComDeficiencia'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    avenidaRuaEtc = json['avenidaRuaEtc'];
    bairroLocalidade = json['bairroLocalidade'];
    distrito = json['distrito'];
    CEP = json['CEP'];
    whatsapp = json['whatsapp'];
    instagram = json['instagram'];
    email = json['email'];
    site = json['site'];
    pontosDeReferencia = json['pontosDeReferencia'];
    tabelaMTUR = Map<String, dynamic>.from(json['tabelaMTUR'] ?? {});
    outrasRegrasEInformacoes = json['outrasRegrasEInformacoes'];
    nAnoOcupacao = json['nAnoOcupacao'];
    nOcupacaoAltaTemporada = json['nOcupacaoAltaTemporada'];
    nTotalDeUH = json['nTotalDeUH'];
    nTotalDeLeitos = json['nTotalDeLeitos'];
    nUhAdaptadasParaPCD = json['nUhAdaptadasParaPCD'];
    nCapacidadeDeVeiculos = json['nCapacidadeDeVeiculos'];
    nAutomoveis = json['nAutomoveis'];
    nOnibus = json['nOnibus'];
    capacidadeEmKVA = json['capacidadeEmKVA'];
    geradorCapacidadeEmKVA = json['geradorCapacidadeEmKVA'];
    nCapacidadeInstaladaPorDia = json['nCapacidadeInstaladaPorDia'];
    nPessoasAtendidasSentadas = json['nPessoasAtendidasSentadas'];
    nCapacidadeSimultanea = json['nCapacidadeSimultanea'];
    nPessoasAtendidasSentadasSimultanea =
        json['nPessoasAtendidasSentadasSimultanea'];
    lanchoneteCapacidadeInstaladaPorDia =
        json['lanchoneteCapacidadeInstaladaPorDia'];
    lanchoneteCapacidadePessoasAtendidasSentadas =
        json['lanchoneteCapacidadePessoasAtendidasSentadas'];
    lanchoneteCapacidadeSimultanea = json['lanchoneteCapacidadeSimultanea'];
    lanchoneteCapacidadeSentadasSimultanea =
        json['lanchoneteCapacidadeSentadasSimultanea'];
    tabelaInstalacoes =
        Map<String, dynamic>.from(json['tabelaInstalacoes'] ?? {});
    tabelaEquipamentoEEspaco =
        Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco'] ?? {});
    tabelaEquipamentoEEspaco2 =
        Map<String, dynamic>.from(json['tabelaEquipamentoEEspaco2'] ?? {});
    outros = json['outros'];
    outrasAcessibilidade = json['outrasAcessibilidade'];
  }
}
