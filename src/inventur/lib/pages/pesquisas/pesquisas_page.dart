import 'package:flutter/material.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/pesquisas/widgets/pesquisa_card_widget.dart';

class PesquisasPage extends StatefulWidget {
  const PesquisasPage({super.key});

  @override
  State<PesquisasPage> createState() => _PesquisasPageState();
}

class _PesquisasPageState extends State<PesquisasPage> {
  final PesquisaController _pesquisaController = PesquisaController();

  PesquisaModel pm = PesquisaModel(
    codigoIBGE: 11111,
    estado: "CE",
    municipio: "Tianguá",
    dataInicio: "01/01/2024",
    dataTermino: "01/01/2024",
    quantidadeLocais: 23,
    quantidadePesquisadores: 5,
  );

  @override
  void initState() {
    super.initState();
    _pesquisaController.addPesquisa(pm);
    _pesquisaController.addPesquisa(pm);
    _pesquisaController.addPesquisa(pm);
    _pesquisaController.addPesquisa(pm);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // TABELA PARA MOSTRAR AS PESQUISASA CADASTRADAS
          Expanded(
            child: Card(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)
              ),
              child: ListenableBuilder(
                listenable: _pesquisaController,
                builder: (context, child) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              DataTable(
                                columns: [
                                  ..._pesquisaController.informacoesPesquisa.map(
                                    (columnName) => DataColumn(
                                      label: Text(
                                        columnName,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                                rows: [
                                  ..._pesquisaController.pesquisas.map(
                                    (e) => DataRow(
                                      cells: [
                                        DataCell(
                                          Center(child: Text(e.codigoIBGE.toString())),
                                        ),
                                        DataCell(
                                          Center(child: Text(e.estado)),
                                        ),
                                        DataCell(
                                          Center(child: Text(e.municipio)),
                                        ),
                                        DataCell(
                                          Center(child: Text(e.dataInicio)),
                                        ),
                                        DataCell(
                                          Center(child: Text(e.dataTermino)),
                                        ),
                                        DataCell(
                                          Center(child: Text(e.quantidadeLocais.toString())),
                                        ),
                                        DataCell(
                                          Center(child: Text(e.quantidadePesquisadores.toString())),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
          // TABELA PARA MOSTRAR AS PESQUISASA CADASTRADAS
          // LISTVIEW PARA MOSTRAR AS EM CARDs AS PESQUISAS CADASTRADAS
          Expanded(
            child: ListenableBuilder(
              listenable: _pesquisaController,
              builder: (context, child) {
                return _pesquisaController.pesquisas.isNotEmpty
                ? ListView.builder(
                  itemCount: _pesquisaController.pesquisas.length,
                  itemBuilder: (context, index) {
                    return PesquisaCard(
                      pesquisa: _pesquisaController.pesquisas[index],
                    );
                  },
                )
                : const Center(
                  child: Text("Nehuma Pesquisa Cadastrada"),
                );
              },
            ),
          ),
          // LISTVIEW PARA MOSTRAR AS EM CARDs AS PESQUISAS CADASTRADAS
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: screenSize.height * .06,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.012
                    )
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 55, 111, 60)
                  ),
                  overlayColor: MaterialStateProperty.all(
                    Colors.green[600]
                  )
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/RegisterPesquisa');
                }, 
                child: Text(
                  'Cadastrar Nova Pesquisa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenSize.height * .03
                  ),
                )
              )
            ),
          ),
        ],
      ),
    );
  }
}