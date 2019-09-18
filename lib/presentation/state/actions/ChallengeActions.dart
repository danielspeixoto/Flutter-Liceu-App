import 'package:app/presentation/state/aggregates/ChallengeData.dart';

class StartChallengeAction {
  final ChallengeData challenge;

  StartChallengeAction(this.challenge);
}

class AnswerChallengeAction {
  final String challengeId;

  AnswerChallengeAction(this.challengeId);
}

class GetChallengeAction {
  GetChallengeAction();
}

class AnswerTriviaAction {
  final String answer;

  AnswerTriviaAction(this.answer);
}

class ChallengeFinishedAction {

}