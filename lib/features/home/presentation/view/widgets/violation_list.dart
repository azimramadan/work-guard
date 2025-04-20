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
