import 'package:flutter/material.dart';

import 'setups/app_routes/app_routes.dart';
import 'shared/presentation/toast/toast_area.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) => ToastArea(
        child: MaterialApp.router(
          title: 'Car Store',
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
          ),
        ),
      );
}
