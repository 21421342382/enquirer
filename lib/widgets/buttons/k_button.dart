import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class KButton extends StatelessWidget {
  const KButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.color,
    this.expanded = false,
    this.padding,
  }) : super(key: key);

  final bool expanded;
  final String title;
  final Color color;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final Widget buttonComponent = ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: padding == null ? EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0) : padding!,
        child: Text(
          "$title",
          style: Okito.theme.textTheme.bodyText2!.copyWith(
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 1.4,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );

    if (this.expanded) {
      return Row(
        children: [Expanded(child: buttonComponent)],
      );
    }
    return buttonComponent;
  }

  static outlined({
    required VoidCallback onPressed,
    required String title,
    required Color color,
    bool dense = false,
    bool expanded = false,
  }) {
    final Widget buttonComponent = OutlinedButton(
      onPressed: onPressed,
      child: Padding(
        padding: dense ? EdgeInsets.all(4.0) : const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
        child: Text(
          "$title",
          style: Okito.theme.textTheme.bodyText1!.copyWith(
            color: color,
            fontSize: dense ? 9.0 : 12.0,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        side: BorderSide(color: color, width: 1),
      ),
    );
    if (expanded) {
      return Row(
        children: [Expanded(child: buttonComponent)],
      );
    }
    return buttonComponent;
  }

  static Widget regular({
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFF5F7FD),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 2.0,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$title",
              style: Okito.theme.textTheme.bodyText2!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
                color: Okito.theme.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
