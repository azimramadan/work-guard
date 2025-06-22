import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:work_guard/core/services/firebase_service.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';

void showChangePasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const ChangePasswordBottomSheet(),
  );
}

class ChangePasswordBottomSheet extends StatefulWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  State<ChangePasswordBottomSheet> createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _showOldPassword = false;
  bool _showNewPassword = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildContainerDecoration(),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHandleBar(),
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 24),
              _buildForm(),
              const SizedBox(height: 32),
              _buildActionButtons(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      color: AppColors.scaffoldBackgroundColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
    );
  }

  // Handle bar widget
  Widget _buildHandleBar() {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.silverGray.withOpacity(0.5),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Change Password',
          style: TextStyle(
            color: AppColors.deepCharcoal,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, color: AppColors.silverGray),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildPasswordField(
            title: 'Current Password',
            controller: _oldPasswordController,
            hintText: 'Enter your current password',
            icon: Icons.lock_outline,
            isVisible: _showOldPassword,
            onVisibilityToggle: () {
              setState(() {
                _showOldPassword = !_showOldPassword;
              });
            },
            validator: _validateOldPassword,
          ),
          const SizedBox(height: 24),
          _buildPasswordField(
            title: 'New Password',
            controller: _newPasswordController,
            hintText: 'Enter your new password',
            icon: Icons.lock_reset,
            isVisible: _showNewPassword,
            onVisibilityToggle: () {
              setState(() {
                _showNewPassword = !_showNewPassword;
              });
            },
            validator: _validateNewPassword,
          ),
          const SizedBox(height: 8),
          _buildPasswordHint(),
        ],
      ),
    );
  }

  Widget _buildPasswordField({
    required String title,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.deepCharcoal,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: _buildFieldDecoration(),
          child: TextFormField(
            controller: controller,
            obscureText: !isVisible,
            style: TextStyle(color: AppColors.deepCharcoal, fontSize: 16),
            decoration: _buildInputDecoration(
              hintText: hintText,
              prefixIcon: icon,
              isVisible: isVisible,
              onVisibilityToggle: onVisibilityToggle,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }

  BoxDecoration _buildFieldDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: AppColors.silverGray.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData prefixIcon,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: AppColors.silverGray, fontSize: 14),
      prefixIcon: Icon(prefixIcon, color: AppColors.primaryColor, size: 20),
      suffixIcon: IconButton(
        icon: Icon(
          isVisible ? Icons.visibility : Icons.visibility_off,
          color: AppColors.silverGray,
          size: 20,
        ),
        onPressed: onVisibilityToggle,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildPasswordHint() {
    return Text(
      'Password must be at least 6 characters long',
      style: TextStyle(color: AppColors.silverGray, fontSize: 12),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(child: _buildCancelButton()),
        const SizedBox(width: 16),
        Expanded(flex: 2, child: _buildChangePasswordButton()),
      ],
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.silverGray.withOpacity(0.3),
            width: 1,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      child: Text(
        'Cancel',
        style: TextStyle(
          color: AppColors.silverGray,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildChangePasswordButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handleChangePassword,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        shadowColor: AppColors.primaryColor.withOpacity(0.3),
      ),
      child: _isLoading ? _buildLoadingContent() : _buildButtonContent(),
    );
  }

  Widget _buildLoadingContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        SizedBox(width: 8),
        Text('Changing...'),
      ],
    );
  }

  Widget _buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.security, size: 18),
        SizedBox(width: 8),
        Text(
          'Change Password',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  String? _validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your current password';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.length < 6) {
      return 'New password must be at least 6 characters';
    }

    if (value == _oldPasswordController.text.trim()) {
      return 'New password must be different from current password';
    }

    return null;
  }

  Future<void> _handleChangePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final oldPassword = _oldPasswordController.text.trim();
    final newPassword = _newPasswordController.text.trim();

    try {
      await _performPasswordChange(oldPassword, newPassword);
      _showSuccessMessage();
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      _handleFirebaseError(e);
    } catch (e) {
      _handleGenericError(e);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _performPasswordChange(
    String oldPassword,
    String newPassword,
  ) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user?.email == null) {
      throw Exception('User not found or email not available');
    }

    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: oldPassword,
    );
    await user.reauthenticateWithCredential(credential);

    await FirebaseService().changePassword(newPassword);
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "Password changed successfully",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _handleFirebaseError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'wrong-password':
        message = 'Incorrect current password';
        break;
      case 'weak-password':
        message = 'The new password is too weak';
        break;
      case 'requires-recent-login':
        message = 'Please log in again and try changing the password';
        break;
      default:
        message = e.message ?? 'An error occurred while changing the password';
    }
    _showErrorMessage(message);
  }

  void _handleGenericError(dynamic error) {
    _showErrorMessage("Unexpected error: ${error.toString()}");
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
