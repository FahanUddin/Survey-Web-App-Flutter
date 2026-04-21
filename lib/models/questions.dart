//Question class
class Question {
  String questionId;
  String questionTitle;
  List<Map<String, int>> options = [];
  int vote = 0;

  Question(
      {required this.questionId,
      required this.questionTitle,
      required this.options,
      required this.vote});

  factory Question.fromMap(map) {
    return Question(
        questionId: map['questionId'],
        questionTitle: map['questionTitle'],
        options: map['options'],
        vote: map['vote']);
  }

  Map<String, dynamic> toMap() {
    return {
      'questionId': questionId,
      'questionTitle': questionTitle,
      'options': options,
      'vote': vote,
    };
  }
}
