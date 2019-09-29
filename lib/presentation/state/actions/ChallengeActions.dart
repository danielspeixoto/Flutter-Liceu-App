import 'package:app/presentation/state/aggregates/ChallengeData.dart';

//Navigates
class NavigateChallengeAction {
  NavigateChallengeAction();
}

class NavigateChallengeSomeoneAction {
  final String challengedId;

  NavigateChallengeSomeoneAction(this.challengedId);
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
