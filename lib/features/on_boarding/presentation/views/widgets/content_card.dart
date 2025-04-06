import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_colors.dart';
import 'package:work_guard/features/on_boarding/presentation/views/widgets/page_indicators.dart';

class ContentCard extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNextPressed;
  final bool isLastPage;
  final Widget contentWidget;

  const ContentCard({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNextPressed,
    required this.isLastPage,
    required this.contentWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
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
            contentWidget,
            const Spacer(),
            _buildButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
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
        onPressed: onNextPressed,
        child: Text(
          isLastPage ? 'Get Started' : 'Next',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
