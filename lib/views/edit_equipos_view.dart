import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditEquiposView extends StatelessWidget {
  final String equipoId;

  const EditEquiposView({super.key, required this.equipoId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Equipo'),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('equipos')
            .doc(equipoId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Equipo no encontrado.'));
          }

          final equipoData = snapshot.data!.data() as Map<String, dynamic>;
          final participantes =
              (equipoData['participantes'] as List<dynamic>?) ?? [];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  equipoData['nombre'] ?? 'Nombre del equipo',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  'Miembros:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: participantes.isEmpty
                      ? const Center(
                          child: Text('No hay miembros en este equipo.'),
                        )
                      : ListView.builder(
                          itemCount: participantes.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(participantes[index])
                                  .get(),
                              builder: (context, userSnapshot) {
                                if (!userSnapshot.hasData ||
                                    !userSnapshot.data!.exists) {
                                  return const ListTile(
                                      title: Text('Usuario desconocido'));
                                }

                                final userData = userSnapshot.data!.data()
                                    as Map<String, dynamic>;
                                final username =
                                    userData['username'] ?? 'Usuario';
                                final profileImage = userData['profileImage'];

                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: profileImage != null
                                        ? NetworkImage(profileImage)
                                        : null,
                                    child: profileImage == null
                                        ? const Icon(Icons.person)
                                        : null,
                                  ),
                                  title: Text(username),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.remove_circle,
                                        color: Colors.red),
                                    onPressed: () => _confirmRemoveMember(
                                      context,
                                      participantes[index],
                                      username,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                    ),
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
                      'Eliminar equipo',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () => _confirmDeleteEquipo(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _confirmRemoveMember(
    BuildContext context,
    String memberId,
    String username,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Miembro'),
          content:
              Text('¿Estás seguro que deseas eliminar a $username del equipo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _removeMember(context, memberId);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _removeMember(BuildContext context, String memberId) async {
    try {
      final equipoRef =
          FirebaseFirestore.instance.collection('equipos').doc(equipoId);

      await equipoRef.update({
        'participantes': FieldValue.arrayRemove([memberId])
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Miembro eliminado con éxito.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al eliminar miembro.')),
      );
    }
  }

  Future<void> _confirmDeleteEquipo(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Equipo'),
          content: const Text(
              '¿Estás seguro de eliminar este equipo? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteEquipo(context);
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteEquipo(BuildContext context) async {
    try {
      final equipoRef =
          FirebaseFirestore.instance.collection('equipos').doc(equipoId);

      await equipoRef.delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Equipo eliminado con éxito.')),
      );

      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al eliminar el equipo.')),
      );
    }
  }
}
