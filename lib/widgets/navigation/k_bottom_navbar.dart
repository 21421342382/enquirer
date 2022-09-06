import 'package:flutter/material.dart';
import 'package:arcopen_enquirer/widgets/navigation/k_bottom_navbar_item.dart';

typedef ActionItemTappedCallback = Function(int);

class KBottomNavBar extends StatefulWidget {
  const KBottomNavBar({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  final List<KBottomNavBarItem> items;
  final ActionItemTappedCallback onTap;

  @override
  _KBottomNavBarState createState() => _KBottomNavBarState();
}

class _KBottomNavBarState extends State<KBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.items.map((e) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(120.0),
              onTap: () {
                widget.onTap(widget.items.indexOf(e));
              },
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: e,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
