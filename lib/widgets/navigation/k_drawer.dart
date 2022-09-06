import 'package:arcopen_enquirer/utils/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/constants/app_constants.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/utils/helpers/asset_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class KDrawer extends StatelessWidget {
  const KDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = Okito.theme.textTheme.bodyText2!.copyWith(fontSize: 16.0);
    ImageProvider profilePicture = AssetImage(AssetHelper.getAsset(name: "avatar.png", assetType: AssetType.image));
    final authService = Okito.use<AuthService>();
    if (authService.profileExists && (authService.profile?.companyLogo.isNotEmpty ?? false)) {
      profilePicture = NetworkImage(AssetHelper.getMemberProfilePic(name: authService.profile!.companyLogo));
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: ColorConstants.lightBlue,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        KRouter().pop();
                      },
                      icon: Icon(PhosphorIcons.x_bold, size: 25),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        KRouter().push(KRoutes.userProfileRoute);
                      },
                      child: CircleAvatar(
                        maxRadius: 20,
                        backgroundImage: profilePicture,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ListTile(
                  dense: true,
                  onTap: () {
                    KRouter().push(KRoutes.choosePlanRoute);
                  },
                  leading: Icon(
                    PhosphorIcons.buildings_fill,
                    color: ColorConstants.darkBlue,
                    size: 20,
                  ),
                  title: Text(
                    "Subscription",
                    style: titleStyle,
                  ),
                ),
                Divider(),
                ListTile(
                  dense: true,
                  onTap: () {
                    KRouter().push(KRoutes.settingsRoute);
                  },
                  leading: Icon(
                    PhosphorIcons.gear_fill,
                    color: ColorConstants.darkBlue,
                    size: 20,
                  ),
                  title: Text(
                    "Settings",
                    style: titleStyle,
                  ),
                ),
                Divider(),
                ListTile(
                  dense: true,
                  leading: Icon(
                    PhosphorIcons.scales_bold,
                    color: ColorConstants.darkBlue,
                    size: 20,
                  ),
                  title: Text(
                    "Disputes",
                    style: titleStyle,
                  ),
                  onTap: () {
                    KRouter().push(KRoutes.disputesRoute);
                  },
                ),
                Divider(),
                ListTile(
                  dense: true,
                  leading: Icon(
                    PhosphorIcons.lifebuoy_fill,
                    color: ColorConstants.darkBlue,
                    size: 20,
                  ),
                  title: Text(
                    "Support",
                    style: titleStyle,
                  ),
                  onTap: () async {
                    if (await canLaunch(AppConstants.supportUrl)) {
                      launch(AppConstants.supportUrl);
                    }
                  },
                ),
                Divider(),
                ListTile(
                  dense: true,
                  leading: Icon(
                    PhosphorIcons.sign_out_fill,
                    color: ColorConstants.darkBlue,
                    size: 20,
                  ),
                  title: Text(
                    "Logout",
                    style: titleStyle,
                  ),
                  onTap: () {
                    Okito.use<AuthService>().logout();
                  },
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
