import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app_widget.dart';
import 'setups/service_locator/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator(GetIt.instance).setup();
  runApp(const AppWidget());
}
