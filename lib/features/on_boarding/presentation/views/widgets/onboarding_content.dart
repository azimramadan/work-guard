import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';
import 'package:work_guard/features/on_boarding/data/models/onboarding_item.dart';

class OnboardingContent extends StatelessWidget {
  final OnboardingItem item;
  final AnimationController animationController;

  const OnboardingContent({
    super.key,
    required this.item,
    required this.animationController,
  });

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
        FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                item.title,
                style: TextStyle(
                  fontSize: screenWidth * 0.055,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ),
        ),
        Spacer(),
        FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.15,
              ),
              child: Text(
                item.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: AppColors.deepCharcoal,
                ),
              ),
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
