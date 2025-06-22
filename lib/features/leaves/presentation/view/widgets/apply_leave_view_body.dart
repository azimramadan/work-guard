import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_guard/core/routes.dart';
import 'package:work_guard/features/leaves/data/models/leave_model.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/apply_leave_controller.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/apply_leave_form.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/success_bottom_sheet.dart';

class ApplyLeaveViewBody extends StatefulWidget {
  const ApplyLeaveViewBody({super.key});

  @override
  State<ApplyLeaveViewBody> createState() => _ApplyLeaveViewBodyState();
}

class _ApplyLeaveViewBodyState extends State<ApplyLeaveViewBody> {
  final ApplyLeaveController controller = ApplyLeaveController();

  @override
  void initState() {
    super.initState();
    controller.titleController.addListener(_onFormChanged);
    controller.contactController.addListener(_onFormChanged);
    controller.reasonController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    setState(() {
      controller.validateTitle();
      controller.validateContact();
      controller.validateReason();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _submitForm() async {
    controller.enableAutoValidate();
    if (controller.validateForm()) {
      Map<String, dynamic> result = await controller.submitLeave();
      bool success = result['success'];
      LeaveModel leaveModel = result['leaveModel'];
      if (success) {
        // You can now use leaveModel as needed
        _showSuccessBottomSheet();
      }
    } else {
      setState(() {});
    }
  }

  void _showSuccessBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SuccessBottomSheet(
          onDone: () {
            context.go(AppRouter.kLeavesView);
            setState(() {
              controller.resetForm();
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ApplyLeaveForm(controller: controller, onSubmit: _submitForm);
  }
}
