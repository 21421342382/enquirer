import 'package:flutter/material.dart';

class KRoute {
  final String name;
  final Widget page;
  final bool isInitial;

  KRoute({
    required this.name,
    required this.page,
    this.isInitial = false,
  });
}
