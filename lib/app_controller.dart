import 'package:flutter/material.dart';

import 'features/auth/domain/entities/user_entity.dart';

class AppController extends ChangeNotifier {
  static final AppController I = AppController._internal();
  AppController._internal();

  UserEntity user = UserEntity.visitor();
  int navBarCurrentIndex = 0;

  void setUser(UserEntity newUser) {
    user = newUser;
    notifyListeners();
  }

  void setNavBarIndex(int index) async {
    if (index == navBarCurrentIndex) return;
    navBarCurrentIndex = index;
    notifyListeners();
  }

  void logout() {
    user = UserEntity.visitor();
    notifyListeners();
  }
}
