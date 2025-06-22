import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_guard/core/data/models/user_model.dart';
import 'package:work_guard/core/utils/constants/app_assets.dart';
import 'package:work_guard/features/home/presentation/view/widgets/attendance_card.dart';
import 'package:work_guard/features/home/presentation/view/widgets/icon_container.dart';
import 'package:work_guard/features/home/presentation/view_model/cubit/attendance_cubit.dart';

class AttendanceOverviewGrid extends StatelessWidget {
  const AttendanceOverviewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    AttendanceDay? attendance;
    return BlocConsumer<AttendanceCubit, AttendanceState>(
      listener: (context, state) {
        // AttendanceDayNotFound
        // AttendanceDayFound
        // AttendanceLoading
        // AttendanceError
        if (state is AttendanceError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is AttendanceDayNotFound) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is AttendanceLoading) {
          // Optionally show a loading indicator
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Loading attendance data...')));
        }
        if (state is AttendanceDayFound) {
          attendance = state.attendanceDay;
        }
      },
      builder: (context, state) {
        return SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverGrid(
            delegate: SliverChildListDelegate.fixed([
              AttendanceCard(
                title: 'Check In',
                time: '08:00 AM',
                status: 'On Time',
                iconWidget: ContainerWithImageIcon(
                  iconUrl: AppAssets.loginIcon,
                ),
              ),
              AttendanceCard(
                title: 'Check Out',
                time: '04:00 PM',
                status: 'Go Home',
                iconWidget: ContainerWithImageIcon(
                  iconUrl: AppAssets.logoutIcon,
                ),
              ),
              AttendanceCard(
                title: 'Total Hours',
                time: '08.00',
                status: 'Worktime',
                iconWidget: ContainerWithIconData(icon: Icons.access_time),
              ),
              AttendanceCard(
                title: 'Total Days',
                time: '25',
                status: 'Working Days',
                iconWidget: ContainerWithIconData(
                  icon: Icons.calendar_month_outlined,
                ),
              ),
            ]),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
          ),
        );
      },
    );
  }
}
