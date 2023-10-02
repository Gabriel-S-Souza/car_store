import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'setups/app_routes/app_routes.dart';
import 'shared/presentation/global_scaffold_widget.dart/global_scaffold_widget.dart';
import 'shared/presentation/toast/toast_area.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) => ToastArea(
        child: MaterialApp.router(
          title: 'Car Store',
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          theme: ThemeData(
            colorScheme: const ColorScheme.dark(),
          ),
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: GlobalScaffoldWidget(child: child!),
            breakpoints: [
              const Breakpoint(start: 0, end: 550, name: MOBILE),
              const Breakpoint(start: 550, end: 4000, name: DESKTOP),
            ],
          ),
        ),
      );
}
