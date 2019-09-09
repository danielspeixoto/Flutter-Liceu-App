class Challenge {
  final String id;
  final String challenger;
  final String challenged;
  final int scoreChallenged;
  final int scoreChallenger;
  final List<Trivia> questions;

  Challenge(this.id, this.challenger, this.challenged, this.scoreChallenged,
      this.scoreChallenger, this.questions);
}

class Trivia {
  final String authorId;
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final List<String> tags;

  Trivia(this.authorId, this.question, this.correctAnswer,
      this.wrongAnswer, this.tags);
}
