import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 30),
          Image.asset('assets/logo.jpeg', height: 200, width: 150),

          const SizedBox(height: 20),

          Center(
            child: Column(
              children: [
                Text(
                  'Bienvenido',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text('Selecciona una opción', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.only(
              top: 100,
              right: 100,
              bottom: 50,
              left: 100,
            ),
            child: ElevatedButton(
              onPressed: () => context.push('/home-teacher'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF78DB78),
                foregroundColor: Colors.white,
                elevation: 4,
                minimumSize: const Size(220, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Profesor',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 50),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: ElevatedButton(
              onPressed: () => context.push('/home-student'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF78DB78),
                foregroundColor: Colors.white,
                elevation: 4,
                minimumSize: const Size(220, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Alumno',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
