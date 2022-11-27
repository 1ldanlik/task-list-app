import 'package:flutter/material.dart';
import 'package:task_list_app/entity/task/task.dart';

class TaskList extends InheritedWidget{
  const TaskList({
    Key? key,
    required this.addNewTask,
    required this.removeTask,
    required this.changeCheckValue,
    required this.taskList,
    required this.child
  }) : super(key: key, child: child);

  final Function addNewTask;
  final Function removeTask;
  final Function changeCheckValue;
  final List<Task> taskList;
  final Widget child;

  @override
  bool updateShouldNotify(TaskList oldWidget) {
    debugPrint('hhhhhhhhhhhhhhhhhhhhhhhhh${oldWidget.taskList == taskList}');
    return oldWidget.taskList == taskList;
  }

  static TaskList? of(context) {
    return context.dependOnInheritedWidgetOfExactType<TaskList>();
  }

}