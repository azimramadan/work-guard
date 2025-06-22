import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_guard/core/routes.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';

class MainNavigationBar extends StatelessWidget {
  const MainNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          return Colors.transparent;
        }),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          final isSelected = states.contains(WidgetState.selected);
          return TextStyle(
            color: isSelected ? AppColors.primaryColor : Colors.black,
            fontWeight: FontWeight.bold,
          );
        }),
      ),
      child: NavigationBar(
        selectedIndex: getSelectedIndex(context),
        onDestinationSelected: (index) => onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.black),
            selectedIcon: Icon(
              Icons.home_outlined,
              color: AppColors.primaryColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_busy, color: Colors.black),
            selectedIcon: Icon(Icons.event_busy, color: AppColors.primaryColor),
            label: 'Leaves',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined, color: Colors.black),
            selectedIcon: Icon(
              Icons.assignment_outlined,
              color: AppColors.primaryColor,
            ),
            label: 'Reports',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: Colors.black),
            selectedIcon: Icon(
              Icons.person_outline,
              color: AppColors.primaryColor,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int getSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith(AppRouter.kLeavesView)) return 1;
    if (location.startsWith(AppRouter.kMonthlyReportView)) return 2;
    if (location.startsWith(AppRouter.kProfileView)) return 3;
    return 0;
  }

  void onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRouter.kHomeView);
        break;
      case 1:
        context.go(AppRouter.kLeavesView);
        break;
      case 2:
        context.go(AppRouter.kMonthlyReportView);
        break;
      case 3:
        context.go(AppRouter.kProfileView);
        break;
    }
  }
}
