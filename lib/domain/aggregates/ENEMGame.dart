class ENEMGame {
  final String id;
  final String userId;
  final List<ENEMAnswer> answers;
  final int timeSpent;

  ENEMGame(this.id, this.userId, this.answers, this.timeSpent);
}

class ENEMAnswer {

  final String questionId;
  final int correctAnswer;
  final int selectedAnswer;

  ENEMAnswer(this.questionId, this.correctAnswer, this.selectedAnswer);
}