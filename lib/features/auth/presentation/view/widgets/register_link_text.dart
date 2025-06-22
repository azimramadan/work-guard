import 'package:flutter/material.dart';
import 'package:work_guard/features/auth/presentation/view/dialogs/assistance_dialog.dart';

class RegisterLinkText extends StatelessWidget {
  const RegisterLinkText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            showRegisterHelpDialog(context);
          },
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

  void showRegisterHelpDialog(BuildContext context) {
    const subtitle =
        "This app is for company employees only. New accounts are created by the HR admin. Please contact your HR department to get access.";
    showAssistanceDialog(context, subtitle);
  }
}
