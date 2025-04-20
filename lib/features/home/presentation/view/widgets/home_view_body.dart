import 'package:flutter/material.dart';
import 'package:work_guard/features/home/presentation/view/widgets/attendance_overview_grid.dart';
import 'package:work_guard/features/home/presentation/view/widgets/month_calendar.dart';
import 'package:work_guard/features/home/presentation/view/widgets/month_calendar_controller.dart';
import 'package:work_guard/features/home/presentation/view/widgets/profile_header.dart';
import 'package:work_guard/features/home/presentation/view/widgets/section_title.dart';
import 'package:work_guard/features/home/presentation/view/widgets/violation_list.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ProfileHeader(),
          ),
        ),
        SliverToBoxAdapter(
          child: MonthCalendarController(
            builder: (monthDays, selectedDayIndex, scrollController, onDayTap) {
              return MonthCalendar(
                monthDays: monthDays,
                selectedDayIndex: selectedDayIndex,
                scrollController: scrollController,
                onDayTap: onDayTap,
              );
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16),
            child: SectionTitle(title: 'Today Attendance'),
          ),
        ),
        AttendanceOverviewGrid(),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 16),
            child: SectionTitle(title: 'Violations Section'),
          ),
        ),
        ViolationList(),
      ],
    );
  }
}
