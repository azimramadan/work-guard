import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_colors.dart';
import 'package:work_guard/features/on_boarding/data/models/onboarding_item.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingItem item;
  final AnimationController animationController;

  const OnboardingContent({
    Key? key,
    required this.item,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    final slideAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    return Column(
      children: [
        // Animated title
        FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Text(
              item.title,
              style: TextStyle(
                fontSize: screenWidth * 0.065,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Animated description
        FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Text(
              item.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: AppColors.deepCharcoal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
