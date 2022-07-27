class Task {
  String? taskId;
  String? title;
  String? date;
  bool state = false;
  Task({
    required this.taskId,
    required this.title,
    required this.date,
    this.state = false,
  });
}
