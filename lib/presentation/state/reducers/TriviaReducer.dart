import 'package:app/domain/aggregates/Trivia.dart';
import 'package:app/presentation/state/actions/TriviaActions.dart';
import 'package:redux/redux.dart';

class TriviaState {
  final bool isCreatingTrivia;
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final TriviaDomain domain;

  TriviaState(
      {this.question = "",
      this.correctAnswer = "",
      this.wrongAnswer = "",
      this.domain,
      this.isCreatingTrivia: true});

  factory TriviaState.initial() => TriviaState();

  TriviaState copyWith(
      {String question,
      String correctAnswer,
      String wrongAnswer,
      TriviaDomain domain,
      bool isCreatingTrivia}) {
    final state = TriviaState(
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      wrongAnswer: wrongAnswer ?? this.wrongAnswer,
      domain: domain ?? this.domain,
      isCreatingTrivia: isCreatingTrivia ?? this.isCreatingTrivia,
    );
    return state;
  }
}

final Reducer<TriviaState> triviaReducer = combineReducers<TriviaState>([
  TypedReducer<TriviaState, CreateTriviaAction>(createTrivia),
  TypedReducer<TriviaState, TriviaCreatedAction>(triviaCreated),
  TypedReducer<TriviaState, SetCreateTriviaQuestionFieldAction>(setQuestionField),
  TypedReducer<TriviaState, SetCreateTriviaCorrectAnswerFieldAction>(setCorrectAnswerField),
  TypedReducer<TriviaState, SetCreateTriviaWrongAnswerFieldAction>(setWrongAnswerField),
]);

TriviaState createTrivia(TriviaState state, CreateTriviaAction action) {
  return state.copyWith(isCreatingTrivia: true);
}

TriviaState triviaCreated(TriviaState state, TriviaCreatedAction action) {
  return state.copyWith(isCreatingTrivia: false);
}

TriviaState setDomain(TriviaState state, CreateTriviaAction action) {
  return state.copyWith(domain: action.domain);
}

TriviaState setQuestionField(TriviaState state, SetCreateTriviaQuestionFieldAction action) {
  return state.copyWith(question: action.question);
}

TriviaState setCorrectAnswerField(
    TriviaState state, SetCreateTriviaCorrectAnswerFieldAction action) {
  return state.copyWith(correctAnswer: action.correctAnswer);
}

TriviaState setWrongAnswerField(TriviaState state, SetCreateTriviaWrongAnswerFieldAction action) {
  return state.copyWith(wrongAnswer: action.wrongAnswer);
}
