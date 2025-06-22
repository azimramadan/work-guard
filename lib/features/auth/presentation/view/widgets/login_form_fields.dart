import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:work_guard/core/routes.dart';
import 'package:work_guard/core/validation/validators.dart';
import 'package:work_guard/features/auth/presentation/view/widgets/custom_text_form_field.dart';
import 'package:work_guard/features/auth/presentation/view/widgets/forgot_password_link_text.dart';
import 'package:work_guard/features/auth/presentation/view/widgets/login_button.dart';
import 'package:work_guard/features/auth/presentation/view_model/cubit/auth_sign_in_cubit.dart';

class LoginFormFields extends StatefulWidget {
  const LoginFormFields({super.key});

  @override
  State<LoginFormFields> createState() => _LoginFormFieldsState();
}

class _LoginFormFieldsState extends State<LoginFormFields> {
  bool _obscureText = true;
  bool _shouldValidate = false;
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
    setState(() {
      _shouldValidate = true;
    });
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthSignInCubit>(context).signInUser(
        email: _emailController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthSignInCubit, AuthSignInState>(
      listener: (context, state) {
        if (state is AuthSignInSuccess) {
          context.go(AppRouter.kHomeView);
        } else if (state is AuthSignInFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          autovalidateMode:
              _shouldValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
          child: Column(
            children: [
              _buildEmailField(),
              const SizedBox(height: 16),
              _buildPasswordField(),
              ForgotPasswordLinkText(),
              const SizedBox(height: 20),
              LoginButton(
                loading: state is AuthSignInLoading,
                handleLogin: _handleLogin,
              ),
            ],
          ),
        );
      },
    );
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
