import 'package:flutter/material.dart';

class IconSelectionView {
  static void showIconSelectionModal(
      BuildContext context, Function(String) onIconSelected) {
    final List<String> predefinedIcons = [
      'assets/icons_users/user1.png',
      'assets/icons_users/user2.png',
      'assets/icons_users/user3.png',
      'assets/icons_users/user4.png',
      'assets/icons_users/user5.png',
      'assets/icons_users/user6.png',
      'assets/icons_users/user7.png',
      'assets/icons_users/user8.png',
      'assets/icons_users/user9.png',
      'assets/icons_users/user10.png',
      'assets/icons_users/user11.png',
      'assets/icons_users/user12.png',
      // Agrega más íconos aquí
    ];

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: predefinedIcons.length,
            itemBuilder: (context, index) {
              final iconPath = predefinedIcons[index];
              return GestureDetector(
                onTap: () {
                  onIconSelected(iconPath);
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      iconPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
