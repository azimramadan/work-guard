// YearCalendar.dart - Main class for displaying months
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class YearCalendar extends StatelessWidget {
  final List<Map<String, dynamic>> yearMonths;
  final int selectedMonthIndex;
  final ScrollController scrollController;
  final Function(int, bool, bool, String) onMonthTap;

  const YearCalendar({
    super.key,
    required this.yearMonths,
    required this.selectedMonthIndex,
    required this.scrollController,
    required this.onMonthTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.builder(
        controller: scrollController,
        itemCount: yearMonths.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          final monthData = yearMonths[index];
          final bool isCurrent = monthData['isCurrent'];
          final bool isFuture = monthData['isFuture'];
          final String monthName = monthData['month'];

          return Padding(
            padding:
                index == 0
                    ? const EdgeInsets.only(left: 20.0)
                    : index == yearMonths.length - 1
                    ? const EdgeInsets.only(right: 12.0)
                    : EdgeInsets.zero,
            child: MonthItem(
              month: monthName,
              isSelected: index == selectedMonthIndex,
              isCurrent: isCurrent,
              isFuture: isFuture,
              onTap: () => onMonthTap(index, isCurrent, isFuture, monthName),
            ),
          );
        },
      ),
    );
  }
}

class YearCalendarController extends StatefulWidget {
  final Widget Function(
    List<Map<String, dynamic>>,
    int,
    ScrollController,
    Function(int, bool, bool, String),
  )
  builder;

  const YearCalendarController({super.key, required this.builder});

  @override
  State<YearCalendarController> createState() => _YearCalendarControllerState();
}

class _YearCalendarControllerState extends State<YearCalendarController> {
  late List<Map<String, dynamic>> yearMonths;
  late DateTime currentDate;
  late int selectedMonthIndex;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    yearMonths = _getYearMonths();

    // Automatically select the previous month
    DateTime previousMonth = DateTime(
      currentDate.year,
      currentDate.month - 1,
      1,
    );
    selectedMonthIndex = _findMonthIndex(previousMonth);

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedMonth();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Find the month index in the list
  int _findMonthIndex(DateTime date) {
    for (int i = 0; i < yearMonths.length; i++) {
      DateTime monthDate = yearMonths[i]['fullDate'];
      if (monthDate.year == date.year && monthDate.month == date.month) {
        return i;
      }
    }
    // If month not found, return to the first month
    return 0;
  }

  // Helper function to check if the month is the current month
  bool _isCurrentMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  // Helper function to check if the month is in the future
  bool _isFutureMonth(DateTime date) {
    final now = DateTime.now();
    return date.isAfter(DateTime(now.year, now.month, 1));
  }

  void _scrollToSelectedMonth() {
    if (!mounted) return;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = 78; // Width of a single month item

    // Calculate offset to center the selected month
    double offset =
        (itemWidth * selectedMonthIndex) - (screenWidth / 3) + (itemWidth / 2);

    // Make sure offset is not negative
    offset = offset < 0 ? 0 : offset;

    // Make sure scrolling doesn't exceed the end of the list
    final double maxOffset = (itemWidth * yearMonths.length) - screenWidth;
    offset = offset > maxOffset ? maxOffset : offset;

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showCurrentMonthMessage(String monthName) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorry, $monthName has not ended yet'),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showFutureMonthMessage(String monthName) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorry, $monthName has not arrived yet'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  List<Map<String, dynamic>> _getYearMonths() {
    List<Map<String, dynamic>> months = [];

    // Create a list of months for the current and previous year
    final DateTime now = DateTime.now();
    final int currentYear = now.year;
    final int previousYear = currentYear - 1;

    // Add months from the previous year
    for (int month = 1; month <= 12; month++) {
      final date = DateTime(previousYear, month, 1);
      final isCurrent = _isCurrentMonth(date);
      final isFuture = _isFutureMonth(date);

      // Use English month names with DateFormat
      final String monthName = DateFormat('MMM').format(date);

      months.add({
        'month': monthName,
        'year': previousYear.toString(),
        'fullDate': date,
        'isCurrent': isCurrent,
        'isFuture': isFuture,
      });
    }

    // Add months from the current year
    for (int month = 1; month <= 12; month++) {
      final date = DateTime(currentYear, month, 1);
      final isCurrent = _isCurrentMonth(date);
      final isFuture = _isFutureMonth(date);

      // Use English month names with DateFormat
      final String monthName = DateFormat('MMM').format(date);

      months.add({
        'month': monthName,
        'year': currentYear.toString(),
        'fullDate': date,
        'isCurrent': isCurrent,
        'isFuture': isFuture,
      });
    }

    return months;
  }

  void _onMonthTap(int index, bool isCurrent, bool isFuture, String monthName) {
    if (isFuture) {
      _showFutureMonthMessage(monthName);
    } else if (isCurrent) {
      _showCurrentMonthMessage(monthName);
    } else {
      // Only if it's a past month, it can be selected
      setState(() {
        selectedMonthIndex = index;
        _scrollToSelectedMonth();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      yearMonths,
      selectedMonthIndex,
      _scrollController,
      _onMonthTap,
    );
  }
}

class MonthItem extends StatelessWidget {
  final String month;
  final bool isSelected;
  final bool isCurrent;
  final bool isFuture;
  final VoidCallback onTap;

  const MonthItem({
    super.key,
    required this.month,
    required this.isSelected,
    required this.isCurrent,
    required this.isFuture,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine background color
    Color bgColor;
    if (isSelected) {
      bgColor = Colors.blue;
    } else if (isCurrent || isFuture) {
      bgColor = Colors.grey.shade200;
    } else {
      bgColor = Colors.white;
    }

    // Determine main text color (month name)
    Color textColor;
    if (isSelected) {
      textColor = Colors.white;
    } else if (isCurrent || isFuture) {
      textColor = Colors.grey.shade400;
    } else {
      textColor = Colors.black;
    }

    // Determine year text color

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                month,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

class MonthCalendarExample extends StatelessWidget {
  const MonthCalendarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return YearCalendarController(
      builder: (yearMonths, selectedMonthIndex, scrollController, onMonthTap) {
        return YearCalendar(
          yearMonths: yearMonths,
          selectedMonthIndex: selectedMonthIndex,
          scrollController: scrollController,
          onMonthTap: onMonthTap,
        );
      },
    );
  }
}
