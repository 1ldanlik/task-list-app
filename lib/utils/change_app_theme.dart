import 'package:flutter/material.dart';

class ChangeAppTheme extends InheritedWidget {
  final ThemeMode themeMode;
  final Widget child;
  final Function toDarkMode;
  final Function toLightMode;

  const ChangeAppTheme({
    Key? key,
    required this.themeMode,
    required this.toDarkMode,
    required this.toLightMode,
    required this.child
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(ChangeAppTheme oldWidget) {
    return themeMode != oldWidget.themeMode;
  }

  static ChangeAppTheme? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ChangeAppTheme>());
  }
}
