import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_assets.dart';
import 'package:work_guard/core/utils/app_colors.dart';
import 'package:work_guard/features/on_boarding/data/models/onboarding_item.dart';
import 'package:work_guard/features/on_boarding/presentation/views/widgets/background_image.dart';
import 'package:work_guard/features/on_boarding/presentation/views/widgets/onboarding_view_body.dart';
import 'package:work_guard/features/on_boarding/presentation/views/widgets/page_indicators.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: OnboardingViewBody()));
  }
}
