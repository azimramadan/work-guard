import 'package:flutter/material.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/leave_item.dart';

class LeaveSliverList extends StatelessWidget {
  const LeaveSliverList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final leave = leaves[index];
        return LeaveItem(
          dateRange: leave['dateRange']!,
          applyDays: leave['applyDays']!,
          leaveBalance: leave['leaveBalance']!,
          approvedBy: leave['approvedBy']!,
          status: leave['status']!,
        );
      }, childCount: leaves.length),
    );
  }
}

final List<Map<String, String>> leaves = [
  {
    'dateRange': 'Apr 15, 2023 - Apr 18, 2023',
    'applyDays': '3 Days',
    'leaveBalance': '16',
    'approvedBy': 'Martin Deo',
    'status': 'Pending',
  },
  {
    'dateRange': 'Apr 15, 2023 - Apr 18, 2023',
    'applyDays': '3 Days',
    'leaveBalance': '16',
    'approvedBy': 'Martin Deo',
    'status': 'Rejected',
  },
  {
    'dateRange': 'Apr 15, 2023 - Apr 18, 2023',
    'applyDays': '3 Days',
    'leaveBalance': '16',
    'approvedBy': 'Martin Deo',
    'status': 'Approved',
  },
];
