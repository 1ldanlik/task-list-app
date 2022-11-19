import 'package:flutter/material.dart';

class TaskListAppTheme {
static ThemeData get light {
  return ThemeData(
    brightness: Brightness.light,
  );
}

static ThemeData get dark {
  return ThemeData(
      brightness: Brightness.dark,
  );
}
}