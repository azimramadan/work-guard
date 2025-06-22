import 'package:flutter/material.dart';
import 'package:work_guard/core/data/models/user_local_model.dart';
import 'package:work_guard/core/helper/hive_helper.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({super.key});

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  late final UserLocalModel? localUser;

  @override
  void initState() {
    super.initState();
    _loadLocalUser(); // استدعِ الدالة async هنا بدون await
  }

  Future<void> _loadLocalUser() async {
    final user = await HiveHelper.getUser();
    setState(() {
      localUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          localUser?.name ?? 'Loading...',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          localUser?.position ?? 'Loading...',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
