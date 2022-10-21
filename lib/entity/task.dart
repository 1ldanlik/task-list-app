
class Task {
  Task({
    required this.title, this.isChecked = false
  });

  String title;
  bool isChecked;

  bool operator ==(dynamic other) {
    return (other is Task && other.title == title
        && other.isChecked == isChecked);
  }

  @override
  int get hashCode => Object.hash(title.hashCode, isChecked.hashCode);

}