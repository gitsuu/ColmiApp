import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class SentimientosView extends StatelessWidget {
  const SentimientosView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> sentimientos = [
      {'palabra': 'Alegre', 'imagen': 'assets/sentimientos/alegre_sign.png'},
      {'palabra': 'Amable', 'imagen': 'assets/sentimientos/amable_sign.png'},
      {'palabra': 'Amor', 'imagen': 'assets/sentimientos/amor_sign.png'},
      {'palabra': 'Atento', 'imagen': 'assets/sentimientos/atento_sign.png'},
      {'palabra': 'Celos', 'imagen': 'assets/sentimientos/celos_sign.png'},
      {'palabra': 'Culpa', 'imagen': 'assets/sentimientos/culpa_sign.png'},
      {'palabra': 'Egoista', 'imagen': 'assets/sentimientos/egoista_sign.png'},
      {'palabra': 'Feliz', 'imagen': 'assets/sentimientos/feliz_sign.png'},
      {
        'palabra': 'Nostalgia',
        'imagen': 'assets/sentimientos/nostalgia_sign.png'
      },
      {
        'palabra': 'Simpatico',
        'imagen': 'assets/sentimientos/simpatico_sign.png'
      },
      {'palabra': 'Sufrir', 'imagen': 'assets/sentimientos/sufrir_sign.png'},
      {'palabra': 'Triste', 'imagen': 'assets/sentimientos/triste_sign.png'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Sentimientos")),
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
              itemCount: sentimientos.length,
              itemBuilder: (context, index) {
                final palabra = sentimientos[index]['palabra']!;
                final imagen = sentimientos[index]['imagen']!;
                return FlipCard(
                  front: _buildCardFace(palabra, Colors.red, 160, 120),
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
