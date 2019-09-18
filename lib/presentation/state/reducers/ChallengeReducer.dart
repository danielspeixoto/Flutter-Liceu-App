import 'dart:math';

import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/aggregates/ChallengeData.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

class ChallengeState {
  final Data<ChallengeData> challenge;
  final List<String> answers;
  final int currentQuestion;

  ChallengeState(this.challenge, this.answers, this.currentQuestion);

  factory ChallengeState.initial() => ChallengeState(Data(), [], 0);

  ChallengeState copyWith({
    Data<ChallengeData> challenge,
    List<String> answers,
    int currentQuestion,
  }) {
    final state = ChallengeState(
      challenge ?? this.challenge,
      answers ?? this.answers,
      currentQuestion ?? this.currentQuestion,
    );
    return state;
  }
}

final Reducer<ChallengeState> challengeReducer =
    combineReducers<ChallengeState>([
  TypedReducer<ChallengeState, StartChallengeAction>(startChallenge),
  TypedReducer<ChallengeState, GetChallengeAction>(resetChallenge),
  TypedReducer<ChallengeState, AnswerTriviaAction>(answerTrivia),
]);

ChallengeState startChallenge(
    ChallengeState state, StartChallengeAction action) {
  return ChallengeState.initial().copyWith(challenge: Data(content: action.challenge, isLoading: false));
}

ChallengeState resetChallenge(ChallengeState state, GetChallengeAction action) {
  return state.copyWith(challenge: Data(isLoading: true));
}

ChallengeState answerTrivia(ChallengeState state, AnswerTriviaAction action) {
  return state.copyWith(
    answers: [...state.answers, action.answer],
    currentQuestion: min(state.challenge.content.questions.length - 1,
        state.currentQuestion + 1),
  );
}
