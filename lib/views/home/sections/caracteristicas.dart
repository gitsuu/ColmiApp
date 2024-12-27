import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CaracteristicasSection extends StatelessWidget {
  const CaracteristicasSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        int crossAxisCount = screenWidth > 900
            ? 3
            : screenWidth > 600
                ? 2
                : 1;
        double aspectRatio = screenWidth > 600 ? 1.5 : 2;
        double horizontalPadding = screenWidth > 900
            ? 100
            : screenWidth > 600
                ? 50
                : 20;

        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: 40,
            horizontal: horizontalPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Características',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 76, 119, 255),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Cambiamos las reglas del juego',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF19233D),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 40,
                  childAspectRatio: aspectRatio,
                ),
                itemCount: _caracteristicas.length,
                itemBuilder: (context, index) {
                  return _CaracteristicaCard(
                    caracteristica: _caracteristicas[index],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Caracteristica {
  final String title;
  final String description;

  _Caracteristica({required this.title, required this.description});
}

final List<_Caracteristica> _caracteristicas = [
  _Caracteristica(
    title: 'Comunicación sin Barreras',
    description:
        'Elimina las barreras de comunicación con traducción en tiempo real entre Lengua de Señas y lenguaje hablado/texto. Conéctate sin problemas con la comunidad Sorda.',
  ),
  _Caracteristica(
    title: 'Inteligencia Artificial Avanzada',
    description:
        'Nuestra IA aprende y se adapta a tus necesidades, ofreciendo predicción de Lengua de Señas y mejora continua en la precisión de la traducción para una experiencia más personalizada.',
  ),
  _Caracteristica(
    title: 'Conectividad Multiplataforma',
    description:
        'Accede a tus videoconferencias desde cualquier dispositivo: móviles (iOS y Android), tablets y computadoras. Disfruta de una sincronización perfecta entre plataformas para no perderte ninguna conversación.',
  ),
  _Caracteristica(
    title: 'Subtitulado Automático',
    description:
        'Genera subtítulos en tiempo real para todas las conversaciones, mejorando la accesibilidad y la comprensión para todos los participantes.',
  ),
  _Caracteristica(
    title: 'Grabación y Transcripción',
    description:
        'Graba tus videoconferencias y obtén transcripciones automáticas para repasar la información o compartirla con quienes no pudieron asistir.',
  ),
  _Caracteristica(
    title: 'Seguridad y Privacidad',
    description:
        'Encriptación de extremo a extremo y protocolos de seguridad robustos para proteger la confidencialidad de tus conversaciones y datos.',
  ),
];

class _CaracteristicaCard extends StatelessWidget {
  final _Caracteristica caracteristica;
  const _CaracteristicaCard({required this.caracteristica});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.blue),
          const SizedBox(height: 20),
          Text(
            caracteristica.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            caracteristica.description,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
