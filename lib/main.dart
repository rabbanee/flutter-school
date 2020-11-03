import 'package:flutter/material.dart';
import 'package:school/views/view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Student',
      home: Students(),
    );
  }
}
