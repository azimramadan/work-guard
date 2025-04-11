import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_colors.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(text: 'Welcome Back 👋\nto '),
          TextSpan(
            text: 'HR Attendee',
            style: TextStyle(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}
