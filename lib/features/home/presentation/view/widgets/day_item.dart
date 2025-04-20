import 'package:flutter/material.dart';

class DayItem extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;
  final bool isHoliday;
  final bool isFuture;
  final VoidCallback onTap;

  const DayItem({
    super.key,
    required this.day,
    required this.date,
    required this.isSelected,
    required this.isHoliday,
    required this.isFuture,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // تحديد لون الخلفية
    Color bgColor;
    if (isSelected) {
      bgColor = Colors.blue;
    } else if (isHoliday) {
      bgColor = Colors.grey.shade200;
    } else {
      bgColor = Colors.white;
    }

    // تحديد لون النص الرئيسي (التاريخ)
    Color textColor;
    if (isSelected) {
      textColor = Colors.white;
    } else if (isHoliday) {
      textColor = Colors.grey.shade400;
    } else if (isFuture) {
      textColor = Colors.grey.shade400;
    } else {
      textColor = Colors.black;
    }

    // تحديد لون نص اليوم
    Color dayTextColor;
    if (isSelected) {
      dayTextColor = Colors.white;
    } else if (isHoliday) {
      dayTextColor = Colors.grey.shade400;
    } else if (isFuture) {
      dayTextColor = Colors.grey.shade400;
    } else {
      dayTextColor = Colors.grey;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                day,
                style: TextStyle(
                  fontSize: screenWidth * 0.037,
                  fontWeight: FontWeight.w500,
                  color: dayTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
