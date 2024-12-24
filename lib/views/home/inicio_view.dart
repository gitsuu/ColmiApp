import 'package:flutter/material.dart';

class InicioView extends StatelessWidget {
  const InicioView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Barra de navegación
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo e identificación
                  Flexible(
                    child: Row(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 55, // Altura máxima del logo
                            maxWidth: 60, // Ancho máximo del logo
                          ),
                          child: Image.asset(
                            'assets/logos/logo-light.png', // Ruta de la imagen local
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Flexible(
                          child: Text(
                            "Colmee",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow:
                                TextOverflow.ellipsis, // Maneja texto largo
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Menú de navegación
                  isMobile
                      ? PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (value) {
                            if (value == "Características") {
                              Navigator.of(context)
                                  .pushNamed('/caracteristicas');
                            } else if (value == "Acerca de") {
                              Navigator.of(context).pushNamed('/acerca');
                            } else if (value == "Ingresar") {
                              Navigator.of(context).pushNamed('/login');
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: "Inicio",
                              child: Text("Inicio"),
                            ),
                            const PopupMenuItem(
                              value: "Características",
                              child: Text("Características"),
                            ),
                            const PopupMenuItem(
                              value: "Acerca de",
                              child: Text("Acerca de"),
                            ),
                            const PopupMenuItem(
                              value: "Contacto",
                              child: Text("Contacto"),
                            ),
                            const PopupMenuItem(
                              value: "Ingresar",
                              child: Text("Ingresar"),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            _navItem(
                              "Inicio",
                              () {
                                // Acción para Inicio
                              },
                            ),
                            _navItem(
                              "Características",
                              () {
                                Navigator.of(context)
                                    .pushNamed('/caracteristicas');
                              },
                            ),
                            _navItem(
                              "Acerca de",
                              () {
                                Navigator.of(context).pushNamed('/acerca');
                              },
                            ),
                            _navItem(
                              "Contacto",
                              () {
                                // Acción para Contacto
                              },
                            ),
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
            ),
            const SizedBox(height: 20),
            // Contenido principal
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: isMobile
                        ? Column(
                            children: [
                              _iconSection(),
                              const SizedBox(height: 20),
                              _textSection(),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(child: _textSection()),
                              const SizedBox(width: 50),
                              Flexible(child: _iconSection()),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _textSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Bienvenido a Mi Página de Inicio",
          style: TextStyle(
            fontSize: 28, // Ajustado para pantallas pequeñas
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center, // Alineación responsiva
        ),
        SizedBox(height: 20),
        Text(
          "Esta es una página de inicio simple y responsiva construida con Flutter. "
          "Puedes personalizarla para que se ajuste a tus necesidades y muestres tu producto o aplicación de manera efectiva.",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center, // Alineación responsiva
        ),
      ],
    );
  }

  Widget _iconSection() {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: const [
        Icon(Icons.phone_android, size: 50, color: Colors.blueAccent),
        Icon(Icons.web, size: 50, color: Colors.blueAccent),
        Icon(Icons.security, size: 50, color: Colors.blueAccent),
        Icon(Icons.support, size: 50, color: Colors.blueAccent),
      ],
    );
  }
}
