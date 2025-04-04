import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_guard/features/on_boarding/presentation/views/onboarding_view.dart';

abstract class AppRouter {
  static final kOnboardingView = '/OnboardingView';
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: kOnboardingView,
      routes: [
        GoRoute(
          path: kOnboardingView,
          builder: (BuildContext context, GoRouterState state) {
            return OnboardingView();
          },
        ),
      ],
    );
  }
}
