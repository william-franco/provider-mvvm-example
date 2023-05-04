// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future<SharedPreferences> _loadStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<bool> getBoolValue({required String key}) async {
    try {
      final storage = await _loadStorage();
      bool value = storage.getBool(key) ?? false;
      return value;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> setBoolValue({required String key, required bool value}) async {
    try {
      final storage = await _loadStorage();
      await storage.setBool(key, value);
    } catch (error) {
      throw Exception(error);
    }
  }
}
