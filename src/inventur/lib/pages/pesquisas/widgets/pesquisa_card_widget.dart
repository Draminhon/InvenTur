import 'package:flutter/material.dart';
import 'package:inventur/models/pesquisa_model.dart';

class PesquisaCard extends StatelessWidget {
  final PesquisaModel pesquisa;

  const PesquisaCard({
    super.key,
    required this.pesquisa,
  });

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
                const Text(
                  'Código IBGE:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(pesquisa.codigoIBGE.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Estado:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(pesquisa.estado)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Município:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(pesquisa.municipio)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Data de Início:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(pesquisa.dataInicio)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Data de Término:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(pesquisa.dataTermino)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quantidade de Locais Cadastrados:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(pesquisa.quantidadeLocais.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quantidade de Pesquisadores:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(pesquisa.quantidadePesquisadores.toString())
              ],
            ),
          ],
        ),
      ),
    );
  }
}