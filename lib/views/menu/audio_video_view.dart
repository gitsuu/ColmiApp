import 'package:flutter/material.dart';

class AudioVideoView extends StatelessWidget {
  const AudioVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio/Video'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado
            Text(
              'Configuración de Audio y Video',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Calidad de video
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.high_quality, color: theme.colorScheme.primary),
                title: const Text('Calidad de video'),
                subtitle: const Text('Selecciona la calidad para videollamadas.'),
                trailing: DropdownButton<String>(
                  items: const [
                    DropdownMenuItem(value: '720p', child: Text('720p')),
                    DropdownMenuItem(value: '1080p', child: Text('1080p (Premium)')),
                  ],
                  onChanged: (value) {},
                  hint: const Text('720p'),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Configuración de audio
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: SwitchListTile(
                title: const Text('Reducción de ruido'),
                subtitle: const Text('Reduce el ruido de fondo durante las llamadas.'),
                value: true,
                onChanged: (bool value) {},
                activeColor: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),

            // Altavoz o auriculares
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: SwitchListTile(
                title: const Text('Usar altavoz'),
                subtitle: const Text('Activa o desactiva el altavoz durante las llamadas.'),
                value: false,
                onChanged: (bool value) {},
                activeColor: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),

            // Encabezado de pruebas
            Text(
              'Pruebas de Audio y Video',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Botón de prueba de audio
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.speaker, color: theme.colorScheme.primary),
                title: const Text('Probar audio'),
                subtitle: const Text('Reproduce un sonido para verificar el audio.'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reproduciendo sonido de prueba...')),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // Botón de prueba de video
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: ListTile(
                leading: Icon(Icons.videocam, color: theme.colorScheme.primary),
                title: const Text('Probar video'),
                subtitle: const Text('Muestra la vista previa de la cámara.'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mostrando vista previa de la cámara...')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
