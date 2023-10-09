import 'package:flutter/material.dart';

import 'features/auth/domain/entities/user_entity.dart';
import 'setups/local_storage/secure_local_storage.dart';
import 'setups/utils/storage_keys.dart';

class AppController extends ChangeNotifier {
  late final SecureLocalStorage _secureLocalStorage;

  static final AppController I = AppController._internal();
  AppController._internal();

  void init(SecureLocalStorage secureLocalStorage) {
    _secureLocalStorage = secureLocalStorage;
  }

  UserEntity user = UserEntity.visitor();
  int navigationBarIndex = 0;

  void setUser(UserEntity newUser) {
    user = newUser;
    notifyListeners();
  }

  void setNavigationBarIndex(int index) async {
    if (index == navigationBarIndex) return;
    navigationBarIndex = index;
    notifyListeners();
  }

  void logout() {
    user = UserEntity.visitor();
    _secureLocalStorage.delete(StorageKeys.accessToken);
    _secureLocalStorage.delete(StorageKeys.refreshToken);
    notifyListeners();
  }
}
