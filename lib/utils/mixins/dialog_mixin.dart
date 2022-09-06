import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

mixin DialogMixin {
  showNotification(String content) {
    showDialog(
      context: Okito.context!,
      builder: (context) {
        return AlertDialog(
          title: Text("Notification"),
          content: Text(content),
          actions: [
            TextButton(onPressed: Okito.pop, child: Text("OK")),
          ],
        );
      },
    );
  }
}
