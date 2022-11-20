
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    this.isChecked = false,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isChecked;

  factory Task.create({
    required String? title,
  }) =>
      Task(
        id: const Uuid().v1(),
        title: title ?? "",
        isChecked: false,
      );


// @override
// bool operator ==(dynamic other) {
//   return (other is Task && other.title == title
//       && other.isChecked == isChecked);
// }

// @override
// int get hashCode => Object.hash(title.hashCode, isChecked.hashCode);

}