import 'package:flutter/material.dart';
import 'package:task_list_app/screens/main_page.dart';
import 'package:task_list_app/utils/change_app_theme.dart';

class RootWidget extends StatefulWidget {
  @override
  State<RootWidget> createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  bool isDarkMode = false;

  void toDarkMode() {
    debugPrint('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
    setState(() {
      isDarkMode = true;
    });
  }

  void toLightMode() {
    debugPrint('}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}');
    setState(() {
      isDarkMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeAppTheme(
      isDarkMode: isDarkMode,
      toDarkMode: toDarkMode,
      toLightMode: toLightMode,
      child: MainPage(),
    );
  }
}
