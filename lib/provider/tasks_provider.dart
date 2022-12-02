import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../entity/task/task.dart';

class TasksModel extends ChangeNotifier {
  var box = Hive.box<Task>('taskBox');
  List<Task> _list = [];

  List<Task> get list => _list;

  TasksModel() {
    final List<Task> tasksInBox = box.values.toList();

    if(tasksInBox.isEmpty) {
      for(int i = 1; i <= 25; i++) {
        box.add(Task(id: const Uuid().v1(), title: 'Task item'));
        _list.add(Task(id: const Uuid().v1(), title: 'Task item'));
      }
    }
    _list = tasksInBox;

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
    _list.insert(0, task);
    box.values.toList().insert(0, task);

    notifyListeners();
  }

  void removeTask(Task task) {
    _list.remove(task);
    box.delete(task.key);

    notifyListeners();
  }
}