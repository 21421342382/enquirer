import 'package:flutter/material.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.title,
    this.textColor,
    this.hasBoldTitle = false,
  }) : super(key: key);

  final String title;
  final Color? textColor;
  final bool hasBoldTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$title",
      style: Okito.theme.textTheme.bodyText2!.copyWith(
        fontSize: 10.0,
        letterSpacing: 1.3,
        fontWeight: hasBoldTitle ? FontWeight.bold : FontWeight.w600,
        color: textColor ?? ColorConstants.greyColor,
      ),
    );
  }
}
