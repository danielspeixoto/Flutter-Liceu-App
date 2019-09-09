class Challenge {
  final String id;
  final String challenger;
  final String challenged;
  final int scoreChallenged;
  final int scoreChallenger;
  final List<ChallengeQuestion> questions;

  Challenge(this.id, this.challenger, this.challenged, this.scoreChallenged,
      this.scoreChallenger, this.questions);
}

class ChallengeQuestion {
  final String authorId;
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final List<String> tags;

  ChallengeQuestion(this.authorId, this.question, this.correctAnswer,
      this.wrongAnswer, this.tags);
}
