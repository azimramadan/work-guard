import 'package:flutter/material.dart';
import 'package:work_guard/features/auth/presentation/view/dialogs/assistance_dialog.dart';

class ForgotPasswordLinkText extends StatelessWidget {
  const ForgotPasswordLinkText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: GestureDetector(
          onTap: () {
            showForgotPasswordDialog(context);
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.blue, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

void showForgotPasswordDialog(BuildContext context) {
  const subtitle =
      "If you forgot your password, please contact your company's HR admin. They are the only ones who can reset your password.";
  showAssistanceDialog(context, subtitle);
}
