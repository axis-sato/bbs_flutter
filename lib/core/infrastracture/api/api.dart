import 'dart:convert';

import 'package:bbs_flutter/Question.dart';
import 'package:bbs_flutter/QuestionsWithTotalCount.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _endpoint = "http://localhost:1234";

  final _client = http.Client();

  Future<QuestionsWithTotalCount> fetchQuestions(
      {@required int limit, int sinceId}) async {
    var url = '$_endpoint/questions?limit=$limit';
    if (sinceId != null) {
      url += "&since_id=$sinceId";
    }

    final response = await _client.get(url);
    return QuestionsWithTotalCount.fromJson(json.decode(response.body));
//    final itemMapList = json.decode(response.body) as List<dynamic>;
//    return itemMapList.map((itemMap) => Question.fromJson(itemMap)).toList();
  }
}
