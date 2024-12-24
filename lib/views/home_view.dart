import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/views/chats_view.dart';
import 'package:myapp/views/equipos_view.dart';
import 'package:myapp/views/diccionario_view.dart';
import 'package:myapp/views/barra_de_navegacion.dart';
import 'package:myapp/views/menu_bottom_sheet.dart';
import 'package:myapp/views/chat_ia_contact.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required this.toggleTheme,
    required this.changeColor,
  });

  final VoidCallback toggleTheme;
  final Function(int) changeColor;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0; // Índice del destino seleccionado

  // Cambiar la vista según el índice seleccionado
  Widget _getSelectedView() {
    switch (_selectedIndex) {
      case 0:
        return const Chats(showNavBottomBar: false);
      case 1:
        return const ChatIAContactView();
      case 2:
        return const EquiposView();
      case 3:
        return const DiccionarioView(); // Cambiado para coincidir con índice
      case 4:
        return const PerfilSideSheetContent(); // Cambiado para menú
      default:
        return const Chats(showNavBottomBar: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth >= 450;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 60,
            ),
            const SizedBox(width: 8),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.toggleTheme,
            tooltip: "Cambiar Tema",
          ),
          PopupMenuButton(
            icon: const Icon(Icons.color_lens),
            itemBuilder: (context) {
              return List.generate(colorOptions.length, (index) {
                return PopupMenuItem(
                  value: index,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          index == colorOptions.indexOf(colorOptions[index])
                              ? Icons.circle
                              : Icons.circle_outlined,
                          color: colorOptions[index],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(colorText[index]),
                      ),
                    ],
                  ),
                );
              });
            },
            onSelected: widget.changeColor,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
            tooltip: "Cerrar sesión",
          ),
        ],
      ),
      body: Row(
        children: [
          if (isWeb)
            NavigationRailSection(
              selectedIndex: _selectedIndex,
              onSelectItem: (index) => setState(() => _selectedIndex = index),
              extended: true,
            ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _getSelectedView(),
          ),
        ],
      ),
      bottomNavigationBar: !isWeb
          ? NavigationBars(
              selectedIndex: _selectedIndex,
              onSelectItem: (index) => setState(() => _selectedIndex = index),
            )
          : null,
    );
  }
}

class NavigationRailSection extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onSelectItem;
  final bool extended;

  const NavigationRailSection({
    super.key,
    required this.selectedIndex,
    required this.onSelectItem,
    this.extended = false,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: extended,
      destinations: [
        _buildDestination(Icons.chat, "Chats", 0),
        _buildDestination(Icons.smart_toy_outlined, "Chat IA", 1),
        _buildDestination(Icons.group_outlined, "Equipos", 2),
        _buildDestination(Icons.library_books_outlined, "Diccionario", 3),
        _buildDestination(Icons.menu_outlined, "Menú", 4),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelectItem,
    );
  }

  NavigationRailDestination _buildDestination(
      IconData icon, String label, int index) {
    final isSelected = index == selectedIndex;
    return NavigationRailDestination(
      icon: Icon(icon, color: isSelected ? Colors.blue : null),
      selectedIcon: Icon(icon, color: Colors.blue),
      label: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.blue : null,
        ),
      ),
    );
  }
}

// Opciones de colores
const List<Color> colorOptions = [
  Colors.white,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
];

// Nombres de colores para el menú
const List<String> colorText = [
  "M3 Baseline",
  "Blue",
  "Teal",
  "Green",
  "Yellow",
  "Orange",
  "Pink",
];
