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
      appBar: AppBar(title: const Text("Días de la Semana")),
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
              itemCount: diasSemana.length,
              itemBuilder: (context, index) {
                final dia = diasSemana[index]['dia']!;
                final imagen = diasSemana[index]['imagen']!;
                return FlipCard(
                  front: _buildCardFace(dia, Colors.blue, 150, 120),
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
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
            : content,
      ),
    );
  }
}
