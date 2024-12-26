import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/services.dart'; // Necesario para rootBundle

class ChatIAMsgView extends StatefulWidget {
  final String username;
  final String chatId;

  const ChatIAMsgView({
    super.key,
    required this.username,
    required this.chatId,
  });

  @override
  State<ChatIAMsgView> createState() => _ChatIAMsgViewState();
}

class _ChatIAMsgViewState extends State<ChatIAMsgView> {
  final TextEditingController messageController = TextEditingController();
  bool showEmojiPicker = false;

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

  Future<List<String>> _getImagesForWords(String message) async {
    List<String> images = [];
    final processedMessage =
        message.replaceAll('  ', '|'); // 2 espacios = separador
    final words =
        processedMessage.split('|'); // Divide palabras por el separador
    for (String word in words) {
      final formattedWord =
          word.replaceAll(' ', '_'); // Reemplaza 1 espacio por "_"
      final assetPath =
          'assets/chat_ia/${formattedWord.toLowerCase()}_sign.png';
      try {
        await rootBundle.load(assetPath);
        images.add(assetPath); // Agrega la imagen si existe
      } catch (_) {
        // Ignorar si no existe la imagen
      }
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
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
        ? 'assets/images/chat_dark.png'
        : 'assets/images/chat_background_light.png';

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/editContact', arguments: {
                      'username': widget.username,
                    });
                  },
                  child: Row(
                    children: [
                      FutureBuilder<String?>(
                        future: _fetchProfileImage(widget.username),
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
                                    widget.username[0].toUpperCase(),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  )
                                : null,
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.username,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
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
                    .collection('ia_chats')
                    .doc(widget.chatId)
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No hay mensajes, ¡envía el primero!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isSentByUser = message['senderId'] == currentUserId;

                      return Align(
                        alignment: isSentByUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: ChatBubble(
                          text: message['message'],
                          images: List<String>.from(message['images'] ?? []),
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
                  bgColor: Theme.of(context).colorScheme.surface,
                  enableSkinTones: true,
                  iconColorSelected: Theme.of(context).colorScheme.primary,
                  initCategory: Category.RECENT,
                  emojiTextStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          _MessageInput(
            controller: messageController,
            onSend: (message) async {
              if (message.isNotEmpty) {
                final images = await _getImagesForWords(message);

                await FirebaseFirestore.instance
                    .collection('ia_chats')
                    .doc(widget.chatId)
                    .collection('messages')
                    .add({
                  'senderId': currentUserId,
                  'receiverId': widget.username,
                  'message': message,
                  'images': images,
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
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final List<String> images;
  final bool isSentByUser;

  const ChatBubble({
    super.key,
    required this.text,
    required this.images,
    required this.isSentByUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: isSentByUser
            ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
            : Theme.of(context).colorScheme.surface,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSentByUser
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          if (images.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: images.map((image) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    image,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                );
              }).toList(),
            ),
        ],
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
              icon: Icon(
                Icons.emoji_emotions,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: onEmojiPressed,
            ),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  fillColor: Theme.of(context).colorScheme.surface,
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
