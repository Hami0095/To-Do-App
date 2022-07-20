class Task {
  String? taskId;
  String? title;
  String? category;
  bool state = false;
  Task({
    required this.taskId,
    required this.title,
    required this.category,
    this.state = false,
  });
}
