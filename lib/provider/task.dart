import 'package:flutter/material.dart';

class Task extends ChangeNotifier {
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
  void toggleState() {
    state = state == false ? state : !state;
  }
}
