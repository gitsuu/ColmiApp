import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class MesesView extends StatelessWidget {
  const MesesView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> meses = [
      {'mes': 'Enero', 'imagen': 'assets/meses/enero_sign.png'},
      {'mes': 'Febrero', 'imagen': 'assets/meses/febrero_sign.png'},
      {'mes': 'Marzo', 'imagen': 'assets/meses/marzo_sign.png'},
      {'mes': 'Abril', 'imagen': 'assets/meses/abril_sign.png'},
      {'mes': 'Mayo', 'imagen': 'assets/meses/mayo_sign.png'},
      {'mes': 'Junio', 'imagen': 'assets/meses/junio_sign.png'},
      {'mes': 'Julio', 'imagen': 'assets/meses/julio_sign.png'},
      {'mes': 'Agosto', 'imagen': 'assets/meses/agosto_sign.png'},
      {'mes': 'Septiembre', 'imagen': 'assets/meses/septiembre_sign.png'},
      {'mes': 'Octubre', 'imagen': 'assets/meses/octubre_sign.png'},
      {'mes': 'Noviembre', 'imagen': 'assets/meses/noviembre_sign.png'},
      {'mes': 'Diciembre', 'imagen': 'assets/meses/diciembre_sign.png'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Meses")),
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
              itemCount: meses.length,
              itemBuilder: (context, index) {
                final mes = meses[index]['mes']!;
                final imagen = meses[index]['imagen']!;
                return FlipCard(
                  front: _buildCardFace(mes, Colors.orange, 150, 120),
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
                style: const TextStyle(fontSize: 30, color: Colors.white),
              )
            : content,
      ),
    );
  }
}
