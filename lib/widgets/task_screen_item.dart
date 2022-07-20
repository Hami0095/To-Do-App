import 'package:flutter/material.dart';

import '../provider/task.dart';

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
      background: Container(
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
              ),
            ),
            backgroundColor: Colors.white,
            radius: 25,
          ),
          title: Text(task.title!),
          subtitle: Text(task.category!),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Provider.of<Task>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Are You Sure?',
            ),
            content: const Text(
                'Do you want to remove the item from the cart permanently?'),
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
      },
    );
  }
}
