import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';

class KTextField extends StatelessWidget {
  const KTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.color,
    this.padding,
    this.validator,
    this.isPassword = false,
    this.keyboardType,
    this.minLines,
    this.maxLines = 1,
    this.borderVisible = true,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final int? minLines;
  final int? maxLines;
  final Color? color;
  final bool borderVisible;
  final bool isPassword;
  final TextInputType? keyboardType;
  final EdgeInsets? padding;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final border = borderVisible
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(color: color ?? ColorConstants.greyColor),
          )
        : InputBorder.none;
    return TextFormField(
      validator: validator,
      obscureText: isPassword,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        contentPadding: padding ?? EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
        hintText: hintText,
        hintStyle: TextStyle(color: (color ?? ColorConstants.greyColor), fontSize: 12.0),
        prefixIcon: icon == null
            ? null
            : Icon(
                icon,
                color: color ?? ColorConstants.greyColor,
              ),
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }

  static Widget exposed({
    String? hintText,
    bool isPassword = false,
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFFF5F7FD),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        obscureText: isPassword,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
          hintText: hintText,
          hintStyle: Okito.theme.textTheme.bodyText2!.copyWith(
            fontSize: 12.0,
            color: ColorConstants.greyColor,
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }

  static Widget soft({
    required String label,
    TextEditingController? controller,
    String? hintText,
    int minLines = 1,
    int maxLines = 1,
    bool isPassword = false,
    Color? titleTextColor,
    IconData? suffixIcon,
    Widget? prefixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
    bool withShadow = true,
    TextInputType? keybordType,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label",
          style: Okito.theme.textTheme.bodyText2!.copyWith(
            color: titleTextColor ?? ColorConstants.greyColor,
            fontWeight: FontWeight.w500,
            fontSize: 10.0,
          ),
        ),
        SizedBox(height: 5),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: withShadow
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 2.0,
                      offset: Offset(0, 1),
                    ),
                  ]
                : null,
            color: Colors.white,
          ),
          child: TextFormField(
            validator: validator,
            controller: controller,
            inputFormatters: inputFormatters,
            readOnly: readOnly,
            onTap: onTap,
            minLines: minLines,
            maxLines: maxLines,
            obscureText: isPassword,
            keyboardType: keybordType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Okito.theme.textTheme.bodyText2!.copyWith(
                fontSize: 14.0,
                color: ColorConstants.greyColor,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon == null
                  ? null
                  : Icon(
                      suffixIcon,
                      color: Okito.theme.primaryColor,
                    ),
              contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2.0),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }

  static Widget circular({
    IconData? leading,
    required String hintText,
    required TextEditingController controller,
    final FormFieldValidator<String>? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
      ),
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: ColorConstants.greyColor.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Okito.theme.primaryColor,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: ColorConstants.greyColor.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          hintText: hintText,
          hintStyle: Okito.theme.textTheme.bodyText2!.copyWith(
            color: ColorConstants.greyColor,
            fontSize: 14.0,
          ),
          prefixIcon: (leading != null) ? Icon(leading) : null,
        ),
      ),
    );
  }
}
