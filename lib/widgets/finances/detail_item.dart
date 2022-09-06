import 'package:flutter/material.dart';

class DetailItem extends StatelessWidget {
  const DetailItem({
    Key? key,
    required this.title,
    required this.value,
    this.boldTitle = false,
    this.boldValue = false,
  }) : super(key: key);

  final String title;
  final String value;
  final bool boldTitle;
  final bool boldValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "$title",
                  style: TextStyle(
                    fontWeight: boldTitle ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12.0,
                  ),
                ),
              ),
              Text(
                "$value",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: boldValue ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}
