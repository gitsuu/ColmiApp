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
      appBar: AppBar(
        title: const Text("Interrogativos"),
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
                final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

                return GridView.builder(
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
                            palabra,
                            style: TextStyle(
                              fontSize: 20,
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
