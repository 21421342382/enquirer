import 'package:flutter/material.dart';
import 'package:okito/okito.dart';
import 'package:arcopen_enquirer/constants/color_constants.dart';

mixin ToastMixin {
  void showErrorToast(String content) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        "$content",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: ColorConstants.red,
    );
    Okito.showSnackBar(snackBar: snackBar);
  }

  void showInfoToast(String content) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        "$content",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: ColorConstants.darkBlue,
    );
    Okito.showSnackBar(snackBar: snackBar);
  }

  void showWarningToast(String content) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        "$content",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: ColorConstants.orangeColor,
    );
    Okito.showSnackBar(snackBar: snackBar);
  }

  void showSuccessToast(String content) {
    final SnackBar snackBar = SnackBar(
      content: Text(
        "$content",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: ColorConstants.greenColor,
    );
    Okito.showSnackBar(snackBar: snackBar);
  }
}
