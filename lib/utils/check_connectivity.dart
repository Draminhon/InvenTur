import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Uma classe singleton que monitora o estado da conexão com a internet.
///
/// Ela expõe um [ValueNotifier<bool>] que pode ser ouvido para obter
/// atualizações em tempo real sobre o status da conexão.
class CheckConnectivity {
  // 1. Instância Singleton
  // O construtor privado e a instância estática garantem que apenas uma
  // instância desta classe seja criada em todo o aplicativo.
  CheckConnectivity._();
  static final CheckConnectivity _instance = CheckConnectivity._();
  factory CheckConnectivity() => _instance;

  // 2. Notificador de Estado
  // ValueNotifier é uma classe do Flutter que notifica seus ouvintes
  // sempre que seu valor é alterado. É perfeito para este caso.
  // Inicia com 'false' como valor padrão.
  final ValueNotifier<bool> isConnected = ValueNotifier(false);

  // 3. Controlador do Stream
  // Para manter uma referência à assinatura do stream e poder cancelá-la
  // quando o objeto for descartado, evitando memory leaks.
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  /// Inicializa o verificador.
  ///
  /// Deve ser chamado no início do aplicativo, como na função `main()`.
  /// Ele faz uma verificação inicial e começa a ouvir as mudanças de estado.
  Future<void> inicializar() async {
    // Faz uma verificação inicial ao iniciar o app
    final resultados = await Connectivity().checkConnectivity();
    _atualizarStatusConexao(resultados);

    // Começa a ouvir as mudanças no estado da conexão
    _subscription = Connectivity().onConnectivityChanged.listen(_atualizarStatusConexao);
  }

  /// Retorna o valor booleano atual da conexão.
  ///
  /// Este é um getter para conveniência, retornando o valor contido
  /// dentro do ValueNotifier.
  bool get currentValue => isConnected.value;

  /// Método privado para atualizar o ValueNotifier com base no resultado.
  /// A conexão é considerada 'true' se o resultado não for [ConnectivityResult.none].
  void _atualizarStatusConexao(List<ConnectivityResult> resultados) {
    // Se a lista de resultados contém 'none', significa que uma das
    // interfaces de rede não tem conexão. Para ser mais robusto,
    // consideramos desconectado apenas se 'none' for o único resultado.
    if (resultados.contains(ConnectivityResult.none) && resultados.length == 1) {
      isConnected.value = false;
    } else {
      isConnected.value = true;
    }
  }Future<bool> checarConexaoUmaVez() async {
  // O método checkConnectivity() retorna uma lista de resultados.
  // Um dispositivo pode ter múltiplas conexões (ex: WiFi e Dados Móveis).
  final List<ConnectivityResult> resultados = await Connectivity().checkConnectivity();

  // Se a lista de resultados NÃO contiver 'ConnectivityResult.none',
  // significa que há pelo menos uma conexão ativa.
  return !resultados.contains(ConnectivityResult.none);
}

  /// Libera os recursos, cancelando a assinatura do stream.
  ///
  /// É importante chamar isso se o serviço puder ser descartado,
  /// embora em um singleton que dura a vida toda do app, seja menos crítico.
  void dispose() {
    _subscription.cancel();
  }
}