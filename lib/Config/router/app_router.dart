import 'package:forms_app/presentation/screens/teacher_register_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:forms_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
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
      builder: (context, state) => const HomeTeacherScreen(),
    ),
  ],
);
