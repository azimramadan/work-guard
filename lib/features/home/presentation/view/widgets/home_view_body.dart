import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:work_guard/features/home/presentation/view/widgets/attendance_overview_grid.dart';
import 'package:work_guard/features/home/presentation/view/widgets/month_calendar.dart';
import 'package:work_guard/features/home/presentation/view/widgets/month_calendar_controller.dart';
import 'package:work_guard/features/home/presentation/view/widgets/profile_header.dart';
import 'package:work_guard/features/home/presentation/view/widgets/section_title.dart';
import 'package:work_guard/features/home/presentation/view/widgets/violation_list.dart';
import 'package:work_guard/features/home/presentation/view_model/cubit/attendance_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: ProfileHeader(),
          ),
        ),
        SliverToBoxAdapter(
          child: MonthCalendarController(
            builder: (monthDays, selectedDayIndex, scrollController, onDayTap) {
              BlocProvider.of<AttendanceCubit>(
                context,
              ).getAttendanceByDate(getSelectedDateFormatted(selectedDayIndex));
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

  String getSelectedDateFormatted(int selectedDayIndex) {
    final currentDate = DateTime.now();
    final selectedDate = DateTime(
      currentDate.year,
      currentDate.month,
      selectedDayIndex + 1,
    );
    return DateFormat('yyyy-MM-dd').format(selectedDate);
  }
}
