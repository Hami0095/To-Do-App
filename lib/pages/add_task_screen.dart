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
  final dateController = TextEditingController();
  final _dateFocusNode = FocusNode();
  var _initValues = {
    'title': '',
    'id': DateTime.now().toString(),
    'date': '',
    'state': 'false',
  };

  var _editedTask = Task(taskId: '', title: '', date: '');
  var _isInit = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final taskId = ModalRoute.of(context)?.settings.arguments as String?;
      print("\n \n \n  TASK ID ==>  $taskId \n");
      if (taskId != null) {      
        _editedTask =
            Provider.of<TaskProvider>(context, listen: false).findByID(taskId);
        _initValues = {
          'title': _editedTask.title!,
          'taskId': _editedTask.taskId!,
          'date': _editedTask.date!,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    setState(() {});
    if (_editedTask.taskId != '') {
      await Provider.of<TaskProvider>(context, listen: false)
          .updateProduct(_editedTask.taskId!, _editedTask);
    } else {
      try {
        await Provider.of<TaskProvider>(context, listen: false)
            .addProduct(_editedTask);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('An error occured!'),
                  content: const Text('Something went wrong!'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Okay'),
                    ),
                  ],
                ));
      }
    }
    setState(() {});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edition",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: (() => _saveForm()),
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
                    title: value!.toString(),
                    date: _editedTask.date,
                    state: _editedTask.state,
                  );
                },
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_dateFocusNode),
                validator: (v) {
                  if (v!.isEmpty) {
                    return 'Please enter value';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Pick your Date'),
              controller: dateController,
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                print("value = $value");
                _editedTask = Task(
                  taskId: _editedTask.taskId,
                  title: _editedTask.title,
                  date: value!,
                  state: _editedTask.state,
                );
              },
              onTap: () async {
                var date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                dateController.text = date.toString().substring(0, 10);
              },
              onFieldSubmitted: (_) => _saveForm(),
              readOnly: true,
            ),
            Center(
              child: IconButton(
                onPressed: (() => _saveForm()),
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
