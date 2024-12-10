import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/services/admin_service.dart';
class PesquisaPesquisadorCardWidget extends StatefulWidget {
  final Pesquisa pesquisa;

  const PesquisaPesquisadorCardWidget({
    super.key,
    required this.pesquisa,
  });

  @override
  State<PesquisaPesquisadorCardWidget> createState() => _PesquisaPesquisadorCardWidgetState();
}

class _PesquisaPesquisadorCardWidgetState extends State<PesquisaPesquisadorCardWidget> {
  

  bool _opened = false;

  @override
  void initState() {
    super.initState();
  
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
                        'Coordenador da Pesquisa:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      FutureBuilder<String>(future: AdminService.getAdminName(widget.pesquisa.adminId),
                      builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Carregando...');
        } else if (snapshot.hasError) {
          return const Text('Erro ao carregar');
        } else if (snapshot.hasData) {
          return Text(snapshot.data!);
        } else {
          return const Text('Desconhecido');
        }
                      },)
                    ],
                  ),
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
           
          ],
        ),
      ),
    );
  }
}