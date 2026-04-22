import 'package:forms_app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:forms_app/presentation/blocs/auth_cubit/auth_state.dart';
import 'package:go_router/go_router.dart';
import 'package:forms_app/presentation/screens/screens.dart';
import 'dart:async';
import 'package:flutter/material.dart';

GoRouter createRouter(AuthCubit authCubit) {
  return GoRouter(
    initialLocation: '/',
    // ¡ESTA ES LA PIEZA CLAVE!
    refreshListenable: GoRouterRefreshStream(authCubit.stream),

    redirect: (context, state) {
      final authState = authCubit.state;
      final String location = state.matchedLocation;

      if (authState.status == AuthStatus.checking) return null;

      if (authState.status == AuthStatus.unauthenticated) {
        return (location == '/') ? null : '/';
      }

      if (authState.status == AuthStatus.authenticated) {
        final user = authState.user!;

        // 1. REGLA DE ORO: Si es estudiante y le falta la matrícula, bloquearlo.
        final isStudentWithoutEnrollment = user.role == 'student' && 
            (user.enrollment == null || user.enrollment!.isEmpty);

        if (isStudentWithoutEnrollment) {
          // Si ya está en la pantalla de registro, lo dejamos ahí. Si no, lo forzamos a ir.
          return (location == '/new-student') ? null : '/new-student';
        }

        // 2. Si tiene sus datos completos y está en la raíz (o acaba de terminar el registro)
        if (location == '/' || location == '/new-student') {
          return (user.role == 'professor') ? '/home-teacher' : '/home-student';
        }
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
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
        path: '/new-teacher',
        builder: (context, state) => const TeacherRegisterScreen(),
      ),
      GoRoute(
        path: '/classroom-teacher',
        builder: (context, state) => const ClassroomTeacher(),
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
