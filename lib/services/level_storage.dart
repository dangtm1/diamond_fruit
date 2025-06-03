import 'package:shared_preferences/shared_preferences.dart';

class LevelStorage {
  static const _key = 'unlockedLevel';

  static Future<int> getUnlockedLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key) ?? 1; // mặc định mở màn 1
  }

  static Future<void> setUnlockedLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, level);
  }
}
