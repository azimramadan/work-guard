import 'package:hive/hive.dart';
import 'package:work_guard/core/data/models/user_local_model.dart';

class HiveHelper {
  static const String userBoxName = 'userBox';

  static Future<void> saveUser(UserLocalModel user) async {
    final box = await Hive.openBox<UserLocalModel>(userBoxName);
    await box.put('user', user);
  }

  static Future<UserLocalModel?> getUser() async {
    final box = await Hive.openBox<UserLocalModel>(userBoxName);
    return box.get('user');
  }

  static Future<void> clearUser() async {
    final box = await Hive.openBox<UserLocalModel>(userBoxName);
    await box.clear();
  }
}
