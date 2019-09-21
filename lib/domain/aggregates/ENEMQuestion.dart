class ENEMQuestion {
  final String id;
  final int correctAnswer;
  final String imageURL;
  final int width;
  final int height;

  ENEMQuestion(this.id, this.correctAnswer, this.imageURL, this.width, this.height);
}

enum QuestionDomain {
  MATHEMATICS, LANGUAGES, NATURAL_SCIENCES, HUMAN_SCIENCES
}