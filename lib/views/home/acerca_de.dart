import 'package:flutter/material.dart';

class AcercaDeView extends StatelessWidget {
  const AcercaDeView({super.key});

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
                    _buildHeader(isMobile),
                    const SizedBox(height: 30),
                    _buildAboutSection(isMobile),
                    const SizedBox(height: 30),
                    _buildTeamSection(isMobile),
                    const SizedBox(height: 30),
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
            "Acerca de Colmee",
            style: TextStyle(
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            "Nuestra misión es crear un mundo más inclusivo y accesible a través de la tecnología de vanguardia.",
            style: TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(bool isMobile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Nuestra Historia",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            "Colmee nació con el propósito de derribar barreras de comunicación entre las comunidades sordas y oyentes, combinando innovación, accesibilidad y aprendizaje continuo. Nuestra plataforma facilita la interacción a través del lenguaje de señas chileno en tiempo real y soluciones educativas modernas.",
            style: TextStyle(fontSize: 16, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection(bool isMobile) {
    const teamMembers = [
      {
        "name": "María González",
        "role": "CEO y Fundadora",
        "image": "assets/team/member1.png",
      },
      {
        "name": "Juan Pérez",
        "role": "Desarrollador Principal",
        "image": "assets/team/member2.png",
      },
      {
        "name": "Carla Rodríguez",
        "role": "Diseñadora UX/UI",
        "image": "assets/team/member3.png",
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Nuestro Equipo",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: teamMembers.map((member) {
              return Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(member['image'] as String),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    member['name'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    member['role'] as String,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCTA() {
    return Column(
      children: [
        const Text(
          "¿Quieres saber más sobre Colmee?",
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
            "Contáctanos",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
