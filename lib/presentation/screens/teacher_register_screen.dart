import 'package:flutter/material.dart';
import 'package:forms_app/presentation/widgets/widgets.dart'; 

class TeacherRegisterScreen extends StatelessWidget {
  const TeacherRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nuevo profesor'),),
      body: _TeacherRegisterView(),
    );
  }
}

class _TeacherRegisterView extends StatelessWidget {
  const _TeacherRegisterView();

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
              SizedBox(height: 40),               

              _TeacherRegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TeacherRegisterForm extends StatefulWidget {
  const _TeacherRegisterForm();

  @override
  State<_TeacherRegisterForm> createState() => _TeacherRegisterFormState();
}

class _TeacherRegisterFormState extends State<_TeacherRegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String username = '';
  String lastname = '';
  String enrollment = '';
  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre',
            onChanged: (value) => username = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              return null;
            },
          ),
          SizedBox(height: 20),

          CustomTextFormField(
            label: 'Apellidos',
            onChanged: (value) => lastname = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              return null;
            },
          ),
          SizedBox(height: 20),

          CustomTextFormField(
            label: 'Matricula de profesor',
            onChanged: (value) => enrollment = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 9) return 'Deben ser 10 digitos';
              return null;
            },
          ),
          SizedBox(height: 20),

          CustomTextFormField(
            label: 'correo electronico',
            onChanged: (value) => email = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

              if (!emailRegExp.hasMatch(value)) return 'No tiene formato de correo';

              return null;
            },
          ),
          SizedBox(height: 20),

          CustomTextFormField(
            label: 'contraseña',
            obscureText: true,
            onChanged: (value) => password = value,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              if (value.length < 6) return 'Debe de contener mas de 6 caracteres';
              return null;
            },
          ),
      
          SizedBox(height: 50),

          FilledButton.tonalIcon(
            onPressed: () {
              final isValid = _formKey.currentState!.validate();
              if (!isValid) return;

              print('$username, $lastname, $enrollment, $email, $password');
            },
            icon: Icon(Icons.save),
            label: Text('Crear profesor'),
          ),
        ],
      ),
    );
  }
}