import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDetailsView extends StatelessWidget {
  final String receiverUsername;
  final String receiverId;

  const UserDetailsView({
    super.key,
    required this.receiverUsername,
    required this.receiverId,
  });

  Future<void> _blockContact(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        final userDoc = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

        await userDoc.update({
          'blockedUsers': FieldValue.arrayUnion([receiverId]), // Agregar a la lista de bloqueados
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contacto bloqueado exitosamente.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al bloquear contacto: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteContact(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        final userDoc = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);

        await userDoc.update({
          'friends': FieldValue.arrayRemove([receiverId]), // Eliminar de la lista de amigos
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contacto eliminado exitosamente.'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pop(); // Cerrar la vista después de eliminar
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al eliminar contacto: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5), // Fondo semitransparente
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: Colors.transparent), // Fondo clicable
          ),
          Center(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        receiverUsername[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      receiverUsername,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Divider(color: Colors.grey.shade300),
                    ListTile(
                      leading: const Icon(Icons.info_outline, color: Colors.blue),
                      title: const Text('Ver información'),
                      onTap: () {
                        // Lógica de "Ver información" (si aplica)
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.notifications, color: Colors.orange),
                      title: const Text('Silenciar notificaciones'),
                      onTap: () {
                        // Lógica de "Silenciar notificaciones" (si aplica)
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.block, color: Colors.red),
                      title: const Text('Bloquear contacto'),
                      onTap: () => _blockContact(context),
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete, color: Colors.redAccent),
                      title: const Text('Eliminar contacto'),
                      onTap: () => _deleteContact(context),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
