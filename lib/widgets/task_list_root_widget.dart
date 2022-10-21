import 'package:flutter/material.dart';
import 'package:task_list_app/screens/main_page.dart';
import 'package:task_list_app/utils/task_list.dart';

import '../entity/task.dart';

class TaskListRootWidget extends StatefulWidget {
  const TaskListRootWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<TaskListRootWidget> createState() => _TaskListRootWidgetState();
}

class _TaskListRootWidgetState extends State<TaskListRootWidget> {

  List<Task>? taskList = [];
  void addNewTask(int index, String title) {
    taskList!.insert(index, Task(title: title));
  }

  void removeTask(int index) {
    taskList!.removeAt(index);
  }

  void changeCheckValue(int index, bool isChecked) {
    taskList![index].isChecked = isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return TaskList(
        addNewTask: addNewTask,
        removeTask: removeTask,
        changeCheckValue: changeCheckValue,
        taskList: taskList!,
        child: MainPage()
    );
  }
}
