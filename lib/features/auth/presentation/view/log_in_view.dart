import 'package:flutter/material.dart';
import 'package:work_guard/features/auth/presentation/view/widgets/logIn_view_body.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Center(child: LogInViewBody())));
  }
}
