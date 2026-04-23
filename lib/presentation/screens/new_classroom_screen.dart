import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class NewClassroomScreen extends StatefulWidget {
  const NewClassroomScreen({super.key});

  @override
  State<NewClassroomScreen> createState() => _NewClassroomScreenState();
}

class _NewClassroomScreenState extends State<NewClassroomScreen> {
  final _gradoController = TextEditingController();
  final _grupoController = TextEditingController();
  final _materiaController = TextEditingController();

  void _crearAula() async {
    final user = context.read<AuthCubit>().state.user;
    if (user == null) return;

    final classroomData = {
      'professorId': user.uid,
      'grade': _gradoController.text.trim(),
      'group': _grupoController.text.trim(),
      'subjectName': _materiaController.text.trim(),
      'uid_students': [],
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('classrooms').add(classroomData);
      if (mounted) context.pop(); // Regresa al home del profesor
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al crear aula: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nueva aula")),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TextField(
              controller: _gradoController,
              decoration: const InputDecoration(labelText: 'Grado'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _grupoController,
              decoration: const InputDecoration(labelText: 'Grupo'),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _materiaController,
              decoration: const InputDecoration(labelText: 'Materia'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.blue[800],
              ),
              onPressed: _crearAula,
              child: const Text("Crear", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}