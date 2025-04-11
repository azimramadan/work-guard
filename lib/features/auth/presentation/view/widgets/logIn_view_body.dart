import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_assets.dart';
import 'package:work_guard/core/utils/app_colors.dart';
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
        _buildLogo(),
        const SizedBox(height: 25),
        _buildWelcomeText(),
        const SizedBox(height: 8),
        _buildSubtitleText(),
        const SizedBox(height: 30),
        _buildLoginFormFields(),
        const SizedBox(height: 20),
        _buildRegisterLinkText(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildWelcomeText() {
    return WelcomeText();
  }

  Widget _buildLoginFormFields() {
    return LoginFormFields();
  }

  Widget _buildRegisterLinkText() {
    return RegisterLinkText();
  }

  Widget _buildLogo() {
    return AspectRatio(aspectRatio: 2, child: Image.asset(AppAssets.logo));
  }

  Widget _buildSubtitleText() {
    return const Text(
      'Hello there, login to continue',
      style: TextStyle(color: AppColors.silverGray, fontSize: 14),
    );
  }
}
