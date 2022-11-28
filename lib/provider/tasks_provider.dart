import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entity/task/task.dart';

class TasksModel extends ChangeNotifier {
  var box = Hive.box<Task>('taskBox');
  List<Task> list = [];

  TasksModel() {
    list = box.values.toList();

    notifyListeners();
  }

  void changeSelection(Task task) {
    final indexOfTask = list.indexOf(task);
    list[indexOfTask].isChecked = task.isChecked;

    task.isChecked = !task.isChecked;
    box.put(task.key, task);

    notifyListeners();
  }

  void addTask(Task task) {
    list.add(task);
    box.add(task);

    notifyListeners();
  }

  void removeTask(Task task) {
    list.remove(task);
    box.delete(task);

    notifyListeners();
  }
}