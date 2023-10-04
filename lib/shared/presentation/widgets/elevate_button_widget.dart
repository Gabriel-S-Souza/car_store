import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool enabled;

  const ElevatedButtonWidget({
    super.key,
    this.text = '',
    this.onPressed,
    this.child,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: enabled ? onPressed : null,
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
