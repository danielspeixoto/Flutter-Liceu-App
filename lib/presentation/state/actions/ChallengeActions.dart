import 'package:app/presentation/state/aggregates/ChallengeData.dart';

//Navigates
class NavigateChallengeAction {
  NavigateChallengeAction();
}

class FetchRandomChallengeAction {}

class FetchChallengeAction {
  final String challengeId;

  FetchChallengeAction(this.challengeId);
}

//Setters
class SetChallengeAction {
  final ChallengeData challenge;

  SetChallengeAction(this.challenge);
}

class SetTriviaTimerDecrementAction {}

//Submits
class SubmitChallengeAction {}

//Interactions
class AnswerTriviaAction {
  final String answer;

  AnswerTriviaAction(this.answer);
}

class NextTriviaAction {}

class AcceptChallengeAction {
  final String challengeId;

  AcceptChallengeAction(this.challengeId);
}

class PlayRandomChallengeAction {}

class ChallengeSomeoneAction {
  final String challengedId;

  ChallengeSomeoneAction(this.challengedId);
}
