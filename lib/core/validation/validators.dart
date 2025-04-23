class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^01[0125]\d{8}$').hasMatch(value.trim())) {
      return 'Enter a valid number like: (01x) xxxx-xxxx';
    }

    return null;
  }

  static String? validateFutureDate(DateTime? value, String fieldName) {
    if (value == null) {
      return '$fieldName is required';
    } else if (value.isBefore(DateTime.now())) {
      return '$fieldName must be in the future';
    }
    return null;
  }

  static String? validateEndDate(DateTime? endDate, DateTime? startDate) {
    if (endDate == null) {
      return 'End date is required';
    } else if (startDate != null && endDate.isBefore(startDate)) {
      return 'End date must be after start date';
    }
    return null;
  }
}
