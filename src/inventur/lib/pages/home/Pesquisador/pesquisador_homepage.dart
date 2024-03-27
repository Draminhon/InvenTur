import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_widget.dart';
import 'package:intl/intl.dart';

class PesquisadorHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.sizeOf(context);
    DateTime now = DateTime.now();
    var inputFormat = DateFormat('dd/MM/yyyy');

    var outputFormat = DateFormat('dd/MM/yyyy');


  


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        foregroundColor: const Color.fromARGB(255, 55, 111, 60),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        width: sizeScreen.width * 0.6,
        child: Column(
          // padding:  EdgeInsets.zero,

          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('Ex'),
              accountEmail: Text(
                'ex@gmail.com',
              ),
              currentAccountPicture: CircleAvatar(
                child: Text('Sz'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Conta'),
              onTap: () {
                Navigator.pushNamed(context, '/PerfilPesquisador');
              },
            )
          ],
        ),
      ),
      body:  Padding(
          padding: EdgeInsets.only(
            top: sizeScreen.height * 0.01,
            left: sizeScreen.height * 0.02,
            right: sizeScreen.height * 0.02,
          
          ),
          child: ListView(children: [
            ContainerWidget(
                11111,
                'Ceará',
                'Viçosa do Ceará',
                outputFormat.format(inputFormat.parse('07/02/2024')),
                outputFormat.format(now),
                43213123,
                3),
            ContainerWidget(22222, 'Ceará', 'Tianguá', outputFormat.format(now),
                outputFormat.format(now), 732123, 5),
            ContainerWidget(33333, 'Ceará', 'Sobral', outputFormat.format(now),
                outputFormat.format(now), 123123123, 8),
            ContainerWidget(
                4444,
                'Ceará',
                'Fortaleza',
                outputFormat.format(now),
                outputFormat.format(now),
                1512313,
                153344444),
            ContainerWidget(
                5555,
                'Ceará',
                'Fortaleza',
                outputFormat.format(now),
                outputFormat.format(now),
                15321312,
                15),
            ContainerWidget(
                5556,
                'Ceará',
                'Fortaleza',
                outputFormat.format(now),
                outputFormat.format(now),
                15321312,
                15),
          ])),
    );
  }
}
