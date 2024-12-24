import 'package:flutter/material.dart';

class AcercaDeView extends StatelessWidget {
  const AcercaDeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado
            Text(
              'Acerca de esta aplicación',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Tarjeta interactiva sobre la misión
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Misión de la App'),
                    content: const Text(
                      'Esta aplicación busca mejorar la comunicación y accesibilidad para la comunidad sorda chilena mediante herramientas innovadoras como reconocimiento de señas en tiempo real.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cerrar'),
                      ),
                    ],
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.accessibility, size: 40, color: theme.colorScheme.primary),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'Aprende más sobre nuestra misión inclusiva.',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Características principales
            Text(
              'Características principales',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.chat, color: theme.colorScheme.primary),
                    title: const Text('Chat en tiempo real'),
                    subtitle: const Text('Comunícate fácilmente con tus contactos.'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.videocam, color: theme.colorScheme.primary),
                    title: const Text('Videollamadas HD'),
                    subtitle: const Text('Videollamadas en alta calidad (720p y 1080p para Premium).'),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.gesture, color: theme.colorScheme.primary),
                    title: const Text('Reconocimiento de señas'),
                    subtitle: const Text('Traducción de señas en tiempo real durante videollamadas.'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Créditos
            Text(
              'Créditos',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Desarrollado por estudiantes chilenos apasionados por la inclusión y la tecnología.',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Versión de la aplicación
            Text(
              'Versión de la aplicación',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'ChatApp versión 1.0.0',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            // Contacto
            Text(
              'Contacto',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.email, color: theme.colorScheme.primary),
              title: const Text('Email'),
              subtitle: const Text('support@chatapp.com'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.web, color: theme.colorScheme.primary),
              title: const Text('Sitio web'),
              subtitle: const Text('www.chatapp.com'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}