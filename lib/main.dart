import 'package:bbs_flutter/ui/pages/question_list/question_list_page.dart';
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
