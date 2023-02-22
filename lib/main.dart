import 'package:flutter/material.dart';
import 'package:lab1/screens/home.dart';

import 'constants/colors.dart';

void main() => runApp(const MyApp());

// The root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // The home screen of the app is the to-do list
      home: TodoList(),
    );
  }
}
