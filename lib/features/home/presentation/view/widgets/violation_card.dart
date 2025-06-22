import 'package:flutter/material.dart';
import 'package:work_guard/features/home/presentation/view/widgets/icon_container.dart';

class ViolationCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String severity;
  final String deductions;

  const ViolationCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.severity,
    required this.deductions,
  });

  Color _getSeverityColor() {
    switch (severity.toLowerCase()) {
      case 'high':
        return const Color(0xFFEF5350); // Red soft
      case 'medium':
        return const Color(0xFFFFA726); // Orange soft
      case 'low':
        return const Color(0xFF66BB6A); // Green soft
      default:
        return const Color(0xFFB0BEC5); // Greyish blue
    }
  }

  IconData _getSeverityIcon() {
    switch (severity.toLowerCase()) {
      case 'high':
        return Icons.warning_amber_rounded;
      case 'medium':
        return Icons.report_problem_rounded;
      case 'low':
        return Icons.info_outline;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    ContainerWithIconData(
                      icon: _getSeverityIcon(),
                      color: _getSeverityColor(),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '-$deductions EGP',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFEF5350),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Date: $date",
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x193085FE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          severity.toUpperCase(),
                          style: TextStyle(
                            color: _getSeverityColor(),
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.035,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
