import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/auth_cubit/auth_cubit.dart';

class HomeStudentScreen extends StatelessWidget {
  const HomeStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenemos los datos del alumno desde el Cubit
    final user = context.watch<AuthCubit>().state.user;
    final String studentName = user?.name.split(' ')[0] ?? 'Estudiante';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Botón de logout para pruebas
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
            const SizedBox(height: 20),
            Text(
              "Hola $studentName",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "¿Listo para registrar tu asistencia?",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            
            const Spacer(), // Empuja el contenido al centro
            
            Center(
              child: Column(
                children: [
                  _ScannerButton(
                    onPressed: () {
                      // TODO: Navegar a la pantalla del escáner QR
                      // context.push('/scan-qr');
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Escanear QR",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(flex: 2), // Espacio extra abajo para equilibrio visual
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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.blue[50], // Fondo suave
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.blue[100]!, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
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
    );
  }
}