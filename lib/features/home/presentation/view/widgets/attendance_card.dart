import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  final String title;
  final String time;
  final String status;
  final Widget iconWidget;
  const AttendanceCard({
    super.key,
    required this.title,
    required this.time,
    required this.status,
    required this.iconWidget,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              iconWidget,
              Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black,
                ),
              ),
              Spacer(),
            ],
          ),

          Text(
            time,
            style: TextStyle(
              fontSize: screenWidth * 0.055,
              fontWeight: FontWeight.bold,
            ),
          ),
          StatusText(status: status),
        ],
      ),
    );
  }
}

class StatusText extends StatelessWidget {
  final String status;

  const StatusText({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Text(
      status,
      style: TextStyle(
        fontSize: screenWidth * 0.04,
        color: status == 'On Time' ? Colors.green : Colors.black,
      ),
    );
  }
}
