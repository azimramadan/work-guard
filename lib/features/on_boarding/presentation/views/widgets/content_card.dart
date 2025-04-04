import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_colors.dart';
import 'package:work_guard/features/on_boarding/presentation/views/widgets/action_button.dart';
import 'package:work_guard/features/on_boarding/presentation/views/widgets/page_indicators.dart';

class ContentCard extends StatelessWidget {
  final double screenWidth;
  final String title;
  final String description;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNextPressed;

  const ContentCard({
    super.key,
    required this.screenWidth,
    required this.title,
    required this.description,
    required this.currentPage,
    required this.totalPages,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          PageIndicators(currentPage: currentPage, totalPages: totalPages),
          const SizedBox(height: 20),
          _TitleText(text: title, screenWidth: screenWidth),
          const SizedBox(height: 10),
          _DescriptionText(text: description, screenWidth: screenWidth),
          Expanded(child: const SizedBox()),
          ActionButton(
            isLastPage: currentPage == totalPages - 1,
            onPressed: onNextPressed,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String text;
  final double screenWidth;

  const _TitleText({required this.text, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: screenWidth * 0.065,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _DescriptionText extends StatelessWidget {
  final String text;
  final double screenWidth;

  const _DescriptionText({required this.text, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: screenWidth * 0.04,
        color: AppColors.deepCharcoal,
      ),
    );
  }
}
