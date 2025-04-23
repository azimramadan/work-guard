import 'package:flutter/material.dart';
import 'package:work_guard/core/validation/validators.dart';
import 'package:work_guard/features/leaves/data/models/leave_model.dart';

class ApplyLeaveController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  LeaveModel leaveModel = LeaveModel(
    startDate: DateTime.now().add(const Duration(days: 1)),
    endDate: DateTime.now().add(const Duration(days: 4)),
    email: '',
  );

  String? titleError;
  String? contactError;
  String? startDateError;
  String? endDateError;
  String? reasonError;
  String? emailError;

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  ApplyLeaveController() {
    titleController.text = leaveModel.title;
    contactController.text = leaveModel.contactNumber;
    reasonController.text = leaveModel.reason;
  }

  void enableAutoValidate() {
    autoValidateMode = AutovalidateMode.always;
  }

  void dispose() {
    titleController.dispose();
    contactController.dispose();
    reasonController.dispose();
  }

  void updateLeaveType(String? value) {
    if (value != null) {
      leaveModel.leaveType = value;
    }
  }

  void updateStartDate(DateTime date) {
    leaveModel.startDate = date;
    if (leaveModel.endDate.isBefore(date)) {
      leaveModel.endDate = date.add(const Duration(days: 3));
    }
    validateDates();
  }

  void updateEndDate(DateTime date) {
    leaveModel.endDate = date;
    validateDates();
  }

  void validateTitle() {
    titleError = Validators.validateRequired(titleController.text, 'Title');
    if (titleError == null) {
      leaveModel.title = titleController.text;
    }
  }

  void validateContact() {
    contactError = Validators.validatePhoneNumber(contactController.text);
    if (contactError == null) {
      leaveModel.contactNumber = contactController.text;
    }
  }

  void validateReason() {
    reasonError = Validators.validateRequired(reasonController.text, 'Reason');
    if (reasonError == null) {
      leaveModel.reason = reasonController.text;
    }
  }

  void validateDates() {
    startDateError = Validators.validateFutureDate(
      leaveModel.startDate,
      'Start date',
    );
    endDateError = Validators.validateEndDate(
      leaveModel.endDate,
      leaveModel.startDate,
    );
  }

  bool validateForm() {
    bool isValid = true;

    validateTitle();
    if (titleError != null) isValid = false;

    validateContact();
    if (contactError != null) isValid = false;

    if (emailError != null) isValid = false;

    validateDates();
    if (startDateError != null || endDateError != null) isValid = false;

    validateReason();
    if (reasonError != null) isValid = false;

    return isValid;
  }

  void resetForm() {
    leaveModel = LeaveModel(
      startDate: DateTime.now().add(const Duration(days: 1)),
      endDate: DateTime.now().add(const Duration(days: 4)),
      email: '',
    );
    titleController.text = '';
    contactController.text = '';
    reasonController.text = '';
    titleError = null;
    contactError = null;
    startDateError = null;
    endDateError = null;
    reasonError = null;
    emailError = null;
  }

  Future<Map<String, dynamic>> submitLeave() async {
    leaveModel.title = titleController.text;
    leaveModel.contactNumber = contactController.text;
    leaveModel.reason = reasonController.text;
    leaveModel.email =
        'emailController.text'; ///////////////////////////////////////////////////////////////////////////////////
    return {'success': true, 'leaveModel': leaveModel};
  }
}
