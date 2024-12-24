import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class InterrogativosView extends StatelessWidget {
  const InterrogativosView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> interrogativos = [
      {
        'palabra': '¿Con-Qué?',
        'imagen': 'assets/interrogativos/con_que_sign.png'
      },
      {
        'palabra': '¿Con-Quién?',
        'imagen': 'assets/interrogativos/con_quien_sign.png'
      },
      {
        'palabra': '¿Cuando?',
        'imagen': 'assets/interrogativos/cuando_sign.png'
      },
      {
        'palabra': '¿Cuánto-Tiempo?',
        'imagen': 'assets/interrogativos/cuanto_tiempo_sign.png'
      },
      {
        'palabra': '¿Cuantos?',
        'imagen': 'assets/interrogativos/cuantos_sign.png'
      },
      {
        'palabra': '¿De-Que?',
        'imagen': 'assets/interrogativos/de_que_sign.png'
      },
      {'palabra': '¿Donde?', 'imagen': 'assets/interrogativos/donde_sign.png'},
      {
        'palabra': '¿Para-Quien?',
        'imagen': 'assets/interrogativos/para_quien_sign.png'
      },
      {'palabra': '¿Quien?', 'imagen': 'assets/interrogativos/quien_sign.png'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Interrogativos")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determina el número de columnas basado en el ancho disponible
          final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemCount: interrogativos.length,
              itemBuilder: (context, index) {
                final palabra = interrogativos[index]['palabra']!;
                final imagen = interrogativos[index]['imagen']!;
                return FlipCard(
                  front: _buildCardFace(palabra, Colors.blue, 160, 120),
                  back: _buildCardFace(Image.asset(imagen),
                      const Color.fromARGB(255, 255, 255, 255), 160, 120),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardFace(
      dynamic content, Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: content is String
            ? Text(
                content,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              )
            : content,
      ),
    );
  }
}
