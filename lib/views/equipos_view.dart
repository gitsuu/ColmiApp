import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EquiposView extends StatelessWidget {
  const EquiposView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Equipos'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Por favor, inicia sesión para ver los equipos.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Equipos'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('equipos')
            .where('participantes', arrayContains: currentUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay equipos disponibles.'));
          }

          final equipos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: equipos.length,
            itemBuilder: (context, index) {
              final equipo = equipos[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: equipo['icono'] != null
                      ? AssetImage(equipo['icono'])
                      : null,
                  child: equipo['icono'] == null
                      ? Text(equipo['nombre'][0].toUpperCase())
                      : null,
                ),
                title: Text(equipo['nombre']),
                subtitle: Text(
                    '${(equipo['participantes'] as List).length} participantes'),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/equipo/msg',
                    arguments: equipo.id,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/equipo/crear');
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
