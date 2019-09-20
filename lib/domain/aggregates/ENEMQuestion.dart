class ENEMQuestion {
  final String id;
  final int correctAnswer;
  final String imageURL;

  ENEMQuestion(this.id, this.correctAnswer, this.imageURL);
}

enum QuestionDomain {
  MATHEMATICS, LANGUAGES, NATURAL_SCIENCES, HUMAN_SCIENCES
}