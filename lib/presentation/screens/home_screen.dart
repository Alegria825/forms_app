import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          /*ListTile(
            title: const Text('Cubits'),
            subtitle: Text('Gestor de estado simple'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => context.push('/cubits'),
          ),
          ListTile(
            title: const Text ("Bloc"),
            subtitle: Text('Gestor de estado BLOC'),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => context.push('/counter-bloc'),
          ),*/

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(),
          ),
          ListTile(
            title: const Text('User Screen'),
            subtitle: const Text('Formulario'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.push('/new-student'),
          ),
          ListTile(
            title: Text('Teacher screen'),
            subtitle: Text('Teacher registration'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.push('/new-teacher'),
          )
        ],
      ),
    );
  }
}