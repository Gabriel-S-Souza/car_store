import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? child;
  final Color? borderColor;

  const OutlinedButtonWidget({
    super.key,
    this.text = '',
    this.child,
    required this.onPressed,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: borderColor != null ? BorderSide(color: borderColor!) : null,
          ),
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
