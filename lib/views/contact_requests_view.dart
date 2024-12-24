import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactRequestsView extends StatelessWidget {
  const ContactRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      return const Center(child: Text('Usuario no autenticado.'));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Solicitudes de Contacto')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('contact_requests')
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay solicitudes pendientes.'));
          }

          final requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              final senderUsername = request['senderUsername'];
              final senderId = request['senderId'];

              return ListTile(
                title: Text(senderUsername),
                subtitle: const Text('Solicitud de contacto'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () async {
                        await _acceptRequest(userId, senderId, senderUsername);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () async {
                        await _rejectRequest(userId, request.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _acceptRequest(
      String userId, String senderId, String senderUsername) async {
    final chatId = _generateChatId(userId, senderId);

    try {
      // Agregar contacto al usuario actual
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('contacts')
          .doc(senderId)
          .set({
        'username': senderUsername,
        'chatId': chatId,
      });

      // Agregar contacto al remitente
      await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('contacts')
          .doc(userId)
          .set({
        'username': FirebaseAuth.instance.currentUser?.displayName ?? 'Desconocido',
        'chatId': chatId,
      });

      // Eliminar la solicitud de contacto
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('contact_requests')
          .doc(senderId)
          .delete();

      print('Contacto aceptado: $senderUsername');
    } catch (e) {
      print('Error al aceptar la solicitud de contacto: $e');
    }
  }

  Future<void> _rejectRequest(String userId, String requestId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('contact_requests')
          .doc(requestId)
          .delete();

      print('Solicitud rechazada.');
    } catch (e) {
      print('Error al rechazar la solicitud: $e');
    }
  }

  String _generateChatId(String userId, String senderId) {
    return userId.hashCode <= senderId.hashCode
        ? '${userId}_$senderId'
        : '${senderId}_$userId';
  }
}
