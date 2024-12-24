import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'username_view.dart';
import 'email_view.dart';
import 'delete_account_view.dart';
import 'icon_selection_view.dart';
import 'subscription_options_view.dart'; // Importar la nueva vista de suscripciones

class CuentaView extends StatefulWidget {
  const CuentaView({super.key});

  @override
  _CuentaViewState createState() => _CuentaViewState();
}

class _CuentaViewState extends State<CuentaView> {
  String? profileImage;
  String? username;
  String? email;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            profileImage = userDoc.data()?['profileImage'] as String?;
            username = userDoc.data()?['username'] as String?;
            email = user.email; // Obtener directamente del objeto `user`
          });
        } else {
          // Si el documento no existe, manejar el caso
          setState(() {
            username = 'Usuario no configurado';
            email = 'Correo no configurado';
          });
        }
      }
    } catch (e) {
      // Manejar errores de carga de datos
      debugPrint('Error al cargar datos del usuario: $e');
      setState(() {
        username = 'Error al cargar';
        email = 'Error al cargar';
      });
    }
  }

  Future<void> _updateProfileImage(String newImagePath) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'profileImage': newImagePath});
        setState(() {
          profileImage = newImagePath;
        });
      }
    } catch (e) {
      debugPrint('Error al actualizar la imagen de perfil: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuenta'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    backgroundImage: profileImage != null
                        ? NetworkImage(profileImage!) as ImageProvider
                        : null,
                    child: profileImage == null
                        ? Icon(
                            Icons.person,
                            size: 60,
                            color: theme.colorScheme.onPrimaryContainer,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.primary,
                      ),
                      child: IconButton(
                        onPressed: () {
                          IconSelectionView.showIconSelectionModal(
                            context,
                            (selectedIcon) async {
                              await _updateProfileImage(selectedIcon);
                            },
                          );
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.person, color: theme.colorScheme.primary),
                title: const Text('Nombre de usuario'),
                subtitle: Text(username ?? 'Cargando...'),
                trailing: Icon(Icons.edit, color: theme.colorScheme.primary),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const UsernameView(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.email, color: theme.colorScheme.primary),
                title: const Text('Correo electrónico'),
                subtitle: Text(email ?? 'Cargando...'),
                trailing: Icon(Icons.edit, color: theme.colorScheme.primary),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const EmailView(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.star, color: Colors.amber),
                title: const Text(
                  'Actualizar a Premium',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 10,
                        color: Colors.amberAccent,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SubscriptionOptionsView(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.delete, color: theme.colorScheme.error),
                title: const Text(
                  'Eliminar cuenta',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const DeleteAccountView(),
                    ),
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
