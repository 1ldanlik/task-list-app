import 'package:flutter/material.dart';
import 'package:task_list_app/screens/main_page.dart';
import 'package:task_list_app/widgets/root_widget.dart';
import 'package:task_list_app/widgets/task_list_root_widget.dart';

void main() {
  runApp(const RootWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListRootWidget(
        child: MainPage(),
      ),
    );
  }
}