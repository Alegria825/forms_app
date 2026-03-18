import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class StudentRegisterScreen extends StatelessWidget {
  const StudentRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nuevo estudiante")),
      body: BlocProvider(
        create: (context) => RegisterCubit(), 
        child: _StudentRegisterView(),
        ),
    );
  }
}

class _StudentRegisterView extends StatelessWidget {
  const _StudentRegisterView();

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

              _StudentRegisterForm(),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _StudentRegisterForm extends StatefulWidget {
  const _StudentRegisterForm();

  @override
  State<_StudentRegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_StudentRegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //String username = '';
  //String lastname = '';
  //String enrollment = '';
  //String email = '';
  //String password = '';

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre',
            onChanged: (value) {
              registerCubit.usernameChanged(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              return null;
            },
          ),
          SizedBox(height: 20),

          CustomTextFormField(
            label: 'Apellidos',
            onChanged: (value) {
              registerCubit.lastnameChanged(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if (value == null || value.isEmpty) return 'Campo requerido';
              if (value.trim().isEmpty) return 'Campo requerido';
              return null;
            },
          ),
          SizedBox(height: 20),

          CustomTextFormField(
            label: 'Matricula',
            onChanged: (value) {
              registerCubit.enrollmentChanged(value);
              _formKey.currentState?.validate();
            },
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
            onChanged: (value) {
              registerCubit.emailChanged(value);
              _formKey.currentState?.validate();
            },
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
            onChanged: (value) {
              registerCubit.passwordChanged(value);
              _formKey.currentState?.validate();
            },
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
              //final isValid = _formKey.currentState!.validate();
              //if (!isValid) return;

              registerCubit.onSubmit();
            },
            icon: Icon(Icons.save),
            label: Text('Crear usuario'),
          ),
        ],
      ),
    );
  }
}
