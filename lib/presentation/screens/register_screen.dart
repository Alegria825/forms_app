import 'package:flutter/material.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

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

              _RegisterForm(),


              SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  } 
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [

            CustomTextFormField(), 
            SizedBox(height: 20),
            
            CustomTextFormField(),
            SizedBox(height: 40),
            


            FilledButton.tonalIcon(
              onPressed: () {}, 
              icon: Icon(Icons.save),
              label: Text('Crear usuario'),
              ),
        ],
      ));
  }
}