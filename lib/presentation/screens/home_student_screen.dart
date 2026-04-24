
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class HomeStudentScreen extends StatelessWidget {
  const HomeStudentScreen({super.key});

  // FUNCIÓN PARA REGISTRAR LA ASISTENCIA EN FIREBASE
  void _marcarAsistencia(BuildContext context, String classId, String studentId) async {
    final now = DateTime.now();
    // El documento tendrá el formato DD_MM_YYYY (ej: 22_04_2026)
    final String dateDoc = "${now.day.toString().padLeft(2, '0')}_${now.month.toString().padLeft(2, '0')}_${now.year}";

    try {
      final attendanceRef = FirebaseFirestore.instance
          .collection('classrooms')
          .doc(classId)
          .collection('attendances')
          .doc(dateDoc);

      await attendanceRef.set({
        'present_students': FieldValue.arrayUnion([studentId]),
        'last_updated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("¡Asistencia registrada con éxito!"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al registrar: $e"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthCubit>().state.user;
    final String studentName = user?.name.split(' ')[0] ?? 'Estudiante';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.grey),
            onPressed: () => context.read<AuthCubit>().logout(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              "Hola $studentName",
              style: const TextStyle(
                fontSize: 28, 
                fontWeight: FontWeight.bold,
                color: Colors.black),
            ),
            const SizedBox(height: 10),
            const Text(
              "¿Listo para registrar tu asistencia?",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            
            const SizedBox(height: 30),
            const Text(
              "Mis Materias",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // LISTA DE MATERIAS DONDE EL ALUMNO ESTÁ INSCRITO
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('classrooms')
                    .where('uid_students', arrayContains: user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final classrooms = snapshot.data?.docs ?? [];

                  if (classrooms.isEmpty) {
                    return const Center(
                      child: Text("No estás inscrito en ninguna materia todavía.",
                      style: TextStyle(
                        fontSize: 16, 
                        color: Colors.black87
                        )
                        ),
                    );
                  }

                  return ListView.builder(
                    itemCount: classrooms.length,
                    itemBuilder: (context, index) {
                      final data = classrooms[index].data() as Map<String, dynamic>;
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: Colors.blue[50],
                        child: ListTile(
                          title: Text(data['subjectName'] ?? 'Sin nombre'),
                          subtitle: Text("Grupo: ${data['grade']}-${data['group']}"),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            
            // BOTÓN DE ESCÁNER
            Center(
              child: Column(
                children: [
                  _ScannerButton(
                    onPressed: () async {
                      // Navegamos al escáner y esperamos el resultado (classId)
                      final String? classId = await context.push('/scanner');
                      
                      if (classId != null && user != null) {
                        _marcarAsistencia(context, classId, user.uid);
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Escanear QR",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _ScannerButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ScannerButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.blue[200]!, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Icon(
            Icons.qr_code_scanner_rounded,
            size: 100,
            color: Colors.blue[800],
          ),
        ),
      ),
    );
  }
}