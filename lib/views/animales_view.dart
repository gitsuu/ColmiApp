import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class AnimalesView extends StatelessWidget {
  const AnimalesView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> animales = [
      {'animal': 'Araña', 'imagen': 'assets/animales/araña_sign.png'},
      {'animal': 'Gallina', 'imagen': 'assets/animales/gallina_sign.png'},
      {'animal': 'Gallo', 'imagen': 'assets/animales/gallo_sign.png'},
      {'animal': 'Gato', 'imagen': 'assets/animales/gato_sign.png'},
      {'animal': 'Jirafa', 'imagen': 'assets/animales/jirafa_sign.png'},
      {'animal': 'Leon', 'imagen': 'assets/animales/leon_sign.png'},
      {'animal': 'Mono', 'imagen': 'assets/animales/mono_sign.png'},
      {'animal': 'Oso', 'imagen': 'assets/animales/oso_sign.png'},
      {'animal': 'Perro', 'imagen': 'assets/animales/perro_sign.png'},
      {'animal': 'Pescado', 'imagen': 'assets/animales/pescado_sign.png'},
      {'animal': 'Serpiente', 'imagen': 'assets/animales/serpiente_sign.png'},
      {'animal': 'Tigre', 'imagen': 'assets/animales/tigre_sign.png'},
      // Agrega más animales aquí
    ];

    // Detectar el ancho de la pantalla para ajustar el número de columnas
    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2;
    if (screenWidth >= 720) {
      crossAxisCount = 4;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Animales")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemCount: animales.length,
          itemBuilder: (context, index) {
            final animal = animales[index]['animal']!;
            final imagen = animales[index]['imagen']!;
            return FlipCard(
              front: _buildCardFace(animal, Colors.green, 150, 120),
              back: _buildCardFace(Image.asset(imagen),
                  const Color.fromARGB(255, 255, 255, 255), 150, 120),
            );
          },
        ),
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
