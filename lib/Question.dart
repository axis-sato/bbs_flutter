import 'package:bbs_flutter/Category.dart';

class Question {
  final int id;
  final String title;
  final String body;
  final DateTime createdAt;
  final Category category;

  Question({this.id, this.title, this.body, this.createdAt, this.category});
}
