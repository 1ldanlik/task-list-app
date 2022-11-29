import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_app/provider/tasks_provider.dart';

import '../../../provider/theme_provider.dart';

class TasksListComponent extends StatefulWidget {
  const TasksListComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<TasksListComponent> createState() => _TasksListComponentState();
}

class _TasksListComponentState extends State<TasksListComponent> {
  @override
  Widget build(BuildContext context) {
    final TasksModel tasksModel = context.watch<TasksModel>();
    final ThemeModel themeModel = context.read<ThemeModel>();

    return ListView.builder(
      itemCount: tasksModel.list.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ObjectKey(tasksModel.list[index]),
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red,
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          onDismissed: (value) {
          setState(() {
            tasksModel.removeTask(tasksModel.list[index]);
          });
        },
          child: CheckboxListTile(
            activeColor: Colors.grey,
            controlAffinity: ListTileControlAffinity.leading,
            onChanged: (value) {
              setState(() {
                tasksModel.changeSelection(tasksModel.list[index]);
              });
            },
            side: const BorderSide(
                color: Colors.grey,
                width: 2
            ),
            title: Text(
              tasksModel.list[index].title,
              style: TextStyle(
                color: themeModel.isDark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            value: tasksModel.list[index].isChecked,
          ),
        );
      },
    );
  }
}
