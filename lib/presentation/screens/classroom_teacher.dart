import 'package:flutter/material.dart';

class ClassroomTeacher extends StatelessWidget {
  const ClassroomTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aulas')),
      body: const _ClassroomView(),
    );
  }
}

class _ClassroomView extends StatelessWidget {
  const _ClassroomView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text('Aulas del profesor'),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para crear una nueva aula
              },
              child: Text('Ver salones existentes'),
            ),
              SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para gestionar las aulas existentes
                },
                child: Text('Crear nueva aula'),
            ),
          ]
        )
      )
    );
  }
}