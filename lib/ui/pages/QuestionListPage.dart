import 'package:flutter/material.dart';

import '../../Category.dart';
import '../../Question.dart';

class QuestionListPage extends StatefulWidget {
  QuestionListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuestionListPage createState() => _QuestionListPage();
}

class _QuestionListPage extends State<QuestionListPage> {
  bool _isShownMoreButton = true;
  var _questions = List<Question>.generate(
      10,
      (i) => Question(
          id: i,
          title: "title$i",
          body: "body$i",
          createdAt: DateTime.now(),
          category: Category(id: i, name: "category$i")));

  void _addQuestion() {
    print("質問追加");
  }

  void _showMoreButton() {
    setState(() {
      _isShownMoreButton = true;
    });
  }

  void _hideMoreButton() {
    setState(() {
      _isShownMoreButton = false;
    });
  }

  void _fetchQuestions() {
    final q = List<Question>.generate(
      10,
      (i) {
        final id = _questions.length + i;
        return Question(
            id: id,
            title: "title$id",
            body: "body$id",
            createdAt: DateTime.now(),
            category: Category(id: id, name: "category$id"));
      },
    );
    setState(() {
      _questions.addAll(q);
    });

    if (_questions.length >= 100) {
      _hideMoreButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _questions.length) {
                      return Visibility(
                        visible: _isShownMoreButton,
                        child: FlatButton(
                          child: Text("もっと見る"),
                          onPressed: () {
                            print("もっと見る");
                            _fetchQuestions();
                          },
                        ),
                      );
                    }

                    final question = _questions[index];
                    return _QuestionRow(
                      question: question,
                    );
                  },
                  itemCount: _questions.length + 1),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addQuestion,
        tooltip: '質問追加',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _QuestionRow extends StatelessWidget {
  final Question question;

  const _QuestionRow({Key key, this.question}) : super(key: key);

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
    ));
  }
}
