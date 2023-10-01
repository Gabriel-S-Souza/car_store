import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final bool readOnly;
  final TextInputAction textInputAction;
  final Widget? suffix;

  const TextFieldWidget({
    super.key,
    this.label,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType,
    this.prefixIcon,
    this.textInputAction = TextInputAction.next,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) => TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        readOnly: readOnly,
        textInputAction: textInputAction,
        style: const TextStyle(fontSize: 16),
        textAlignVertical: const TextAlignVertical(y: 0.05),
        decoration: InputDecoration(
          labelText: label,
          contentPadding: const EdgeInsets.only(left: 10),
          labelStyle: const TextStyle(fontSize: 16),
          border: const OutlineInputBorder(),
          prefixIcon: prefixIcon,
          suffixIcon: suffix,
        ),
        validator: validator,
      );
}
