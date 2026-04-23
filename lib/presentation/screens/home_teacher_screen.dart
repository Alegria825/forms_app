import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/domain/entities/classroom.dart';
import 'package:go_router/go_router.dart';
import 'package:forms_app/presentation/blocs/auth_cubit/auth_cubit.dart';
// Importa tu entidad Classroom aquí

class HomeTeacherScreen extends StatelessWidget {
  const HomeTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthCubit>().state.user;
    final String professorName = user?.name ?? 'Profesor';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Panel de Control", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => context.read<AuthCubit>().logout(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Hola $professorName",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            
            // LISTA DINÁMICA DE AULAS
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                // Escuchamos solo las aulas de ESTE profesor
                stream: FirebaseFirestore.instance
                    .collection('classrooms')
                    .where('professorId', isEqualTo: user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return const Text('Error al cargar');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;

                  if (docs.isEmpty) {
                    return const Center(child: 
                    Text("No tienes aulas creadas.", 
                    style: TextStyle(fontSize: 18)
                    )
                    );
                  }

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final classroom = Classroom.fromFirestore(
                        docs[index].data() as Map<String, dynamic>,
                        docs[index].id
                      );

                      return _ClassroomCard(
                        classroom: classroom,
                        // Alternamos colores para que se vea como tu diseño
                        color: index % 2 == 0 ? Colors.teal[300]! : Colors.blue[300]!,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => context.push('/new-classroom'), 
      ),
    );
  }
}

class _ClassroomCard extends StatelessWidget {
  final Classroom classroom;
  final Color color;

  const _ClassroomCard({required this.classroom, required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/classroom-detail', extra: classroom);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            // Concatenamos grado y grupo aquí
            "${classroom.grade}-${classroom.group}", 
            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}