import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropSelectorWidget<T> extends StatelessWidget {
  final List<T> items;
  final String? hint;
  final List<String>? textItems;
  final T? selectedValue;
  final void Function(T?)? onChanged;

  const DropSelectorWidget({
    super.key,
    this.hint,
    required this.items,
    this.textItems,
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          isExpanded: true,
          hint: selectedValue == null
              ? hint != null
                  ? AutoSizeText(
                      hint!,
                      style: const TextStyle(fontSize: 16),
                    )
                  : null
              : null,
          items: items
              .map((T item) => DropdownMenuItem<T>(
                    value: item,
                    child: AutoSizeText(
                      textItems?[items.indexOf(item)] ?? item.toString(),
                      maxFontSize: 16,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 16,
              ),
          buttonStyleData: ButtonStyleData(
            height: 46,
            padding: const EdgeInsets.only(left: 4, right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                width: 0.9,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
            elevation: 0,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 16,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(4),
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 50,
            padding: EdgeInsets.only(left: 8, right: 8),
          ),
        ),
      );
}
