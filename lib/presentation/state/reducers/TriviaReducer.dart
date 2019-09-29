import 'package:app/domain/aggregates/Trivia.dart';
import 'package:app/presentation/state/actions/TriviaActions.dart';
import 'package:redux/redux.dart';

class TriviaState {
  final bool isCreatingTrivia;
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final TriviaDomain domain;
  final String domainNullError;

  TriviaState(
      {this.question = "",
      this.correctAnswer = "",
      this.wrongAnswer = "",
      this.domain,
      this.isCreatingTrivia: false,
      this.domainNullError: " "});

  factory TriviaState.initial() => TriviaState();

  TriviaState copyWith(
      {String question,
      String correctAnswer,
      String wrongAnswer,
      TriviaDomain domain,
      bool isCreatingTrivia,
      String domainNullError}) {
    final state = TriviaState(
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      wrongAnswer: wrongAnswer ?? this.wrongAnswer,
      domain: domain ?? this.domain,
      isCreatingTrivia: isCreatingTrivia ?? this.isCreatingTrivia,
      domainNullError: domainNullError ?? this.domainNullError
    );
    return state;
  }
}

final Reducer<TriviaState> triviaReducer = combineReducers<TriviaState>([
  TypedReducer<TriviaState, SubmitTriviaAction>(createTrivia),
  TypedReducer<TriviaState, SubmitTriviaSuccessAction>(triviaCreated),
  TypedReducer<TriviaState, SetCreateTriviaDomainFieldAction>(setDomainField),
  TypedReducer<TriviaState, SetCreateTriviaQuestionFieldAction>(
      setQuestionField),
  TypedReducer<TriviaState, SetCreateTriviaCorrectAnswerFieldAction>(
      setCorrectAnswerField),
  TypedReducer<TriviaState, SetCreateTriviaWrongAnswerFieldAction>(
      setWrongAnswerField),
  TypedReducer<TriviaState, NavigateCreateTriviaAction>(navigateTrivia),
  TypedReducer<TriviaState, SubmitTriviaErrorTagNullAction>(onCreateTriviaErrorTagNull)
]);

TriviaState createTrivia(TriviaState state, SubmitTriviaAction action) {
  return state.copyWith(
      isCreatingTrivia: true,
      question: "",
      correctAnswer: "",
      wrongAnswer: "",
      domain: null);
}

TriviaState triviaCreated(TriviaState state, SubmitTriviaSuccessAction action) {
  return state.copyWith(isCreatingTrivia: false,
  domain: null);
}

TriviaState setDomainField(
    TriviaState state, SetCreateTriviaDomainFieldAction action) {
  return state.copyWith(
    domain: action.domain,
    domainNullError: " ");
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

TriviaState onCreateTriviaErrorTagNull(TriviaState state, SubmitTriviaErrorTagNullAction actions) {
  return state.copyWith(
    isCreatingTrivia: false,
    domainNullError: "Você precisa escolher uma tag!"
  );
}
