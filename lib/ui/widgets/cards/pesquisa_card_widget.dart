import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sistur/models/pesquisa_model.dart';
import 'package:sistur/controllers/pesquisa_controller.dart';
import 'package:sistur/utils/app_constants.dart';
import 'dart:io';
import 'package:sistur/services/secure_storage_service.dart';
import 'package:sistur/services/interceptor_service.dart';
import 'package:dio/dio.dart';

class PesquisaCard extends StatefulWidget {
  final Pesquisa pesquisa;
  final PesquisaController pesquisaController;

  const PesquisaCard({
    super.key,
    required this.pesquisa,
    required this.pesquisaController,
  });

  @override
  State<PesquisaCard> createState() => _PesquisaCardState();
}


 Future<List<Pesquisa>> getPesquisas() async {
    final secureStorage = SecureStorageService();
    String? userDataString = await secureStorage.read('user_data');
    if (userDataString == null) {
      print("Nenhum dado do usuário encontrado no SecureStorage.");
      return [];
    }

    Map<String, dynamic> userData = json.decode(userDataString);
    int adminId = userData['id'];

    try {
      final response = await ApiService().get(AppConstants.GET_PESQUISAS);

      final List body = response.data;
      final List<Pesquisa> todasAsPesquisas =
          body.map((e) => Pesquisa.fromJson(e)).toList();
      final List<Pesquisa> pesquisasFiltradas = todasAsPesquisas
          .where((pesquisa) =>
              pesquisa.adminId != null && pesquisa.adminId == adminId)
          .toList();
      return pesquisasFiltradas;
    } catch (e) {
      print("Erro: $e");
      return [];
    }
  }

 
/// Exporta a pesquisa para Excel: baixa a planilha do servidor, pergunta onde salvar e oferece abrir o arquivo.
/// Mostra o resultado (ou o motivo da falha) num SnackBar.
Future<void> exportarPesquisaExcel(BuildContext context, Pesquisa pesquisa) async {
  final mensagens = ScaffoldMessenger.of(context);
  void avisar(String texto, {bool erro = false, SnackBarAction? acao}) {
    mensagens
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(texto),
        backgroundColor: erro ? Colors.red[700] : AppConstants.MAIN_GREEN,
        action: acao,
        duration: Duration(seconds: acao != null ? 6 : 4),
      ));
  }

  final Response<dynamic> resposta;
  try {
    resposta = await ApiService().get(
      'export/pesquisa/${pesquisa.id}/',
      options: Options(responseType: ResponseType.bytes, receiveTimeout: const Duration(minutes: 2)),
    );
  } on DioException catch (e) {
    final status = e.response?.statusCode;
    avisar(
      status == null
          ? 'Sem conexão com o servidor. A exportação precisa de internet.'
          : status == 404
              ? 'Pesquisa não encontrada ou você não tem acesso a ela.'
              : 'Não foi possível gerar a planilha (erro $status). Tente novamente.',
      erro: true,
    );
    return;
  } catch (_) {
    avisar('Não foi possível gerar a planilha. Tente novamente.', erro: true);
    return;
  }

  final bytes = Uint8List.fromList(List<int>.from(resposta.data ?? const <int>[]));
  if (bytes.isEmpty) {
    avisar('O servidor devolveu uma planilha vazia. Tente novamente.', erro: true);
    return;
  }

  // Nome sugerido pelo servidor (SisTur_municipio-UF_data.xlsx)
  final cabecalho = resposta.headers.value('content-disposition') ?? '';
  final nome = RegExp(r'filename="([^"]+)"').firstMatch(cabecalho)?.group(1) ?? 'SisTur_pesquisa_${pesquisa.id}.xlsx';

  String? caminho;
  try {
    // Diálogo nativo "Salvar como". No Android/iOS o próprio plugin grava os bytes (funciona com o
    // armazenamento restrito do Android 11+, onde gravar com File numa pasta escolhida falha).
    caminho = await FilePicker.platform.saveFile(
      dialogTitle: 'Salvar planilha da pesquisa',
      fileName: nome,
      type: FileType.custom,
      allowedExtensions: const ['xlsx'],
      bytes: bytes,
    );
    if (caminho == null) return; // usuário cancelou
    // No Android/iOS o plugin já gravou, e o caminho devolvido pode não ser acessível ao app (armazenamento
    // restrito): não mexer nele. No desktop o diálogo só devolve o caminho: grava aqui.
    if (!Platform.isAndroid && !Platform.isIOS) {
      await File(caminho).writeAsBytes(bytes, flush: true);
    }
  } catch (_) {
    avisar('Não foi possível salvar o arquivo no local escolhido.', erro: true);
    return;
  }

  // Para o botão ABRIR: no celular, abre uma cópia na pasta temporária do app (sempre acessível)
  String paraAbrir = caminho;
  if (Platform.isAndroid || Platform.isIOS) {
    try {
      final copia = File('${(await getTemporaryDirectory()).path}/$nome');
      await copia.writeAsBytes(bytes, flush: true);
      paraAbrir = copia.path;
    } catch (_) {}
  }
  avisar(
    'Planilha salva: $nome',
    acao: SnackBarAction(
      label: 'ABRIR',
      textColor: Colors.white,
      onPressed: () async {
        final resultado = await OpenFile.open(paraAbrir);
        if (resultado.type != ResultType.done) {
          avisar('Nenhum aplicativo de planilhas encontrado para abrir o arquivo.', erro: true);
        }
      },
    ),
  );
}


class _PesquisaCardState extends State<PesquisaCard> {
  late PesquisaController _pesquisaController;

  Future<void> _loadPesquisas() async {
    List<Pesquisa> pesquisas = await getPesquisas();
    _pesquisaController.addPesquisa(pesquisas);
  }

  bool _opened = false;
  bool _exportando = false;

  @override
  void initState() {
    super.initState();
    _pesquisaController = widget.pesquisaController;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Código único de vínculo: o administrador o compartilha para o pesquisador entrar na pesquisa
                if (widget.pesquisa.codigo != null)
                  Expanded(child: _CodigoPesquisa(codigo: widget.pesquisa.codigo!))
                else
                  const Spacer(),
                IconButton(
                    tooltip: 'Exportar para Excel',
                    onPressed: _exportando
                        ? null
                        : () async {
                            setState(() {
                              _exportando = true;
                            });
                            await exportarPesquisaExcel(context, widget.pesquisa);
                            if (mounted) {
                              setState(() {
                                _exportando = false;
                              });
                            }
                          },
                    icon: _exportando
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2.5, color: AppConstants.MAIN_GREEN))
                        : Icon(
                            Icons.download_rounded,
                            color: AppConstants.MAIN_GREEN,
                          )),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Pesquisas', arguments: {
                        'pesquisa_id': widget.pesquisa.id,
                        'is_admin': true
                      }).then((_) => _loadPesquisas());
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: AppConstants.MAIN_GREEN,
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/EditPesquisa',
                        arguments: {
                          'id': widget.pesquisa.id,
                          'data_inicio': widget.pesquisa.dataInicio,
                          'data_termino': widget.pesquisa.dataTermino,
                          'codigoIBGE': widget.pesquisa.codigoIBGE,
                          'municipio': widget.pesquisa.municipio,
                          'estado': widget.pesquisa.estado,
                          'pesquisadores': widget.pesquisa.userId,
                          'admin_id': widget.pesquisa.adminId
                        },
                      ).then((result) {
                        if (result == true) {
                          _loadPesquisas();
                        }
                      });
                    },
                    icon: Icon(
                      Icons.edit_rounded,
                      color: Colors.green[700],
                    )),
                IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Tem certeza?"),
                              content: const Text(
                                  'Você deseja excluir essa pesquisa?'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancelar')),
                                TextButton(
                                    onPressed: () {
                                      _pesquisaController.removePesquisa(
                                          false, widget.pesquisa);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Excluir',
                                      style: TextStyle(color: Colors.red),
                                    ))
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      Icons.delete_rounded,
                      color: Colors.red[700],
                    )),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: const Color.fromARGB(255, 55, 111, 60),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Código IBGE:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.pesquisa.codigoIBGE.toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Estado:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.pesquisa.estado)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Município:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.pesquisa.municipio)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Data de Início:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.pesquisa.dataInicio)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Data de Término:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.pesquisa.dataTermino)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantidade de Equipamentos:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.pesquisa.quantidadeLocais.toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Quantidade de Pesquisadores:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.pesquisa.quantidadePesquisadores.toString())
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: const Color.fromARGB(255, 55, 111, 60),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: PopupMenuButton<String>(
                enableFeedback: true,
                color: Colors.white,
                tooltip: 'Status da Pesquisa',
                initialValue: widget.pesquisa.status,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                itemBuilder: (context) {
                  return _pesquisaController.statusItems
                      .map<PopupMenuItem<String>>((String value) {
                    return PopupMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList();
                },
                onSelected: (String value) {
                  setState(() {
                    _pesquisaController.setPesquisaStatus(
                        value, widget.pesquisa);
                    _opened = !_opened;
                  });
                },
                onOpened: () => setState(() {
                  _opened = !_opened;
                }),
                onCanceled: () => setState(() {
                  _opened = !_opened;
                }),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                          color: _pesquisaController
                              .statusColor(widget.pesquisa.status),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        widget.pesquisa.status,
                        style: TextStyle(
                            color: _pesquisaController
                                .statusColor(widget.pesquisa.status),
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        _opened
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: _pesquisaController
                            .statusColor(widget.pesquisa.status),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Código de vínculo da pesquisa, em verde. Tocar copia o código para compartilhar com os pesquisadores.
class _CodigoPesquisa extends StatelessWidget {
  final String codigo;

  const _CodigoPesquisa({required this.codigo});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Tooltip(
        message: 'Toque para copiar. Compartilhe com os pesquisadores para que se vinculem a esta pesquisa.',
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: codigo));
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Código $codigo copiado.'), duration: const Duration(seconds: 2)),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppConstants.MAIN_GREEN.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppConstants.MAIN_GREEN.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.vpn_key_rounded, size: 16, color: AppConstants.MAIN_GREEN),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    codigo,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppConstants.MAIN_GREEN,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.copy_rounded, size: 14, color: AppConstants.MAIN_GREEN),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
