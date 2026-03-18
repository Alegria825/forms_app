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

class _StudentRegisterForm extends StatelessWidget {
  const _StudentRegisterForm();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final lastname = registerCubit.state.lastname;
    final enrollment = registerCubit.state.enrollment;
    final email = registerCubit.state.email;
    final password = registerCubit.state.password;

    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre',
            onChanged: registerCubit.usernameChanged,
            errorMessage: username.errorMessage,
          ),
          SizedBox(height: 20),

          CustomTextFormField(
            label: 'Apellidos',
            onChanged: registerCubit.lastnameChanged,
            errorMessage: lastname.errorMessage,
          ),
          SizedBox(height: 20),

          CustomTextFormField(
            label: 'Matricula',
            onChanged: registerCubit.enrollmentChanged,
            errorMessage: enrollment.errorMessage,
          ),
          SizedBox(height: 20),

          CustomTextFormField(
            label: 'correo electronico',
            onChanged: registerCubit.emailChanged,
            errorMessage: email.errorMessage,
          ),
          SizedBox(height: 20),

          CustomTextFormField(
            label: 'contraseña',
            obscureText: true,
            onChanged: registerCubit.passwordChanged,
            errorMessage: password.errorMessage,
          ),

          SizedBox(height: 50),

          FilledButton.tonalIcon(
            onPressed: () {
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
