import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/constants/app_assets.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';
import 'package:work_guard/features/auth/presentation/view/widgets/login_form_fields.dart';
import 'package:work_guard/features/auth/presentation/view/widgets/register_link_text.dart';
import 'package:work_guard/features/auth/presentation/view/widgets/welcome_text.dart';

class LogInViewBody extends StatelessWidget {
  const LogInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20.0),
        child: _buildLogInViewBody(),
      ),
    );
  }

  Widget _buildLogInViewBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AspectRatio(aspectRatio: 2, child: Image.asset(AppAssets.logo)),
        const SizedBox(height: 25),
        WelcomeText(),
        const SizedBox(height: 8),
        const Text(
          'Hello there, login to continue',
          style: TextStyle(color: AppColors.silverGray, fontSize: 14),
        ),
        const SizedBox(height: 30),
        LoginFormFields(),
        const SizedBox(height: 20),
        RegisterLinkText(),
        const SizedBox(height: 20),
      ],
    );
  }
}
