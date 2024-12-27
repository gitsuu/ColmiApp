import 'package:flutter/material.dart';
import 'package:myapp/views/home/utils/device_type.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = getDeviceType(context);

    if (deviceType == DeviceType.mobile) {
      return const SizedBox.shrink();
    }

    double horizontalPadding = 84;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(vertical: 16, horizontal: horizontalPadding),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (screenWidth > 497)
            Image.asset(
              'assets/home/logo-colmi.png', // Reemplaza con la ruta de tu logo
              height: 50,
              fit: BoxFit.contain,
            ),
          const SizedBox(width: 20),
          if (screenWidth > 450) const _NavbarDesktopMenu(),
          const Spacer(),
          _buildRightButtons(),
        ],
      ),
    );
  }

  Widget _buildRightButtons() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0), // Add right padding here
          child: TextButton(
            onPressed: () {},
            child: const Text('Contacto',
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF19233D),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 18),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Comencemos'),
        ),
      ],
    );
  }
}

class _NavbarDesktopMenu extends StatelessWidget {
  const _NavbarDesktopMenu();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _NavbarItem(text: 'Producto'),
        _NavbarItem(text: 'Caracteristicas'),
        _NavbarItem(text: 'Nosotros'),
        SizedBox(width: 20),
      ],
    );
  }
}

class _NavbarItem extends StatelessWidget {
  final String text;

  const _NavbarItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontSize: 18),
        ),
        child: Text(text, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
