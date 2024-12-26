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
      appBar: AppBar(
        title: const Text("Sentimientos"),
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
                  itemCount: sentimientos.length,
                  itemBuilder: (context, index) {
                    final palabra = sentimientos[index]['palabra']!;
                    final imagen = sentimientos[index]['imagen']!;

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
