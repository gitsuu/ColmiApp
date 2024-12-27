import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactoSection extends StatelessWidget {
  const ContactoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contactanos',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 76, 119, 255),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Mantente conectado',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF19233D),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Estamos aquí para ayudarte. No dudes en ponerte en contacto con nosotros.',
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(221, 97, 97, 97)),
                ),
                const SizedBox(height: 30),
                const Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.indigo),
                    SizedBox(width: 10),
                    Text('Calle 123, Osorno, Chile',
                        style:
                            TextStyle(color: Color.fromARGB(221, 97, 97, 97))),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(Icons.email, color: Colors.indigo),
                    SizedBox(width: 10),
                    Text('contacto@colmi.com',
                        style:
                            TextStyle(color: Color.fromARGB(221, 97, 97, 97))),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(Icons.phone, color: Colors.indigo),
                    SizedBox(width: 10),
                    Text('+123 456 7890',
                        style:
                            TextStyle(color: Color.fromARGB(221, 97, 97, 97))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tu Nombre',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tu Correo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Tu Teléfono',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Asunto',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Escribe tu mensaje',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width /
                      4, // ANCHO MODIFICADO (mitad de la columna)
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF19233D),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child: const Text('Enviar Ahora',
                        style: TextStyle(color: Colors.white)),
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
