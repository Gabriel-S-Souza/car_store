import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../setups/app_routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Login'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Login',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.go(RouteNames.vehicles);
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.go(RouteNames.signup);
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      );
}
