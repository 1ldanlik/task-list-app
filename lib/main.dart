
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_list_app/provider/tasks_provider.dart';
import 'package:task_list_app/screens/main_page.dart';
import 'package:task_list_app/widgets/root_widget.dart';
import 'package:task_list_app/widgets/task_list_root_widget.dart';

import 'entity/task.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');
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

    final model = TasksModel();

    return ChangeNotifierProvider<TasksModel>(
      create: (context) => model,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        themeMode: _themeMode,
        home: TaskListRootWidget(
          child: MainPage(),
        ),
      ),
    );
  }
}