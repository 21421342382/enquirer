import 'package:flutter/material.dart';
import 'package:arcopen_enquirer/widgets/misc/section_title.dart';

class NotificationsDialog extends StatefulWidget {
  const NotificationsDialog({Key? key}) : super(key: key);

  @override
  _NotificationsDialogState createState() => _NotificationsDialogState();
}

class _NotificationsDialogState extends State<NotificationsDialog> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SectionTitle(title: "TODAY"),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text("Express Solutions has viewed your application for Talwar's Residency"),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text("Express Solutions has viewed your application for Talwar's Residency"),
          ),
          SizedBox(height: 10),
          SectionTitle(title: "YESTERDAY"),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text("Express Solutions has viewed your application for Talwar's Residency"),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text("Express Solutions has viewed your application for Talwar's Residency"),
          ),
          SizedBox(height: 10),
          SectionTitle(title: "MON APR. 5 2021"),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text("Express Solutions has viewed your application for Talwar's Residency"),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text("Express Solutions has viewed your application for Talwar's Residency"),
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(),
            title: Text("Express Solutions has viewed your application for Talwar's Residency"),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
