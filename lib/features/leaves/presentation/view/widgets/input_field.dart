import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    this.hint,
    this.toggleVisibility,
    this.keyboardType,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final FormFieldValidator<String> validator;
  final int maxLines;
  final VoidCallback? toggleVisibility;
  final TextInputType? keyboardType;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      child: TextFormField(
        maxLines: widget.maxLines,
        cursorColor: AppColors.primaryColor,
        controller: widget.controller,
        keyboardType:
            widget.keyboardType ??
            (widget.label.toLowerCase().contains('email')
                ? TextInputType.emailAddress
                : null),
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
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          labelStyle: TextStyle(color: Colors.grey),
          labelText: widget.label,
          alignLabelWithHint: true,
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
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.3),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1.3),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
