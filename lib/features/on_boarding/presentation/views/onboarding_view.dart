import 'package:flutter/material.dart';
import 'package:work_guard/features/on_boarding/presentation/views/widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: OnboardingViewBody()));
  }
}
