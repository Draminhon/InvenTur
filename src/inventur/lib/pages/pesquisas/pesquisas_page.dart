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

  Pesquisa pm = Pesquisa(
    codigoIBGE: 11111,
    estado: "CE",
    municipio: "Tianguá",
    dataInicio: "01/01/2024",
    dataTermino: "01/01/2024",
    quantidadeLocais: 23,
    quantidadePesquisadores: 5,
    status: "Não Iniciado"
  );

  Pesquisa pm2 = Pesquisa(
    codigoIBGE: 11111,
    estado: "CE",
    municipio: "Viçosa do Ceará",
    dataInicio: "01/01/2024",
    dataTermino: "01/01/2024",
    quantidadeLocais: 23,
    quantidadePesquisadores: 5,
    status: "Não Iniciado"
  );

  @override
  void initState() {
    super.initState();
    _pesquisaController.addPesquisa(pm);
    _pesquisaController.addPesquisa(pm2);
    _pesquisaController.addPesquisa(pm);
    _pesquisaController.addPesquisa(pm2);
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
                      pesquisaController: _pesquisaController,
                    );
                  },
                )
                : const Center(
                  child: Text("Nehuma Pesquisa Cadastrada"),
                );
              },
            ),
          ),
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