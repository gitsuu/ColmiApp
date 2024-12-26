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
      appBar: AppBar(
        title: const Text("Números"),
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
                  itemCount: numeros.length,
                  itemBuilder: (context, index) {
                    final numero = numeros[index]['numero']!;
                    final imagen = numeros[index]['imagen']!;

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
                            numero,
                            style: TextStyle(
                              fontSize: 28,
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
