import 'package:flutter/material.dart';
import 'package:inventur/main.dart';
import 'package:inventur/models/pesquisa_model.dart';
import 'package:inventur/pages/controllers/pesquisa_controller.dart';
import 'package:inventur/pages/pesquisas/register_pesquisa_page.dart';
import 'package:inventur/utils/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {
                  Navigator.pushNamed(context, '/Pesquisas',arguments: {'pesquisa_id': _pesquisa.id, 'is_admin': true});
                }, icon: Icon(Icons.remove_red_eye, color: AppConstants.MAIN_GREEN,)),
               // SizedBox(width: 700.w,),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/EditPesquisa', arguments: {
                        'id': _pesquisa.id,
                        'data_inicio': _pesquisa.dataInicio,
                        'data_termino': _pesquisa.dataTermino,
                        'codigoIBGE': _pesquisa.codigoIBGE,
                        'municipio': _pesquisa.municipio,
                        'estado': _pesquisa.estado,
                        'pesquisadores': _pesquisa.userId,
                        'admin_id': _pesquisa.adminId

                      });
                      print(_pesquisa.municipio);
                    },
                    icon: Icon(
                      Icons.edit_rounded,
                      color: Colors.green[700],
                    )),
                IconButton(
                    onPressed: () async {
                      showDialog(context: context, builder: (BuildContext context){

                        return AlertDialog(

                          title: const Text("Tem certeza?"),
                          content: const Text('Você deseja excluir essa pesquisa?'),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          actions: [
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text('Cancelar')
                            
                            )
                            ,
                            TextButton(onPressed: (){
                      _pesquisaController.removePesquisa(false, _pesquisa);
                      Navigator.pop(context);
                              
                            }, child: Text('Excluir', style: TextStyle(color: Colors.red),))
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: TextStyle(
                          color:
                              _pesquisaController.statusColor(_pesquisa.status),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        _pesquisa.status,
                        style: TextStyle(
                            color: _pesquisaController
                                .statusColor(_pesquisa.status),
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        _opened
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color:
                            _pesquisaController.statusColor(_pesquisa.status),
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
