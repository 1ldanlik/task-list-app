
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_list_app/provider/tasks_provider.dart';
import 'package:task_list_app/screens/main_page.dart';
import 'package:task_list_app/widgets/root_widget.dart';
import 'package:task_list_app/widgets/task_list_root_widget.dart';

import 'entity/task/task.dart';
import 'provider/theme_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');
  runApp(const RootWidget(child: MyApp()));
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
              title: 'Flutter Demo',
              theme: ThemeData(),
              darkTheme: ThemeData.dark(),
              themeMode: themeNotifier.isDark ? ThemeMode.dark : ThemeMode.light,
              home: TaskListRootWidget(
                child: MainPage(),
              ),
            );
          },)
    );
  }
}