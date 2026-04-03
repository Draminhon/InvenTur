import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
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

 
Future<File?> downloadExcel(int pesquisaId) async {
  try {
    final response = await ApiService().get(
      'export/pesquisa/$pesquisaId',
      options: Options(responseType: ResponseType.bytes),
    );

    if (response.statusCode == 200) {
      final selectedDirectory = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Selecione o local para salvar o arquivo',
      );

      if (selectedDirectory == null) {
        print("Nenhum diretório foi selecionado");
        return null;
      }

      final filePath = '$selectedDirectory/pesquisa_$pesquisaId.xlsx';
      final file = File(filePath);

      await file.writeAsBytes(response.data);
      print('Arquivo saved com sucesso em: $filePath');
      
      try {
        final result = await OpenFile.open(file.path);
        print('Resultado ao abrir o arquivo: ${result.message}');
      } catch (e) {
        print('Erro ao tentar abrir o arquivo: $e');
      }

      return file;
    } else {
      print('Erro ao baixar o Excel: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Erro fatal ao baixar Excel: $e');
    return null;
  }
}


class _PesquisaCardState extends State<PesquisaCard> {
  late PesquisaController _pesquisaController;

  Future<void> _loadPesquisas() async {
    List<Pesquisa> pesquisas = await getPesquisas();
    _pesquisaController.addPesquisa(pesquisas);
  }

  bool _opened = false;

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
                IconButton(
                    onPressed: () {
                      downloadExcel(widget.pesquisa.id!);
                    },
                    icon: Icon(
                      Icons.print_rounded,
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
