import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:forms_app/Config/router/app_router.dart';
import 'package:forms_app/firebase_options.dart';
// Asegúrate de que la ruta sea minúscula si así es tu carpeta
import 'package:forms_app/infrastructure/datasources/firebase_auth_datasource.dart';
import 'package:forms_app/infrastructure/repositories/auth_repository_impl.dart';
import 'package:forms_app/presentation/blocs/auth_cubit/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Preparamos el repositorio (Infrastructure)
    final authRepository = AuthRepositoryImpl(FirebaseAuthDatasource());

    return MultiBlocProvider(
      providers: [
        // 2. Proveemos el Cubit a toda la aplicación
        BlocProvider(
          create: (_) => AuthCubit(authRepository),
          lazy: false, // Se ejecuta de inmediato para revisar si ya hay sesión
        ),
      ],
      // El hijo '_AppRouterConfig' sí tendrá acceso al AuthCubit en su context
      child: const _AppRouterConfig(),
    );
  }
}

class _AppRouterConfig extends StatelessWidget {
  const _AppRouterConfig();

  @override
  Widget build(BuildContext context) {
    // 3. Ahora sí podemos leer el Cubit porque este widget es hijo del Provider
    final authCubit = context.read<AuthCubit>();
    
    // 4. Creamos el router inyectando el Cubit (esto activa el refreshListenable)
    final router = createRouter(authCubit);

    return MaterialApp.router(
      routerConfig: router, // <--- Importante: usamos 'router' y no el 'appRouter' global
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: Colors.blue,
      ),
    );
  }
}