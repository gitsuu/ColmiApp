import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ContactList extends StatefulWidget {
  final Function(String username, String chatId) onContactSelected;

  const ContactList({super.key, required this.onContactSelected});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final TextEditingController usernameController = TextEditingController();
  List<Map<String, dynamic>> contacts = [];
  List<String> suggestedUsernames = [];

  @override
  void initState() {
    super.initState();
    _listenForContactUpdates();
  }

  void _listenForContactUpdates() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('contacts')
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
              'chatId': contactData['chatId'] ?? '',
              'status': contactData['status'] ?? 'pending',
              'contactId': contactId,
            });
          } else {
            // Eliminar el contacto si el usuario ya no existe
            FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('contacts')
                .doc(contactId)
                .delete();
          }
        }

        setState(() {
          contacts = updatedContacts;
        });
      });
    }
  }

  Future<void> _fetchSuggestions(String query) async {
    if (query.isEmpty) {
      setState(() {
        suggestedUsernames = [];
      });
      return;
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isGreaterThanOrEqualTo: query)
        .where('username', isLessThanOrEqualTo: '$query\uf8ff')
        .get();

    setState(() {
      suggestedUsernames =
          querySnapshot.docs.map((doc) => doc['username'] as String).toList();
    });
  }

  Future<String?> _fetchContactImage(String contactId) async {
    try {
      final contactDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(contactId)
          .get();

      if (contactDoc.exists) {
        return contactDoc['profileImage'] as String?;
      }
    } catch (e) {
      debugPrint('Error al obtener la imagen de perfil: $e');
    }
    return null;
  }

  void _addContact() async {
    final username = usernameController.text.trim();
    final currentUser = FirebaseAuth.instance.currentUser;

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, introduce un nombre de usuario.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario no autenticado.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .get();

      if (querySnapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El usuario no existe.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final contactUserDoc = querySnapshot.docs.first;
      final contactUserId = contactUserDoc.id;

      final existingContact = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('contacts')
          .doc(contactUserId)
          .get();

      if (existingContact.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El usuario ya está en tu lista de contactos.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final chatId = currentUser.uid.hashCode <= contactUserId.hashCode
          ? '${currentUser.uid}_$contactUserId'
          : '${contactUserId}_${currentUser.uid}';

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('contacts')
          .doc(contactUserId)
          .set({
        'username': username,
        'chatId': chatId,
        'status': 'pending',
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(contactUserId)
          .collection('contacts')
          .doc(currentUser.uid)
          .set({
        'username': currentUser.displayName ?? currentUser.email!.split('@')[0],
        'chatId': chatId,
        'status': 'requested',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Solicitud de contacto enviada.'),
          backgroundColor: Colors.green,
        ),
      );

      usernameController.clear();
      setState(() {
        suggestedUsernames = [];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al enviar la solicitud: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: 'Agregar contacto',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                      onChanged: _fetchSuggestions,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _addContact,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (suggestedUsernames.isNotEmpty)
                Container(
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: suggestedUsernames.length,
                    itemBuilder: (context, index) {
                      final suggestion = suggestedUsernames[index];
                      return ListTile(
                        title: Text(suggestion),
                        onTap: () {
                          usernameController.text = suggestion;
                          setState(() {
                            suggestedUsernames = [];
                          });
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return FutureBuilder<String?>(
                future: _fetchContactImage(contact['contactId']),
                builder: (context, snapshot) {
                  final profileImage = snapshot.data;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: profileImage != null
                          ? AssetImage(profileImage)
                          : null,
                      child: profileImage == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    title: Text(contact['username']),
                    subtitle: Text(contact['status'] == 'accepted'
                        ? 'Haz clic para conversar'
                        : contact['status'] == 'requested'
                            ? 'Solicitud recibida'
                            : 'Estado: ${contact['status']}'),
                    trailing: contact['status'] == 'requested'
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.check),
                                onPressed: () {
                                  // Aceptar la solicitud
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .collection('contacts')
                                      .doc(contact['contactId'])
                                      .update({'status': 'accepted'});

                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(contact['contactId'])
                                      .collection('contacts')
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .update({'status': 'accepted'});
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  // Rechazar la solicitud
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .collection('contacts')
                                      .doc(contact['contactId'])
                                      .delete();

                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(contact['contactId'])
                                      .collection('contacts')
                                      .doc(FirebaseAuth
                                          .instance.currentUser?.uid)
                                      .delete();
                                },
                              ),
                            ],
                          )
                        : null,
                    onTap: contact['status'] == 'accepted'
                        ? () => widget.onContactSelected(
                              contact['username'],
                              contact['chatId'],
                            )
                        : null,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
