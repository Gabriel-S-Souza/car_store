import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../setups/app_routes/app_routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('SignUp'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'SignUp',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.go(RouteNames.login);
                },
                child: const Text('SignUp'),
              ),
            ],
          ),
        ),
      );
}
