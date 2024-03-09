import 'package:flutter/material.dart';


class ExpansionTileExample extends StatefulWidget{
  const ExpansionTileExample({super.key});

  @override
  State<ExpansionTileExample> createState() => _ExpansionTile();
}

class _ExpansionTile extends State<ExpansionTileExample>{
    bool _customTileExpanded = false;
    
    @override 
      Widget build(BuildContext context){
       Size sizeScreen = MediaQuery.sizeOf(context);
        return  Column(
          children: [
            
            ExpansionTile(title: Text('ADICIONAR NOVO LOCAL', style: TextStyle(color: const Color.fromARGB(255, 55, 111, 60)),),
            collapsedBackgroundColor: Colors.white,
            tilePadding: EdgeInsets.only(left: sizeScreen.width * 0.22, right: sizeScreen.width * 0.08),
            backgroundColor: Colors.white,
            collapsedShape: Border(top: BorderSide(width: 0.5, color: Colors.black), bottom: BorderSide(width: 0.5, color: Colors.black)),
            childrenPadding: EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.3 ),
              children: <Widget>[
                ListTile(title: (Text('Categoria A')), onTap: () => Navigator.pushNamed(context, '/FormA'),),
                ListTile(title: (Text('Categoria B'))),
                ListTile(title: (Text('Categoria C')) )
              ],
            )


          ],
        );
      }




}