import 'package:flutter/material.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/custom_app_bar.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/leave_sliver_list.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/leaves_overview_grid.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/tab_section.dart';

class LeavesViewBody extends StatelessWidget {
  const LeavesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: CustomAppBar(title: 'All Leaves')),
        LeavesOverviewGrid(),
        SliverToBoxAdapter(child: TabSection()),
        LeaveSliverList(),
      ],
    );
  }
}
