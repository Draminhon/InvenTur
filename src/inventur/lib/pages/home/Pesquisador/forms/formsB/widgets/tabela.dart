import 'package:flutter/material.dart';

class Tabela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    return 
    Table(
                
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children:   [
                  TableRow(

                      decoration: BoxDecoration(
                          color: Colors.white),
                      children: [
                        TableCell(

                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Entidade/guia\nturístico',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Categoria/tipo/classificação/número',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                                   textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                      TableRow(
                      decoration: BoxDecoration(
                          color: Colors.white),
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Mtur',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'CADASTUR\noutros',
                              style: TextStyle(color: Colors.black),
                                   textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ]),
                       TableRow(
                      decoration: BoxDecoration(
                          color: Colors.white),
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Associações e sindicatos do\nsetor de hospedagem',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              
                            
                            ),
                          ),
                        )
                      ]),
                       TableRow(
                      decoration: BoxDecoration(
                          color: Colors.white),
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Associações de turismos',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              
                            
                            ),
                          ),
                        )
                      ]),
                       TableRow(
                      decoration: BoxDecoration(
                          color: Colors.white),
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Associações comerciais',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              
                            
                            ),
                          ),
                        )
                      ]),
                       TableRow(
                      decoration: BoxDecoration(
                          color: Colors.white),
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Guías Turísticos',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                             child: TextField(
                              
                            
                            ),
                          ),
                        )
                      ]),
                      TableRow(
                      decoration: BoxDecoration(
                          color: Colors.white),
                      children: [
                        TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Outros',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: 
                            SizedBox(height:sizeScreen.height * 0.05  ,child: 
                            TextField(
                              decoration: null ,
                            
                            ),)
                          ),
                        )
                      ]),
                ],
              );

              
  }
}
