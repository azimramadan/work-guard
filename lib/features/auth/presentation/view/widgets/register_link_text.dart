import 'package:flutter/material.dart';

class RegisterLinkText extends StatelessWidget {
  const RegisterLinkText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: Text(
            'Don\'t have an account? ',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
