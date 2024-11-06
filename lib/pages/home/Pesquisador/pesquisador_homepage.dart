import 'package:flutter/material.dart';
import 'package:inventur/pages/home/Pesquisador/widgets/container_widget.dart';
import 'package:intl/intl.dart';

class PesquisadorHome extends StatelessWidget {
  const PesquisadorHome({super.key});

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
        title:  Text('Minhas Pesquisas',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 55, 111, 60),
                      fontSize: sizeScreen.width * 0.06),
                ),centerTitle: true,
                
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
      body: Padding(
          padding: EdgeInsets.only(
            top: sizeScreen.height * 0.01,
            left: sizeScreen.height * 0.02,
            right: sizeScreen.height * 0.02,
          ),
          child: ListView(padding: const EdgeInsets.only( bottom: 20),children: [
            ContainerWidget(
                11111,
                'Ceará',
                'Viçosa do Ceará',
                outputFormat.format(inputFormat.parse('07/02/2024')),
                outputFormat.format(now),
                 4,
                3),
            ContainerWidget(22222, 'Ceará', 'Tianguá', outputFormat.format(now),
                outputFormat.format(now), 4, 5),
            ContainerWidget(33333, 'Ceará', 'Sobral', outputFormat.format(now),
                outputFormat.format(now), 3, 8),
            ContainerWidget(
                4444,
                'Ceará',
                'Fortaleza',
                outputFormat.format(now),
                outputFormat.format(now),
                2,
                5),
            ContainerWidget(
                5555,
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
