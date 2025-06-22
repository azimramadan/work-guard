// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserLocalModelAdapter extends TypeAdapter<UserLocalModel> {
  @override
  final int typeId = 0;

  @override
  UserLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserLocalModel(
      uid: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      phone: fields[3] as String,
      address: fields[4] as String,
      position: fields[5] as String,
      token: fields[6] as String,
      basicSalary: fields[7] as double,
      bonus: fields[8] as double,
      deductions: fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserLocalModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.position)
      ..writeByte(6)
      ..write(obj.token)
      ..writeByte(7)
      ..write(obj.basicSalary)
      ..writeByte(8)
      ..write(obj.bonus)
      ..writeByte(9)
      ..write(obj.deductions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
