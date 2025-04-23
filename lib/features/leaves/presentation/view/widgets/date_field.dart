import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:work_guard/core/utils/app_colors.dart';

class DateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final String? errorText;
  final String hintText;
  final Function(DateTime) onDateSelected;
  final DateTime firstDate;

  const DateField({
    super.key,
    required this.label,
    required this.value,
    required this.onDateSelected,
    required this.firstDate,
    this.errorText,
    this.hintText = 'Select date',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now().add(const Duration(days: 1)),
              firstDate: firstDate,
              lastDate: DateTime(firstDate.year + 2),
            );
            if (picked != null) {
              onDateSelected(picked);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: errorText != null ? Colors.red : AppColors.primaryColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      value != null
                          ? DateFormat('MMMM dd, yyyy').format(value!)
                          : hintText,
                      style: TextStyle(
                        fontSize: 16,
                        color: value != null ? Colors.black : Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                const Icon(Icons.calendar_month, color: Colors.grey),
              ],
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 6),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
