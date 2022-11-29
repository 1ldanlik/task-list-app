
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_app/provider/tasks_provider.dart';
import 'package:task_list_app/screens/main_page/component/add_button_component.dart';
import 'package:task_list_app/screens/main_page/component/tasks_list_component.dart';

import '../../entity/task/task.dart';
import '../../provider/theme_provider.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late TextEditingController _controller = TextEditingController();
  bool _isVisibleTextField = false;
  bool _isEmptyError = false;
  final FocusNode _focusNode = FocusNode();



  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    if (mounted) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final TasksModel tasksModel = context.read<TasksModel>();
    final ThemeModel themeModel = context.read<ThemeModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task list',
          style: TextStyle(
            color: themeModel.isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeModel.isDark
                  ? themeModel.isDark = false
                  : themeModel.isDark = true;
            },
            icon: Icon(
              themeModel.isDark ? Icons.mode_night : Icons.sunny,
              color: themeModel.isDark ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tasks',
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      color: themeModel.isDark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  AddButtonComponent(onPressed: () {
                    if (_isVisibleTextField) {
                      if (_controller.text.isNotEmpty) {
                        tasksModel.addTask(Task.create(title: _controller.text));
                        _controller.clear();
                        _isEmptyError = false;
                      } else {
                        _isEmptyError = true;
                      }
                    } else {
                      _focusNode.requestFocus();
                    }
                    _isVisibleTextField = !_isVisibleTextField;
                    setState(() {});
                  },)
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              const Divider(
                thickness: 1,
                color: Color(0xFFEBEBEB),
              ),
              Visibility(
                visible: _isVisibleTextField,
                child: TextField(
                  style: TextStyle(
                    color: themeModel.isDark ? Colors.white : Colors.black,
                  ),
                  focusNode: _focusNode,
                  controller: _controller,
                ),
              ),
              Visibility(
                  visible: _isEmptyError,
                  child: const Text(
                    "The task can't be empty",
                    style: TextStyle(color: Colors.red),
                  )),
              const SizedBox(
                height: 32,
              ),
              const Expanded(
                child: TasksListComponent(),
              ),
              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
