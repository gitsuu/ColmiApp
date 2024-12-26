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
      appBar: AppBar(
        title: const Text("Abecedario"),
      ),
      body: Stack(
        children: [
          // Fondo de imagen dinámico según el modo oscuro
          Positioned.fill(
            child: Image.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? 'assets/logos/diccionario_night.png'
                  : 'assets/logos/diccionario_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: abecedario.length,
                  itemBuilder: (context, index) {
                    final letra = abecedario[index]['letra']!;
                    final imagen = abecedario[index]['imagen']!;

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
                            letra,
                            style: TextStyle(
                              fontSize: 30.0,
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
