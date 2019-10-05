import 'package:app/presentation/state/actions/ItemActions.dart';
import 'package:app/presentation/state/aggregates/ChallengeData.dart';

//Navigates
class NavigateChallengeAction {
  NavigateChallengeAction();
}

class FetchRandomChallengeAction {}

class FetchChallengeAction extends ItemAction {
  final String challengeId;

  FetchChallengeAction(this.challengeId);

  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{
      'challengeId': challengeId,
    };
  }
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
class AnswerTriviaAction extends ItemAction {
  final String answer;

  AnswerTriviaAction(this.answer);

  @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{
      'answer': answer,
    };
  }
}

class NextTriviaAction {}

class AcceptChallengeAction extends ItemAction {
  final String challengeId;

  AcceptChallengeAction(this.challengeId);

  @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{
      'challengeId': challengeId,
    };
  }
}

class PlayRandomChallengeAction {}

class ChallengeSomeoneAction extends ItemAction {
  final String challengedId;

  ChallengeSomeoneAction(this.challengedId);

  @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{
      'challengedId': challengedId,
    };
  }
}

class CancelChallengeAction {}

class ChallengeMeAction {}
