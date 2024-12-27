import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double horizontalPadding = screenWidth > 900
            ? 100
            : screenWidth > 600
                ? 50
                : 20;

        return Container(
          color: const Color(0xFFF5F5F5),
          padding:
              EdgeInsets.symmetric(vertical: 60, horizontal: horizontalPadding),
          child: Column(
            children: [
              SizedBox(
                width: screenWidth > 1200 ? 1200 : screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _FooterColumn(
                      title: 'Contacto',
                      children: [
                        _FooterRow(
                            icon: Icons.location_on,
                            text: 'Calle 123, Osorno, Chile'),
                        _FooterRow(
                            icon: Icons.email, text: 'contacto@colmi.com'),
                        _FooterRow(icon: Icons.phone, text: '+123 456 7890'),
                      ],
                    ),
                    const _FooterColumn(
                      title: 'Enlaces',
                      children: [
                        _FooterText(text: 'Producto'),
                        _FooterText(text: 'Caracteristicas'),
                        _FooterText(text: 'Nosotros'),
                        _FooterText(text: 'Contacto'),
                      ],
                    ),
                    const _FooterColumn(
                      title: 'Ayuda',
                      children: [
                        _FooterText(text: 'Soporte'),
                        _FooterText(text: 'Documentación'),
                        _FooterText(text: 'Privacidad'),
                        _FooterText(text: 'Legal'),
                      ],
                    ),
                    _FooterColumn(
                      title: 'Recibe noticias y actualizaciónes',
                      children: [
                        const Text(
                          'Ingresa tu correo y recibe las últimas noticias \ny actualizaciones de nuestra plataforma.',
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 250,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Tu correo aquí...',
                              hintStyle: const TextStyle(fontSize: 14),
                              suffixIcon: const Icon(Icons.send,
                                  color: Color(0xFFAFAFAF)),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: screenWidth > 1200 ? 1200 : screenWidth,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Todos los derechos reservados © Colmi.com',
                        style:
                            TextStyle(fontSize: 14, color: Color(0xFF9E9E9E))),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _FooterColumn({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...children,
      ],
    );
  }
}

class _FooterRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FooterRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _FooterText extends StatelessWidget {
  final String text;
  const _FooterText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child:
          Text(text, style: const TextStyle(fontSize: 14, color: Colors.grey)),
    );
  }
}
