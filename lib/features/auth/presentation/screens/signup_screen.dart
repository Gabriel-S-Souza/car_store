import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../setups/app_routes/app_routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Toast.show(
  //       'A senha deve conter pelo menos 8 carácteres e conter pelo menos uma letra maiúscula, uma letra minúscula, um número e um caractere especial',
  //       duration: const Duration(seconds: 5),
  //     );

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
                  context.go(RouteName.login.name);
                },
                child: const Text('SignUp'),
              ),
            ],
          ),
        ),
      );
}
