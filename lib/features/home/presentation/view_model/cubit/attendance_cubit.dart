import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:work_guard/core/data/models/user_model.dart';

part 'attendance_state.dart';

class AttendanceCubit extends Cubit<AttendanceState> {
  AttendanceCubit() : super(AttendanceInitial());
  List<AttendanceDay> attendanceList = [];

  // Get attendance by specific date (yyyy-MM-dd format)
  Future<void> getAttendanceByDate(String date) async {
    try {
      // First check if we have the data in memory
      final existingRecord = attendanceList.firstWhere(
        (attendance) => attendance.date == date,
        orElse:
            () => AttendanceDay(
              date: '',
              arrivalTime: '',
              departureTime: '',
              workedHours: 0.0,
              violations: [],
            ),
      );

      if (existingRecord.date.isNotEmpty) {
        emit(AttendanceDayFound(existingRecord));
        return;
      }

      // If not in memory, fetch from Firebase
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(AttendanceError('No user is logged in.'));
        return;
      }

      emit(AttendanceLoading());

      final docSnapshot =
          await FirebaseFirestore.instance
              .collection('employees')
              .doc(user.uid)
              .collection('attendance')
              .doc('2025-06-18')
              .get();
      log(docSnapshot.data().toString());
      if (docSnapshot.exists) {
        final attendanceDay = AttendanceDay.fromJson(date, docSnapshot.data()!);

        // Add to memory list if not exists
        final index = attendanceList.indexWhere((a) => a.date == date);
        if (index == -1) {
          attendanceList.add(attendanceDay);
          attendanceList.sort((a, b) => b.date.compareTo(a.date));
        }

        emit(AttendanceDayFound(attendanceDay));
      } else {
        emit(
          AttendanceDayNotFound(
            date,
            'No attendance record for this date $date',
          ),
        );
      }
    } catch (e) {
      emit(
        AttendanceError(
          'Failed to search for attendance record: ${e.toString()}',
        ),
      );
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////


// class AttendanceCubit extends Cubit<AttendanceState> {
//   AttendanceCubit() : super(AttendanceInitial());
  
//   List<AttendanceDay> _attendanceList = [];
  
//   // Get current attendance list
//   List<AttendanceDay> get attendanceList => _attendanceList;

//   // Fetch all attendance for current user
//   Future<void> fetchAttendanceForCurrentUser() async {
//     emit(AttendanceLoading());
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       emit(const AttendanceError('No user is logged in.'));
//       return;
//     }
//     final uid = user.uid;
//     try {
//       final attendanceSnapshot = await FirebaseFirestore.instance
//           .collection('employees')
//           .doc(uid)
//           .collection('attendance')
//           .get();
//       _attendanceList = attendanceSnapshot.docs.map((doc) {
//         return AttendanceDay.fromJson(doc.id, doc.data());
//       }).toList();
      
//       // Sort by date (newest first)
//       _attendanceList.sort((a, b) => b.date.compareTo(a.date));
      
//       emit(AttendanceLoaded(_attendanceList));
//     } catch (e) {
//       emit(AttendanceError('Failed to load attendance: ${e.toString()}'));
//     }
//   }

//   // Record arrival time
//   Future<void> recordArrival() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       emit(const AttendanceError('No user is logged in.'));
//       return;
//     }

//     try {
//       final now = DateTime.now();
//       final dateStr = DateFormat('yyyy-MM-dd').format(now);
//       final timeStr = DateFormat('HH:mm:ss').format(now);

//       final docRef = FirebaseFirestore.instance
//           .collection('employees')
//           .doc(user.uid)
//           .collection('attendance')
//           .doc(dateStr);

//       final docSnapshot = await docRef.get();
      
//       if (docSnapshot.exists) {
//         // Update existing record
//         await docRef.update({
//           'arrivalTime': timeStr,
//         });
//       } else {
//         // Create new record
//         await docRef.set({
//           'arrivalTime': timeStr,
//           'departureTime': '',
//           'workedHours': 0.0,
//           'violations': [],
//         });
//       }

//       emit(AttendanceRecordingSuccess('تم تسجيل وقت الحضور بنجاح'));
//       // Refresh attendance list
//       await fetchAttendanceForCurrentUser();
//     } catch (e) {
//       emit(AttendanceError('فشل في تسجيل وقت الحضور: ${e.toString()}'));
//     }
//   }

//   // Record departure time
//   Future<void> recordDeparture() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       emit(const AttendanceError('No user is logged in.'));
//       return;
//     }

//     try {
//       final now = DateTime.now();
//       final dateStr = DateFormat('yyyy-MM-dd').format(now);
//       final timeStr = DateFormat('HH:mm:ss').format(now);

//       final docRef = FirebaseFirestore.instance
//           .collection('employees')
//           .doc(user.uid)
//           .collection('attendance')
//           .doc(dateStr);

//       final docSnapshot = await docRef.get();
      
//       if (docSnapshot.exists) {
//         final data = docSnapshot.data()!;
//         final arrivalTime = data['arrivalTime'] ?? '';
        
//         double workedHours = 0.0;
//         if (arrivalTime.isNotEmpty) {
//           final arrival = DateFormat('HH:mm:ss').parse(arrivalTime);
//           final departure = DateFormat('HH:mm:ss').parse(timeStr);
//           final duration = departure.difference(arrival);
//           workedHours = duration.inMinutes / 60.0;
//         }

//         await docRef.update({
//           'departureTime': timeStr,
//           'workedHours': workedHours,
//         });
//       } else {
//         emit(const AttendanceError('لم يتم تسجيل وقت الحضور اليوم'));
//         return;
//       }

//       emit(AttendanceRecordingSuccess('تم تسجيل وقت الانصراف بنجاح'));
//       // Refresh attendance list
//       await fetchAttendanceForCurrentUser();
//     } catch (e) {
//       emit(AttendanceError('فشل في تسجيل وقت الانصراف: ${e.toString()}'));
//     }
//   }

//   // Get attendance by specific date (yyyy-MM-dd format)
//   Future<void> getAttendanceByDate(String date) async {
//     try {
//       // First check if we have the data in memory
//       final existingRecord = _attendanceList.firstWhere(
//         (attendance) => attendance.date == date,
//         orElse: () => AttendanceDay(
//           date: '',
//           arrivalTime: '',
//           departureTime: '',
//           workedHours: 0.0,
//           violations: [],
//         ),
//       );

//       if (existingRecord.date.isNotEmpty) {
//         emit(AttendanceDayFound(existingRecord));
//         return;
//       }

//       // If not in memory, fetch from Firebase
//       final user = FirebaseAuth.instance.currentUser;
//       if (user == null) {
//         emit(const AttendanceError('No user is logged in.'));
//         return;
//       }

//       emit(AttendanceLoading());

//       final docSnapshot = await FirebaseFirestore.instance
//           .collection('employees')
//           .doc(user.uid)
//           .collection('attendance')
//           .doc(date)
//           .get();

//       if (docSnapshot.exists) {
//         final attendanceDay = AttendanceDay.fromJson(date, docSnapshot.data()!);
        
//         // Add to memory list if not exists
//         final index = _attendanceList.indexWhere((a) => a.date == date);
//         if (index == -1) {
//           _attendanceList.add(attendanceDay);
//           _attendanceList.sort((a, b) => b.date.compareTo(a.date));
//         }
        
//         emit(AttendanceDayFound(attendanceDay));
//       } else {
//         emit(AttendanceDayNotFound(date, 'لا يوجد سجل حضور لتاريخ $date'));
//       }
//     } catch (e) {
//       emit(AttendanceError('فشل في البحث عن سجل الحضور: ${e.toString()}'));
//     }
//   }

//   // Get attendance for today
//   Future<void> getTodayAttendance() async {
//     final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
//     await getAttendanceByDate(today);
//   }

//   // Check if user has arrived today
//   bool hasArrivedToday() {
//     final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
//     final todayRecord = _attendanceList.firstWhere(
//       (attendance) => attendance.date == today,
//       orElse: () => AttendanceDay(
//         date: '',
//         arrivalTime: '',
//         departureTime: '',
//         workedHours: 0.0,
//         violations: [],
//       ),
//     );
//     return todayRecord.arrivalTime.isNotEmpty;
//   }

//   // Check if user has departed today
//   bool hasDepartedToday() {
//     final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
//     final todayRecord = _attendanceList.firstWhere(
//       (attendance) => attendance.date == today,
//       orElse: () => AttendanceDay(
//         date: '',
//         arrivalTime: '',
//         departureTime: '',
//         workedHours: 0.0,
//         violations: [],
//       ),
//     );
//     return todayRecord.departureTime.isNotEmpty;
//   }

//   // Get attendance for date range
//   List<AttendanceDay> getAttendanceByDateRange(DateTime startDate, DateTime endDate) {
//     final startDateStr = DateFormat('yyyy-MM-dd').format(startDate);
//     final endDateStr = DateFormat('yyyy-MM-dd').format(endDate);
    
//     return _attendanceList.where((attendance) {
//       return attendance.date.compareTo(startDateStr) >= 0 &&
//              attendance.date.compareTo(endDateStr) <= 0;
//     }).toList();
//   }

//   // Get total worked hours for a month
//   double getTotalWorkedHoursForMonth(int year, int month) {
//     final monthStr = '${year.toString()}-${month.toString().padLeft(2, '0')}';
    
//     return _attendanceList
//         .where((attendance) => attendance.date.startsWith(monthStr))
//         .fold(0.0, (total, attendance) => total + attendance.workedHours);
//   }

//   // Add violation to a specific date
//   Future<void> addViolation(String date, String violationType) async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) {
//       emit(const AttendanceError('No user is logged in.'));
//       return;
//     }

//     try {
//       final now = DateTime.now();
//       final timeStr = DateFormat('HH:mm:ss').format(now);
      
//       final violation = {
//         'time': timeStr,
//         'type': violationType,
//       };

//       final docRef = FirebaseFirestore.instance
//           .collection('employees')
//           .doc(user.uid)
//           .collection('attendance')
//           .doc(date);

//       await docRef.update({
//         'violations': FieldValue.arrayUnion([violation]),
//       });

//       emit(AttendanceRecordingSuccess('تم إضافة المخالفة بنجاح'));
//       // Refresh attendance list
//       await fetchAttendanceForCurrentUser();
//     } catch (e) {
//       emit(AttendanceError('فشل في إضافة المخالفة: ${e.toString()}'));
//     }
//   }

//   // Calculate present days count for current month up to today
//   int getPresentDaysThisMonth() {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final currentYear = now.year;
//     final currentMonth = now.month;
    
//     // Get work days up to today only
//     final workDaysUpToToday = _getWorkDaysInMonth(currentYear, currentMonth)
//         .where((day) => day.isBefore(today) || day.isAtSameMomentAs(today))
//         .toList();
    
//     // Filter attendance records for current month
//     final monthlyAttendance = attendanceList.where((attendance) {
//       final attendanceDate = DateTime.parse(attendance.date);
//       return attendanceDate.year == currentYear && 
//              attendanceDate.month == currentMonth;
//     }).toList();
    
//     // Count present days (days with attendance records)
//     int presentDays = 0;
    
//     for (final workDay in workDaysUpToToday) {
//       final dateStr = '${workDay.year.toString()}-${workDay.month.toString().padLeft(2, '0')}-${workDay.day.toString().padLeft(2, '0')}';
      
//       // Check if there's an attendance record for this work day
//       final hasRecord = monthlyAttendance.any((attendance) => attendance.date == dateStr);
      
//       if (hasRecord) {
//         presentDays++;
//       }
//     }
    
//     return presentDays;
//   }
  
//   // Calculate absent days count for current month up to today
//   int getAbsentDaysThisMonth() {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final currentYear = now.year;
//     final currentMonth = now.month;
    
//     // Get work days up to today only
//     final workDaysUpToToday = _getWorkDaysInMonth(currentYear, currentMonth)
//         .where((day) => day.isBefore(today) || day.isAtSameMomentAs(today))
//         .toList();
    
//     // Filter attendance records for current month
//     final monthlyAttendance = attendanceList.where((attendance) {
//       final attendanceDate = DateTime.parse(attendance.date);
//       return attendanceDate.year == currentYear && 
//              attendanceDate.month == currentMonth;
//     }).toList();
    
//     // Count absent days
//     int absentDays = 0;
    
//     for (final workDay in workDaysUpToToday) {
//       final dateStr = '${workDay.year.toString()}-${workDay.month.toString().padLeft(2, '0')}-${workDay.day.toString().padLeft(2, '0')}';
      
//       // Check if there's an attendance record for this work day
//       final hasRecord = monthlyAttendance.any((attendance) => attendance.date == dateStr);
      
//       if (!hasRecord) {
//         absentDays++;
//       }
//     }
    
//     return absentDays;
//   }
  
//   // Calculate attendance statistics for current month up to today
//   Map<String, int> getMonthlyAttendanceStats() {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final currentYear = now.year;
//     final currentMonth = now.month;
    
//     // Get all work days for current month
//     final allWorkDays = _getWorkDaysInMonth(currentYear, currentMonth);
    
//     // Get work days up to today only
//     final workDaysUpToToday = allWorkDays
//         .where((day) => day.isBefore(today) || day.isAtSameMomentAs(today))
//         .toList();
    
//     final presentDays = getPresentDaysThisMonth();
//     final absentDays = getAbsentDaysThisMonth();
//     final remainingDays = allWorkDays.length - workDaysUpToToday.length;
    
//     return {
//       'totalWorkDays': allWorkDays.length,
//       'workDaysUpToToday': workDaysUpToToday.length,
//       'presentDays': presentDays,
//       'absentDays': absentDays,
//       'remainingDays': remainingDays,
//     };
//   }
  
//   // Get all work days in a specific month (excluding Friday and Saturday)
//   List<DateTime> _getWorkDaysInMonth(int year, int month) {
//     final workDays = <DateTime>[];
//     final daysInMonth = DateTime(year, month + 1, 0).day;
    
//     for (int day = 1; day <= daysInMonth; day++) {
//       final date = DateTime(year, month, day);
//       final weekday = date.weekday;
      
//       // Skip Friday (5) and Saturday (6)
//       if (weekday != DateTime.friday && weekday != DateTime.saturday) {
//         workDays.add(date);
//       }
//     }
    
//     return workDays;
//   }
  
//   // Get attendance statistics for specific month
//   Map<String, int> getAttendanceStatsForMonth(int year, int month) {
//     // Get all work days (excluding Friday and Saturday) for specified month
//     final workDays = _getWorkDaysInMonth(year, month);
    
//     // Filter attendance records for specified month
//     final monthlyAttendance = attendanceList.where((attendance) {
//       final attendanceDate = DateTime.parse(attendance.date);
//       return attendanceDate.year == year && 
//              attendanceDate.month == month;
//     }).toList();
    
//     // Count present days (days with attendance records)
//     int presentDays = 0;
//     int absentDays = 0;
//     final now = DateTime.now();
    
//     for (final workDay in workDays) {
//       final dateStr = '${workDay.year.toString()}-${workDay.month.toString().padLeft(2, '0')}-${workDay.day.toString().padLeft(2, '0')}';
      
//       // Check if there's an attendance record for this work day
//       final hasRecord = monthlyAttendance.any((attendance) => attendance.date == dateStr);
      
//       if (hasRecord) {
//         presentDays++;
//       } else {
//         // Only count as absent if the day has passed
//         if (workDay.isBefore(now) || workDay.isAtSameMomentAs(DateTime(now.year, now.month, now.day))) {
//           absentDays++;
//         }
//       }
//     }
    
//     return {
//       'totalWorkDays': workDays.length,
//       'presentDays': presentDays,
//       'absentDays': absentDays,
//       'remainingDays': workDays.length - presentDays - absentDays,
//     };
//   }
  
 
//   double getMonthlyAttendancePercentage() {
//     final stats = getMonthlyAttendanceStats();
//     final workDaysUpToToday = stats['workDaysUpToToday']!;
//     final presentDays = stats['presentDays']!;
    
//     if (workDaysUpToToday == 0) return 0.0;
//     return (presentDays / workDaysUpToToday) * 100;
//   }
  
//   int getWorkDaysUpToTodayCount() {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final currentYear = now.year;
//     final currentMonth = now.month;
    
//     return _getWorkDaysInMonth(currentYear, currentMonth)
//         .where((day) => day.isBefore(today) || day.isAtSameMomentAs(today))
//         .length;
//   }
  
  
  
//   List<DateTime> getAbsentDaysListThisMonth() {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final currentYear = now.year;
//     final currentMonth = now.month;
    
//     final workDaysUpToToday = _getWorkDaysInMonth(currentYear, currentMonth)
//         .where((day) => day.isBefore(today) || day.isAtSameMomentAs(today))
//         .toList();
        
//     final monthlyAttendance = attendanceList.where((attendance) {
//       final attendanceDate = DateTime.parse(attendance.date);
//       return attendanceDate.year == currentYear && 
//              attendanceDate.month == currentMonth;
//     }).toList();
    
//     final absentDays = <DateTime>[];
    
//     for (final workDay in workDaysUpToToday) {
//       final dateStr = '${workDay.year.toString()}-${workDay.month.toString().padLeft(2, '0')}-${workDay.day.toString().padLeft(2, '0')}';
      
//       // Check if there's an attendance record for this work day
//       final hasRecord = monthlyAttendance.any((attendance) => attendance.date == dateStr);
      
//       if (!hasRecord) {
//         absentDays.add(workDay);
//       }
//     }
    
//     return absentDays;
//   }

  
// }