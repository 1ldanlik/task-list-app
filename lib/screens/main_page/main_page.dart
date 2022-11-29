
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_list_app/provider/tasks_provider.dart';

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

  MaterialStateProperty<Color>? getColor(Color color, Color colorPressed) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return colorPressed;
      } else {
        return color;
      }
    };

    return MaterialStateProperty.resolveWith(getColor);
  }

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
              debugPrint(';;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ' + themeModel.isDark.toString());
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
                  SizedBox(
                    width: 46,
                    height: 46,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            backgroundColor: getColor(const Color(0xFFF2F3FF),
                                const Color(0xFFD6F0BF))),
                        onPressed: () {
                          if (_isVisibleTextField) {
                            if (_controller.text.isNotEmpty) {
                              tasksModel.addTask(Task.create(title: _controller.text));
                              debugPrint('================' + tasksModel.list.toString());
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
                        },
                        child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Color(0xFF575767),
                              size: 36,
                            ))),
                  )
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
              Expanded(
                child: ListView.builder(
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
                            debugPrint('sdsfsfsdfsdfsfs___' + tasksModel.list.toString());
                            debugPrint('sdsfsfsdfsdfsfs+++' + tasksModel.box.values.toString());
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
                    },),
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
