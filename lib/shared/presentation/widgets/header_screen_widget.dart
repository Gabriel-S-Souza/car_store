import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HeaderScreenWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackButtonTap;
  final double fontSize;
  final bool centerTitle;

  const HeaderScreenWidget({
    Key? key,
    required this.title,
    this.onBackButtonTap,
    this.fontSize = 16,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (onBackButtonTap != null)
              Flexible(
                fit: FlexFit.loose,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Visibility(
                    visible: onBackButtonTap != null,
                    child: IconButton(
                      onPressed: onBackButtonTap,
                      visualDensity: VisualDensity.compact,
                      splashRadius: 28,
                      icon: Transform.translate(
                        offset: const Offset(-2, 0),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Expanded(
              child: Align(
                alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
                child: AutoSizeText(
                  title,
                  maxFontSize: fontSize,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (onBackButtonTap != null) const Spacer(),
          ],
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
