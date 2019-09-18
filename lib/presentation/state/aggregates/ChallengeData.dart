import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/aggregates/User.dart';

class ChallengeData {
  final String id;
  final User challenger;
  final User challenged;
  final int scoreChallenger;
  final int scoreChallenged;
  final List<Trivia> questions;

  ChallengeData(
    this.id,
    this.challenger,
    this.challenged,
    this.scoreChallenged,
    this.scoreChallenger,
    this.questions,
  );
}