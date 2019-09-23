class Trivia {
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final TriviaDomain domain;

  Trivia(this.question, this.correctAnswer, this.wrongAnswer, this.domain);
}

enum TriviaDomain {
  MATHEMATICS, LANGUAGES, NATURAL_SCIENCES, HUMAN_SCIENCES
}