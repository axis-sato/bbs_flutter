import 'package:flutter/material.dart';
import '../../../question.dart';

class QuestionRow extends StatelessWidget {
  final Question question;

  const QuestionRow({Key key, this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(question.title),
            subtitle: Text(question.createdAt.toString()),
          ),
        ],
      ),
    );
  }
}
