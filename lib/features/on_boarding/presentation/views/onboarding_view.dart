import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_guard/core/routes.dart';
import 'package:work_guard/core/utils/app_assets.dart';
import 'package:work_guard/features/on_boarding/data/models/onboarding_item.dart';
import 'package:work_guard/features/on_boarding/presentation/views/widgets/onboarding_page.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'our Daily Work Summary is Ready! 🕒',
      description:
          'View your check-in and check-out times, actual working hours, recorded violations, and performance rating for the day—all in one place!',
      mockupImage: AppAssets.onboarding_1,
    ),
    OnboardingItem(
      title: 'Manage Your Leaves with Ease 🏖️',
      description:
          'Check your available leave balance, track past requests, and apply for new leaves effortlessly.',
      mockupImage: AppAssets.onboarding_2,
    ),
    OnboardingItem(
      title: 'Your Monthly Performance at a Glance 📊',
      description:
          'Get a detailed report of your attendance, leaves, absences, recorded violations, salary, and deductions for the month.',
      mockupImage: AppAssets.onboarding_3,
    ),
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _navigateToNextPage() {
    if (_currentPage < _items.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    GoRouter.of(context).push(AppRouter.kLogInView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: _items.length,
          onPageChanged: _onPageChanged,
          itemBuilder:
              (context, index) => OnboardingSlide(
                item: _items[index],
                currentPage: _currentPage,
                totalPages: _items.length,
                onNextPressed: _navigateToNextPage,
              ),
        ),
      ),
    );
  }
}
