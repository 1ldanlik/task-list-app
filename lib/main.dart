
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_list_app/provider/tasks_provider.dart';
import 'package:task_list_app/screens/main_page/main_page.dart';

import 'entity/task/task.dart';
import 'provider/theme_provider.dart';
import 'theme/theme.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskModel = TasksModel();
    final themeModel = ThemeModel();

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => taskModel,
          ),
          ChangeNotifierProvider(
            create: (_) => themeModel,
          ),
        ],
        child: Consumer<ThemeModel>(
          builder: (context, ThemeModel themeNotifier, child) {

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: themeNotifier.isDark ? TaskListAppTheme.dark : TaskListAppTheme.light,
              home: MainPage(),
            );
          },)
    );
  }
}