import 'package:flutter/material.dart';

class AddButtonComponent extends StatelessWidget {
  final Function() onPressed;

  const AddButtonComponent({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  MaterialStateProperty<Color>? _getColor(Color color, Color colorPressed) {
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
    return SizedBox(
      width: 46,
      height: 46,
      child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: _getColor(const Color(0xFFF2F3FF),
                  const Color(0xFFD6F0BF))),
          onPressed: onPressed,
          child: const Center(
              child: Icon(
                Icons.add,
                color: Color(0xFF575767),
                size: 36,
              ),
          ),
      ),
    );
  }
}
