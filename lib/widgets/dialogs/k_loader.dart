import 'package:arcopen_enquirer/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

class KLoader {
  KLoader({this.message});
  final String? message;

  Future show() async {
    showDialog(
      context: Okito.context!,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.darkBlue),
                ),
              ),
              SizedBox(width: 10),
              Text("${message ?? "Please wait..."}"),
            ],
          ),
        );
      },
    );
  }

  static void hide() {
    Okito.pop();
  }
}
