import 'package:flutter/material.dart';

import '../entity/task.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Task> _taskList = [];
  late TextEditingController _controller;
  bool _isVisibleTextField = false;
  bool _isEpmtyError = false;

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
    if(mounted) {
      _controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список задач'),
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
                  const Text(
                    'Tasks',
                    style: TextStyle(fontSize: 56, fontWeight: FontWeight.w800),
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
                          setState(() {
                            if(_isVisibleTextField) {
                              if(_controller.text.isNotEmpty) {
                                _taskList.add(Task(_controller.text));
                                _controller.clear();
                                _isEpmtyError = false;
                              } else {
                                _isEpmtyError = true;
                              }
                            }
                            _isVisibleTextField = !_isVisibleTextField;
                            setState(() {});
                          });
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
                  controller: _controller,
                ),
              ),
              Visibility(
                visible: _isEpmtyError,
                child: const Text(
                  "The task can't be empty", style: TextStyle(color: Colors.red),
                )
              ),
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
                          child: const Icon(Icons.delete, color: Colors.white,),
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
                          title: Text(_taskList[index].title),
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
