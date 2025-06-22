import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:work_guard/core/utils/constants/app_assets.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return CircleAvatar(
      radius: screenWidth * 0.16,
      backgroundColor: Colors.transparent,
      // backgroundImage: AssetImage('assets/images/avatar.jpg'),
      child: Lottie.asset(
        AppAssets.animationProfileImage,
        repeat: false,
        fit: BoxFit.fill,
      ),
    );
  }
}
