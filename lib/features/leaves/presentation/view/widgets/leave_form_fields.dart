import 'package:flutter/material.dart';
import 'package:work_guard/core/validation/validators.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/date_field.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/dropdown_field.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/input_field.dart';

class LeaveFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contactController;
  final TextEditingController reasonController;
  final String leaveType;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? titleError;
  final String? contactError;
  final String? startDateError;
  final String? endDateError;
  final String? reasonError;
  final String? emailError;
  final AutovalidateMode autoValidateMode;
  final Function(String?) onLeaveTypeChanged;
  final Function(DateTime) onStartDateSelected;
  final Function(DateTime) onEndDateSelected;

  const LeaveFormFields({
    super.key,
    required this.titleController,
    required this.contactController,
    required this.reasonController,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    this.titleError,
    this.contactError,
    this.startDateError,
    this.endDateError,
    this.reasonError,
    this.emailError,
    required this.autoValidateMode,
    required this.onLeaveTypeChanged,
    required this.onStartDateSelected,
    required this.onEndDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InputField(
          controller: titleController,
          label: 'Leave title',
          hint: 'Enter leave title',
          validator: (value) => Validators.validateRequired(value, 'Title'),
        ),
        const SizedBox(height: 16),
        DropdownField(
          label: 'Leave Type',
          value: leaveType,
          items: const [
            'Medical Leave',
            'Casual Leave',
            'Annual Leave',
            'Maternity Leave',
          ],
          onChanged: onLeaveTypeChanged,
        ),
        const SizedBox(height: 16),
        InputField(
          controller: contactController,
          label: 'Contact Number',
          hint: '(123) 456-7890',
          keyboardType: TextInputType.phone,
          validator: Validators.validatePhoneNumber,
        ),
        const SizedBox(height: 16),
        DateField(
          label: 'Start Date',
          value: startDate,
          errorText: startDateError,
          hintText: 'Select start date',
          onDateSelected: onStartDateSelected,
          firstDate: DateTime.now(),
        ),
        const SizedBox(height: 16),
        DateField(
          label: 'End Date',
          value: endDate,
          errorText: endDateError,
          hintText: 'Select end date',
          onDateSelected: onEndDateSelected,
          firstDate: startDate ?? DateTime.now(),
        ),
        const SizedBox(height: 16),
        InputField(
          maxLines: 3,
          controller: reasonController,
          label: 'Reason for Leave',
          hint: 'Enter the reason for your leave request...',
          validator: (value) => Validators.validateRequired(value, 'Reason'),
        ),
      ],
    );
  }
}
