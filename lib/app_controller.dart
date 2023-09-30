import 'package:flutter/material.dart';

import 'shared/domain/entities/roles.dart';

class AppController extends ChangeNotifier {
  Roles role = Roles.user;

  void setRole(Roles newRole) {
    role = newRole;
    notifyListeners();
  }
}
