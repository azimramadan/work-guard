import 'package:flutter/material.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/apply_leave_app_bar.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/apply_leave_view_body.dart';

class ApplyLeaveView extends StatelessWidget {
  const ApplyLeaveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ApplyLeaveAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: ApplyLeaveViewBody(),
        ),
      ),
    );
  }
}
