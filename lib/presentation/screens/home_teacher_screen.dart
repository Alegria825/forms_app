import 'package:flutter/material.dart';
import 'package:forms_app/presentation/widgets/shared/custom_filled_auth_button.dart';
// Asegúrate de importar tu carpeta de widgets
import 'package:forms_app/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';


class HomeTeacherScreen extends StatelessWidget {
  const HomeTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profesor")),
      body: const _TeacherView(),
    );
  }
}

class _TeacherView extends StatelessWidget {
  const _TeacherView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30), // Más padding para que se vea como el diseño
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
              onPressed: () {
                //TODO: IMPLEMENTAR METODO DE LOGIN CON GOOGLE
              },
              ),
            const SizedBox(height: 30),

            CustomFilledButton(
              text: "Rellenar formulario",
              onPressed: () => context.push('/new-teacher'),
              )

          ],
        ),
      ),
    );
  }
}