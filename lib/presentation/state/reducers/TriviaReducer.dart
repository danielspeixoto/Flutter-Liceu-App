import 'package:app/domain/aggregates/Trivia.dart';
import 'package:app/presentation/state/actions/TriviaActions.dart';
import 'package:redux/redux.dart';

class TriviaState {
  final bool isCreatingTrivia;
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final TriviaDomain domain;
  final String domainNullErrorMessage;
  final String createTriviaQuestionErrorMessage;
  final String createTriviaCorrectAnswerErrorMessage;
  final String createTriviaWrongAnswerErrorMessage;
  final String message;

  TriviaState(
      {this.question,
      this.correctAnswer,
      this.wrongAnswer,
      this.domain,
      this.isCreatingTrivia: false,
      this.domainNullErrorMessage: " ",
      this.createTriviaQuestionErrorMessage: "",
      this.createTriviaCorrectAnswerErrorMessage: "",
      this.createTriviaWrongAnswerErrorMessage: "",
      this.message: ""});

  factory TriviaState.initial() => TriviaState();

  TriviaState copyWith(
      {String question,
      String correctAnswer,
      String wrongAnswer,
      TriviaDomain domain,
      bool isCreatingTrivia,
      String domainNullErrorMessage,
      String createTriviaQuestionErrorMessage,
      String createTriviaCorrectAnswerErrorMessage,
      String createTriviaWrongAnswerErrorMessage,
      String message}) {
    final state = TriviaState(
      question: question ?? this.question,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      wrongAnswer: wrongAnswer ?? this.wrongAnswer,
      domain: domain ?? this.domain,
      isCreatingTrivia: isCreatingTrivia ?? this.isCreatingTrivia,
      domainNullErrorMessage:
          domainNullErrorMessage ?? this.domainNullErrorMessage,
      createTriviaQuestionErrorMessage: createTriviaQuestionErrorMessage ??
          this.createTriviaQuestionErrorMessage,
      createTriviaCorrectAnswerErrorMessage:
          createTriviaCorrectAnswerErrorMessage ??
              this.createTriviaCorrectAnswerErrorMessage,
      createTriviaWrongAnswerErrorMessage:
          createTriviaWrongAnswerErrorMessage ??
              this.createTriviaWrongAnswerErrorMessage,
      message: message ?? this.message
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
  TypedReducer<TriviaState, SubmitTriviaErrorTagNullAction>(
      onCreateTriviaErrorTagNull),
  TypedReducer<TriviaState, SubmitTriviaErrorQuestionSizeMismatchAction>(
      onCreateTriviaErrorQuestionSizeMismatch),
  TypedReducer<TriviaState, SubmitTriviaErrorCorrectAnswerSizeMismatchAction>(
      onCreateTriviaErrorCorrectAnswerSizeMismatch),
  TypedReducer<TriviaState, SubmitTriviaErrorWrongAnswerSizeMismatchAction>(
      onCreateTriviaErrorWrongAnswerSizeMismatch),
  TypedReducer<TriviaState, SubmitTriviaErrorAction>(
      setErrorMessage),    
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
  return state.copyWith(
      isCreatingTrivia: false,
      domain: null,
      domainNullErrorMessage: "",
      createTriviaQuestionErrorMessage: "",
      createTriviaCorrectAnswerErrorMessage: "",
      createTriviaWrongAnswerErrorMessage: "",
      message: "Questão criada com sucesso.");
}

TriviaState setErrorMessage(TriviaState state, SubmitTriviaErrorAction action) {
  return state.copyWith(
      isCreatingTrivia: false,
      message: "Algum erro ocorreu ao criar a questão.");
}

TriviaState setDomainField(
    TriviaState state, SetCreateTriviaDomainFieldAction action) {
  return state.copyWith(domain: action.domain, domainNullErrorMessage: "");
}

TriviaState setQuestionField(
    TriviaState state, SetCreateTriviaQuestionFieldAction action) {
  return state.copyWith(
      question: action.question, createTriviaQuestionErrorMessage: "");
}

TriviaState setCorrectAnswerField(
    TriviaState state, SetCreateTriviaCorrectAnswerFieldAction action) {
  return state.copyWith(
      correctAnswer: action.correctAnswer,
      createTriviaCorrectAnswerErrorMessage: "");
}

TriviaState setWrongAnswerField(
    TriviaState state, SetCreateTriviaWrongAnswerFieldAction action) {
  return state.copyWith(
      wrongAnswer: action.wrongAnswer, createTriviaWrongAnswerErrorMessage: "");
}

TriviaState navigateTrivia(
    TriviaState state, NavigateCreateTriviaAction action) {
  return state.copyWith(
      isCreatingTrivia: false,
      question: "",
      correctAnswer: "",
      wrongAnswer: "",
      domain: null,
      domainNullErrorMessage: "",
      createTriviaQuestionErrorMessage: "",
      createTriviaCorrectAnswerErrorMessage: "",
      createTriviaWrongAnswerErrorMessage: "",
      message: "");
}

TriviaState onCreateTriviaErrorTagNull(
    TriviaState state, SubmitTriviaErrorTagNullAction actions) {
  return state.copyWith(
      question: actions.question,
      correctAnswer: actions.correctAnswer,
      wrongAnswer: actions.wrongAnswer,
      isCreatingTrivia: false,
      domainNullErrorMessage: "Você precisa escolher um assunto!");
}

TriviaState onCreateTriviaErrorQuestionSizeMismatch(
    TriviaState state, SubmitTriviaErrorQuestionSizeMismatchAction actions) {
  return state.copyWith(
      isCreatingTrivia: false,
      question: actions.question,
      correctAnswer: actions.correctAnswer,
      wrongAnswer: actions.wrongAnswer,
      createTriviaQuestionErrorMessage:
          "A questão precisa conter entre 20 e 300 caracteres.");
}

TriviaState onCreateTriviaErrorCorrectAnswerSizeMismatch(TriviaState state,
    SubmitTriviaErrorCorrectAnswerSizeMismatchAction actions) {
  return state.copyWith(
      isCreatingTrivia: false,
      question: actions.question,
      correctAnswer: actions.correctAnswer,
      wrongAnswer: actions.wrongAnswer,
      createTriviaCorrectAnswerErrorMessage:
          "A Reposta Correta precisa conter entre 1 e 200 caracteres.");
}

TriviaState onCreateTriviaErrorWrongAnswerSizeMismatch(
    TriviaState state, SubmitTriviaErrorWrongAnswerSizeMismatchAction actions) {
  return state.copyWith(
      isCreatingTrivia: false,
      question: actions.question,
      correctAnswer: actions.correctAnswer,
      wrongAnswer: actions.wrongAnswer,
      createTriviaWrongAnswerErrorMessage:
          "A Reposta Errada precisa conter entre 1 e 200 caracteres.");
}
