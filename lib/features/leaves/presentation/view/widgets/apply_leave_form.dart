import 'package:flutter/material.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/apply_leave_controller.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/leave_form_fields.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/submit_button.dart';

class ApplyLeaveForm extends StatelessWidget {
  final ApplyLeaveController controller;
  final VoidCallback onSubmit;

  const ApplyLeaveForm({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      autovalidateMode: controller.autoValidateMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LeaveFormFields(
            titleController: controller.titleController,
            contactController: controller.contactController,
            reasonController: controller.reasonController,
            leaveType: controller.leaveModel.leaveType,
            startDate: controller.leaveModel.startDate,
            endDate: controller.leaveModel.endDate,
            titleError: controller.titleError,
            contactError: controller.contactError,
            startDateError: controller.startDateError,
            endDateError: controller.endDateError,
            reasonError: controller.reasonError,
            emailError: controller.emailError,
            autoValidateMode: controller.autoValidateMode,
            onLeaveTypeChanged: controller.updateLeaveType,
            onStartDateSelected: controller.updateStartDate,
            onEndDateSelected: controller.updateEndDate,
          ),
          const SizedBox(height: 32),
          SubmitButton(onPressed: onSubmit),
        ],
      ),
    );
  }
}
