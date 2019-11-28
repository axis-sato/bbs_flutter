import 'package:bbs_flutter/ui/pages/QuestionListPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 掲示板',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuestionListPage(title: 'Flutter 掲示板'),
    );
  }
}
