import 'package:flutter/material.dart';

class SubscriptionOptionsView extends StatelessWidget {
  const SubscriptionOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Opciones de Suscripción'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isWeb
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: _buildSubscriptionCard(
                        context,
                        title: 'Gratis',
                        color: Colors.green,
                        features: [
                          '• Videollamadas en calidad 720p',
                          '• Sin opción para grabar videollamadas',
                          '• Mensajes ilimitados',
                          '• Publicidad incluida',
                          '• Acceso limitado al diccionario de señas (50 palabras)',
                        ],
                        buttonText: 'Seleccionar',
                        buttonAction: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Actualmente estás en el plan Gratis.',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: _buildSubscriptionCard(
                        context,
                        title: 'Premium',
                        color: Colors.amber,
                        features: [
                          '• Videollamadas en calidad 1080p',
                          '• Posibilidad de grabar videollamadas',
                          '• Traducción en tiempo real del lenguaje de señas',
                          '• Sin anuncios publicitarios',
                          '• Acceso completo al diccionario de señas (más de 10,000 palabras)',
                        ],
                        buttonText: 'Actualizar',
                        buttonAction: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Función Premium próximamente disponible.',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildSubscriptionCard(
                      context,
                      title: 'Gratis',
                      color: Colors.green,
                      features: [
                        '• Videollamadas en calidad 720p',
                        '• Sin opción para grabar videollamadas',
                        '• Mensajes ilimitados',
                        '• Publicidad incluida',
                        '• Acceso limitado al diccionario de señas (50 palabras)',
                      ],
                      buttonText: 'Seleccionar',
                      buttonAction: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Actualmente estás en el plan Gratis.',
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildSubscriptionCard(
                      context,
                      title: 'Premium',
                      color: Colors.amber,
                      features: [
                        '• Videollamadas en calidad 1080p',
                        '• Posibilidad de grabar videollamadas',
                        '• Traducción en tiempo real del lenguaje de señas',
                        '• Sin anuncios publicitarios',
                        '• Acceso completo al diccionario de señas (más de 10,000 palabras)',
                      ],
                      buttonText: 'Actualizar',
                      buttonAction: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Función Premium próximamente disponible.',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildSubscriptionCard(
    BuildContext context, {
    required String title,
    required Color color,
    required List<String> features,
    required String buttonText,
    required VoidCallback buttonAction,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 300, maxHeight: 400),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    title == 'Gratis' ? Icons.check_circle : Icons.star,
                    color: color,
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: features.map((feature) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        feature,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: buttonAction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
