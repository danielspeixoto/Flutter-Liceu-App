import 'dart:math';

import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/aggregates/ChallengeData.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

const TRIVIA_TIME_TO_ANSWER = 15;

class ChallengeState {
  final Data<ChallengeData> challenge;
  final List<String> answers;
  final int timeLeft;
  final int currentQuestion;
  final bool isTimerRunning;
  final int randomNum;

  ChallengeState(
    this.challenge,
    this.answers,
    this.currentQuestion,
    this.timeLeft,
    this.isTimerRunning,
    this.randomNum,
  );

  factory ChallengeState.initial() => ChallengeState(
      Data(), [], 0, TRIVIA_TIME_TO_ANSWER, false, TRIVIA_TIME_TO_ANSWER);

  ChallengeState copyWith({
    Data<ChallengeData> challenge,
    List<String> answers,
    int currentQuestion,
    int timeLeft,
    bool isTimerRunning,
    int randomNum,
  }) {
    final state = ChallengeState(
      challenge ?? this.challenge,
      answers ?? this.answers,
      currentQuestion ?? this.currentQuestion,
      timeLeft ?? this.timeLeft,
      isTimerRunning ?? this.isTimerRunning,
      randomNum ?? this.randomNum,
    );
    return state;
  }
}

final Reducer<ChallengeState> challengeReducer =
    combineReducers<ChallengeState>([
  TypedReducer<ChallengeState, SetChallengeAction>(startChallenge),
  TypedReducer<ChallengeState, SetNextTriviaAction>(nextTrivia),
  TypedReducer<ChallengeState, NavigateChallengeAction>(resetChallenge),
  TypedReducer<ChallengeState, SetAnswerTriviaAction>(answerTrivia),
  TypedReducer<ChallengeState, SetTriviaTimerDecrementAction>(decrementTime),
]);

ChallengeState startChallenge(
    ChallengeState state, SetChallengeAction action) {
  return ChallengeState.initial().copyWith(
    challenge: Data(content: action.challenge, isLoading: false),
    timeLeft: TRIVIA_TIME_TO_ANSWER,
    currentQuestion: 0,
    answers: [],
    isTimerRunning: true,
    randomNum: Random().nextInt(2),
  );
}

ChallengeState resetChallenge(ChallengeState state, NavigateChallengeAction action) {
  return state.copyWith(challenge: Data(isLoading: true));
}

ChallengeState answerTrivia(ChallengeState state, SetAnswerTriviaAction action) {
  return state.copyWith(
    answers: [...state.answers, action.answer],
    isTimerRunning: false,
  );
}

ChallengeState decrementTime(
    ChallengeState state, SetTriviaTimerDecrementAction action) {
  return state.copyWith(timeLeft: state.timeLeft - 1);
}

ChallengeState nextTrivia(ChallengeState state, SetNextTriviaAction action) {
  return state.copyWith(
    isTimerRunning: true,
    timeLeft: TRIVIA_TIME_TO_ANSWER,
    currentQuestion: min(state.challenge.content.questions.length - 1,
        state.currentQuestion + 1),
    randomNum: Random().nextInt(2),
  );
}
