import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/add_task_screen.dart';
import '../provider/task.dart';
import '../provider/task_provider.dart';

// ignore: must_be_immutable
class TaskScreenItems extends StatelessWidget {
  Task task;
  TaskScreenItems({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(task.taskId),
      direction: DismissDirection.horizontal,
      background: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        color: Theme.of(context).primaryColorLight,
        child: const Icon(Icons.edit, color: Colors.white, size: 30),
        alignment: Alignment.centerRight,
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        color: Theme.of(context).errorColor,
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
        alignment: Alignment.centerRight,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Icon(
                Icons.circle_outlined,
                color: Theme.of(context).iconTheme.color,
                size: MediaQuery.of(context).size.height * 0.05,
              ),
            ),
            backgroundColor: Colors.white,
            radius: 25,
          ),
          title: Text(task.title!),
          subtitle: Text(task.date.toString()),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          Provider.of<TaskProvider>(context, listen: false)
              .deleteTask(task.taskId!);
        } else {
          Navigator.of(context).pushReplacementNamed(AddTaskScreen.routeName, arguments: task.taskId);
        }
      },
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text(
                'Is the Task Completed?',
              ),
              content: const Text('Task will be marked Done and removed!'),
              actions: [
                TextButton(
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
                TextButton(
                  child: Text(
                    'YES',
                    style: TextStyle(
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                ),
              ],
            ),
          );
        } else {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text(
                'Are you sure to Edit this task?',
              ),
              content: const Text('You will be taken to edit screen'),
              actions: [
                TextButton(
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
                TextButton(
                  child: Text(
                    'YES',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
