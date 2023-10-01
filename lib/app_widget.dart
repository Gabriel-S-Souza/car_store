import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: Stack(
              children: [
                child!,
              ],
            ),
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 450, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: 4000, name: '4K'),
            ],
          ),
        ),
      );
}
