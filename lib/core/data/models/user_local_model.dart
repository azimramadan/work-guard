import 'package:hive/hive.dart';

part 'user_local_model.g.dart';

@HiveType(typeId: 0)
class UserLocalModel extends HiveObject {
  @HiveField(0)
  final String uid;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String address;

  @HiveField(5)
  final String position;

  @HiveField(6)
  final String token;

  @HiveField(7)
  final double basicSalary;

  @HiveField(8)
  final double bonus;

  @HiveField(9)
  final double deductions;

  UserLocalModel({
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
  });
}
