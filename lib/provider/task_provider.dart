import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../provider/task.dart';

class TaskProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Task> _items = [
    // Task(
    //   taskId: DateTime.now().toString(),
    //   title: "this is title 1",
    //   category: "Work",
    // ),
    // Task(
    //   taskId: DateTime.now().toString(),
    //   title: "this is title 2",
    //   category: "Work",
    // ),
    // Task(
    //   taskId: DateTime.now().toString(),
    //   title: "this is title 3",
    //   category: "Work",
    // ),
    // Task(
    //   taskId: DateTime.now().toString(),
    //   title: "this is title 4",
    //   category: "Health",
    // ),
    // Task(
    //   taskId: DateTime.now().toString(),
    //   title: "this is title 5",
    //   category: "personal",
    // ),
  ];

  List<Task> get items {
    return [..._items];
  }

  Task findByID(String id) {
    return items.firstWhere((element) => element.taskId == id);
  }

  Future<void> fetchAndSetProduct() async {
    final url = Uri.parse(
      'https://fbp1-5dc1a-default-rtdb.firebaseio.com/task.json',
    );
    try {
      print("In Fetch Portion");
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Task> loadedProducts = [];
      extractedData.forEach(
        (taskId, taskData) {
          loadedProducts.add(
            Task(
              taskId: taskId,
              title: taskData['title'],
              category: taskData['category'],
              state: taskData['state'] ? false : false,
            ),
          );
          print('\n loaded data  $loadedProducts ');
        },
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      // ignore: use_rethrow_when_possible
      if (error.runtimeType != Null) {
        print('$error');
      }
      print('$error');
    }
  }

  Future<void> addProduct(Task task) async {
    // ignore: prefer_typing_uninitialized_variables
    late final _newTask;
    print('in addProduct()');

    final url = Uri.parse(
      'https://fbp1-5dc1a-default-rtdb.firebaseio.com/task.json',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': task.title,
            'category': task.category,
            'state': task.state,
          },
        ),
      );
      _newTask = Task(
        taskId: json.decode(response.body)['name'],
        title: task.title,
        category: task.category,
      );
      _items.add(_newTask);
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  void deleteTask(String id) {
    _items.removeWhere((element) => element.taskId == id);
    notifyListeners();
  }
}
