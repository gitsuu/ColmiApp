import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class NumerosView extends StatelessWidget {
  const NumerosView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> numeros = [
      {'numero': '1', 'imagen': 'assets/images/1_sign.png'},
      {'numero': '2', 'imagen': 'assets/images/2_sign.png'},
      {'numero': '3', 'imagen': 'assets/images/3_sign.png'},
      {'numero': '4', 'imagen': 'assets/images/4_sign.png'},
      {'numero': '5', 'imagen': 'assets/images/5_sign.png'},
      {'numero': '6', 'imagen': 'assets/images/6_sign.png'},
      {'numero': '7', 'imagen': 'assets/images/7_sign.png'},
      {'numero': '8', 'imagen': 'assets/images/8_sign.png'},
      {'numero': '9', 'imagen': 'assets/images/9_sign.png'},
      {'numero': '10', 'imagen': 'assets/images/10_sign.png'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Números")),
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
              itemCount: numeros.length,
              itemBuilder: (context, index) {
                final numero = numeros[index]['numero']!;
                final imagen = numeros[index]['imagen']!;
                return FlipCard(
                  front: _buildCardFace(
                    numero,
                    Colors.white,
                    const Color.fromARGB(255, 208, 206, 206),
                    150,
                    120,
                  ),
                  back: _buildCardFace(
                    Image.asset(imagen),
                    const Color.fromARGB(255, 255, 255, 255),
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

  Widget _buildCardFace(dynamic content, Color textColor, Color backgroundColor,
      double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: content is String
            ? Text(
                content,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                  fontFamily: 'Roboto',
                ),
              )
            : content,
      ),
    );
  }
}
