import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/config/routes/k_router.dart';
import 'package:arcopen_enquirer/config/routes/k_routes.dart';
import 'package:arcopen_enquirer/constants/app_constants.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:arcopen_enquirer/utils/navigation/k_app_bar.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = Okito.theme.textTheme.bodyText2!;
    return Scaffold(
      appBar: KAppBar(
        title: "Settings",
      ),
      backgroundColor: ColorConstants.lightBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              ListTile(
                dense: true,
                onTap: () {
                  KRouter().push(KRoutes.bankDetailsRoute);
                },
                title: Text(
                  "Bank details",
                  style: titleStyle,
                ),
                trailing: Icon(PhosphorIcons.caret_right, size: 15),
              ),
              Divider(),
              ListTile(
                dense: true,
                onTap: () {
                  KRouter().push(KRoutes.changePasswordRoute);
                },
                title: Text(
                  "Change password",
                  style: titleStyle,
                ),
                trailing: Icon(PhosphorIcons.caret_right, size: 15),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: SectionTitle(title: "LEGAL", hasBoldTitle: true),
              ),
              ListTile(
                dense: true,
                onTap: () async {
                  if (await canLaunch(AppConstants.privacyPolicyUrl)) {
                    launch(AppConstants.privacyPolicyUrl);
                  }
                },
                title: Text(
                  "Privacy Policy",
                  style: titleStyle,
                ),
                trailing: Icon(PhosphorIcons.share, size: 15),
              ),
              Divider(),
              ListTile(
                dense: true,
                onTap: () async {
                  if (await canLaunch(AppConstants.accessibilityUrl)) {
                    launch(AppConstants.accessibilityUrl);
                  }
                },
                title: Text(
                  "Accessibility",
                  style: titleStyle,
                ),
                trailing: Icon(PhosphorIcons.share, size: 15),
              ),
              Divider(),
              ListTile(
                dense: true,
                onTap: () async {
                  if (await canLaunch(AppConstants.tosUrl)) {
                    launch(AppConstants.tosUrl);
                  }
                },
                title: Text(
                  "Terms of service",
                  style: titleStyle,
                ),
                trailing: Icon(PhosphorIcons.share, size: 15),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
