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
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "タイトル",
                    ),
                    controller: vm.newQuestionTitleController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "質問内容",
                    ),
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
                      print(newValue.name);
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
            onPressed: () => Navigator.of(context).pop(0),
          ),
          FlatButton(
            child: Text('投稿する'),
            onPressed: () {
              print(vm.newQuestionTitleController.text);
              print(vm.newQuestionBodyController.text);
              Navigator.of(context).pop(1);
            },
          ),
        ],
      ),
    );
  }
}
