// ignore_for_file: avoid_print

// import 'dart:_http';
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
              date: taskData['date'],
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

  Future<void> updateProduct(String id, Task editedTask) async {
    final taskIndex = _items.indexWhere((task) => task.taskId == id);
    print("\n \n \n \n  IN UPDATE PROVIDER");
    if (taskIndex >= 0) {
      final url = Uri.parse(
        'https://fbp1-5dc1a-default-rtdb.firebaseio.com/task/$id.json',
      );
      await http.patch(
        url,
        body: json.encode(
          {
            'title': editedTask.title,
          },
        ),
      );
      _items[taskIndex] = editedTask;
      notifyListeners();
    } else {
      print('error in update');
    }
  }

  Future<void> addProduct(Task task) async {
    // ignore: prefer_typing_uninitialized_variables
    late final _newTask;

    final url = Uri.parse(
      'https://fbp1-5dc1a-default-rtdb.firebaseio.com/task.json',
    );

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': task.title,
            'date': task.date,
            'state': task.state,
          },
        ),
      );
      _newTask = Task(
        taskId: json.decode(response.body)['name'],
        title: task.title,
        date: task.date,
      );
      _items.add(_newTask);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  Future<void> deleteTask(String id) async {
    final url = Uri.parse(
      'https://fbp1-5dc1a-default-rtdb.firebaseio.com/task/$id.json',
    );
    final existingProductIndex =
        _items.indexWhere((element) => element.taskId == id);
    Task? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      // throw HttpException('Could not delete product.');
    }
    existingProduct = null;

    notifyListeners();
  }
}
