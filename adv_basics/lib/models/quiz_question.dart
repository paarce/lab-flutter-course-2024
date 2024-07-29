class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  List<String> get suffleAnswers {
    final shuffle = List.of(answers);
    shuffle.shuffle();
    return shuffle;
  }
}