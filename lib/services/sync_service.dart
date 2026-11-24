import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sistur/services/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:sistur/services/interceptor_service.dart';

/// Resultado de uma sincronização da fila offline.
class ResultadoSync {
  /// Formulários enviados e removidos da fila.
  final int enviados;

  /// Recusados pelo servidor (ex.: o pesquisador saiu da pesquisa, ela foi excluída, faltam dados).
  /// Continuam na fila (nada se perde), mas não travam mais o envio dos demais.
  final int recusados;

  /// A sincronização parou no meio (sem conexão, servidor fora do ar, sessão expirada).
  final bool interrompida;

  const ResultadoSync({this.enviados = 0, this.recusados = 0, this.interrompida = false});
}

class DataSyncService {
  static final DataSyncService _instace = DataSyncService._();
  late Database _db;

  DataSyncService._();

  factory DataSyncService() => _instace;

  /// Quantidade de formulários na fila. As telas escutam para atualizar o contador sem recarregar.
  final ValueNotifier<int> pendentes = ValueNotifier<int>(0);

  /// Intervalo das tentativas silenciosas enquanto houver algo na fila (inclusive itens recusados antes).
  static const Duration intervaloRetentativa = Duration(minutes: 2);

  Future<ResultadoSync>? _emAndamento;
  Timer? _timerRetentativa;
  StreamSubscription<List<ConnectivityResult>>? _conexao;

  /// Envia a fila. Se já houver um envio em andamento (manual ou em segundo plano), aguarda o mesmo envio
  /// em vez de começar outro — dois envios simultâneos mandariam o mesmo formulário duas vezes.
  Future<ResultadoSync> syncPending() {
    return _emAndamento ??= _processQueue().whenComplete(() => _emAndamento = null);
  }

  /// Tentativas silenciosas (sem diálogo): a cada [intervaloRetentativa] e sempre que a conexão volta.
  /// Os itens que falharam ficam na fila e são tentados de novo até serem aceitos.
  void _iniciarRetentativas() {
    _timerRetentativa ??= Timer.periodic(intervaloRetentativa, (_) => _tentarEmSegundoPlano());
    _conexao ??= Connectivity().onConnectivityChanged.listen((resultado) {
      if (!resultado.contains(ConnectivityResult.none)) _tentarEmSegundoPlano();
    });
  }

  Future<void> _tentarEmSegundoPlano() async {
    if (_emAndamento != null) return;
    try {
      if (await getPendingCount() == 0) return;
      // Só com alguém logado (sem sessão, o servidor recusaria tudo)
      if (await SecureStorageService().read('access_token') == null) return;
      final r = await syncPending();
      debugPrint('Sincronização silenciosa: ${r.enviados} enviado(s), ${r.recusados} recusado(s)'
          '${r.interrompida ? ', interrompida' : ''}.');
    } catch (e) {
      debugPrint('Sincronização silenciosa falhou: $e');
    }
  }

  Future<void> _atualizarContagem() async {
    try {
      pendentes.value = await getPendingCount();
    } catch (_) {}
  }

  /// Erro do servidor que não se resolve tentando de novo (o item é pulado em vez de travar a fila)
  static bool _recusaDefinitiva(DioException e) {
    final status = e.response?.statusCode;
    return status != null && status >= 400 && status < 500 && status != 401 && status != 408 && status != 429;
  }

  Future<void> init() async {
    final path = await getDatabasesPath();

    _db = await openDatabase(
      join(path, 'sync_queue.db'),
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE queue (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        method TEXT,
        endpoint TEXT,
        payload TEXT,
        pesquisa_id INTEGER)''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
ALTER TABLE queue
ADD COLUMN pesquisa_id INTEGER''');
        }
      },
    );

    await _atualizarContagem();
    _iniciarRetentativas();
    // Ao abrir o app, já tenta enviar o que ficou pendente
    unawaited(_tentarEmSegundoPlano());
  }

  Future<void> enqueue({
    required String method,
    required String endpoint,
    required Map<String, dynamic> payload,
    required int pesquisa_id,
  }) async {
    await _db.insert('queue', {
      'method': method,
      'endpoint': endpoint,
      'payload': json.encode(payload),
      'pesquisa_id': pesquisa_id
    });
    await _atualizarContagem();
  }

  Future<void> removeItem(int id) async {
    await _db.delete(
      'queue',
      where: 'id = ?',
      whereArgs: [id],
    );
    await _atualizarContagem();
  }

  Future<int> getPendingCount() async {
    // faz SELECT COUNT(*) FROM queue
    final result = await _db.rawQuery('SELECT COUNT(*) AS count FROM queue');
    // o rawQuery sempre retorna List<Map<String, Object?>>
    final count = result.first['count'] as int;
    return count;
  }

  Future<int> filterQueue(int pesquisaId) async{
    if(_db == null){
      await init();
    }

    final List<Map<String, Object?>> results = await _db.rawQuery('SELECT COUNT(*) AS count FROM queue WHERE pesquisa_id = ?', [pesquisaId]
    );
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<void> clearQueue() async {
    await _db.delete('queue');
    await _atualizarContagem();
    debugPrint('Queue completamente limpa');
  }

  Future<ResultadoSync> _processQueue() async {
    final items = await _db.query('queue');
    int enviados = 0;
    int recusados = 0;
    bool interrompida = false;
    for (final item in items) {
      final id = item['id'] as int;
      final method = item['method'] as String;
      final endpoint = item['endpoint'] as String;
      final payload = json.decode(item['payload'] as String);
      
      try {
        late Response resp;

        if (method == 'POST') {
          resp = await ApiService().post(
            endpoint,
            data: payload,
          );
        } else if (method == 'PUT') {
          resp = await ApiService().put(
            endpoint,
            data: payload,
          );
        }

        if (resp.statusCode != null && resp.statusCode! >= 200 && resp.statusCode! < 300) {
          await removeItem(id);
          enviados++;
          debugPrint('Item $id sincronizado e removido da fila.');
        } else {
          recusados++;
          debugPrint('Falha no servidor para item $id: ${resp.statusCode}');
        }
      } on DioException catch (e) {
        if (_recusaDefinitiva(e)) {
          // Antes: um único item recusado parava a fila para sempre e nada depois dele era enviado
          recusados++;
          debugPrint('Item $id recusado pelo servidor (${e.response?.statusCode}); segue para o próximo.');
          continue;
        }
        interrompida = true; // sem conexão / servidor fora: tenta de novo depois
        debugPrint('Sincronização interrompida no item $id: $e');
        break;
      } catch (e) {
        interrompida = true;
        debugPrint('Erro ao processar item $id: $e');
        break;
      }
    }
    return ResultadoSync(enviados: enviados, recusados: recusados, interrompida: interrompida);
  }

  Future<List<Map<String, dynamic>>> getPendingItems() async {
    final items = await _db.query('queue', orderBy: 'id DESC');

    return items.map((row) {
      return {
        'id': row['id'],
        'method': row['method'],
        'endpoint': row['endpoint'],
        'payload': json.decode(row['payload'] as String),
      };
    }).toList();
  }
}
