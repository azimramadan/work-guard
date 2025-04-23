import 'package:flutter/material.dart';

class LeaveStatusCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;
  final Color textColor;

  const LeaveStatusCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: textColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Leave\n$title',
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            count,
            style: TextStyle(
              fontSize: screenWidth * 0.065,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
