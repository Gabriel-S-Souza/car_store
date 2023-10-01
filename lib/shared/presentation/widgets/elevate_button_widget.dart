import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final Widget? child;
  final VoidCallback onPressed;
  const ElevatedButtonWidget({
    super.key,
    this.text = '',
    required this.onPressed,
    this.child,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          child: child ??
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      );
}
