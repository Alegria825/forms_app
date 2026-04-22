import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:forms_app/presentation/blocs/auth_cubit/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos el estado para mostrar un indicador de carga si es necesario
    final authStatus = context.watch<AuthCubit>().state.status;
    final isLoading = authStatus == AuthStatus.checking;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Aquí va tu logo del PDF (Birrete, libro y QR)
                Image.asset('assets/logo.jpeg', height: 150), // Asegúrate de tener esta imagen en tu carpeta assets')
                const SizedBox(height: 20),
                const Text(
                  'Bienvenido',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                
                // Botón de Autenticación
                isLoading 
                  ? const CircularProgressIndicator()
                  : ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[400], // Color similar al PDF
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )
                      ),
                      
                      icon: const Icon(Icons.login), // Puedes cambiarlo por el logo de Google
                      label: const Text(
                        'Autenticarse',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () async {
                        // Llamamos al método de login. 
                        // ¡El GoRouter hará el cambio de pantalla automáticamente!
                        await context.read<AuthCubit>().login();
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}