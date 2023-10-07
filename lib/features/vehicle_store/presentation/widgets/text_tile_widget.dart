import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextTileWidget extends StatelessWidget {
  final String label;
  final String content;
  final double marginBottom;
  final Color? titleColor;
  final Color? textColor;

  const TextTileWidget({
    super.key,
    required this.label,
    required this.content,
    this.marginBottom = 12,
    this.titleColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: marginBottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              label,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 9),
            AutoSizeText(
              content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
          ],
        ),
      );
}
