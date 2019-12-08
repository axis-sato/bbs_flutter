import 'package:bbs_flutter/question.dart';
import 'package:bbs_flutter/ui/pages/question_list/question_list_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../category.dart';

class CreateQuestionDialog extends StatelessWidget {
  CreateQuestionDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionListViewModel>(
      builder: (context, vm, child) => AlertDialog(
        title: Text('質問作成'),
        content: SizedBox(
          width: 1300,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "タイトル",
                      counterText: "50文字まで",
                      errorText: vm.questionTitleErrorMessage,
                      errorMaxLines: 2,
                    ),
                    onChanged: (text) {
                      vm.validateQuestionTitle(text);
                    },
                    controller: vm.newQuestionTitleController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "質問内容",
                      counterText: "1000文字まで",
                      errorText: vm.questionBodyErrorMessage,
                      errorMaxLines: 2,
                    ),
                    onChanged: (text) {
                      vm.validateQuestionBody(text);
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 5,
                    controller: vm.newQuestionBodyController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<Category>(
                    decoration: InputDecoration(
                      labelText: "カテゴリ",
                    ),
                    value: vm.category,
                    items: vm.categories
                        .map<DropdownMenuItem<Category>>((Category category) {
                      return DropdownMenuItem<Category>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                    onChanged: (Category newValue) {
                      vm.selectCategory(newValue);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('キャンセル'),
            onPressed: () => Navigator.of(context).pop(null),
          ),
          FlatButton(
            child: Text('投稿する'),
            onPressed: () {
              if (!vm.validateQuestion()) {
                return;
              }
              final question = vm.makeQuestion();
              Navigator.of(context).pop(question);
            },
          ),
        ],
      ),
    );
  }
}
