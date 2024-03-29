import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HeaderScreenWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;
  final IconData? primaryIcon;
  final IconData? secondaryIcon;
  final double fontSize;
  final bool centerTitle;
  final Widget? leading;

  const HeaderScreenWidget({
    Key? key,
    required this.title,
    this.onPrimaryTap,
    this.onSecondaryTap,
    this.primaryIcon,
    this.secondaryIcon,
    this.fontSize = 20,
    this.centerTitle = true,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (onPrimaryTap == null && onSecondaryTap != null && leading == null) const Spacer(),
            if (onPrimaryTap != null && leading == null)
              Flexible(
                fit: FlexFit.loose,
                child: Align(
                  alignment: const Alignment(-1.2, 0.5),
                  child: Visibility(
                    visible: onPrimaryTap != null,
                    child: IconButton(
                      onPressed: onPrimaryTap,
                      tooltip: 'Voltar',
                      visualDensity: VisualDensity.compact,
                      splashRadius: 28,
                      icon: Transform.translate(
                        offset: const Offset(3, 0),
                        child: Icon(
                          primaryIcon ?? Icons.arrow_back_ios,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (leading != null)
              Flexible(
                fit: FlexFit.loose,
                child: Align(
                  alignment: const Alignment(-1.2, 0.5),
                  child: Visibility(
                    visible: leading != null,
                    child: IconButton(
                      onPressed: onPrimaryTap,
                      tooltip: 'Voltar',
                      visualDensity: VisualDensity.compact,
                      splashRadius: 28,
                      icon: leading!,
                    ),
                  ),
                ),
              ),
            Expanded(
              flex: 3,
              child: Align(
                alignment: centerTitle ? const Alignment(0, 0.35) : const Alignment(-1, 0.22),
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
            if (onSecondaryTap != null)
              Flexible(
                fit: FlexFit.loose,
                child: Align(
                  alignment: const Alignment(1.2, 0.5),
                  child: Visibility(
                    visible: onSecondaryTap != null,
                    child: IconButton(
                      onPressed: onSecondaryTap,
                      tooltip: 'Sair',
                      visualDensity: VisualDensity.compact,
                      splashRadius: 28,
                      icon: Icon(
                        secondaryIcon ?? Icons.logout,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            if (onPrimaryTap != null && onSecondaryTap == null) const Spacer(),
          ],
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
