import 'package:arcopen_enquirer/constants/color_constants.dart';
import "package:flutter/material.dart";
import 'package:okito/okito.dart';

class KDropdownButton<T> extends StatelessWidget {
  const KDropdownButton(
      {Key? key,
      required this.title,
      this.onChanged,
      this.value,
      required this.items})
      : super(key: key);

  final String title;
  final T? value;
  final void Function(T?)? onChanged;
  final List<DropdownMenuItem<T>> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: Okito.theme.textTheme.bodyText2!.copyWith(
            color: ColorConstants.greyColor,
            fontWeight: FontWeight.w500,
            fontSize: 10.0,
          ),
        ),
        SizedBox(height: 5),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 2.0,
                offset: Offset(0, 1),
              ),
            ],
            color: Colors.white,
          ),
        ),
        Container(
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 2.0,
                offset: Offset(0, 1),
              ),
            ],
            color: Colors.white,
          ),
          child: DropdownButton<T>(
            value: value,
            icon: Icon(Icons.keyboard_arrow_down_sharp),
            underline: Text(""),
            isExpanded: true,
            onChanged: onChanged,
            items: items,
          ),
        ),
      ],
    );
  }
}
