import 'package:flutter/material.dart';

import '../../../app_controller.dart';
import '../../../setups/app_routes/app_routes.dart';

class GlobalScaffoldWidget extends StatelessWidget {
  final Widget child;

  const GlobalScaffoldWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) => Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) => Scaffold(
              body: child,
              bottomNavigationBar: AnimatedBuilder(
                animation: AppController.I,
                builder: (context, animation) => BottomNavigationBar(
                  currentIndex: AppController.I.navBarCurrentIndex,
                  onTap: (value) {
                    AppController.I.setNavBarIndex(value);
                    AppRouter.router.goNamed(AppRouter.getRouteNameByNavIndex(value).name);
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.admin_panel_settings),
                      label: 'Admin',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
