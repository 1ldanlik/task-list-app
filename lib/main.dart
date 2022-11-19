import 'package:flutter/material.dart';
import 'package:task_list_app/screens/main_page.dart';
import 'package:task_list_app/widgets/root_widget.dart';
import 'package:task_list_app/widgets/task_list_root_widget.dart';

void main() {
  runApp(const RootWidget(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  ThemeMode _themeMode = ThemeMode.light;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: TaskListRootWidget(
        child: MainPage(),
      ),
    );
  }
}