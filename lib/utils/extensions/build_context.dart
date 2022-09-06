import 'package:flutter/material.dart';

extension ContextHelper on BuildContext {
  ThemeData get theme => Theme.of(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Routing helpers
  Future navigate(String name, {Map<String, Object>? params}) {
    return Navigator.of(this).pushNamed(name, arguments: params);
  }

  TextTheme get textTheme => Theme.of(this).textTheme;

  Size get customSize => MediaQuery.of(this).size;
}
