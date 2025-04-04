import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_colors.dart';

class PageIndicators extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicators({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalPages,
        (index) => _PageIndicator(isActive: index == currentPage),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final bool isActive;

  const _PageIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 4,
      width: isActive ? 50 : 10,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : AppColors.silverGray,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
