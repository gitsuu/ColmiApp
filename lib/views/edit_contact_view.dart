import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditContactView extends StatelessWidget {
  final String username;

  const EditContactView({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      appBar: AppBar(
        title: const Text('Editar Contacto'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20), // Espacio superior
            // Mostrar nombre de usuario
            _buildInfoTile(
              context,
              icon: Icons.person,
              title: 'Nombre de usuario',
              value: username,
            ),
            // Mostrar correo electrónico como texto fijo
            _buildInfoTile(
              context,
              icon: Icons.email,
              title: 'Correo electrónico',
              value: 'Correo no disponible',
            ),
            const Divider(height: 40, thickness: 1),
            // Botón de bloquear contacto (solo visual)
            _buildOptionTile(
              context,
              icon: Icons.block,
              title: 'Bloquear contacto',
              titleStyle: TextStyle(color: Colors.red),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Funcionalidad no disponible.'),
                  ),
                );
              },
            ),
            // Botón para eliminar contacto
            _buildOptionTile(
              context,
              icon: Icons.delete,
              title: 'Eliminar contacto',
              titleStyle: TextStyle(color: Colors.red),
              onTap: () => _confirmDelete(context),
            ),
            const SizedBox(height: 20), // Espacio inferior
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController confirmationController =
            TextEditingController();

        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('¿Estás seguro de eliminar a $username?'),
              const SizedBox(height: 10),
              TextField(
                controller: confirmationController,
                decoration: const InputDecoration(
                  labelText: 'Escribe "confirmar" para eliminar',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (confirmationController.text.toLowerCase() == 'confirmar') {
                  Navigator.of(context).pop();
                  _deleteContact(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Acción no confirmada.'),
                    ),
                  );
                }
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteContact(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final contactQuery = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('contacts')
          .where('username', isEqualTo: username)
          .get();

      if (contactQuery.docs.isNotEmpty) {
        final contactId = contactQuery.docs.first.id;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('contacts')
            .doc(contactId)
            .delete();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$username ha sido eliminado.')),
          );
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home',
            (route) => false,
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se pudo eliminar el contacto.')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al eliminar el contacto.')),
        );
      }
    }
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    TextStyle? titleStyle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        title,
        style: titleStyle ?? Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: onTap,
    );
  }
}
