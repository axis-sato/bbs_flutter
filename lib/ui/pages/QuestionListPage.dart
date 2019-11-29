import 'package:bbs_flutter/core/infrastracture/api/api.dart';
import 'package:bbs_flutter/ui/pages/QiestionPage.dart';
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
//  var _questions = List<Question>.generate(
//      10,
//      (i) => Question(
//          id: i,
//          title: "title$i",
//          body: "body$i",
//          createdAt: DateTime.now(),
//          category: Category(id: i, name: "category$i")));

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

  void _fetchQuestions() async {
    final oldQuestions = await _questions;
    final lastQuestion = oldQuestions.last;
    final questions =
        await api.fetchQuestions(limit: 10, sinceId: lastQuestion.id);
    final newQuestions = [...oldQuestions, ...questions];
    setState(() {
      _questions = Future.value(newQuestions);
    });
  }

  Future<List<Question>> _questions;
  final api = Api();
  @override
  void initState() {
    super.initState();
    _questions = api.fetchQuestions(limit: 10);
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
            FutureBuilder<List<Question>>(
              future: _questions,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("エラー");
                }

                return Expanded(
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        if (index == snapshot.data.length) {
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

                        final question = snapshot.data[index];
                        return InkWell(
                          child: _QuestionRow(
                            question: question,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuestionPage(
                                  question: question,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      itemCount: snapshot.data.length + 1),
                );
              },
            )
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
