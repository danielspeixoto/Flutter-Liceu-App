class Trivia {
  final String question;
  final String correctAnswer;
  final String wrongAnswer;

  Trivia(this.question, this.correctAnswer, this.wrongAnswer);
}

enum TriviaDomain {
  MATHEMATICS, LANGUAGES, NATURAL_SCIENCES, HUMAN_SCIENCES
}