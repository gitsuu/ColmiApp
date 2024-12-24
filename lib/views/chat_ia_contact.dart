import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatIAContactView extends StatefulWidget {
  const ChatIAContactView({super.key});

  @override
  State<ChatIAContactView> createState() => _ChatIAContactViewState();
}

class _ChatIAContactViewState extends State<ChatIAContactView> {
  List<Map<String, dynamic>> contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  void _loadContacts() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('contacts')
          .where('status', isEqualTo: 'accepted') // Solo contactos aceptados
          .snapshots()
          .listen((snapshot) async {
        if (!mounted) return;

        final updatedContacts = <Map<String, dynamic>>[];

        for (var doc in snapshot.docs) {
          final contactData = doc.data();
          final contactId = doc.id;

          // Verificar si el usuario asociado aún existe en Firestore
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(contactId)
              .get();

          if (userDoc.exists) {
            updatedContacts.add({
              'username': contactData['username'] ?? 'Sin nombre',
              'profileImage': userDoc['profileImage'] as String?,
              'chatId':
                  contactData['chatId']?.toString() ?? '', // Convertir a String
            });
          }
        }

        setState(() {
          contacts = updatedContacts;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactos Chat IA'),
        centerTitle: true,
      ),
      body: contacts.isEmpty
          ? const Center(
              child: Text('No tienes contactos aceptados.'),
            )
          : ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                final profileImage = contact['profileImage'];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: profileImage != null
                        ? NetworkImage(profileImage)
                        : null,
                    child:
                        profileImage == null ? const Icon(Icons.person) : null,
                  ),
                  title: Text(contact['username']),
                  onTap: () {
                    // Navegar a la vista de Chat IA con los argumentos necesarios
                    Navigator.of(context).pushNamed(
                      '/chatIAMsg', // Ruta de ChatIAMsgView
                      arguments: {
                        'username': contact['username']?.toString() ?? '',
                        'chatId': contact['chatId']?.toString() ??
                            '', // Convertir a String
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
