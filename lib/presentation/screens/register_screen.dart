import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nuevo usuario"),
      ),
      body: _RegisterView(),
    );
  }

  
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const FlutterLogo(size: 100),
              
              TextFormField(),
              TextFormField(),
              TextFormField(),
              TextFormField(),

              const SizedBox(height: 40),


              FilledButton.tonalIcon(
                onPressed: () {}, 
                icon: Icon(Icons.save),
                label: Text('Crear usuario'),
                ),

              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  } 
}