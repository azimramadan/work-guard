import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/app_assets.dart';
import 'package:work_guard/features/home/presentation/view/widgets/attendance_card.dart';
import 'package:work_guard/features/home/presentation/view/widgets/icon_container.dart';

class AttendanceOverviewGrid extends StatelessWidget {
  const AttendanceOverviewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        delegate: SliverChildListDelegate.fixed([
          AttendanceCard(
            title: 'Check In',
            time: '10:20 am',
            status: 'On Time',
            iconWidget: ContainerWithImageIcon(iconUrl: AppAssets.loginIcon),
          ),
          AttendanceCard(
            title: 'Check Out',
            time: '07:00 pm',
            status: 'Go Home',
            iconWidget: ContainerWithImageIcon(iconUrl: AppAssets.logoutIcon),
          ),
          AttendanceCard(
            title: 'Total Hours',
            time: '08:40:00 hrs',
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
  }
}
