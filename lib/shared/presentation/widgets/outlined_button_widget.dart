import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? child;

  const OutlinedButtonWidget({
    super.key,
    this.text = '',
    this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50,
        child: OutlinedButton(
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
