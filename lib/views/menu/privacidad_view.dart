import 'package:flutter/material.dart';

class PrivacidadView extends StatelessWidget {
  const PrivacidadView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacidad'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título principal
            Text(
              'Privacidad y Seguridad',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Sección de cumplimiento
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cumplimos con normativas internacionales',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '- Ley N° 19.628 sobre Protección de la Vida Privada (Chile).',
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '- Reglamento General de Protección de Datos (GDPR, Europa).',
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '- Ley de Privacidad del Consumidor de California (CCPA, EE.UU.).',
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      '- ISO/IEC 27001: Gestión de Seguridad de la Información.'),
                    const SizedBox(height: 5),
                    const Text(
                      '- ISO/IEC 29100: Marco de privacidad para sistemas de información.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Uso de datos
            Text(
              'Cómo utilizamos tus datos',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tus datos personales se utilizan únicamente para ofrecer una experiencia segura y personalizada. La información nunca será compartida con terceros sin tu consentimiento.',
            ),
            const SizedBox(height: 20),

            // Seguridad
            Text(
              'Medidas de Seguridad',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.lock, color: theme.colorScheme.primary),
              title: const Text('Cifrado extremo a extremo'),
              subtitle: const Text(
                  'Tus chats y videollamadas están protegidos con cifrado de extremo a extremo.'),
            ),
            ListTile(
              leading: Icon(Icons.security, color: theme.colorScheme.primary),
              title: const Text('Autenticación segura'),
              subtitle: const Text(
                  'Implementamos autenticación de dos factores (2FA) para mayor seguridad.'),
            ),
            const SizedBox(height: 20),

            // Derechos de los usuarios
            Text(
              'Tus derechos',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '- Derecho a acceder, rectificar y eliminar tus datos personales.',
            ),
            const SizedBox(height: 5),
            const Text(
              '- Derecho a la portabilidad de datos según el RGPD.',
            ),
            const SizedBox(height: 5),
            const Text(
              '- Derecho a revocar tu consentimiento en cualquier momento.',
            ),
            const SizedBox(height: 20),

            // Sección de contacto
            Text(
              '¿Tienes preguntas?',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.email, color: theme.colorScheme.primary),
              title: const Text('Contáctanos'),
              subtitle: const Text('privacy@chatapp.com'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
