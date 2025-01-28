import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Constelação de Estrelas'),
        ),
        body: ConstellationScreen(),
      ),
    );
  }
}

class ConstellationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Fundo preto para simular o céu
      child: SizedBox.expand(
        child: CustomPaint(
          painter: ConstellationPainter(),
        ),
      ),
    );
  }
}

class ConstellationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Coordenadas das estrelas (x, y)
    final stars = [
      Offset(size.width * 0.2, size.height * 0.3),
      Offset(size.width * 0.5, size.height * 0.1),
      Offset(size.width * 0.8, size.height * 0.3),
      Offset(size.width * 0.4, size.height * 0.5),
      Offset(size.width * 0.6, size.height * 0.7),
    ];

    // Desenhar as estrelas
    for (var star in stars) {
      canvas.drawCircle(star, 4, paint); // Estrelas como círculos
    }

    // Desenhar as linhas da constelação
    final connections = [
      [stars[0], stars[1]], // Conecta a estrela 0 com a estrela 1
      [stars[1], stars[2]], // Conecta a estrela 1 com a estrela 2
      [stars[2], stars[3]], // Conecta a estrela 2 com a estrela 3
      [stars[3], stars[4]], // Conecta a estrela 3 com a estrela 4
    ];

    for (var connection in connections) {
      canvas.drawLine(connection[0], connection[1], linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}