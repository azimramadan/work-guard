import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_colors.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  const DropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 6),
                child: Text(
                  label,
                  style: TextStyle(color: AppColors.primaryColor, fontSize: 14),
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  alignment: Alignment.centerLeft,
                  value: value,
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.keyboard_arrow_down),
                  ),
                  isExpanded: true,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: onChanged,
                  items:
                      items.map<DropdownMenuItem<String>>((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                  hint: const Text('Select leave type'),
                  buttonStyleData: ButtonStyleData(
                    padding: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
