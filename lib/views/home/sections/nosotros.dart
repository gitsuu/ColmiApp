import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NosotrosSection extends StatelessWidget {
  const NosotrosSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double horizontalPadding = screenWidth > 900
            ? 100
            : screenWidth > 600
                ? 50
                : 20;

        return Container(
          color: Colors.white,
          padding:
              EdgeInsets.symmetric(vertical: 50, horizontal: horizontalPadding),
          child: Row(
            // Usamos un Row para la distribución horizontal
            crossAxisAlignment:
                CrossAxisAlignment.start, // Alinea los elementos arriba
            children: [
              // Espacio para la imagen (40-60% del ancho disponible)
              SizedBox(
                width: screenWidth *
                    (screenWidth > 900 ? 0.4 : 0.6), // 40% o 60% según el ancho
                child: Image.asset(
                  'assets/home/about-img.png', // Ruta de tu imagen
                  fit: BoxFit.cover, // Ajusta la imagen al contenedor
                ),
              ),
              const SizedBox(width: 40), // Espacio entre la imagen y el texto
              // Columna para el texto (el resto del ancho disponible)
              Expanded(
                // Usamos Expanded para que el texto ocupe el espacio restante
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sobre nosotros',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 76, 119, 255),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Innovamos con propósito',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF19233D),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'En Colmi, nos impulsa la convicción de que la comunicación debe ser accesible para todos. Somos un equipo multidisciplinario con experiencia en desarrollo de software, inteligencia artificial y diseño centrado en el usuario, unidos por el objetivo de crear una plataforma que facilite la comunicación entre personas sordas y oyentes.',
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 97, 97, 97)),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Combinamos nuestra experiencia técnica con una profunda comprensión de las necesidades de la comunidad Sorda para desarrollar soluciones innovadoras que realmente impacten en la vida de las personas. Creemos en el poder de la tecnología para construir puentes y fomentar la inclusión.',
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 97, 97, 97)),
                    ),
                    const SizedBox(height: 40),
                    TextButton(
                      onPressed: () {
                        // Acción del botón "More About Us"
                      },
                      style: TextButton.styleFrom(
                        foregroundColor:
                            const Color.fromARGB(255, 76, 119, 255),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Más sobre nosotros'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
