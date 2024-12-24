import 'package:flutter/material.dart';
import 'abecedario_view.dart';
import 'animales_view.dart';
import 'meses_view.dart';
import 'numeros_view.dart';
import 'pronombres_view.dart';
import 'dias_de_la_semana_view.dart';
import 'interrogativos_view.dart';
import 'sentimientos_view.dart';

class DiccionarioView extends StatelessWidget {
  const DiccionarioView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 450 && screenWidth < 720;
    final isWeb = screenWidth >= 720;

    if (isTablet) {
      return _TabletDiccionarioView();
    } else if (isWeb) {
      return _WebDiccionarioView();
    } else {
      return _MobileDiccionarioView();
    }
  }
}

class _MobileDiccionarioView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Abecedario',
        'image': 'assets/logos/abc_sign.png',
        'view': const AbecedarioView()
      },
      {
        'title': 'Animales',
        'image': 'assets/logos/animal_sign.png',
        'view': const AnimalesView()
      },
      {
        'title': 'Meses',
        'image': 'assets/logos/calendario_sign.png',
        'view': const MesesView()
      },
      {
        'title': 'Números',
        'image': 'assets/logos/numeros_sign.png',
        'view': const NumerosView()
      },
      {
        'title': 'Pronombres',
        'image': 'assets/logos/pronombres_sign.png',
        'view': const PronombresView()
      },
      {
        'title': 'Días de la semana',
        'image': 'assets/logos/semana_sign.png',
        'view': const DiasDeLaSemanaView()
      },
      {
        'title': 'Interrogativos',
        'image': 'assets/logos/interrogativo_sign.png',
        'view': const InterrogativosView()
      },
      {
        'title': 'Sentimientos',
        'image': 'assets/logos/sentimientos_sign.png',
        'view': const SentimientosView()
      },
    ];

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryCard(
            context,
            categories[index]['title'] as String,
            categories[index]['image'] as String,
            categories[index]['view'] as Widget,
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, String imagePath, Widget targetView) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetView),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImage(imagePath),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 30, color: Colors.red);
        },
      ),
    );
  }
}

class _TabletDiccionarioView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Abecedario',
        'image': 'assets/logos/abc_sign.png',
        'view': const AbecedarioView()
      },
      {
        'title': 'Animales',
        'image': 'assets/logos/animal_sign.png',
        'view': const AnimalesView()
      },
      {
        'title': 'Meses',
        'image': 'assets/logos/calendario_sign.png',
        'view': const MesesView()
      },
      {
        'title': 'Números',
        'image': 'assets/logos/numeros_sign.png',
        'view': const NumerosView()
      },
      {
        'title': 'Pronombres',
        'image': 'assets/logos/pronombres_sign.png',
        'view': const PronombresView()
      },
      {
        'title': 'Días de la semana',
        'image': 'assets/logos/semana_sign.png',
        'view': const DiasDeLaSemanaView()
      },
      {
        'title': 'Interrogativos',
        'image': 'assets/logos/interrogativo_sign.png',
        'view': const InterrogativosView()
      },
      {
        'title': 'Sentimientos',
        'image': 'assets/logos/sentimientos_sign.png',
        'view': const SentimientosView()
      },
    ];

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryCard(
            context,
            categories[index]['title'] as String,
            categories[index]['image'] as String,
            categories[index]['view'] as Widget,
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, String imagePath, Widget targetView) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetView),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildImage(imagePath),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 30, color: Colors.red);
        },
      ),
    );
  }
}

class _WebDiccionarioView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'title': 'Abecedario',
        'image': 'assets/logos/abc_sign.png',
        'view': const AbecedarioView()
      },
      {
        'title': 'Animales',
        'image': 'assets/logos/animal_sign.png',
        'view': const AnimalesView()
      },
      {
        'title': 'Meses',
        'image': 'assets/logos/calendario_sign.png',
        'view': const MesesView()
      },
      {
        'title': 'Números',
        'image': 'assets/logos/numeros_sign.png',
        'view': const NumerosView()
      },
      {
        'title': 'Pronombres',
        'image': 'assets/logos/pronombres_sign.png',
        'view': const PronombresView()
      },
      {
        'title': 'Días de la semana',
        'image': 'assets/logos/semana_sign.png',
        'view': const DiasDeLaSemanaView()
      },
      {
        'title': 'Interrogativos',
        'image': 'assets/logos/interrogativo_sign.png',
        'view': const InterrogativosView()
      },
      {
        'title': 'Sentimientos',
        'image': 'assets/logos/sentimientos_sign.png',
        'view': const SentimientosView()
      },
    ];

    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryCard(
            context,
            categories[index]['title'] as String,
            categories[index]['image'] as String,
            categories[index]['view'] as Widget,
          );
        },
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, String title, String imagePath, Widget targetView) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetView),
        );
      },
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, color: Colors.red);
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
