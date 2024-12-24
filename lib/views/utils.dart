import 'package:flutter/material.dart';

void Function()? handlePressed(
    BuildContext context, bool isDisabled, String buttonName) {
  return isDisabled
      ? null
      : () {
          final snackBar = SnackBar(
            content: Text(
              'Yay! $buttonName is clicked!',
              style: TextStyle(color: Theme.of(context).colorScheme.surface),
            ),
            action: SnackBarAction(
              textColor: Theme.of(context).colorScheme.surface,
              label: 'Close',
              onPressed: () {},
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        };
}

// Destinos de la barra de navegación
const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.chat),
    label: 'Chats',
    selectedIcon: Icon(Icons.chat),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.smart_toy_outlined), // Ícono de Chat IA
    label: 'Chat con IA',
    selectedIcon: Icon(Icons.smart_toy_outlined),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.group_outlined),
    label: 'Equipos',
    selectedIcon: Icon(Icons.group_outlined),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.library_books_outlined),
    label: 'Diccionario',
    selectedIcon: Icon(Icons.library_books_outlined),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.menu_outlined),
    label: 'Menú',
    selectedIcon: Icon(Icons.menu_outlined),
  ),
];

// Generar destinos para la navegación de Rail
final List<NavigationRailDestination> navRailDestinations = [
  NavigationRailDestination(
    icon: Tooltip(
      message: "Chats",
      child: Icon(Icons.chat),
    ),
    selectedIcon: Tooltip(
      message: "Chats",
      child: Icon(Icons.chat),
    ),
    label: Text("Chats"),
  ),
  NavigationRailDestination(
    icon: Tooltip(
      message: "Chat con IA",
      child: Icon(Icons.smart_toy_outlined),
    ),
    selectedIcon: Tooltip(
      message: "Chat con IA",
      child: Icon(Icons.smart_toy_outlined),
    ),
    label: Text("Chat con IA"),
  ),
  NavigationRailDestination(
    icon: Tooltip(
      message: "Equipos",
      child: Icon(Icons.group_outlined),
    ),
    selectedIcon: Tooltip(
      message: "Equipos",
      child: Icon(Icons.group_outlined),
    ),
    label: Text("Equipos"),
  ),
  NavigationRailDestination(
    icon: Tooltip(
      message: "Diccionario",
      child: Icon(Icons.library_books_outlined),
    ),
    selectedIcon: Tooltip(
      message: "Diccionario",
      child: Icon(Icons.library_books_outlined),
    ),
    label: Text("Diccionario"),
  ),
  NavigationRailDestination(
    icon: Tooltip(
      message: "Menú",
      child: Icon(Icons.menu_outlined),
    ),
    selectedIcon: Tooltip(
      message: "Menú",
      child: Icon(Icons.menu_outlined),
    ),
    label: Text("Menú"),
  ),
];
