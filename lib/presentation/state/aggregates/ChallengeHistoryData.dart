import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/aggregates/User.dart';

class ChallengeHistoryData {
  final String id;
  final User challenger;
  final User challenged;
  final int scoreChallenger;
  final int scoreChallenged;
  final List<Trivia> questions;

  ChallengeHistoryData(
    this.id,
    this.challenger,
    this.challenged,
    this.scoreChallenged,
    this.scoreChallenger,
    this.questions,
  );
}