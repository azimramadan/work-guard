import 'package:flutter/material.dart';
import 'package:work_guard/core/validation/validators.dart';
import 'package:work_guard/features/auth/presentation/view/widgets/custom_text_form_field.dart';
import 'package:work_guard/features/auth/presentation/view/widgets/forgot_password_link_text.dart';
import 'package:work_guard/features/auth/presentation/view/widgets/login_button.dart';

class LoginFormFields extends StatefulWidget {
  const LoginFormFields({super.key});

  @override
  State<LoginFormFields> createState() => _LoginFormFieldsState();
}

class _LoginFormFieldsState extends State<LoginFormFields> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Logging in...')));
      // Add your login logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _buildEmailField(),
          const SizedBox(height: 16),
          _buildPasswordField(),
          _buildForgotPasswordLinkText(),
          const SizedBox(height: 20),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordLinkText() {
    return ForgotPasswordLinkText();
  }

  Widget _buildLoginButton() {
    return LoginButton(handleLogin: _handleLogin);
  }

  Widget _buildEmailField() {
    return CustomTextFormField(
      controller: _emailController,
      label: 'Email Address',
      hint: 'michael.mitt@example.com',
      validator: Validators.validateEmail,
    );
  }

  Widget _buildPasswordField() {
    return CustomTextFormField(
      controller: _passwordController,
      label: 'Password',
      validator: Validators.validatePassword,
      isPassword: true,
      obscureText: _obscureText,
      toggleVisibility: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }
}
