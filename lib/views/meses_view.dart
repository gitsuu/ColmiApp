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
      appBar: AppBar(
        title: const Text("Meses"),
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
                  itemCount: meses.length,
                  itemBuilder: (context, index) {
                    final mes = meses[index]['mes']!;
                    final imagen = meses[index]['imagen']!;

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
                            mes,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
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
