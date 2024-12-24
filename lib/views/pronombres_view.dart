import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class PronombresView extends StatelessWidget {
  const PronombresView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pronombres = [
      {'texto': 'El-Ella', 'imagen': 'assets/pronombres/el_ella_sign.png'},
      {
        'texto': 'Ellos-Ellas',
        'imagen': 'assets/pronombres/ellos_ellas_sign.png'
      },
      {'texto': 'Nosotros', 'imagen': 'assets/pronombres/nosotros_sign.png'},
      {'texto': 'Tu', 'imagen': 'assets/pronombres/tu_sign.png'},
      {'texto': 'Usted', 'imagen': 'assets/pronombres/usted_sign.png'},
      {'texto': 'Ustedes', 'imagen': 'assets/pronombres/ustedes_sign.png'},
      {'texto': 'Yo', 'imagen': 'assets/pronombres/yo_sign.png'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Pronombres")),
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
              itemCount: pronombres.length,
              itemBuilder: (context, index) {
                final texto = pronombres[index]['texto']!;
                final imagen = pronombres[index]['imagen']!;
                return FlipCard(
                  front: _buildCardFace(texto, Colors.blue, 150, 120),
                  back: _buildCardFace(
                    Image.asset(imagen),
                    const Color.fromARGB(255, 255, 255, 255),
                    150,
                    120,
                  ),
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
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : content,
      ),
    );
  }
}
