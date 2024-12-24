import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class EquipoMsgView extends StatefulWidget {
  const EquipoMsgView({super.key});

  @override
  State<EquipoMsgView> createState() => _EquipoMsgViewState();
}

class _EquipoMsgViewState extends State<EquipoMsgView> {
  double miembrosWidth = 250;
  bool isWeb = false;
  bool showEmojiPicker = false;
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isWeb = MediaQuery.of(context).size.width > 600;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final String equipoId =
        ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      body: Row(
        children: [
          if (isWeb) ...[
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  miembrosWidth += details.delta.dx;
                  if (miembrosWidth < 200) miembrosWidth = 200;
                  if (miembrosWidth > 400) miembrosWidth = 400;
                });
              },
              child: Container(
                width: miembrosWidth,
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Miembros',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('equipos')
                            .doc(equipoId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return const Center(
                                child: Text('Error al cargar los miembros.'));
                          }

                          final equipoData =
                              snapshot.data!.data() as Map<String, dynamic>;
                          final participantes =
                              (equipoData['participantes'] as List<dynamic>?) ??
                                  [];

                          if (participantes.isEmpty) {
                            return const Center(
                                child: Text('No hay miembros en este equipo.'));
                          }

                          return ListView.builder(
                            itemCount: participantes.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder<DocumentSnapshot>(
                                future: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(participantes[index])
                                    .get(),
                                builder: (context, userSnapshot) {
                                  final userData = userSnapshot.data?.data()
                                      as Map<String, dynamic>?;

                                  final profileImage =
                                      userData?['profileImage'];
                                  final username =
                                      userData?['username'] ?? 'Usuario';

                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: profileImage != null
                                          ? NetworkImage(profileImage)
                                          : null,
                                      child: profileImage == null
                                          ? const Icon(Icons.person)
                                          : null,
                                    ),
                                    title: Text(username),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          Expanded(
            child: Column(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.surface,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/editEquipos',
                            arguments: equipoId,
                          );
                        },
                        child: FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('equipos')
                              .doc(equipoId)
                              .get(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || !snapshot.data!.exists) {
                              return const Text('Equipo desconocido');
                            }

                            final equipoData =
                                snapshot.data!.data() as Map<String, dynamic>;
                            final groupLogo = equipoData['icono'];
                            final groupName = equipoData['nombre'] ?? 'Equipo';

                            return Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: groupLogo != null
                                      ? NetworkImage(groupLogo)
                                      : null,
                                  child: groupLogo == null
                                      ? const Icon(Icons.group)
                                      : null,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  groupName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.videocam),
                        tooltip: 'Videollamada',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Función no implementada.')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.call),
                        tooltip: 'Llamada',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Función no implementada.')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/chat_background_light.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('equipos')
                          .doc(equipoId)
                          .collection('mensajes')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child: Text('No hay mensajes en este equipo.'));
                        }

                        final mensajes = snapshot.data!.docs;

                        return ListView.builder(
                          reverse: true,
                          itemCount: mensajes.length,
                          itemBuilder: (context, index) {
                            final mensaje = mensajes[index];
                            final isSentByUser = mensaje['senderId'] ==
                                FirebaseAuth.instance.currentUser!.uid;

                            return ChatBubble(
                              text: mensaje['texto'],
                              senderId: mensaje['senderId'],
                              isSentByUser: isSentByUser,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.emoji_emotions),
                            onPressed: () {
                              setState(() {
                                showEmojiPicker = !showEmojiPicker;
                              });
                            },
                          ),
                          Expanded(
                            child: TextField(
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: 'Escribe un mensaje...',
                                fillColor: Colors.grey[200],
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: IconButton(
                              icon: const Icon(Icons.send, color: Colors.white),
                              onPressed: () async {
                                final texto = messageController.text.trim();
                                if (texto.isNotEmpty) {
                                  await FirebaseFirestore.instance
                                      .collection('equipos')
                                      .doc(equipoId)
                                      .collection('mensajes')
                                      .add({
                                    'texto': texto,
                                    'senderId':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'timestamp': FieldValue.serverTimestamp(),
                                  });

                                  messageController.clear();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      if (showEmojiPicker)
                        SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            onEmojiSelected: (category, emoji) {
                              messageController.text += emoji.emoji;
                            },
                            config: Config(
                              columns: 8,
                              emojiSizeMax: 32,
                              bgColor: Colors.grey[200]!,
                              iconColorSelected:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final String senderId;
  final bool isSentByUser;

  const ChatBubble({
    super.key,
    required this.text,
    required this.senderId,
    required this.isSentByUser,
  });

  Future<String> _fetchSenderName() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .get();

    return userDoc.exists ? userDoc['username'] ?? 'Usuario' : 'Usuario';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchSenderName(),
      builder: (context, snapshot) {
        final senderName = snapshot.data ?? 'Usuario';

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment: isSentByUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                senderName,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSentByUser ? Colors.teal[300] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
