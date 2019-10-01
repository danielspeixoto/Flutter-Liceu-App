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
  final bool canAnswer;
  final int randomNum;

  ChallengeState(
    this.challenge,
    this.answers,
    this.currentQuestion,
    this.timeLeft,
    this.canAnswer,
    this.randomNum,
  );

  factory ChallengeState.initial() => ChallengeState(
      Data(), [], 0, TRIVIA_TIME_TO_ANSWER, false, TRIVIA_TIME_TO_ANSWER);

  ChallengeState copyWith({
    Data<ChallengeData> challenge,
    List<String> answers,
    int currentQuestion,
    int timeLeft,
    bool canAnswer,
    int randomNum,
  }) {
    final state = ChallengeState(
      challenge ?? this.challenge,
      answers ?? this.answers,
      currentQuestion ?? this.currentQuestion,
      timeLeft ?? this.timeLeft,
      canAnswer ?? this.canAnswer,
      randomNum ?? this.randomNum,
    );
    return state;
  }

  int score() {
    var score = 0;
    for (var i = 0; i < challenge.content.questions.length; i++) {
      if (challenge.content.questions[i].correctAnswer == answers[i]) {
        score++;
      }
    }
    return score;
  }
}

final Reducer<ChallengeState> challengeReducer =
    combineReducers<ChallengeState>([
  TypedReducer<ChallengeState, SetChallengeAction>(startChallenge),
  TypedReducer<ChallengeState, NextTriviaAction>(nextTrivia),
  TypedReducer<ChallengeState, NavigateChallengeAction>(resetChallenge),
  TypedReducer<ChallengeState, AnswerTriviaAction>(answerTrivia),
  TypedReducer<ChallengeState, SetTriviaTimerDecrementAction>(decrementTime),
]);

ChallengeState startChallenge(ChallengeState state, SetChallengeAction action) {
  return ChallengeState.initial().copyWith(
    challenge: Data(content: action.challenge, isLoading: false),
    timeLeft: TRIVIA_TIME_TO_ANSWER,
    currentQuestion: 0,
    answers: [],
    canAnswer: true,
    randomNum: Random().nextInt(2),
  );
}

ChallengeState resetChallenge(
    ChallengeState state, NavigateChallengeAction action) {
  return state.copyWith(challenge: Data(isLoading: true));
}

ChallengeState answerTrivia(ChallengeState state, AnswerTriviaAction action) {
  return state.copyWith(
    answers: [...state.answers, action.answer],
    canAnswer: false,
  );
}

ChallengeState decrementTime(
    ChallengeState state, SetTriviaTimerDecrementAction action) {
  return state.copyWith(timeLeft: state.timeLeft - 1);
}

ChallengeState nextTrivia(ChallengeState state, NextTriviaAction action) {
  return state.copyWith(
    canAnswer: true,
    timeLeft: TRIVIA_TIME_TO_ANSWER,
    currentQuestion: min(state.challenge.content.questions.length - 1,
        state.currentQuestion + 1),
    randomNum: Random().nextInt(2),
  );
}
