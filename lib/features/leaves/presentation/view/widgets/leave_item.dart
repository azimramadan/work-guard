import 'package:flutter/material.dart';

class LeaveItem extends StatelessWidget {
  const LeaveItem({
    super.key,
    required this.dateRange,
    required this.applyDays,
    required this.leaveBalance,
    required this.approvedBy,
    required this.status,
  });

  final String dateRange;
  final String applyDays;
  final String leaveBalance;
  final String approvedBy;
  final String status;

  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case 'approved':
        return Color(0xffA3D139);
      case 'rejected':
        return Color(0xffFF7F74);
      case 'pending':
      default:
        return Color(0xff30BEB6);
    }
  }

  double getResponsiveFontSize(BuildContext context, double baseSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (baseSize * screenWidth / 375).clamp(12.0, 22.0);
  }

  double getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth * 0.04).clamp(16.0, 20.0);
  }

  @override
  Widget build(BuildContext context) {
    final fontSizeSmall = getResponsiveFontSize(context, 14);
    final fontSizeMedium = getResponsiveFontSize(context, 16);
    final fontSizeLarge = getResponsiveFontSize(context, 18);
    final padding = getResponsivePadding(context);

    return Container(
      margin: EdgeInsets.only(right: padding, left: padding, bottom: padding),
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date',
                style: TextStyle(fontSize: fontSizeSmall, color: Colors.grey),
              ),
              Text(
                status,
                style: TextStyle(
                  fontSize: fontSizeSmall,
                  color: getStatusColor(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            dateRange,
            style: TextStyle(
              fontSize: fontSizeLarge,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apply Days',
                      style: TextStyle(
                        fontSize: fontSizeSmall,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      applyDays,
                      style: TextStyle(
                        fontSize: fontSizeMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Leave Balance',
                      style: TextStyle(
                        fontSize: fontSizeSmall,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      leaveBalance,
                      style: TextStyle(
                        fontSize: fontSizeMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Approved By',
                      style: TextStyle(
                        fontSize: fontSizeSmall,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      approvedBy,
                      style: TextStyle(
                        fontSize: fontSizeMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
