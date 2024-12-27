import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/views/home/inicio_view.dart';
import 'package:myapp/views/home_view.dart';
import 'package:myapp/views/chat_msg_view.dart';
import 'package:myapp/views/register_view.dart';
import 'package:myapp/views/menu/cuenta_view.dart';
import 'package:myapp/views/login_view.dart';
import 'package:myapp/views/crear_equipo_view.dart';
import 'package:myapp/views/equipos_msg_view.dart';
import 'package:myapp/views/home/caracteristicas.dart';
import 'package:myapp/views/home/acerca_de.dart';
import 'package:myapp/views/edit_contact_view.dart';
import 'package:myapp/views/edit_equipos_view.dart';
import 'package:myapp/views/recover_password_view.dart';
import 'package:myapp/views/chat_ia_msg.dart'; // Importar ChatIAMsgView
import 'package:myapp/views/chat_ia_contact.dart'; // Importar ChatIAContactView
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Asegurarse de cerrar sesión al inicio
  await FirebaseAuth.instance.signOut();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool useLightMode = true;
  int colorSelected = 0;

  ThemeData _updateTheme(bool isLightMode, int colorIndex) {
    return ThemeData(
      colorSchemeSeed: colorOptions[colorIndex],
      brightness: isLightMode ? Brightness.light : Brightness.dark,
    );
  }

  void _toggleTheme() {
    setState(() {
      useLightMode = !useLightMode;
    });
  }

  void _changeColor(int colorIndex) {
    setState(() {
      colorSelected = colorIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Colmi',
      theme: _updateTheme(useLightMode, colorSelected),
      initialRoute: '/inicio', // Siempre ir al login al iniciar
      routes: {
        '/inicio': (context) => const InicioView(),
        '/login': (context) => const LoginView(),
        '/cuenta': (context) => const CuentaView(),
        '/register': (context) => const RegisterView(),
        '/recoverPassword': (context) => const RecoverPasswordView(),
        '/home': (context) => HomeView(
              toggleTheme: _toggleTheme,
              changeColor: _changeColor,
            ),
        '/chatmsg': (context) => const ChatMsgView(),
        '/equipo/crear': (context) =>
            const CrearEquipoView(), // Ruta para crear equipo
        '/equipo/msg': (context) =>
            const EquipoMsgView(), // Ruta para mensajes de equipo
        '/caracteristicas': (context) =>
            const CaracteristicasView(), // Ruta para Características
        '/acerca': (context) => const AcercaDeView(), // Ruta para Acerca de
        '/chatIAContacts': (context) =>
            const ChatIAContactView(), // Contactos IA
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/editContact') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) => EditContactView(
              username: args['username']!,
            ),
          );
        } else if (settings.name == '/editEquipos') {
          final equipoId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => EditEquiposView(
              equipoId: equipoId,
            ),
          );
        } else if (settings.name == '/chatIAMsg') {
          final args = settings.arguments as Map<String, String>;
          return MaterialPageRoute(
            builder: (context) => ChatIAMsgView(
              username: args['username']!,
              chatId: args['chatId']!,
            ),
          );
        }
        return null; // Manejo de rutas no encontradas
      },
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
