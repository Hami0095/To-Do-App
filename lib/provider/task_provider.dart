// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../provider/task.dart';

class TaskProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Task> _items = [];

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
      print("Items : $_items");
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
        },
      );
      _items = loadedProducts;
      print("Items : $_items");
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
      print(e.toString());
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  void deleteTask(String id) {
    print("id : $id");
    print("\n _items before removing: $_items");
    _items.removeWhere((element) => element.taskId == id);
    print("\n _items: $_items");

    notifyListeners();
  }
}
