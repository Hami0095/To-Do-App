import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/pages/add_task_screen.dart';
import 'package:task2/provider/task.dart';
import 'package:task2/provider/task_provider.dart';
import 'package:task2/widgets/task_screen_item.dart';

class TaskScreen extends StatefulWidget {
  static const routeName = '/task_screen';
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool _isInit = true;
  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {});
      await Provider.of<TaskProvider>(context).fetchAndSetProduct();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context);
    List<Task> _items = taskProvider.items;
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
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Center(
              child: Text(
                "Your Remaining tasks",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: ListView.builder(
              itemBuilder: (context, index) => TaskScreenItems(
                task: Task(
                  // taskId: taskProvider.items[index].taskId,
                  // title: taskProvider.items[index].title,
                  // category: taskProvider.items[index].category,
                  taskId: _items[index].taskId,
                  title: _items[index].title,
                  category: _items[index].category,
                ),
              ),
              itemCount: taskProvider.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
