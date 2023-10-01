import 'package:flutter/material.dart';

import 'shared/domain/entities/roles.dart';

class AppController extends ChangeNotifier {
  static final AppController I = AppController._internal();
  AppController._internal();

  Roles _role = Roles.user;
  Roles get role => _role;

  void setRole(Roles newRole) {
    _role = newRole;
    notifyListeners();
  }
}
