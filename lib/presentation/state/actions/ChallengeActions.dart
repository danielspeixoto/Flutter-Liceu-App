import 'package:app/presentation/state/aggregates/ChallengeData.dart';


//Navigates
class NavigateChallengeAction {
  NavigateChallengeAction();
}

class StartChallengeAction {
  final ChallengeData challenge;

  StartChallengeAction(this.challenge);
}

class AnswerChallengeAction {
  final String challengeId;

  AnswerChallengeAction(this.challengeId);
}



class ChallengeSomeoneAction {
  final String challengedId;

  ChallengeSomeoneAction(this.challengedId);
}

class AnswerTriviaAction {
  final String answer;

  AnswerTriviaAction(this.answer);
}

class ChallengeFinishedAction {}

class TriviaTimerDecrementAction {}

class NextTriviaAction {}
