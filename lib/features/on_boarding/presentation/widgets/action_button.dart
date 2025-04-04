import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_colors.dart';

class ActionButton extends StatelessWidget {
  final bool isLastPage;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.isLastPage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        onPressed: onPressed,
        child: Text(
          isLastPage ? 'Get Started' : 'Next',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
