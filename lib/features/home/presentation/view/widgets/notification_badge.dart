import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as badges;
import 'package:work_guard/core/utils/app_assets.dart';

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return badges.Badge(
      isLabelVisible: true,
      label: const Text('3'),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        clipBehavior: Clip.hardEdge,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: InkWell(
            onTap: () {},
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Image.asset(
                AppAssets.notificationIcon,
                width: screenWidth * .075,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
