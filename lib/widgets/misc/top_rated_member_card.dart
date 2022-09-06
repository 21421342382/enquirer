import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/utils/helpers/asset_helper.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:arcopen_enquirer/widgets/misc/circle.dart';
import 'package:arcopen_enquirer/widgets/misc/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class TopRatedMemberCard extends StatelessWidget {
  const TopRatedMemberCard({
    Key? key,
    required this.username,
    required this.score,
    required this.location,
    required this.onTap,
    required this.profilePic,
  }) : super(key: key);

  final String username;
  final double score;
  final String location;
  final VoidCallback onTap;
  final String profilePic;

  @override
  Widget build(BuildContext context) {
    ImageProvider profilePicture = AssetImage(AssetHelper.getAsset(name: "avatar.png", assetType: AssetType.image));
    if (profilePic.isNotEmpty) {
      profilePicture = NetworkImage(AssetHelper.getMemberProfilePic(name: profilePic));
    }
    return Container(
      width: Okito.isLandscape ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width * 0.7,
      height: 150,
      margin: EdgeInsets.only(left: 18.0, right: 9.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: ColorConstants.purple,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: onTap,
          child: Stack(
            children: [
              Circle(color: Colors.white.withOpacity(0.15), diameter: 50),
              Positioned(
                top: -15,
                left: -15,
                child: Circle(color: Colors.white.withOpacity(0.1), diameter: 80),
              ),
              Positioned(
                top: -30,
                left: -30,
                child: Circle(color: Colors.white.withOpacity(0.09), diameter: 120),
              ),
              Positioned(
                top: -50,
                left: -50,
                child: Circle(color: Colors.white.withOpacity(0.09), diameter: 180),
              ),
              Positioned(
                top: -50,
                left: -50,
                child: Circle(color: Colors.white.withOpacity(0.08), diameter: 210),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(backgroundImage: profilePicture),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$username",
                                    style: Okito.theme.textTheme.bodyText2!.copyWith(
                                      fontSize: 12.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  RatingStars(score: score),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                PhosphorIcons.map_pin,
                                size: 12,
                                color: ColorConstants.greyColor,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "${location.toUpperCase()}",
                                style: Okito.theme.textTheme.bodyText2!.copyWith(
                                  fontSize: 10.0,
                                  color: ColorConstants.greyColor,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.3,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 30,
                              child: KButton(
                                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 0),
                                onPressed: onTap,
                                title: "VIEW PROFILE",
                                color: Colors.white.withOpacity(0.25),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
