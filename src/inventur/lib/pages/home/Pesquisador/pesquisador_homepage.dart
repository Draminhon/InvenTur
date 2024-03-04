import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_widget.dart';

class PesquisadorHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
     final sizeScreen = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        width: sizeScreen.width * 0.6,
        child: Column(
         // padding:  EdgeInsets.zero,
         
          children:  <Widget>[
            UserAccountsDrawerHeader(accountName: Text('Ex'), accountEmail: Text('ex@gmail.com', ),
            currentAccountPicture: CircleAvatar(child: Text('Sz'),),),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Conta'),
            
              
              onTap: () {
                Navigator.pop(context);
                
              },
            )
          ],
        ),
      ),

      body:
       Padding( padding:  EdgeInsets.only(
            top: sizeScreen.height * 0.01,
            left: sizeScreen.height *0.02,
            right: sizeScreen.height * 0.02,
            bottom:  sizeScreen.height * 0.1,
          ),
      child: 
      ListView(children: const [
        
        ContainerWidget(11111, 'Ceará', 'Viçosa do Ceará', 17012005, 1832324, 43213123, 3),
          ContainerWidget(22222, 'Ceará', 'Tianguá', 17012005, 1832324, 732123, 5),
          ContainerWidget(33333, 'Ceará', 'Sobral', 17012005, 1832324, 123123123, 8),
          ContainerWidget(4444, 'Ceará', 'Fortaleza', 17012005, 1832324, 1512313, 153344444),
          ContainerWidget(5555, 'Ceará', 'Fortaleza', 17012005, 1832324, 15321312, 15),
          ContainerWidget(5556, 'Ceará', 'Fortaleza', 17012005, 1832324, 15321312, 15),
        
        
       
         
         
         ])),
    );
}
}