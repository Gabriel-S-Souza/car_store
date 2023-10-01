import 'package:flutter/material.dart';

import 'shared/domain/entities/roles.dart';

class AppController extends ChangeNotifier {
  static final AppController I = AppController._internal();
  AppController._internal();

  Roles role = Roles.visitor;
  int navBarCurrentIndex = 0;

  void setRole(Roles newRole) {
    role = newRole;
    notifyListeners();
  }

  void setNavBarIndex(int index) async {
    if (index == navBarCurrentIndex) return;
    navBarCurrentIndex = index;
    notifyListeners();
  }
}
