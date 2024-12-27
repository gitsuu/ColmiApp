import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductoSection extends StatelessWidget {
  const ProductoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        return SingleChildScrollView(
          child: Container(
            width: screenWidth,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(
                vertical: 50, horizontal: 100), // Altura reducida en 20
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(left: 5.0), // Padding solo a la izquierda
                  child: Text(
                    'Producto',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 76, 119, 255),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  'Sistema multiplataforma impulsado \ncon inteligencia artificial',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF19233D),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          _NumberedBlock(
                            number: 1,
                            title: 'Comunidad Sorda/Usuarios en general',
                            description:
                                'Rompe las barreras de comunicación. Conéctate con el mundo oyente de manera fácil y accesible. Nuestra app traduce la LSCh a texto y voz en tiempo real, permitiéndote participar activamente en conversaciones y acceder a la información sin intermediarios.',
                          ),
                          SizedBox(height: 40),
                          _NumberedBlock(
                            number: 2,
                            title: 'Instituciones/Empresas',
                            description:
                                'Fomenta la inclusión y mejora la accesibilidad. Facilita la comunicación con la comunidad sorda en tus reuniones, capacitaciones y atención al cliente. Nuestra app ofrece una solución innovadora y efectiva para la comunicación bidireccional, promoviendo un entorno más inclusivo.',
                          ),
                          SizedBox(height: 40),
                          _NumberedBlock(
                            number: 3,
                            title: 'Intérpretes/Traductores',
                            description:
                                'Optimiza tu tiempo y amplía tu alcance. Nuestra app te permite realizar interpretaciones remotas de LSCh con la ayuda de la IA, facilitando la comunicación fluida y eficiente en cualquier lugar y momento. Reduce la brecha de comunicación y llega a más personas',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 48),
                          child: Transform.translate(
                            // Usamos Transform.translate
                            offset: const Offset(
                                25, -50), // 5 a la derecha, -10 arriba
                            child: Image.asset(
                              'assets/home/service-img.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ... (Código de _NumberedBlock sin cambios)
class _NumberedBlock extends StatelessWidget {
  final int number;
  final String title;
  final String description;

  const _NumberedBlock({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFEAF4FF),
            radius: 24,
            child: Text(
              number.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2979FF),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
