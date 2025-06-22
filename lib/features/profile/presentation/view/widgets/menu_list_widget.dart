import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';
import 'package:work_guard/features/profile/presentation/view/employee_info_view.dart';
import 'package:work_guard/features/profile/presentation/view/widgets/change_password_bottom_sheet.dart';
import 'package:work_guard/features/profile/presentation/view/widgets/logout_button.dart';

class MenuListWidget extends StatelessWidget {
  const MenuListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuItemWidget(
          icon: Icons.person_outlined,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const EmployeeInfoView()),
            );
          },
          title: 'My Profile',
        ),
        Divider(color: Colors.grey.shade200),
        MenuItemWidget(
          icon: Icons.image_outlined,
          onTap: () {},
          title: 'My Images',
        ),
        Divider(color: Colors.grey.shade200),
        MenuItemWidget(
          icon: Icons.lock_outline,
          onTap: () {
            showChangePasswordBottomSheet(context);
          },
          title: 'Change Password',
        ),
        Divider(color: Colors.grey.shade200),
        LogoutButton(),
      ],
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: EdgeInsets.only(left: 8),
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        child: Icon(icon, color: AppColors.deepCharcoal, size: 24),
      ),
      title: Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
      trailing: const Icon(Icons.chevron_right, color: Colors.black, size: 30),
      onTap: onTap,
    );
  }
}
