import 'package:app/presentation/state/aggregates/ChallengeData.dart';

//Navigates
class NavigateChallengeAction {
  NavigateChallengeAction();
}

class NavigateChallengeSomeoneAction {
  final String challengedId;

  NavigateChallengeSomeoneAction(this.challengedId);
}

//Setters
class SetChallengeAction {
  final ChallengeData challenge;

  SetChallengeAction(this.challenge);
}

class SetTriviaTimerDecrementAction {}

class SetAnswerTriviaAction {
  final String answer;

  SetAnswerTriviaAction(this.answer);
}

class SetNextTriviaAction {}

//Submits
class SubmitChallengeAction {}
