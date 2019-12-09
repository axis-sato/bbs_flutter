import 'package:bbs_flutter/category.dart';
import 'package:bbs_flutter/core/infrastracture/api/api.dart';
import 'package:flutter/material.dart';
import '../../../question.dart';

class QuestionListViewModel extends ChangeNotifier {
  final title = "Flutter 掲示板";
  final newQuestionTitleController = TextEditingController();
  final newQuestionBodyController = TextEditingController();

  Api api;
  List<Question> questions = [];
  List<Category> categories = [];
  Category category;
  int totalCount;
  LoadingState loadingState = LoadingState.normal;
  String questionTitleErrorMessage;
  String questionBodyErrorMessage;

  void initState() async {
    _setLoadingState(LoadingState.loading);
    final questionsWithTotalCount = await api.fetchQuestions(limit: 10);
    questions = questionsWithTotalCount.questions;
    totalCount = questionsWithTotalCount.totalCount;

    categories = await api.fetchCategories();
    clearDialogState();

    _setLoadingState(LoadingState.normal);

    notifyListeners();
  }

  void clearDialogState() {
    newQuestionTitleController.clear();
    newQuestionBodyController.clear();
    category = categories.first;
    questionTitleErrorMessage = null;
    questionBodyErrorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    newQuestionTitleController.dispose();
    newQuestionBodyController.dispose();
  }

  void fetchQuestions() async {
    _setLoadingState(LoadingState.loading);

    final oldQuestions = questions;
    final lastQuestion = oldQuestions.last;
    final questionsWithTotalCount =
        await api.fetchQuestions(limit: 10, sinceId: lastQuestion.id);
    final newQuestions = [
      ...oldQuestions,
      ...questionsWithTotalCount.questions
    ];
    questions = newQuestions;
    totalCount = questionsWithTotalCount.totalCount;

    _setLoadingState(LoadingState.normal);

    notifyListeners();
  }

  void selectCategory(Category newCategory) {
    category = newCategory;
    notifyListeners();
  }

  Question question(int i) {
    return questions[i];
  }

  Question makeQuestion() {
    return Question(
      title: newQuestionTitleController.text,
      body: newQuestionBodyController.text,
      category: category,
    );
  }

  Future<Question> createQuestion(Question question) async {
    return api.postQuestion(question).then((newQuestion) {
      questions = [newQuestion, ...questions];
      totalCount += 1;
      notifyListeners();
      return question;
    });
  }

  void _setLoadingState(LoadingState state) {
    loadingState = state;
    notifyListeners();
  }

  void validateQuestionTitle(String title) {
    questionTitleErrorMessage =
        _validateQuestionTitle(title) ? null : "タイトルは1文字以上50文字以下です。";
    notifyListeners();
  }

  void validateQuestionBody(String body) {
    questionBodyErrorMessage =
        _validateQuestionBody(body) ? null : "本文は1文字以上1000文字以下です。";
    notifyListeners();
  }

  bool _validateQuestionTitle(String title) {
    return title.length >= 1 && title.length <= 50;
  }

  bool _validateQuestionBody(String body) {
    return body.length >= 1 && body.length <= 1000;
  }

  bool validateQuestion() {
    validateQuestionTitle(newQuestionTitleController.text);
    validateQuestionBody(newQuestionBodyController.text);

    return _validateQuestionTitle(newQuestionTitleController.text) &&
        _validateQuestionBody(newQuestionBodyController.text);
  }
}

enum LoadingState { loading, normal }
