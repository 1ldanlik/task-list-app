import 'package:flutter/material.dart';

import '../entity/task.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Task> taskList = [];

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FittedBox(
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Tasks',
                    style: TextStyle(fontSize: 56),
                  ),
                  SizedBox(
                    width: 46,
                    height: 46,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            backgroundColor: getColor(const Color(0xFFF2F3FF),
                                const Color(0xFFD6F0BF))),
                        onPressed: () {},
                        child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Color(0xFF575767),
                              size: 36,
                            ))),
                  )
                ],
              ),
              const SizedBox(height: 32,),
              ListView.builder(
                itemCount: taskList.length,
                  itemBuilder: (context, index) {
                  return FittedBox(
                    child: CheckboxListTile(
                      onChanged: (value) {
                        setState(() {
                          taskList[index].isChecked = value!;
                        });
                      },
                      title: Text(taskList[index].title),
                      value: taskList[index].isChecked,
                    ),
                  );
                  }),
              const SizedBox(height: 32,),
            ],
          ),
        ),
      ),
    );
  }
}
