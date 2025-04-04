import 'package:flutter/material.dart';
import 'package:work_guard/features/on_boarding/data/models/onboarding_item.dart';
import 'package:work_guard/features/on_boarding/presentation/widgets/background_image.dart';
import 'package:work_guard/features/on_boarding/presentation/widgets/content_card.dart';

class OnboardingSlide extends StatelessWidget {
  final OnboardingItem item;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNextPressed;

  const OnboardingSlide({
    super.key,
    required this.item,
    required this.currentPage,
    required this.totalPages,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        BackgroundImage(imagePath: item.mockupImage),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(flex: 3, child: SizedBox()),
            Expanded(
              flex: 2,
              child: ContentCard(
                screenWidth: screenWidth,
                title: item.title,
                description: item.description,
                currentPage: currentPage,
                totalPages: totalPages,
                onNextPressed: onNextPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
