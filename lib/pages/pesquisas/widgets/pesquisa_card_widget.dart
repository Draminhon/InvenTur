import 'package:flutter/material.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/pesquisas/register_pesquisa_page.dart';

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

class _PesquisaCardState extends State<PesquisaCard> {
  late Pesquisa _pesquisa;
  late PesquisaController _pesquisaController;

  bool _opened = false;

  @override
  void initState() {
    super.initState();
    _pesquisa = widget.pesquisa;
    _pesquisaController = widget.pesquisaController;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/RegisterPesquisa');
                  }, 
                  icon: Icon(
                    Icons.edit_rounded,
                    color: Colors.green[700],
                  )
                ),
                IconButton(
                  onPressed: () async {

                    _pesquisaController.removePesquisa(false, _pesquisa);

                  }, 
                  icon: Icon(
                    Icons.delete_rounded,
                    color: Colors.red[700],
                  )
                ),
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
                        'Quantidade de Locais Cadastrados:',
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
              child: PopupMenuButton(
                enableFeedback: true,
                color: Colors.white,
                tooltip: 'Status da Pesquisa',
                initialValue: _pesquisa.status,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                itemBuilder: (context) {
                  return _pesquisaController.statusItems.map<PopupMenuItem<String>>(
                    (String value) {
                      return PopupMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }
                  ).toList();
                },
                onSelected: (String value) {
                  setState(() {
                    _pesquisaController.setPesquisaStatus(value, _pesquisa);
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
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                          color: _pesquisaController.statusColor(_pesquisa.status),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        _pesquisa.status,
                        style: TextStyle(
                          color: _pesquisaController.statusColor(_pesquisa.status),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Icon(
                        _opened
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                        color: _pesquisaController.statusColor(_pesquisa.status),
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