import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app_widget.dart';
import 'setups/service_locator/service_locator_imp.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator(GetIt.instance).setup();
  runApp(const AppWidget());
}
