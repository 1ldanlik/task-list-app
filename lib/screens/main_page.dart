import 'package:flutter/material.dart';

import '../entity/task.dart';
import '../utils/change_app_theme.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Task> _taskList = [];
  late TextEditingController _controller = TextEditingController();
  bool _isVisibleTextField = false;
  bool _isEpmtyError = false;
  FocusNode focusNode = FocusNode();

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
    _taskList.add(Task('title'));
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
    final appThemeState = ChangeAppTheme.of(context);
    return Scaffold(
      backgroundColor: appThemeState!.isDarkMode ? const Color(0xFF29292F) : null,
      appBar: AppBar(
        backgroundColor: appThemeState.isDarkMode ? const Color(0xFF1E1F25) : null,
        title: Text(
          'Список задач',
          style: TextStyle(
            color: appThemeState.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
              appThemeState.isDarkMode
                  ? appThemeState.toLightMode()
                  : appThemeState.toDarkMode(),
            icon: Icon(
              appThemeState.isDarkMode ? Icons.mode_night : Icons.sunny,
              color: appThemeState.isDarkMode ? Colors.white : Colors.black,
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
                      color: appThemeState.isDarkMode
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
                                _taskList.insert(0, Task(_controller.text));
                                _controller.clear();
                                _isEpmtyError = false;
                              } else {
                                _isEpmtyError = true;
                              }
                            } else {
                              focusNode.requestFocus();
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
                    color: appThemeState.isDarkMode ? Colors.white : Colors.black,
                  ),
                  focusNode: focusNode,
                  controller: _controller,
                ),
              ),
              Visibility(
                  visible: _isEpmtyError,
                  child: const Text(
                    "The task can't be empty",
                    style: TextStyle(color: Colors.red),
                  )),
              const SizedBox(
                height: 32,
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: _taskList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ObjectKey(_taskList[index]),
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
                            _taskList.removeAt(index);
                          });
                        },
                        child: CheckboxListTile(
                          activeColor: Colors.grey,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            setState(() {
                              _taskList[index].isChecked = value!;
                            });
                          },
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 2
                          ),
                          title: Text(
                            _taskList[index].title,
                            style: TextStyle(
                              color: appThemeState.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          value: _taskList[index].isChecked,
                        ),
                      );
                    }),
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
