part of 'attendance_cubit.dart';

@immutable
sealed class AttendanceState {}

final class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final List<AttendanceDay> attendanceList;

  AttendanceLoaded(this.attendanceList);
}

class AttendanceError extends AttendanceState {
  final String message;

  AttendanceError(this.message);
}

class AttendanceDayFound extends AttendanceState {
  final AttendanceDay attendanceDay;

  AttendanceDayFound(this.attendanceDay);
}

class AttendanceDayNotFound extends AttendanceState {
  final String date;
  final String message;

  AttendanceDayNotFound(this.date, this.message);
}
