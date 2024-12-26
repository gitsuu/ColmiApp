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
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Animales"),
      ),
      body: Stack(
        children: [
          // Fondo dinámico según el tema
          Positioned.fill(
            child: Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/logos/diccionario_night.png'
                  : 'assets/logos/diccionario_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 720 ? 4 : 2;

                return GridView.builder(
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
                      front: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[800]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            animal,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      back: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            imagen,
                            height: 100.0,
                            width: 100.0,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
