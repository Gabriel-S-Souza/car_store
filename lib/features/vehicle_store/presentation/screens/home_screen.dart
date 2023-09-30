import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../setups/app_routes/app_routes.dart';
import '../../../../shared/presentation/toast/toast_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Toast.show('Bem vindo!');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Car Store'),
          actions: [
            IconButton(
              onPressed: () {
                context.go(RouteNames.login);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Lista de veículos',
              ),
            ],
          ),
        ),
      );
}
