import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_guard/features/auth/presentation/view/log_in_view.dart';
import 'package:work_guard/features/home/presentation/view/home_view.dart';
import 'package:work_guard/features/on_boarding/presentation/views/onboarding_view.dart';

abstract class AppRouter {
  static final kOnboardingView = '/OnboardingView';
  static final kLogInView = '/LogInView';
  static final kHomeView = '/HomeView';
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: kHomeView,
      routes: [
        GoRoute(
          path: kOnboardingView,
          builder: (BuildContext context, GoRouterState state) {
            return OnboardingView();
          },
        ),
        GoRoute(
          path: kLogInView,
          builder: (BuildContext context, GoRouterState state) {
            return const LogInView();
          },
        ),
        GoRoute(
          path: kHomeView,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeView();
          },
        ),
      ],
    );
  }
}
