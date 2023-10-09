import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late final SharedPreferences _prefs;
  static final LocalStorage I = LocalStorage._internal();

  LocalStorage._internal();

  factory LocalStorage(SharedPreferences prefs) {
    I._prefs = prefs;
    return I;
  }

  String? get(String key) => _prefs.getString(key);

  Future<bool> set({required String key, required String value}) async =>
      _prefs.setString(key, value);

  List<String>? getList(String key) => _prefs.getStringList(key);

  Future<bool> setList({required String key, required List<String> value}) =>
      _prefs.setStringList(key, value);

  Future<bool> delete(String key) => _prefs.remove(key);

  Future<bool> deleteAll() => _prefs.clear();
}
