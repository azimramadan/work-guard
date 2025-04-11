import 'package:flutter/material.dart';

class ForgotPasswordLinkText extends StatelessWidget {
  const ForgotPasswordLinkText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: GestureDetector(
          onTap: () {},
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
