import 'package:flutter/material.dart';
import 'package:work_guard/features/home/presentation/view/widgets/violation_card.dart';

class ViolationList extends StatelessWidget {
  const ViolationList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final violation = violations[index];
        return ViolationCard(
          title: violation['title']!,
          description: violation['description']!,
          date: violation['date']!,
          severity: violation['severity']!,
        );
      }, childCount: violations.length),
    );
  }
}

final List<Map<String, String>> violations = [
  {
    'title': 'Late Check-in',
    'description': 'You checked in at 9:45 AM instead of 9:00 AM.',
    'date': 'Apr 21, 2025',
    'severity': 'High',
  },
  {
    'title': 'Early Leave',
    'description': 'You checked out at 4:00 PM instead of 5:00 PM.',
    'date': 'Apr 20, 2025',
    'severity': 'Medium',
  },
  {
    'title': 'Uninformed Absence',
    'description': 'No attendance recorded for the day.',
    'date': 'Apr 19, 2025',
    'severity': 'High',
  },
];
