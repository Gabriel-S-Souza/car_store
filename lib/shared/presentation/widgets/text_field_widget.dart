import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? initialValue;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final FocusNode? focusNode;
  final bool obscure;
  final TextInputAction textInputAction;
  final TextInputType? textInputType;
  final Function(String?)? onChanged;
  final Function()? onSubmitted;
  final bool? enabled;
  final bool readOnly;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final String? mask;
  final TextInputFormatter? inputFormatter;
  final Map<String, RegExp>? filter;

  const TextFieldWidget({
    Key? key,
    this.onChanged,
    this.hint,
    this.prefix,
    this.suffix,
    this.obscure = false,
    this.textInputType,
    this.enabled,
    this.controller,
    this.onSubmitted,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.readOnly = false,
    this.contentPadding,
    this.style,
    this.label,
    this.initialValue,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.mask,
    this.filter,
    this.inputFormatter,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final MaskTextInputFormatter innerMask;

  @override
  void initState() {
    super.initState();
    innerMask = MaskTextInputFormatter(
      mask: widget.mask,
      filter: widget.filter,
      type: MaskAutoCompletionType.lazy,
    );
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        initialValue: widget.initialValue,
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        readOnly: widget.readOnly,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        style: const TextStyle(fontSize: 16),
        focusNode: widget.focusNode,
        onFieldSubmitted: (value) {
          if (widget.onSubmitted != null) {
            widget.onSubmitted!();
          }
        },
        inputFormatters: [innerMask, if (widget.inputFormatter != null) widget.inputFormatter!],
        enabled: widget.enabled,
        textAlignVertical: const TextAlignVertical(y: 0.05),
        decoration: InputDecoration(
          labelText: widget.label,
          contentPadding: const EdgeInsets.only(left: 10),
          labelStyle: const TextStyle(fontSize: 16),
          border: const OutlineInputBorder(),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffix,
          hintText: widget.hint,
          prefix: widget.prefix,
        ),
        validator: widget.validator,
      );
}
