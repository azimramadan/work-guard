import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';

class LoginButton extends StatelessWidget {
  final void Function() handleLogin;
  final bool loading;
  const LoginButton({
    super.key,
    required this.handleLogin,
    this.loading = false,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 0,
        ),
        onPressed: handleLogin,
        child:
            loading
                ? const CircularProgressIndicator()
                : const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
      ),
    );
  }
}
