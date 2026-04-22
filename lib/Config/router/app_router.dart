//import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:forms_app/presentation/screens/screens.dart';

final appRouter = GoRouter(

/*
  initialLocation: '/',
  // Esta es la clave: GoRouter re-evalúa las rutas cuando el estado de Auth cambia
  redirect: (context, state) {
    final isLoggingIn = state.matchedLocation == '/'; // Asumiendo que '/' es tu login
    final user = FirebaseAuth.instance.currentUser;

    // Si no hay usuario y no está en el login, mándalo a logearse
    if (user == null) return isLoggingIn ? null : '/';

    // Si ya está logeado y quiere ir al login, mándalo al home correspondiente
    // Nota: Aquí luego agregaremos la lógica para separar HomeTeacher de HomeStudent
    if (isLoggingIn) return '/home-student'; 

    return null;
  },
  */

  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/new-teacher',
      builder: (context, state) => const TeacherRegisterScreen(),
    ),
    GoRoute(
      path: '/new-student',
      builder: (context, state) => const StudentRegisterScreen(),
    ),
    GoRoute(
      path: '/home-teacher',
      builder: (context, state) => const HomeTeacherScreen(),
    ),
    GoRoute(
      path: '/home-student',
      builder: (context, state) => const HomeStudentScreen(),
    ),
    GoRoute(
      path: '/classroom-teacher',
      builder: (context, state) => const ClassroomTeacher(),
    ),

  ],
);
