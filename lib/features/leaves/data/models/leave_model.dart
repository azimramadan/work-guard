class LeaveModel {
  String title;
  String leaveType;
  String contactNumber;
  DateTime startDate;
  DateTime endDate;
  String reason;
  String email;

  LeaveModel({
    this.title = '',
    this.leaveType = 'Medical Leave',
    this.contactNumber = '',
    required this.startDate,
    required this.endDate,
    this.reason = '',
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'leaveType': leaveType,
      'contactNumber': contactNumber,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'reason': reason,
      'email': email,
      'durationInDays': getDurationInDays(),
    };
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map) {
    return LeaveModel(
      title: map['title'] ?? '',
      leaveType: map['leaveType'] ?? 'Medical Leave',
      contactNumber: map['contactNumber'] ?? '',
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
      reason: map['reason'] ?? '',
      email: map['email'],
    );
  }

  int getDurationInDays() {
    return endDate.difference(startDate).inDays + 1;
  }
}
