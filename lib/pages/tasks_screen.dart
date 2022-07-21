import 'package:flutter/material.dart';
import 'package:task2/pages/add_task_screen.dart';
import 'package:task2/provider/task.dart';
import 'package:task2/provider/task_provider.dart';
import 'package:task2/widgets/task_screen_item.dart';

class TaskScreen extends StatelessWidget {
  static const routeName = '/task_screen';
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = TaskProvider();

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Your Events",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            IconButton(
              onPressed: (() {
                Navigator.of(context)
                    .pushReplacementNamed(AddTaskScreen.routeName);
              }),
              icon: Icon(
                Icons.add,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ]),
      body: ListView.builder(
        itemBuilder: (context, index) => TaskScreenItems(
          task: Task(
            taskId: taskProvider.items[index].taskId,
            title: taskProvider.items[index].title,
            category: taskProvider.items[index].category,
          ),
        ),
        itemCount: taskProvider.items.length,
      ),
    );
  }
}
