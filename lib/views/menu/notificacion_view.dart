import 'package:flutter/material.dart';

class NotificacionView extends StatelessWidget {
  const NotificacionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado
            Text(
              'Configuración de Notificaciones',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Notificaciones Push
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: SwitchListTile(
                title: const Text('Notificaciones Push'),
                subtitle: const Text(
                    'Recibe notificaciones sobre nuevos mensajes y llamadas.'),
                value: true,
                onChanged: (bool value) {},
                activeColor: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),

            // Notificaciones de Mensajes
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: SwitchListTile(
                title: const Text('Notificaciones de Mensajes'),
                subtitle:
                    const Text('Habilita las alertas para nuevos mensajes.'),
                value: true,
                onChanged: (bool value) {},
                activeColor: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),

            // Notificaciones de Videollamadas
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: SwitchListTile(
                title: const Text('Notificaciones de Videollamadas'),
                subtitle: const Text(
                    'Recibe alertas cuando alguien te llame por video.'),
                value: false,
                onChanged: (bool value) {},
                activeColor: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),

            // Notificaciones Silenciosas
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: SwitchListTile(
                title: const Text('Modo Silencioso'),
                subtitle: const Text(
                    'Silencia todas las notificaciones temporalmente.'),
                value: false,
                onChanged: (bool value) {},
                activeColor: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),

            // Preferencias avanzadas
            Text(
              'Preferencias Avanzadas',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.tune, color: theme.colorScheme.primary),
                title: const Text('Personalizar notificaciones'),
                subtitle: const Text('Configura tonos, vibración y más.'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
