import 'package:flutter/material.dart';

class CaracteristicasView extends StatelessWidget {
  const CaracteristicasView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Navbar superior
            _buildNavBar(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Sección
                    _buildHeader(isMobile),
                    const SizedBox(height: 20),
                    // Lista de Características Minimalista
                    _buildFeaturesMinimalist(isMobile),
                    const SizedBox(height: 30),
                    // Sección de Ventajas con diseño alternativo adaptado para móvil
                    _buildAdvantagesSection(isMobile),
                    const SizedBox(height: 30),
                    // Llamada a la acción final
                    _buildCTA(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo e identificación
          Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 50,
                  maxWidth: 50,
                ),
                child: Image.asset(
                  'assets/logos/logo-light.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                "Colmee",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          // Menú de navegación
          Row(
            children: [
              _navItem(context, "Inicio", '/inicio'),
              _navItem(context, "Características", '/caracteristicas'),
              _navItem(context, "Acerca de", '/acerca'),
              _navItem(context, "Contacto", '/contacto'),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Ingresar"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blueAccent.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "¿Qué ofrece Colmee?",
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            "Innovación, inclusión y facilidad de uso en una sola plataforma. Conoce nuestras principales características.",
            style: TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesMinimalist(bool isMobile) {
    const features = [
      {
        "icon": Icons.accessibility_new,
        "title": "Inclusión",
        "description": "Tecnología para todos, facilitando la comunicación accesible.",
      },
      {
        "icon": Icons.video_call,
        "title": "Videollamadas",
        "description": "Transmisiones fluidas con soporte de lenguaje de señas.",
      },
      {
        "icon": Icons.school,
        "title": "Educación",
        "description": "Aprende Lengua de Señas Chilena con herramientas educativas integradas.",
      },
      {
        "icon": Icons.security,
        "title": "Seguridad",
        "description": "Protección avanzada para tus datos personales.",
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: features.map((feature) {
          return Column(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.blueAccent.withOpacity(0.1),
                child: Icon(
                  feature['icon'] as IconData,
                  color: Colors.blueAccent,
                  size: 40,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                feature['title'] as String,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 200,
                child: Text(
                  feature['description'] as String,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAdvantagesSection(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Text(
            "Ventajas de usar Colmee",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: [
              _buildAdvantageTile(Icons.speed, "Rápida Conexión"),
              _buildAdvantageTile(Icons.design_services, "Diseño Intuitivo"),
              _buildAdvantageTile(Icons.lock, "Alta Seguridad"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdvantageTile(IconData icon, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 40,
          color: Colors.blueAccent,
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildCTA() {
    return Column(
      children: [
        const Text(
          "¿Listo para descubrir más?",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text(
            "Explorar más",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
