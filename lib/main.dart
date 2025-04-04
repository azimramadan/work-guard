import 'package:flutter/material.dart';
import 'package:work_guard/core/routes.dart';
import 'package:work_guard/core/utils/app_colors.dart';

void main() {
  runApp(const WorkGuardApp());
}

class WorkGuardApp extends StatelessWidget {
  const WorkGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      ),
      routerConfig: AppRouter.createRouter(),
    );
  }
}
