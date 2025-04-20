import 'package:flutter/material.dart';
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

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Michael Mitc',
          style: TextStyle(
            fontSize: screenWidth * .06,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Lead UI/UX Designer',
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
      onTap: () {},
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: screenWidth * .07,
        backgroundImage: const AssetImage('assets/images/avatar.jpg'),
      ),
    );
  }
}
