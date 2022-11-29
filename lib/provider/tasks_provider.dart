import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entity/task/task.dart';

class TasksModel extends ChangeNotifier {
  var box = Hive.box<Task>('taskBox');
  List<Task> _list = [];

  List<Task> get list => _list;

  TasksModel() {
    _list = box.values.toList();

    notifyListeners();
  }

  void changeSelection(Task task) {
    final indexOfTask = _list.indexOf(task);
    _list[indexOfTask].isChecked = task.isChecked;

    task.isChecked = !task.isChecked;
    box.put(task.key, task);

    notifyListeners();
  }

  void addTask(Task task) {
    _list.add(task);
    box.add(task);

    notifyListeners();
  }

  void removeTask(Task task) {
    _list.remove(task);
    box.deleteAt(task.key);

    notifyListeners();
  }
}