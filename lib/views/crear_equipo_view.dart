import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrearEquipoView extends StatefulWidget {
  const CrearEquipoView({super.key});

  @override
  _CrearEquipoViewState createState() => _CrearEquipoViewState();
}

class _CrearEquipoViewState extends State<CrearEquipoView> {
  final TextEditingController nombreController = TextEditingController();
  final List<String> seleccionados = [];
  String? selectedIcon;

  final List<String> predefinedIcons = [
    'assets/icons/team1.png',
    'assets/icons/team2.png',
    'assets/icons/team3.png',
    'assets/icons/team4.png',
    'assets/icons/team5.png',
  ];

  @override
  void initState() {
    super.initState();
    _addCurrentUserToParticipants();
  }

  void _addCurrentUserToParticipants() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      seleccionados.add(currentUser.uid);
    }
  }

  Future<bool> _isTeamNameDuplicate(String teamName) async {
    final existingTeams = await FirebaseFirestore.instance
        .collection('equipos')
        .where('nombre', isEqualTo: teamName)
        .get();
    return existingTeams.docs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Equipo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Crea tu Equipo',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Completa la información y selecciona a los participantes.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              // Campo para el nombre del equipo
              TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre del equipo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
              const SizedBox(height: 20),
              // Selección de ícono
              Text(
                'Seleccionar Ícono del Equipo',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: predefinedIcons.length,
                  itemBuilder: (context, index) {
                    final iconPath = predefinedIcons[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIcon = iconPath;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedIcon == iconPath
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          iconPath,
                          width: 60,
                          height: 60,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Selección de participantes
              Text(
                'Seleccionar Participantes',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .collection('contacts')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('No hay contactos disponibles.'));
                    }

                    final contactos = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: contactos.length,
                      itemBuilder: (context, index) {
                        final contacto = contactos[index];
                        final username = contacto['username'];

                        return Card(
                          child: CheckboxListTile(
                            title: Text(username),
                            value: seleccionados.contains(contacto.id),
                            onChanged: (selected) {
                              setState(() {
                                if (selected == true) {
                                  seleccionados.add(contacto.id);
                                } else {
                                  seleccionados.remove(contacto.id);
                                }
                              });
                            },
                            activeColor: Theme.of(context).colorScheme.primary,
                            checkColor: Colors.white,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Botón de crear equipo
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final equipoNombre = nombreController.text.trim();
                    if (equipoNombre.isEmpty ||
                        seleccionados.isEmpty ||
                        selectedIcon == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Llena todos los campos.')),
                      );
                      return;
                    }

                    if (await _isTeamNameDuplicate(equipoNombre)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Ya existe un equipo con este nombre.')),
                      );
                      return;
                    }

                    await FirebaseFirestore.instance.collection('equipos').add({
                      'nombre': equipoNombre,
                      'participantes': seleccionados,
                      'icono': selectedIcon,
                    });

                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Crear Equipo',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
