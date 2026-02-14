import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sistur/models/pesquisa_model.dart';
import 'package:sistur/services/admin_service.dart';
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
    print(widget.pesquisa.adminId);
    print('aaaaa');
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
        future: AdminService.getAdminName(widget.pesquisa.adminId==null? -1 : widget.pesquisa.adminId!),
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

class ContainerHeader extends StatelessWidget{
 final String title;
  const ContainerHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    // TODO: implement build
             return Container(
            color: const Color.fromARGB(255, 55, 111, 60),
            height: sizeScreen.height * 0.06,
            width: sizeScreen.width,
            padding: EdgeInsets.only(
                top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white, fontSize: sizeScreen.height * 0.03),
            ),
          );
  }

}

class ContainerHeaderToBigTexts extends StatelessWidget{
 final String title;
  const ContainerHeaderToBigTexts({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    // TODO: implement build
             return Container(
            color: const Color.fromARGB(255, 55, 111, 60),
            width: sizeScreen.width,
            padding: EdgeInsets.only(
                top: sizeScreen.height * 0.008, left: sizeScreen.width * 0.04, bottom: sizeScreen.height * 0.01),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.white, fontSize: sizeScreen.height * 0.03),
            ),
          );
  }

}