import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'contact_list.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMsgView extends StatefulWidget {
  const ChatMsgView({super.key});

  @override
  State<ChatMsgView> createState() => _ChatMsgViewState();
}

class _ChatMsgViewState extends State<ChatMsgView> {
  final TextEditingController messageController = TextEditingController();
  bool showEmojiPicker = false;
  double contactPanelWidth = 300;

  Future<void> _launchVideoCall() async {
    const videoCallUrl = 'https://white-frog-30171.zap.cloud';
    if (await canLaunch(videoCallUrl)) {
      await launch(videoCallUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('No se pudo abrir la videollamada. Inténtalo nuevamente.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<String?> _fetchProfileImage(String userId) async {
    try {
      final userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: userId)
          .get();

      if (userQuery.docs.isNotEmpty) {
        final userDoc = userQuery.docs.first;
        final profileImage = userDoc.data()['profileImage'] as String?;
        return profileImage;
      }
    } catch (e) {
      print('Error fetching profile image: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (arguments == null) {
      return const Scaffold(
        body: Center(
          child: Text('Error: Argumentos no encontrados'),
        ),
      );
    }

    final receiverUsername = arguments['username']!;
    final chatId = arguments['chatId']!;
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return const Scaffold(
        body: Center(
          child: Text('Error: Usuario no autenticado'),
        ),
      );
    }

    final currentUserId = currentUser.uid;
    final backgroundAsset = Theme.of(context).brightness == Brightness.dark
        ? 'assets/images/chat_background_dark.png'
        : 'assets/images/chat_background_light.png';

    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;

    return Scaffold(
      body: Row(
        children: [
          if (isWeb)
            GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  contactPanelWidth += details.delta.dx;
                  contactPanelWidth = contactPanelWidth.clamp(200.0, 500.0);
                });
              },
              child: Container(
                width: contactPanelWidth,
                color: Colors.grey.shade200,
                child: ContactList(
                  onContactSelected: (username, selectedChatId) {
                    Navigator.of(context).pushReplacementNamed(
                      '/chatmsg',
                      arguments: {
                        'username': username,
                        'chatId': selectedChatId,
                      },
                    );
                  },
                ),
              ),
            ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.white,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, size: 28),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/editContact',
                              arguments: {
                                'username': receiverUsername,
                              });
                        },
                        child: Row(
                          children: [
                            FutureBuilder<String?>(
                              future: _fetchProfileImage(receiverUsername),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircleAvatar(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final profileImage = snapshot.data;

                                return CircleAvatar(
                                  backgroundImage: profileImage != null
                                      ? NetworkImage(profileImage)
                                      : null,
                                  child: profileImage == null
                                      ? Text(
                                          receiverUsername[0].toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      : null,
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            Text(
                              receiverUsername,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.videocam, size: 28),
                        tooltip: 'Iniciar videollamada',
                        onPressed: _launchVideoCall,
                      ),
                      IconButton(
                        icon: const Icon(Icons.call, size: 28),
                        tooltip: 'Iniciar llamada',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Función de llamada no implementada.')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(backgroundAsset),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('chats')
                          .doc(chatId)
                          .collection('messages')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                              child:
                                  Text('No hay mensajes, ¡envía el primero!'));
                        }

                        final messages = snapshot.data!.docs;

                        return ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isSentByUser =
                                message['senderId'] == currentUserId;

                            return Align(
                              alignment: isSentByUser
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: ChatBubble(
                                text: message['message'],
                                isSentByUser: isSentByUser,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                if (showEmojiPicker)
                  SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      onEmojiSelected: (category, emoji) {
                        messageController.text += emoji.emoji;
                      },
                      config: Config(
                        columns: 7,
                        emojiSizeMax: 32,
                        bgColor: Colors.white,
                        enableSkinTones: true,
                        iconColorSelected: Colors.blue,
                        initCategory: Category.RECENT,
                        emojiTextStyle: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                _MessageInput(
                  controller: messageController,
                  onSend: (message) async {
                    if (message.isNotEmpty) {
                      await FirebaseFirestore.instance
                          .collection('chats')
                          .doc(chatId)
                          .collection('messages')
                          .add({
                        'senderId': currentUserId,
                        'receiverId': receiverUsername,
                        'message': message,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      messageController.clear();
                    }
                  },
                  onEmojiPressed: () {
                    setState(() {
                      showEmojiPicker = !showEmojiPicker;
                    });
                  },
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
  final bool isSentByUser;

  const ChatBubble({super.key, required this.text, required this.isSentByUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isSentByUser
            ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10),
          bottomLeft: isSentByUser
              ? const Radius.circular(10)
              : const Radius.circular(0),
          bottomRight: isSentByUser
              ? const Radius.circular(0)
              : const Radius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSentByUser
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSend;
  final VoidCallback onEmojiPressed;

  const _MessageInput({
    required this.controller,
    required this.onSend,
    required this.onEmojiPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.emoji_emotions),
              onPressed: onEmojiPressed,
            ),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: IconButton(
                onPressed: () {
                  onSend(controller.text.trim());
                },
                icon: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
