import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsivePadding extends StatelessWidget {
  final Widget child;
  final bool isScreenWrapper;

  const ResponsivePadding({
    super.key,
    required this.child,
    this.isScreenWrapper = false,
  });

  @override
  Widget build(BuildContext context) {
    BoxDecoration? backgroundDecoration;

    final (otherPadding, platform) = ResponsiveValue<(EdgeInsets, String)>(
      context,
      conditionalValues: [
        Condition.equals(
          name: '4K',
          value: (EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.3), '4K'),
        ),
        Condition.equals(
          name: DESKTOP,
          value: (
            EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),
            DESKTOP
          ),
        ),
        Condition.equals(
          name: TABLET,
          value: (
            EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
            TABLET
          ),
        ),
      ],
      defaultValue: (const EdgeInsets.symmetric(horizontal: 16), MOBILE),
    ).value!;
    final EdgeInsets padding = ResponsiveValue<EdgeInsets>(context,
            conditionalValues: [
              Condition.largerThan(
                name: TABLET,
                value: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
              ),
              Condition.largerThan(
                name: MOBILE,
                value: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
              ),
            ],
            defaultValue: const EdgeInsets.symmetric(horizontal: 16))
        .value!;

    final isMobile = platform == MOBILE;

    return Container(
      decoration: backgroundDecoration ?? const BoxDecoration(color: Colors.transparent),
      padding: otherPadding,
      child: Container(
        padding: isScreenWrapper
            ? !isMobile
                ? padding
                : null
            : null,
        child: child,
      ),
    );
  }
}
