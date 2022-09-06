import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/core/models/applicant.dart';
import 'package:arcopen_enquirer/utils/helpers/asset_helper.dart';
import 'package:arcopen_enquirer/widgets/misc/k_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class JobCard extends StatelessWidget {
  const JobCard({
    Key? key,
    required this.jobTitle,
    required this.jobType,
    required this.location,
    required this.applicants,
    required this.budget,
    this.daysLeftCount,
    this.isCompleted = false,
    this.onTap,
  }) : super(key: key);

  final List<Applicant> applicants;
  final String jobTitle;
  final String jobType;
  final String location;
  final String budget;
  final int? daysLeftCount;
  final bool isCompleted;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 4.0,
            offset: Offset(0, 1),
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isCompleted)
                  Text(
                    "COMPLETED",
                    style: Okito.theme.textTheme.bodyText2!.copyWith(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      color: ColorConstants.greenColor,
                    ),
                  ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "$jobTitle",
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "$budget",
                            style: Okito.theme.textTheme.bodyText2!.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              color: Okito.theme.primaryColor,
                            ),
                            children: [
                              TextSpan(
                                text: "/hr",
                                style:
                                    Okito.theme.textTheme.bodyText2!.copyWith(
                                  color: ColorConstants.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$jobType",
                      style: Okito.theme.textTheme.bodyText2!.copyWith(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.greyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    KChip(
                      title: "$location",
                      boldText: true,
                      icon: PhosphorIcons.map_pin,
                      circularCorners: true,
                      hasShadow: false,
                      color: Okito.theme.primaryColor.withOpacity(0.2),
                      textColor: Okito.theme.primaryColor,
                      onTap: () {},
                    ),
                    if (daysLeftCount != null) ...[
                      SizedBox(width: 10),
                      KChip(
                        title: "$daysLeftCount DAYS LEFT",
                        boldText: true,
                        icon: PhosphorIcons.clock_fill,
                        circularCorners: true,
                        hasShadow: false,
                        color: ColorConstants.orangeColor.withOpacity(0.2),
                        textColor: ColorConstants.orangeColor,
                        onTap: () {},
                      ),
                    ]
                  ],
                ),
                if (applicants.isNotEmpty) ...[
                  SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: _ApplicantsUserProfile(applicants: applicants)),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          _computeMembersTitle(),
                          style: Okito.theme.textTheme.bodyText2!.copyWith(
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ]),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _computeMembersTitle() {
    if (applicants.isNotEmpty) {
      if (applicants.length == 1)
        return "${applicants.first.applicantName} is working";
      else
        return "${applicants.first.applicantName} and ${applicants.length - 1} are working";
    }
    return "";
  }
}

class _ApplicantsUserProfile extends StatelessWidget {
  const _ApplicantsUserProfile({
    Key? key,
    required this.applicants,
  }) : super(key: key);

  final List<Applicant> applicants;

  ImageProvider _getMemberPicture(String profilePicture) {
    ImageProvider pp = AssetImage(
        AssetHelper.getAsset(name: "avatar.png", assetType: AssetType.image));
    if (profilePicture.isNotEmpty) {
      pp = NetworkImage(AssetHelper.getMemberProfilePic(name: profilePicture));
    }
    return pp;
  }

  @override
  Widget build(BuildContext context) {
    if (applicants.isEmpty) return SizedBox();
    double leftPadding = 0.0;
    return Container(
      height: 50,
      child: Stack(
        children: [
          ...applicants.take(3).map<Widget>(
            (member) {
              Widget child = Positioned(
                left: leftPadding,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: CircleAvatar(
                    maxRadius: 15,
                    backgroundImage: _getMemberPicture(member.profilePic ?? ""),
                  ),
                ),
              );
              leftPadding += 10;
              return child;
            },
          )
        ],
      ),
    );
  }
}
