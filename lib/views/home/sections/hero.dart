import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/views/home/utils/device_type.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceType deviceType = getDeviceType(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double titleFontSize =
        screenWidth * (deviceType == DeviceType.mobile ? 0.085 : 0.055);
    double descriptionFontSize =
        screenWidth * (deviceType == DeviceType.mobile ? 0.04 : 0.025);

    return SizedBox(
      height: screenHeight,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: deviceType == DeviceType.mobile ? 24 : 120,
        ),
        child: LayoutBuilder(
          // Usamos LayoutBuilder
          builder: (BuildContext context, BoxConstraints constraints) {
            return Transform.translate(
              offset: const Offset(0.0, -15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (constraints.maxWidth <
                      450) // Condición para mostrar la imagen
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 0.0), // Espacio entre imagen y texto
                      child: Image.asset(
                        'assets/home/logo-colmi.png', // Reemplaza con la ruta de tu imagen
                        height: 175, // Ajusta la altura según necesites
                        fit: BoxFit.contain, // Ajusta el ajuste de la imagen
                      ),
                    ),
                  Text(
                    'Tus \nvideoconferencias, \nsin barreras',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF19233D),
                        height: 1.2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Comunicación inclusiva \ncon Lengua de Señas Chilena.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: descriptionFontSize,
                      color: const Color(0xFF6A707B),
                      height: 1.4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF19233D),
                          textStyle: const TextStyle(fontSize: 18),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text('Regístrate'),
                      ),
                      const SizedBox(width: 16),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          textStyle: const TextStyle(fontSize: 18),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 32,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                        child: const Text('Iniciar Sesion'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
