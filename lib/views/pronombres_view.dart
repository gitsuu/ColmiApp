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
      appBar: AppBar(
        title: const Text("Pronombres"),
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
                  itemCount: pronombres.length,
                  itemBuilder: (context, index) {
                    final texto = pronombres[index]['texto']!;
                    final imagen = pronombres[index]['imagen']!;

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
                            texto,
                            style: TextStyle(
                              fontSize: 22,
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
