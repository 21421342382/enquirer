import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:okito/okito.dart';

class NavbarMenuItem {
  final String name;
  final VoidCallback onTap;

  NavbarMenuItem({
    required this.name,
    required this.onTap,
  });
}

class KAppBar extends StatelessWidget with PreferredSizeWidget {
  const KAppBar({
    Key? key,
    required this.title,
    this.menuItems,
  }) : super(key: key);

  final String title;
  final List<NavbarMenuItem>? menuItems;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.8,
      leading: IconButton(
        icon: Icon(
          PhosphorIcons.caret_left_bold,
          color: Colors.black,
        ),
        onPressed: () {
          Okito.pop();
        },
      ),
      title: Text(
        "$title",
        style: Okito.theme.textTheme.headline3,
      ),
      actions: [
        if (menuItems != null)
          PopupMenuButton<int>(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                PhosphorIcons.dots_three_vertical_bold,
                color: ColorConstants.greyColor,
              ),
            ),
            onSelected: (int index) {
              menuItems![index].onTap();
            },
            itemBuilder: (context) {
              return List.generate(menuItems!.length, (index) {
                return PopupMenuItem(
                  value: index,
                  child: Text(menuItems![index].name),
                );
              });
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
