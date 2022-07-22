// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/task.dart';
import '../provider/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  static const routeName = '/add-task-screen';
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _form = GlobalKey<FormState>();

  var _initValues = {
    'title': '',
    'id': DateTime.now().toString(),
    'cateogory': 'work',
    'state': 'false',
  };

  var _editedTask = Task(taskId: '', title: '', category: '');
  var _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final taskId = ModalRoute.of(context)?.settings.arguments as String?;
      if (taskId != null) {
        _editedTask =
            Provider.of<TaskProvider>(context, listen: false).findByID(taskId);
        _initValues = {
          'title': _editedTask.title!,
          'taskId': _editedTask.taskId!,
          'category': _editedTask.category!,
        };
      }
    }
    super.didChangeDependencies();
    _isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> saveForm() async {
    // print('edited product id: ${_editedTask.taskId}');
    final _isValid = _form.currentState?.validate();
    if (!_isValid!) {
      return;
    }
    _form.currentState?.save();
    setState(() {});
    if (_editedTask.taskId != '') {
      // print('Going to update the task');
      // Provider.of<TaskProvider>(context, listen: false)
      //     .updateProduct(_editedTask.id, _editedTask);
      Navigator.of(context).pop();
    } else {
      // print('Going to add product');
      try {
        await Provider.of<TaskProvider>(context, listen: false)
            .addProduct(_editedTask);
      } catch (e) {
        showDialog<void>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Bhai-Error',
            ),
            content: const Text('Something went Wrong bhai'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text(
                  'Okay',
                ),
              ),
            ],
          ),
        );
      } finally {
        // print('Going out of the save product');
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Your Task",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: (() => saveForm()),
            icon: Icon(
              Icons.save_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Center(
                child: Lottie.network(
                  'https://assets9.lottiefiles.com/datafiles/9WPVKhslFJRCdx9VKWDGDnlb6iMmDvQ00EJtMCYo/Add:Save/data.json',
                  height: MediaQuery.of(context).size.height * 0.10,
                  animate: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(
                  label: Text(
                    'Title',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _editedTask = Task(
                    taskId: _editedTask.taskId,
                    title: value!,
                    category: _editedTask.category,
                    state: _editedTask.state,
                  );
                },
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Please enter value';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Center(
              child: IconButton(
                onPressed: (() => saveForm()),
                icon: Icon(
                  Icons.save_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
