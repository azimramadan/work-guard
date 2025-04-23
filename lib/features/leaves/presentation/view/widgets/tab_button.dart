import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;

  const TabButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = (screenWidth * 0.04).clamp(12.0, 18.0);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.blue : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
