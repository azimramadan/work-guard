import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:work_guard/core/data/models/user_local_model.dart';
import 'package:work_guard/core/helper/hive_helper.dart';
import 'package:work_guard/core/routes.dart';
import 'package:work_guard/core/utils/constants/app_assets.dart';
import 'package:work_guard/features/home/presentation/view/widgets/notification_badge.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ImageAvatar(),
        const SizedBox(width: 12),
        Expanded(child: UserInfo()),
        const NotificationBadge(),
      ],
    );
  }
}

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  late final UserLocalModel? localUser;

  @override
  void initState() {
    super.initState();
    _loadLocalUser();
  }

  Future<void> _loadLocalUser() async {
    final user = await HiveHelper.getUser();
    setState(() {
      localUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localUser?.name ?? 'loading...',
          style: TextStyle(
            fontSize: screenWidth * .06,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          localUser?.position ?? 'loading...',
          style: TextStyle(fontSize: screenWidth * .04, color: Colors.grey),
        ),
      ],
    );
  }
}

class ImageAvatar extends StatelessWidget {
  const ImageAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        context.go(AppRouter.kProfileView);
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: screenWidth * .07,
        child: Lottie.asset(
          AppAssets.animationProfileImage,
          repeat: false,
        ), //const AssetImage('assets/images/avatar.jpg'),
      ),
    );
  }
}
