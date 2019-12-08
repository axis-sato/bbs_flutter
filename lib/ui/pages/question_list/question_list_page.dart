import 'package:bbs_flutter/core/infrastracture/api/api.dart';
import 'package:bbs_flutter/ui/pages/question/question_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../question.dart';
import 'create_question_dialog.dart';
import 'question_list_vm.dart';
import 'question_row.dart';

class QuestionListPage extends StatelessWidget {
  void _addQuestion({BuildContext context, QuestionListViewModel vm}) async {
    final newQuestion = await showDialog<Question>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ChangeNotifierProvider.value(
          value: vm,
          child: CreateQuestionDialog(),
        );
      },
    );

    vm.clearDialogState();

    if (newQuestion != null) {
      vm.createQuestion(newQuestion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<Api, QuestionListViewModel>(
      create: (_) => QuestionListViewModel(),
      update: (_, api, vm) => vm
        ..api = api
        ..initState(),
      child: Consumer<QuestionListViewModel>(
        builder: (context, vm, child) => Scaffold(
          appBar: AppBar(
            title: Text(vm.title),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${vm.totalCount}件'),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        final questionsCount = vm.questions.length;
                        if (index == questionsCount) {
                          if (vm.loadingState == LoadingState.loading) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return Visibility(
                            visible: vm.totalCount != questionsCount,
                            child: FlatButton(
                              child: Text("もっと見る"),
                              onPressed: () {
                                print("もっと見る");
                                vm.fetchQuestions();
                              },
                            ),
                          );
                        }
                        final question = vm.question(index);
                        return InkWell(
                          child: QuestionRow(
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
                      itemCount: vm.questions.length + 1),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {_addQuestion(context: context, vm: vm)},
            tooltip: '質問追加',
            child: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
