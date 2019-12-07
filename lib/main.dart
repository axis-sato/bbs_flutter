import 'package:bbs_flutter/core/infrastracture/api/api.dart';
import 'package:bbs_flutter/ui/pages/question_list/question_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => Api(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter 掲示板',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: QuestionListPage(),
      ),
    );
  }
}
