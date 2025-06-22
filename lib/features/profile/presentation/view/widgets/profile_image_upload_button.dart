import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';

class ProfileImageUploadButton extends StatelessWidget {
  const ProfileImageUploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 56),
        maximumSize: Size(double.infinity, 56),
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        'Add Profile Image',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
