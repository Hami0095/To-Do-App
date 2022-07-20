import 'package:flutter/material.dart';
import 'package:task2/Themes/mythemes.dart';
import 'package:task2/pages/tasks_screen.dart';

import './pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do',
      theme: MyThemes.lightTheme,
      home: HomePage(),
      routes: {
        TaskScreen.routeName: (ctx) => const TaskScreen(),
      },
    );
  }
}
