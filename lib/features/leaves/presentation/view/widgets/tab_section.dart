import 'package:flutter/material.dart';
import 'package:work_guard/features/leaves/presentation/view/widgets/tab_button.dart';

class TabSection extends StatefulWidget {
  const TabSection({super.key});

  @override
  State<TabSection> createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection> {
  String selectedTab = "Upcoming";
  double fixedButtonWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        fixedButtonWidth = getMaxButtonWidth(context);
      });
    });
  }

  double getMaxButtonWidth(BuildContext context) {
    final texts = ['Upcoming', 'Past'];
    final screenWidth = MediaQuery.of(context).size.width;
    final textStyle = TextStyle(
      fontSize: (screenWidth * 0.035).clamp(12.0, 18.0),
      fontWeight: FontWeight.w600,
    );

    double maxWidth = 0;

    for (final text in texts) {
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      maxWidth = maxWidth < textPainter.width ? textPainter.width : maxWidth;
    }

    return maxWidth + 32;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          TabButton(
            text: 'Upcoming',
            isSelected: selectedTab == 'Upcoming',
            onTap: () {
              setState(() {
                selectedTab = 'Upcoming';
              });
            },
            width: fixedButtonWidth,
          ),
          const Spacer(flex: 2),
          TabButton(
            text: 'Past',
            isSelected: selectedTab == 'Past',
            onTap: () {
              setState(() {
                selectedTab = 'Past';
              });
            },
            width: fixedButtonWidth,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
