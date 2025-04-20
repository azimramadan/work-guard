// كلاس جديد لإدارة حالة التقويم
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthCalendarController extends StatefulWidget {
  final Widget Function(
    List<Map<String, dynamic>>,
    int,
    ScrollController,
    Function(int, bool, bool, String),
  )
  builder;

  const MonthCalendarController({super.key, required this.builder});

  @override
  State<MonthCalendarController> createState() =>
      _MonthCalendarControllerState();
}

class _MonthCalendarControllerState extends State<MonthCalendarController> {
  late List<Map<String, dynamic>> monthDays;
  late DateTime currentDate;
  late int selectedDayIndex;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    monthDays = _getCurrentMonthDays();

    // تعديل التحديد التلقائي ليكون على يوم الخميس إذا كان اليوم الحالي إجازة
    if (_isWeekend(currentDate)) {
      // البحث عن آخر يوم خميس
      DateTime lastThursday = currentDate;
      while (lastThursday.weekday != DateTime.thursday) {
        lastThursday = lastThursday.subtract(const Duration(days: 1));
      }

      // تحديد مؤشر يوم الخميس في القائمة
      selectedDayIndex = lastThursday.day - 1;
    } else {
      // إذا لم يكن إجازة، حدد اليوم الحالي كالمعتاد
      selectedDayIndex = currentDate.day - 1;
    }

    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDay();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // دالة مساعدة للتحقق ما إذا كان اليوم هو يوم إجازة (الجمعة أو السبت)
  bool _isWeekend(DateTime date) {
    return date.weekday == DateTime.friday || date.weekday == DateTime.saturday;
  }

  // دالة مساعدة للتحقق ما إذا كان التاريخ في المستقبل
  bool _isFutureDate(DateTime date) {
    final now = DateTime.now();
    return date.isAfter(DateTime(now.year, now.month, now.day));
  }

  void _scrollToSelectedDay() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = 78; // عرض العنصر الواحد

    // حساب الإزاحة لوضع اليوم المحدد في المنتصف
    double offset =
        (itemWidth * selectedDayIndex) - (screenWidth / 3) + (itemWidth / 2);

    // التأكد من أن الإزاحة لا تكون سالبة
    offset = offset < 0 ? 0 : offset;

    // التأكد من أن التمرير لا يتجاوز نهاية القائمة
    final double maxOffset = (itemWidth * monthDays.length) - screenWidth;
    offset = offset > maxOffset ? maxOffset : offset;

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showHolidayMessage(String dayName) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('عذراً، يوم $dayName هو يوم إجازة'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showFutureDateMessage() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('عذراً، هذا اليوم لم يأتِ بعد'),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  List<Map<String, dynamic>> _getCurrentMonthDays() {
    final int year = currentDate.year;
    final int month = currentDate.month;

    List<Map<String, dynamic>> days = [];
    final daysInMonth = DateTime(year, month + 1, 0).day;

    for (int i = 1; i <= daysInMonth; i++) {
      final date = DateTime(year, month, i);
      final isHoliday = _isWeekend(date);
      final isFuture = _isFutureDate(date);

      days.add({
        'day': DateFormat('E').format(date).substring(0, 3),
        'date': i.toString().padLeft(2, '0'),
        'fullDate': date,
        'isHoliday': isHoliday,
        'isFuture': isFuture,
      });
    }

    return days;
  }

  void _onDayTap(int index, bool isHoliday, bool isFuture, String dayName) {
    // تغيير ترتيب الأولوية: أولاً نتحقق إذا كان يوم إجازة
    if (isHoliday) {
      // إظهار رسالة أنه يوم إجازة، حتى لو كان مستقبليًا
      _showHolidayMessage(dayName);
    } else if (isFuture) {
      // إذا لم يكن إجازة ولكنه في المستقبل
      _showFutureDateMessage();
    } else {
      // فقط إذا لم يكن يوم إجازة ولم يكن في المستقبل يمكن تحديده
      setState(() {
        selectedDayIndex = index;
        _scrollToSelectedDay();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      monthDays,
      selectedDayIndex,
      _scrollController,
      _onDayTap,
    );
  }
}
