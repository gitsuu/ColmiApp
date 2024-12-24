import 'package:flutter/material.dart';

class AyudaView extends StatelessWidget {
  const AyudaView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TextEditingController ticketController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado
            Text(
              'Centro de Ayuda',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Sección de preguntas frecuentes
            Text(
              'Preguntas Frecuentes',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ExpansionTile(
              leading:
                  Icon(Icons.help_outline, color: theme.colorScheme.primary),
              title: const Text('¿Cómo realizo una videollamada?'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      'Puedes iniciar una videollamada desde el menú principal seleccionando un contacto y presionando el ícono de cámara.'),
                ),
              ],
            ),
            ExpansionTile(
              leading:
                  Icon(Icons.help_outline, color: theme.colorScheme.primary),
              title: const Text('¿Cómo configuro mis notificaciones?'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      'Accede a la sección de configuración y selecciona "Notificaciones" para personalizarlas según tus preferencias.'),
                ),
              ],
            ),
            ExpansionTile(
              leading:
                  Icon(Icons.help_outline, color: theme.colorScheme.primary),
              title: const Text('¿Cómo actualizo a Premium?'),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                      'Dirígete a la sección "Cuenta" y selecciona "Actualizar a Premium" para acceder a beneficios exclusivos.'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Sección para enviar un ticket
            Text(
              'Enviar un Ticket',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: ticketController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Escribe tu consulta o problema aquí...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: theme.colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Ticket enviado: ${ticketController.text}'),
                    ),
                  );
                  ticketController.clear();
                },
                icon: const Icon(Icons.send),
                label: const Text('Enviar'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
