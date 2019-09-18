class Game {
  final String id;
  final String userId;
  final List<Answer> answers;
  final int timeSpent;

  Game(this.id, this.userId, this.answers, this.timeSpent);
}

class Answer {

  final String questionId;
  final int correctAnswer;
  final int selectedAnswer;

  Answer(this.questionId, this.correctAnswer, this.selectedAnswer);
}