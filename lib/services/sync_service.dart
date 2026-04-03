import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistur/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:sistur/services/interceptor_service.dart';

class DataSyncService {
  static final DataSyncService _instace = DataSyncService._();
  late Database _db;

  DataSyncService._();

  factory DataSyncService() => _instace;

  Future<void> syncPending() async {
    await _processQueue();
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

    // Connectivity().onConnectivityChanged.listen((status) {
    //   if (status != ConnectivityResult.none) {
    //     _processQueue();
    //   }
    // });
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
  }

  Future<void> removeItem(int id) async {
    await _db.delete(
      'queue',
      where: 'id = ?',
      whereArgs: [id],
    );
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
    debugPrint('Queue completamente limpa');
  }

  Future<void> _processQueue() async {
    final items = await _db.query('queue');
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
          debugPrint('Item $id sincronizado e removido da fila.');
        } else {
          debugPrint('Falha no servidor para item $id: ${resp.statusCode}');
        }
      } catch (e) {
        debugPrint('Erro ao processar item $id: $e');
        break;
      }
    }
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
