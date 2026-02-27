import 'package:flutter/material.dart';
import 'package:forms_app/Config/router/app_router.dart';
import 'package:forms_app/Config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
