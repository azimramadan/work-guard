import 'package:flutter/material.dart';
import 'package:work_guard/features/home/presentation/view/widgets/day_item.dart';

class MonthCalendar extends StatelessWidget {
  final List<Map<String, dynamic>> monthDays;
  final int selectedDayIndex;
  final ScrollController scrollController;
  final Function(int, bool, bool, String) onDayTap;

  const MonthCalendar({
    super.key,
    required this.monthDays,
    required this.selectedDayIndex,
    required this.scrollController,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.builder(
        controller: scrollController,
        itemCount: monthDays.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final dayData = monthDays[index];
          final bool isHoliday = dayData['isHoliday'];
          final bool isFuture = dayData['isFuture'];
          final String dayName = dayData['day'];
          final String date = dayData['date'];

          return Padding(
            padding:
                index == 0
                    ? const EdgeInsets.only(left: 20.0)
                    : index == monthDays.length - 1
                    ? const EdgeInsets.only(right: 12.0)
                    : EdgeInsets.zero,
            child: DayItem(
              day: dayName,
              date: date,
              isSelected: index == selectedDayIndex,
              isHoliday: isHoliday,
              isFuture: isFuture,
              onTap: () => onDayTap(index, isHoliday, isFuture, dayName),
            ),
          );
        },
      ),
    );
  }
}
