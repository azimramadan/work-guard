import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
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
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 56),
      child: TextFormField(
        cursorColor: const Color.fromARGB(255, 110, 112, 114),
        controller: widget.controller,
        keyboardType:
            widget.label.toLowerCase().contains('email')
                ? TextInputType.emailAddress
                : null,
        obscureText: widget.isPassword ? widget.obscureText : false,
        validator: (value) {
          final error = widget.validator(value);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              hasError = error != null;
            });
          });
          return error;
        },

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          labelText: widget.label,
          hintText: widget.hint,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: TextStyle(
            color: hasError ? Colors.redAccent : AppColors.primaryColor,
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
              widget.isPassword
                  ? IconButton(
                    icon: Icon(
                      widget.obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: widget.toggleVisibility,
                  )
                  : null,
        ),
      ),
    );
  }
}
