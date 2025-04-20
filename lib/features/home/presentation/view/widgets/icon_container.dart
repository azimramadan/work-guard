import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_colors.dart';

class ContainerWithImageIcon extends StatelessWidget {
  final String iconUrl;

  const ContainerWithImageIcon({super.key, required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.09,
      height: screenWidth * 0.09,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0x193085FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FittedBox(child: Image.asset(iconUrl)),
    );
  }
}

class ContainerWithIconData extends StatelessWidget {
  final IconData icon;
  final Color color;
  const ContainerWithIconData({
    super.key,
    required this.icon,
    this.color = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.09,
      height: screenWidth * 0.09,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0x193085FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FittedBox(child: Icon(icon, color: color)),
    );
  }
}
