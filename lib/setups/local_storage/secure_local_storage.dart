import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureLocalStorage {
  final FlutterSecureStorage _storage;
  final options = const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  SecureLocalStorage(this._storage);

  Future<String?> get(String key) async {
    try {
      return _storage.read(key: key);
    } catch (e) {
      return null;
    }
  }

  Future<void> set({required String key, required String value}) =>
      _storage.write(key: key, value: value, iOptions: options);

  Future<void> delete(String key) => _storage.delete(key: key);
}
