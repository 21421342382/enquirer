import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class DisputeCard extends StatelessWidget {
  const DisputeCard({
    Key? key,
    required this.createdAt,
    required this.description,
    required this.isClosed,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final String description;
  final String createdAt;
  final bool isClosed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isClosed ? Color(0XFF57D095) : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
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
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "$name",
                        style: Okito.theme.textTheme.bodyText2!.copyWith(
                          color: isClosed ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      createdAt,
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                        color: isClosed ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "$description",
                        style: Okito.theme.textTheme.bodyText2!.copyWith(
                          color: isClosed ? Colors.white : ColorConstants.greyColor,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
