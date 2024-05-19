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

  List<Pesquisa> pesquisas = [
    Pesquisa(
      codigoIBGE: 11111,
      estado: "CE",
      municipio: "Tianguá",
      dataInicio: "01/01/2024",
      dataTermino: "01/01/2024",
      quantidadeLocais: 23,
      quantidadePesquisadores: 5,
      status: "Não Iniciado"
    ),
    Pesquisa(
      codigoIBGE: 22222,
      estado: "CE",
      municipio: "Viçosa do Ceará",
      dataInicio: "01/01/2024",
      dataTermino: "01/01/2024",
      quantidadeLocais: 23,
      quantidadePesquisadores: 5,
      status: "Não Iniciado"
    ),
    Pesquisa(
      codigoIBGE: 33333,
      estado: "CE",
      municipio: "Tianguá",
      dataInicio: "01/01/2024",
      dataTermino: "01/01/2024",
      quantidadeLocais: 23,
      quantidadePesquisadores: 5,
      status: "Não Iniciado"
    ),
    Pesquisa(
      codigoIBGE: 44444,
      estado: "CE",
      municipio: "Viçosa do Ceará",
      dataInicio: "01/01/2024",
      dataTermino: "01/01/2024",
      quantidadeLocais: 23,
      quantidadePesquisadores: 5,
      status: "Não Iniciado"
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pesquisaController.setPesquisas = pesquisas;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListenableBuilder(
            listenable: _pesquisaController,
            builder: (context, child) {
              return _pesquisaController.pesquisas.isEmpty
              ? const Center(
                child: Text("Nehuma Pesquisa Cadastrada"),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: _pesquisaController.pesquisas.length,
                itemBuilder: (context, index) {
                  return PesquisaCard(
                    pesquisa: _pesquisaController.pesquisas[index],
                    pesquisaController: _pesquisaController,
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            height: screenSize.height * .06,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                padding: WidgetStateProperty.all(
                  EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.012
                  )
                ),
                backgroundColor: WidgetStateProperty.all(
                  const Color.fromARGB(255, 55, 111, 60)
                ),
                overlayColor: WidgetStateProperty.all(
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
    );
  }
}