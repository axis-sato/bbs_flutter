import 'package:flutter/material.dart';
import '../../../question.dart';

class QuestionPage extends StatelessWidget {
  QuestionPage({Key key, @required this.question}) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("質問"),
      ),
      body: Column(
        children: <Widget>[
          Text(question.title),
          Text(question.body),
          Text(question.category.name),
        ],
      ),
    );
  }
}
