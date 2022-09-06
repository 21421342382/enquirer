import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle getStatusBarStyle({required Color color, required Brightness iconBrightness}) {
  return SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: iconBrightness,
  );
}
