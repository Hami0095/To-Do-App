import 'package:flutter/material.dart';
import 'package:task2/provider/task.dart';

class TaskProvider extends ChangeNotifier {
  Map<String, Task> _items = {};

  Map<String, Task> get items {
    return {..._items};
  }

  void addItem(String taskId, String category, String title) {
    if (_items.containsKey(taskId)) {
      _items.update(
        taskId,
        (existingItem) =>
            Task(taskId: taskId, title: title, category: category),
      );
    } else {
      _items.putIfAbsent(
        taskId,
        () => Task(taskId: taskId, title: title, category: category),
      );
    }
    notifyListeners();
  }
}
