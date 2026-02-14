import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sistur/services/sync_service.dart';

class SyncQueuePage extends StatefulWidget {
  const SyncQueuePage({Key? key}) : super(key: key);

  @override
  _SyncQueuePageState createState() => _SyncQueuePageState();
}

class _SyncQueuePageState extends State<SyncQueuePage> {
  late Future<List<Map<String, dynamic>>> _futureQueue;

  @override
  void initState() {
    super.initState();
    _futureQueue = DataSyncService().getPendingItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendências de Sincronização'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureQueue,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
          final queue = snapshot.data!;
          if (queue.isEmpty) {
            return const Center(child: Text('Nenhuma pendência!'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: queue.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, i) {
              final item = queue[i];
              return ListTile(
                leading: CircleAvatar(child: Text('${item['id']}')),
                title: Text('${item['method']}  ${item['endpoint']}'),
                subtitle: Text(
                  // exibe o JSON indentado de payload
                  const JsonEncoder.withIndent('  ')
                      .convert(item['payload']),
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
