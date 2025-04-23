import 'package:flutter/material.dart';

class ApplyLeaveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ApplyLeaveAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      leading: const BackButton(color: Colors.black),
      title: const Text('Apply Leave', style: TextStyle(color: Colors.black)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
