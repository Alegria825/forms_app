import 'package:forms_app/presentation/screens/teacher_register_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:forms_app/presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [

    GoRoute(
      path: '/',
      builder:(context, state) => const HomeScreen(),
      ),
      /*GoRoute(
      path: '/cubits',
      builder:(context, state) => const CubitCounterScreen(),
      ),
      GoRoute(
      path: '/counter-bloc',
      builder:(context, state) => const BlocCounterScreen(),
      ),*/
      GoRoute(
      path: '/new-teacher',
      builder:(context, state) => const TeacherRegisterScreen(),
      ),
      GoRoute(
      path: '/new-student',
      builder:(context, state) => const StudentRegisterScreen(),
      ),

      
  ]
  
  
  );
