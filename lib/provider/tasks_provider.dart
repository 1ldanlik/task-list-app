import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../entity/task.dart';

class TasksModel extends ChangeNotifier {
  var box = Hive.box<Task>('taskBox');
  List<Task> list = [];

  TasksModel() {
    list = box.values.toList();

    notifyListeners();
  }

  addTask(Task task) {
    list.add(task);
    box.add(task);

    notifyListeners();
  }

  removeTask(Task task) {
    list.remove(task);
    box.delete(task);

    notifyListeners();
  }
}