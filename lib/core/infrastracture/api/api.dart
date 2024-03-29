import 'dart:convert';

import 'package:bbs_flutter/category.dart';
import 'package:bbs_flutter/question.dart';
import 'package:bbs_flutter/questions_with_total_count.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _endpoint = "http://localhost:1234";

  final _client = http.Client();

  Future<QuestionsWithTotalCount> fetchQuestions(
      {@required int limit, int sinceId}) async {
    var url = '$_endpoint/questions?limit=$limit';
    if (sinceId != null) {
      url += '&since_id=$sinceId';
    }

    final response = await _client.get(url);
    return QuestionsWithTotalCount.fromJson(json.decode(response.body));
  }

  Future<List<Category>> fetchCategories() async {
    const url = '$_endpoint/categories';
    final response = await _client.get(url);
    final itemMapList = json.decode(response.body) as List<dynamic>;
    return itemMapList.map((itemMap) => Category.fromJson(itemMap)).toList();
  }

  Future<Question> postQuestion(Question question) async {
    const url = '$_endpoint/questions';
    final response = await _client.post(url,
        body: json.encode(question.toJson()),
        headers: {"Content-Type": "application/json"});

    return Question.fromJson(json.decode(response.body));
  }
}
