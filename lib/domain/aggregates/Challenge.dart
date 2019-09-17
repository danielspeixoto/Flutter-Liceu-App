class Challenge {
  final String id;
  final String challenger;
  final String challenged;
  final int scoreChallenger;
  final int scoreChallenged;
  final List<Trivia> questions;

  Challenge(this.id, this.challenger, this.challenged, this.scoreChallenger,
      this.scoreChallenged, this.questions);
}

class Trivia {
  final String authorId;
  final String question;
  final String correctAnswer;
  final String wrongAnswer;

  Trivia(
    this.authorId,
    this.question,
    this.correctAnswer,
    this.wrongAnswer,
  );
}
