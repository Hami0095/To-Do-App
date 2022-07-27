import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task2/firebase_options.dart';
import 'package:task2/pages/add_task_screen.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;
import './Themes/mythemes.dart';
import './pages/tasks_screen.dart';
import './pages/home_page.dart';
import 'provider/task_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Constructor

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => TaskProvider(),
        ),
      ],
      builder: (context, _) {
        return MaterialApp(
          title: 'To-Do',
          theme: MyThemes.lightTheme,
          home: HomePage(),
          routes: {
            TaskScreen.routeName: (ctx) => const TaskScreen(),
            AddTaskScreen.routeName: (ctx) => const AddTaskScreen(),
          },
        );
      },
    );
  }
}
