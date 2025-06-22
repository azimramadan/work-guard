import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:work_guard/core/utils/styles/app_colors.dart';

class TabSection extends StatefulWidget {
  const TabSection({super.key});

  @override
  State<TabSection> createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection> {
  String selectedTab = "Pending";

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: CupertinoSlidingSegmentedControl<String>(
            groupValue: selectedTab,
            onValueChanged: (String? value) {
              if (value != null) {
                setState(() {
                  selectedTab = value;
                });
              }
            },
            children: {
              "Pending": Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Pending",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color:
                        selectedTab == "Pending" ? Colors.white : Colors.black,
                  ),
                ),
              ),
              "Approved": Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  "Approved",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color:
                        selectedTab == "Approved" ? Colors.white : Colors.black,
                  ),
                ),
              ),
              "Rejected": Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  "Rejected",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                    color:
                        selectedTab == "Rejected" ? Colors.white : Colors.black,
                  ),
                ),
              ),
            },
            backgroundColor: Colors.transparent,
            thumbColor: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
