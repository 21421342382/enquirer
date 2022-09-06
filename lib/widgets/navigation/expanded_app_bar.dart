import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/config/routes/k_router.dart';

class ExpandedAppBar extends StatelessWidget {
  final String jobTitle;
  final String company;
  final String duration;
  final String type;
  final String? location;

  const ExpandedAppBar({
    Key? key,
    required this.company,
    required this.jobTitle,
    required this.duration,
    required this.type,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: Okito.theme.primaryColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  KRouter().pop();
                },
                icon: Icon(
                  PhosphorIcons.caret_left_bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            "$jobTitle",
            style: Okito.theme.textTheme.headline2!.copyWith(
              fontSize: 16.0,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Job posted by $company",
            style: Okito.theme.textTheme.bodyText2!.copyWith(
              fontSize: 12.0,
              color: Colors.white54,
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TYPE",
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        fontSize: 10.0,
                        color: Colors.white54,
                      ),
                    ),
                    Text(
                      "$type",
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                if (location != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "LOCATION",
                        style: Okito.theme.textTheme.bodyText2!.copyWith(
                          fontSize: 10.0,
                          color: Colors.white54,
                        ),
                      ),
                      Text(
                        "$location",
                        style: Okito.theme.textTheme.bodyText2!.copyWith(
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DURATION",
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        fontSize: 10.0,
                        color: Colors.white54,
                      ),
                    ),
                    Text(
                      "$duration",
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
