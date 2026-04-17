import 'package:flutter/material.dart';
import 'package:forms_app/infrastructure/datasources/firebase_auth_datasource.dart';
import 'package:forms_app/infrastructure/repositories/auth_repository_impl.dart';
import 'package:forms_app/presentation/widgets/shared/custom_filled_auth_button.dart';


class HomeStudentScreen extends StatelessWidget {
  const HomeStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Estudiante")),
      body: const _StudentView(),
    );
  }
}

class _StudentView extends StatelessWidget {
  const _StudentView();

 @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ), // Más padding para que se vea como el diseño
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrado vertical
          children: [
            const Text(
              "Autenticación requerida",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),

            // USANDO TU NUEVO BOTÓN GLOBAL
            CustomFilledAuthButton(
              text: 'Autentificarse con Google',
              icon: Icons.login,
              onPressed: () async {
                //TODO: IMPLEMENTAR METODO DE LOGIN CON GOOGLE
                // 2. Preparamos el repositorio (esto luego lo hará un Provider o Bloc)
                final authRepository = AuthRepositoryImpl(
                  FirebaseAuthDatasource(),
                );
                try {
                  // 3. Llamamos al login
                  final userCredential = await authRepository.loginWithGoogle();
                  if (userCredential != null) {
                    // ¡ÉXITO!
                    final userName =
                        userCredential.user?.displayName ?? 'Usuario';

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('¡Bienvenido $userName!')),
                    );
                    // Aquí podrías navegar a la pantalla de asistencias
                    // context.push('/asistencias');
                  }
                } catch (e) {
                  // Manejo de errores visual
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al autenticar: $e')),
                  );
                  print('error: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
