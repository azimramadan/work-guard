import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/leave_status_card.dart';

class LeavesOverviewGrid extends StatelessWidget {
  const LeavesOverviewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> cardsData = [
      {
        'title': 'Balance',
        'count': '16',
        'color': AppColors.primaryColor.withOpacity(.08),
        'textColor': AppColors.primaryColor,
      },
      {
        'title': 'Approved',
        'count': '5',
        'color': Color(0xffA3D139).withOpacity(.08),
        'textColor': Color(0xffA3D139),
      },
      {
        'title': 'Pending',
        'count': '3',
        'color': Color(0xff30BEB6).withOpacity(.08),
        'textColor': Color(0xff30BEB6),
      },
      {
        'title': 'Rejected',
        'count': '2',
        'color': Color(0xFFFF7F74).withOpacity(.08),
        'textColor': Color(0xffFF7F74),
      },
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final data = cardsData[index];
          return LeaveStatusCard(
            title: data['title'],
            count: data['count'],
            color: data['color'],
            textColor: data['textColor'],
          );
        }, childCount: cardsData.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
      ),
    );
  }
}
