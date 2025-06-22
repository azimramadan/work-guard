class Violation {
  final String time;
  final String type;

  Violation({required this.time, required this.type});

  factory Violation.fromJson(Map<String, dynamic> json) {
    return Violation(time: json['time'], type: json['type']);
  }
}

class AttendanceDay {
  final String date;
  final String arrivalTime;
  final String departureTime;
  final num workedHours;
  final List<Violation> violations;

  AttendanceDay({
    required this.date,
    required this.arrivalTime,
    required this.departureTime,
    required this.workedHours,
    required this.violations,
  });

  factory AttendanceDay.fromJson(String date, Map<String, dynamic> json) {
    return AttendanceDay(
      date: date,
      arrivalTime: json['arrivalTime'] ?? '',
      departureTime: json['departureTime'] ?? '',
      workedHours: json['workedHours'] ?? 0,
      violations:
          (json['violations'] as List<dynamic>? ?? [])
              .map((v) => Violation.fromJson(v as Map<String, dynamic>))
              .toList(),
    );
  }
}

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String position;
  final String token;
  final double basicSalary;
  final double bonus;
  final double deductions;
  final List<AttendanceDay> attendance;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.position,
    required this.token,
    required this.basicSalary,
    required this.bonus,
    required this.deductions,
    required this.attendance,
  });

  factory UserModel.fromJson(
    String uid,
    Map<String, dynamic> json,
    List<AttendanceDay> attendance,
  ) {
    return UserModel(
      uid: uid,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      position: json['position'] ?? '',
      token: json['token'] ?? '',
      basicSalary: (json['salary']?['basic'] ?? 0).toDouble(),
      bonus: (json['salary']?['bonus'] ?? 0).toDouble(),
      deductions: (json['salary']?['deductions'] ?? 0).toDouble(),
      attendance: attendance,
    );
  }
}
