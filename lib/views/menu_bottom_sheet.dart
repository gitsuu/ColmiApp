import 'package:flutter/material.dart';
import 'package:myapp/views/menu/cuenta_view.dart';
import 'package:myapp/views/menu/notificacion_view.dart';
import 'package:myapp/views/menu/acerca_de_view.dart';
import 'package:myapp/views/menu/audio_video_view.dart';
import 'package:myapp/views/menu/privacidad_view.dart';
import 'package:myapp/views/menu/ayuda_view.dart';

class PerfilSideSheetContent extends StatelessWidget {
  const PerfilSideSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    final options = [
      'Cuenta',
      'Notificaciones',
      'Acerca de',
      'Audio/Video',
      'Privacidad',
      'Ayuda',
    ];

    final optionIcons = [
      Icons.person,
      Icons.notifications,
      Icons.info,
      Icons.videocam,
      Icons.lock,
      Icons.help,
    ];

    final routes = [
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const CuentaView())),
      () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NotificacionView())),
      () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AcercaDeView())),
      () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const AudioVideoView())),
      () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PrivacidadView())),
      () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AyudaView())),
    ];

    final theme = Theme.of(context);

    final content = Padding(
      padding: const EdgeInsets.only(bottom: 16), // Ajustar espacio inferior
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.9),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Menú',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              ListView.separated(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Desactivar scroll interno
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return ElevatedButton.icon(
                    onPressed: routes[index],
                    icon: Icon(optionIcons[index], size: 24),
                    label: Text(
                      options[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
            ],
          ),
        ),
      ),
    );

    if (isWideScreen) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: content,
        ),
      );
    } else {
      return DraggableScrollableSheet(
        initialChildSize: 0.75, // Ajustar el tamaño inicial
        maxChildSize: 0.8,
        minChildSize: 0.2,
        expand: false,
        builder: (context, scrollController) {
          return Material(
            elevation: 4,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: content,
              ),
            ),
          );
        },
      );
    }
  }
}

void showPerfilBottomSheet(BuildContext context) {
  final isWideScreen = MediaQuery.of(context).size.width > 600;

  if (isWideScreen) {
    showDialog(
      context: context,
      builder: (context) => const PerfilSideSheetContent(),
    );
  } else {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PerfilSideSheetContent(),
    );
  }
}
