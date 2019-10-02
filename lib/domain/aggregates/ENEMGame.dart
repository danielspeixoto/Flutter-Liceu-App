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

  static int score(List<ENEMAnswer> answers) {
    var score = 0;
    answers.forEach((answer) {
      if (answer.correctAnswer == answer.selectedAnswer) {
        score++;
      }
    });
    return score;
  }
}
