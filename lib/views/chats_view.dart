import 'package:flutter/material.dart';
import 'package:myapp/views/contact_list.dart';

class Chats extends StatelessWidget {
  const Chats({super.key, required this.showNavBottomBar});

  final bool showNavBottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ContactList(
              onContactSelected: (username, chatId) {
                if (chatId.isNotEmpty) {
                  Navigator.of(context).pushNamed(
                    '/chatmsg',
                    arguments: {
                      'username': username,
                      'chatId': chatId,
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'El chat ID no está asignado. Por favor, verifica.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
