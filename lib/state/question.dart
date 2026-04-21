import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surveywebapp/models/questions.dart';
import 'package:surveywebapp/services/service.dart';
/*
class QuestionState with ChangeNotifier {
  List<Question> _questionList = <Question>[];
  Question? _activeQuestion;
  String? _selectedOptionInActiveQuestion;

  void loadQuestionList() {
    _questionList = getQuestionList();
    notifyListeners();
  }

  void clearState() {
    _activeQuestion = null;
    _selectedOptionInActiveQuestion = null;
  }

  List<Question> get quesionList => _questionList;
  Question? get activeQuestion => _activeQuestion;
  String? get selectedOptionInActiveVote => _selectedOptionInActiveQuestion;

  set activeQuestion(newValue) {
    _activeQuestion = newValue;
    notifyListeners();
  }

  set selectedOptionInActiveVote(String? newValue) {
    _selectedOptionInActiveQuestion = newValue;
    notifyListeners();
  }
}
*/