import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/services/admin_service.dart';
class PesquisaPesquisadorCardWidget extends StatefulWidget {
  final Pesquisa pesquisa;

   PesquisaPesquisadorCardWidget({
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
        padding:  EdgeInsets.all(8.0),
        child: Column(
          children: [
       
            Container(
              padding:  EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color:  Color.fromARGB(255, 55, 111, 60),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                 Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Coordenador da Pesquisa:  ',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.w),
    ),
    Flexible(
      child: FutureBuilder<String>(
        future: AdminService.getAdminName(widget.pesquisa.adminId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Text('Carregando...');
          } else if (snapshot.hasError) {
            return  Text('Erro ao carregar');
          } else if (snapshot.hasData) {
            return Text(
              snapshot.data!,
              style: TextStyle(fontSize: 50.w),
              overflow: TextOverflow.ellipsis, // Adiciona reticências se necessário
            );
          } else {
            return  Text('Desconhecido');
          }
        },
      ),
    ),
  ],
),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        'Código IBGE:',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50.w),
                      ),
                      Text(widget.pesquisa.codigoIBGE.toString(),style: TextStyle(fontSize: 50.w),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        'Estado:',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50.w),
                      ),
                      Text(widget.pesquisa.estado,style: TextStyle(fontSize: 50.w),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        'Município:',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50.w),
                      ),
                      Text(widget.pesquisa.municipio,style: TextStyle(fontSize: 50.w),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        'Data de Início:',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50.w),
                      ),
                      Text(widget.pesquisa.dataInicio,style: TextStyle(fontSize: 50.w),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        'Data de Término:',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50.w),
                      ),
                      Text(widget.pesquisa.dataTermino,style: TextStyle(fontSize: 50.w),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        'Quantidade de Equipamentos:',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50.w),
                      ),
                      Text(widget.pesquisa.quantidadeLocais.toString(),style: TextStyle(fontSize: 50.w),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        'Quantidade de Pesquisadores:',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50.w),
                      ),
                      Text(widget.pesquisa.quantidadePesquisadores.toString(),style: TextStyle(fontSize: 50.w),)
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