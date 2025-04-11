import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    this.hint,
    this.toggleVisibility,
    this.isPassword = false,
    this.obscureText = false,
  });
  final TextEditingController controller;
  final String label;
  final String? hint;
  final FormFieldValidator<String> validator;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 56),
      child: TextFormField(
        cursorColor: const Color.fromARGB(255, 110, 112, 114),
        controller: controller,
        keyboardType:
            label.toLowerCase().contains('email')
                ? TextInputType.emailAddress
                : null,
        obscureText: isPassword ? obscureText : false,
        validator: validator,

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          labelText: label,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: TextStyle(
            color:
                validator(controller.text) != null
                    ? Colors.redAccent
                    : AppColors.primaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.3),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.redAccent, width: 1.3),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.redAccent, width: 1.3),
          ),

          errorStyle: TextStyle(color: Colors.redAccent),
          filled: true,
          fillColor: Colors.transparent,

          suffixIcon:
              isPassword
                  ? IconButton(
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: toggleVisibility,
                  )
                  : null,
        ),
      ),
    );
  }
}
