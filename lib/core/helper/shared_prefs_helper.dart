import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _firstTimeKey = 'first_time';

  static Future<bool> isFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool(_firstTimeKey) ?? true;

    if (isFirstTime) {
      await prefs.setBool(_firstTimeKey, false);
    }

    return isFirstTime;
  }
}
