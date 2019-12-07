import 'package:bbs_flutter/category.dart';

class Question {
  final int id;
  final String title;
  final String body;
  final DateTime createdAt;
  final Category category;

  Question({this.id, this.title, this.body, this.createdAt, this.category});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json["id"],
      title: json["title"],
      body: json["body"],
      createdAt: DateTime.parse(json["createdAt"]),
      category: Category.fromJson(json["category"]),
    );
  }

  Map<String, dynamic> toJson() =>
      {'title': title, 'body': body, 'categoryId': category.id};
}
