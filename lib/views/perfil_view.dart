import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  const Perfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: _maxWidthConstraint,
            child: ListView(
              shrinkWrap: true,
              children: const [
                Center(
                  // Added Center widget
                  child: Text(
                    'Pestaña de Perfil',
                    style: TextStyle(fontSize: 18), // Optional styling
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const double _maxWidthConstraint = 400;
