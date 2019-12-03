import 'Question.dart';

class QuestionsWithTotalCount {
  final List<Question> questions;
  final int totalCount;

  QuestionsWithTotalCount({this.questions, this.totalCount});

  factory QuestionsWithTotalCount.fromJson(Map<String, dynamic> json) {
    final questions = json["questions"] as List<dynamic>;
    return QuestionsWithTotalCount(
      questions:
          questions.map((itemMap) => Question.fromJson(itemMap)).toList(),
      totalCount: json["totalCount"],
    );
  }
}
