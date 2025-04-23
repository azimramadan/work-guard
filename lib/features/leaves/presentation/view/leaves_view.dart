import 'package:flutter/material.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/leaves_view_body.dart';

class LeavesView extends StatelessWidget {
  const LeavesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: LeavesViewBody()));
  }
}
