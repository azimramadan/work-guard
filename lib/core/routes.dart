import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_guard/core/navigation/main_navigation_bar.dart';
import 'package:work_guard/core/services/firebase_service.dart';
import 'package:work_guard/features/auth/presentation/view/log_in_view.dart';
import 'package:work_guard/features/home/presentation/view/home_view.dart';
import 'package:work_guard/features/leaves/presentation/view/apply_leave_view.dart';
import 'package:work_guard/features/leaves/presentation/view/leaves_view.dart';
import 'package:work_guard/features/monthly_report/presentation/view/monthly_report_view.dart';
import 'package:work_guard/features/on_boarding/presentation/views/onboarding_view.dart';
import 'package:work_guard/features/profile/presentation/view/profile_view.dart';
import 'package:work_guard/features/upload_image/presentation/view/upload_image_view.dart';

abstract class AppRouter {
  static final kOnboardingView = '/OnboardingView';
  static final kLogInView = '/LogInView';
  static final kUploadImageView = '/UploadImageView';
  static final kHomeView = '/HomeView';
  static final kLeavesView = '/LeavesView';
  static final kApplyLeaveView = '/ApplyLeaveView';
  static final kMonthlyReportView = '/MonthlyReportView';
  static final kProfileView = '/ProfileView';
  static GoRouter createRouter({required bool isFirstTime}) {
    return GoRouter(
      initialLocation:
          isFirstTime
              ? kOnboardingView
              : FirebaseService().isUserLoggedIn()
              ? kHomeView
              : kLogInView,
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
          path: kUploadImageView,
          builder: (BuildContext context, GoRouterState state) {
            return const UploadImageView();
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return Scaffold(
              body: child,
              bottomNavigationBar: MainNavigationBar(),
            );
          },
          routes: [
            GoRoute(
              path: kHomeView,
              builder: (BuildContext context, GoRouterState state) {
                return const HomeView();
              },
            ),
            GoRoute(
              path: kLeavesView,
              builder: (BuildContext context, GoRouterState state) {
                return const LeavesView();
              },
            ),
            GoRoute(
              path: kApplyLeaveView,
              builder: (BuildContext context, GoRouterState state) {
                return const ApplyLeaveView();
              },
            ),
            GoRoute(
              path: kMonthlyReportView,
              builder: (BuildContext context, GoRouterState state) {
                return const MonthlyReportView();
              },
            ),
            GoRoute(
              path: kProfileView,
              builder: (BuildContext context, GoRouterState state) {
                return const ProfileView();
              },
            ),
          ],
        ),
      ],
    );
  }
}
