import 'package:flutter/material.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';

class PackItem extends StatelessWidget {
  const PackItem({
    Key? key,
    required this.label,
    required this.discount,
    required this.type,
    required this.frequency,
    required this.price,
    this.onTap,
    this.highlightTitle = false,
    this.isActive = false,
  }) : super(key: key);

  final String label;
  final String discount;
  final String type;
  final String frequency;
  final VoidCallback? onTap;
  final String price;
  final bool isActive;
  final bool highlightTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (!highlightTitle) ...[
                Text(
                  "$label",
                  style: Okito.theme.textTheme.bodyText1!.copyWith(fontSize: 12.0),
                ),
                SizedBox(height: 5),
              ] else
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Okito.theme.primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "$label",
                    textAlign: TextAlign.center,
                    style: Okito.theme.textTheme.bodyText1!.copyWith(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: isActive ? Radius.circular(0.0) : Radius.circular(10.0),
                    bottomRight: isActive ? Radius.circular(0.0) : Radius.circular(10.0),
                    topLeft: highlightTitle ? Radius.circular(0.0) : Radius.circular(10.0),
                    topRight: highlightTitle ? Radius.circular(0.0) : Radius.circular(10.0),
                  ),
                  border: Border.all(
                    color: ColorConstants.greyColor.withOpacity(0.5),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    SizedBox(height: 5),
                    Text("$type", style: Okito.theme.textTheme.bodyText2),
                    SizedBox(height: 5),
                    Text("$price", style: Okito.theme.textTheme.bodyText2),
                    Spacer(),
                    Text(
                      "$discount",
                      style: Okito.theme.textTheme.bodyText1!.copyWith(
                        fontSize: 12.0,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        color: Okito.theme.primaryColor,
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "$frequency",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.0),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              if (isActive)
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Okito.theme.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "Active",
                    textAlign: TextAlign.center,
                    style: Okito.theme.textTheme.bodyText1!.copyWith(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
