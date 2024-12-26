import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class DiasDeLaSemanaView extends StatelessWidget {
  const DiasDeLaSemanaView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> diasSemana = [
      {'dia': 'Lunes', 'imagen': 'assets/dias_semana/lunes_sign.png'},
      {'dia': 'Martes', 'imagen': 'assets/dias_semana/martes_sign.png'},
      {'dia': 'Miércoles', 'imagen': 'assets/dias_semana/miercoles_sign.png'},
      {'dia': 'Jueves', 'imagen': 'assets/dias_semana/jueves_sign.png'},
      {'dia': 'Viernes', 'imagen': 'assets/dias_semana/viernes_sign.png'},
      {'dia': 'Sábado', 'imagen': 'assets/dias_semana/sabado_sign.png'},
      {'dia': 'Domingo', 'imagen': 'assets/dias_semana/domingo_sign.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Días de la Semana"),
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
                  itemCount: diasSemana.length,
                  itemBuilder: (context, index) {
                    final dia = diasSemana[index]['dia']!;
                    final imagen = diasSemana[index]['imagen']!;

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
                            dia,
                            style: TextStyle(
                              fontSize: 22,
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
