class Question {
  final int id;
  final String question_text;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.id,
    required this.question_text,
    required this.options,
    required this.correctAnswer,
  });
}
