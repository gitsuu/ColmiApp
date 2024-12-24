import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class AbecedarioView extends StatelessWidget {
  const AbecedarioView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> abecedario = [
      {'letra': 'A', 'imagen': 'assets/images/a_sign.png'},
      {'letra': 'B', 'imagen': 'assets/images/b_sign.png'},
      {'letra': 'C', 'imagen': 'assets/images/c_sign.png'},
      {'letra': 'D', 'imagen': 'assets/images/d_sign.png'},
      {'letra': 'E', 'imagen': 'assets/images/e_sign.png'},
      {'letra': 'F', 'imagen': 'assets/images/f_sign.png'},
      {'letra': 'G', 'imagen': 'assets/images/g_sign.png'},
      {'letra': 'H', 'imagen': 'assets/images/h_sign.png'},
      {'letra': 'I', 'imagen': 'assets/images/i_sign.png'},
      {'letra': 'J', 'imagen': 'assets/images/j_sign.png'},
      {'letra': 'K', 'imagen': 'assets/images/k_sign.png'},
      {'letra': 'L', 'imagen': 'assets/images/l_sign.png'},
      {'letra': 'M', 'imagen': 'assets/images/m_sign.png'},
      {'letra': 'N', 'imagen': 'assets/images/n_sign.png'},
      {'letra': 'Ñ', 'imagen': 'assets/images/ñ_sign.png'},
      {'letra': 'O', 'imagen': 'assets/images/o_sign.png'},
      {'letra': 'P', 'imagen': 'assets/images/p_sign.png'},
      {'letra': 'Q', 'imagen': 'assets/images/q_sign.png'},
      {'letra': 'R', 'imagen': 'assets/images/r_sign.png'},
      {'letra': 'S', 'imagen': 'assets/images/s_sign.png'},
      {'letra': 'T', 'imagen': 'assets/images/t_sign.png'},
      {'letra': 'U', 'imagen': 'assets/images/u_sign.png'},
      {'letra': 'V', 'imagen': 'assets/images/v_sign.png'},
      {'letra': 'W', 'imagen': 'assets/images/w_sign.png'},
      {'letra': 'X', 'imagen': 'assets/images/x_sign.png'},
      {'letra': 'Y', 'imagen': 'assets/images/y_sign.png'},
      {'letra': 'Z', 'imagen': 'assets/images/z_sign.png'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Abecedario")),
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
              itemCount: abecedario.length,
              itemBuilder: (context, index) {
                final letra = abecedario[index]['letra']!;
                final imagen = abecedario[index]['imagen']!;
                return FlipCard(
                  front: _buildCardFace(letra, Colors.blue, 150, 120),
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
