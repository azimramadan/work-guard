import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_guard/core/routes.dart';
import 'package:work_guard/core/utils/app_assets.dart';
import 'package:work_guard/features/on_boarding/data/models/onboarding_item.dart';
import 'package:work_guard/features/on_boarding/presentation/views/widgets/background_image.dart';
import 'package:work_guard/features/on_boarding/presentation/views/widgets/content_card.dart';
import 'package:work_guard/features/on_boarding/presentation/views/widgets/onboarding_content.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody>
    with TickerProviderStateMixin {
  final List<OnboardingItem> items = [
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

  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  int currentPage = 0;

  int get itemsCount => items.length;
  bool get isLastPage => currentPage == items.length - 1;
  OnboardingItem get currentItem => items[currentPage];

  @override
  void initState() {
    super.initState();
    initializeAnimations();
  }

  void initializeAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );

    slideAnimation = Tween<Offset>(
      begin: const Offset(0.2, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void goToPage(int page) {
    animationController.reset();
    currentPage = page;
    animationController.forward();
    setState(() {});
  }

  void navigateToNextPage() {
    if (currentPage < items.length - 1) {
      goToPage(currentPage + 1);
    } else {
      completeOnboarding();
    }
  }

  void navigateToPreviousPage() {
    if (currentPage > 0) {
      goToPage(currentPage - 1);
    }
  }

  void completeOnboarding() {
    GoRouter.of(context).push(AppRouter.kLogInView);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          navigateToPreviousPage();
        } else if (details.primaryVelocity! < 0) {
          navigateToNextPage();
        }
      },
      child: Stack(
        children: [
          _buildBackgroundImage(currentItem),
          Column(
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              ContentCard(
                currentPage: currentPage,
                totalPages: itemsCount,
                onNextPressed: navigateToNextPage,
                isLastPage: isLastPage,
                contentWidget: OnboardingContent(
                  item: currentItem,
                  animationController: animationController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(OnboardingItem currentItem) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Padding(
        padding: _getImagePadding(currentItem),
        child: BackgroundImage(
          key: ValueKey<String>(currentItem.mockupImage),
          imagePath: currentItem.mockupImage,
        ),
      ),
    );
  }

  EdgeInsets _getImagePadding(OnboardingItem item) {
    final int index = items.indexOf(item);
    switch (index) {
      case 0:
        return const EdgeInsets.only(top: 35, left: 23, right: 23);
      case 1:
        return const EdgeInsets.all(30.0);
      case 2:
        return const EdgeInsets.only(top: 35, left: 35, right: 35);
      default:
        return const EdgeInsets.all(30.0);
    }
  }
}
