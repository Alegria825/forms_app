import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:forms_app/presentation/blocs/auth_cubit/auth_cubit.dart';

class HomeTeacherScreen extends StatelessWidget {
  const HomeTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos el nombre del profesor desde el Cubit
    final user = context.watch<AuthCubit>().state.user;
    final String professorName = user?.name ?? 'Profesor';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Panel de Control", style: TextStyle(color: Colors.black)),
        actions: [
          // Botón para cerrar sesión y volver al login (fácil testeo)
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              context.read<AuthCubit>().logout();
            },
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
              style: const TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold,
                color: Colors.black87
              ),
            ),
            const SizedBox(height: 30),
            
            // Sección de Aulas (Grid)
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Dos columnas como en el PDF
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  // Estas son tarjetas de ejemplo, luego vendrán de la base de datos
                  _ClassroomCard(grade: '4', group: 'O', color: Colors.teal[300]!),
                  _ClassroomCard(grade: '2', group: 'M', color: Colors.blue[300]!),
                ],
              ),
            ),
          ],
        ),
      ),
      // Botón para crear nueva aula (Página 4 del PDF)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[800],
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // TODO: Navegar a la pantalla de crear aula
          // context.push('/new-classroom'); 
        },
      ),
    );
  }
}

class _ClassroomCard extends StatelessWidget {
  final String grade;
  final String group;
  final Color color;

  const _ClassroomCard({
    required this.grade, 
    required this.group, 
    required this.color
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Al tocar, navegamos al detalle del aula (Página 3 del PDF)
        context.push('/classroom-detail');
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Center(
          child: Text(
            "$grade-$group",
            style: const TextStyle(
              fontSize: 35, 
              fontWeight: FontWeight.bold, 
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}