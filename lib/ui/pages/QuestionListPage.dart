import 'package:bbs_flutter/core/infrastracture/api/api.dart';
import 'package:bbs_flutter/ui/pages/QuestionPage.dart';
import 'package:flutter/material.dart';

import '../../Question.dart';

class QuestionListPage extends StatefulWidget {
  QuestionListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuestionListPage createState() => _QuestionListPage();
}

class _QuestionListPage extends State<QuestionListPage> {
  final api = Api();
  bool _isShownMoreButton = true;
  Future<List<Question>> _questions;
  Future<int> _totalCount;

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
    final questionsWithTotalCount =
        await api.fetchQuestions(limit: 10, sinceId: lastQuestion.id);
    final newQuestions = [
      ...oldQuestions,
      ...questionsWithTotalCount.questions
    ];
    setState(() {
      _questions = Future.value(newQuestions);
      _totalCount = Future.value(questionsWithTotalCount.totalCount);
    });
  }

  @override
  void initState() {
    super.initState();
    final questionsWithTotalCount = api.fetchQuestions(limit: 10);
    _questions = questionsWithTotalCount.then((qt) => qt.questions);
    _totalCount = questionsWithTotalCount.then((qt) => qt.totalCount);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<int>(
              future: _totalCount,
              builder: (context, snapshot) {
                return Visibility(
                  visible: snapshot.hasData,
                  child: Text("${snapshot.data}件"),
                );
              },
            ),
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
                        final questionsCount = snapshot.data.length;
                        if (index == questionsCount) {
                          return FutureBuilder<int>(
                            future: _totalCount,
                            builder: (context, snapshot) {
                              return Visibility(
                                visible: snapshot.data != questionsCount,
                                child: FlatButton(
                                  child: Text("もっと見る"),
                                  onPressed: () {
                                    print("もっと見る");
                                    _fetchQuestions();
                                  },
                                ),
                              );
                            },
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
