
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/auth_cubit/auth_cubit.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({super.key});

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  final _matriculaController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-llenamos el nombre con el que nos dio Google por defecto
    final user = context.read<AuthCubit>().state.user;
    if (user != null) {
      _nameController.text = user.name;
    }
  }

  @override
  void dispose() {
    _matriculaController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final matricula = _matriculaController.text.trim();
    final nombre = _nameController.text.trim();

    if (matricula.isEmpty || nombre.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor llena todos los campos')),
      );
      return;
    }

    try {
      // 1. Llamamos a un método en el Cubit para actualizar el perfil
      await context.read<AuthCubit>().updateStudentProfile(
        name: nombre,
        enrollment: matricula,
      );
      
      // ¡Magia! Al actualizar el Cubit, el router detectará que user.enrollment 
      // ya no está vacío y automáticamente te mandará a '/home-student'.
      
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alumno')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _matriculaController,
              decoration: const InputDecoration(
                labelText: 'Matricula',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: _submitForm,
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}