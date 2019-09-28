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
      this.isCreatingTrivia: false});

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
  TypedReducer<TriviaState, SetCreateTriviaDomainFieldAction>(setDomainField),
  TypedReducer<TriviaState, SetCreateTriviaQuestionFieldAction>(
      setQuestionField),
  TypedReducer<TriviaState, SetCreateTriviaCorrectAnswerFieldAction>(
      setCorrectAnswerField),
  TypedReducer<TriviaState, SetCreateTriviaWrongAnswerFieldAction>(
      setWrongAnswerField),
  TypedReducer<TriviaState, NavigateCreateTriviaAction>(navigateTrivia)
]);

TriviaState createTrivia(TriviaState state, CreateTriviaAction action) {
  return state.copyWith(
      isCreatingTrivia: true,
      question: "",
      correctAnswer: "",
      wrongAnswer: "",
      domain: null);
}

TriviaState triviaCreated(TriviaState state, TriviaCreatedAction action) {
  return state.copyWith(isCreatingTrivia: false);
}

TriviaState setDomainField(
    TriviaState state, SetCreateTriviaDomainFieldAction action) {
  return state.copyWith(domain: action.domain);
}

TriviaState setQuestionField(
    TriviaState state, SetCreateTriviaQuestionFieldAction action) {
  return state.copyWith(question: action.question);
}

TriviaState setCorrectAnswerField(
    TriviaState state, SetCreateTriviaCorrectAnswerFieldAction action) {
  return state.copyWith(correctAnswer: action.correctAnswer);
}

TriviaState setWrongAnswerField(
    TriviaState state, SetCreateTriviaWrongAnswerFieldAction action) {
  return state.copyWith(wrongAnswer: action.wrongAnswer);
}

TriviaState navigateTrivia(
    TriviaState state, NavigateCreateTriviaAction action) {
  return state.copyWith(
      isCreatingTrivia: false,
      question: "",
      correctAnswer: "",
      wrongAnswer: "",
      domain: null);
}
