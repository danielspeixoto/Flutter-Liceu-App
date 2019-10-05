import 'package:app/domain/aggregates/Trivia.dart';

import 'package:app/presentation/state/actions/TriviaActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class CreateTriviaViewModel {
  final Function() onCreateTriviaButtonPressed;
  final Function(String text) onQuestionTextChanged;
  final Function(String text) onCorrectAnswerTextChanged;
  final Function(String text) onWrongAnswerTextChanged;
  final Function(String value) onTriviaDomainChanged;
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final String domain;
  final bool isCreatingTrivia;
  final String createTriviaDomainNullErrorMessage;
  final String createTriviaQuestionErrorMessage;
  final String createTriviaCorrectAnswerErrorMessage;
  final String createTriviaWrongAnswerErrorMessage;

  CreateTriviaViewModel(
      {this.onCreateTriviaButtonPressed,
      this.onQuestionTextChanged,
      this.onCorrectAnswerTextChanged,
      this.onWrongAnswerTextChanged,
      this.onTriviaDomainChanged,
      this.question,
      this.correctAnswer,
      this.wrongAnswer,
      this.domain,
      this.isCreatingTrivia,
      this.createTriviaDomainNullErrorMessage,
      this.createTriviaQuestionErrorMessage,
      this.createTriviaCorrectAnswerErrorMessage,
      this.createTriviaWrongAnswerErrorMessage});

  factory CreateTriviaViewModel.create(Store<AppState> store) {
    final triviaState = store.state.triviaState;
    final triviaDomain = triviaState.domain;
    String domain;

    if (triviaDomain == TriviaDomain.MATHEMATICS) {
      domain = "Matemática";
    } else if (triviaDomain == TriviaDomain.NATURAL_SCIENCES) {
      domain = "Naturais";
    } else if (triviaDomain == TriviaDomain.LANGUAGES) {
      domain = "Linguagens";
    } else if (triviaDomain == TriviaDomain.HUMAN_SCIENCES) {
      domain = "Humanas";
    } else {
      domain = "Selecione";
    }


    return CreateTriviaViewModel(
        isCreatingTrivia: triviaState.isCreatingTrivia,
        domain: domain,
        question: triviaState.question,
        correctAnswer: triviaState.correctAnswer,
        wrongAnswer: triviaState.wrongAnswer,
        createTriviaDomainNullErrorMessage: triviaState.domainNullErrorMessage,
        createTriviaQuestionErrorMessage:
            triviaState.createTriviaQuestionErrorMessage,
        createTriviaCorrectAnswerErrorMessage:
            triviaState.createTriviaCorrectAnswerErrorMessage,
        createTriviaWrongAnswerErrorMessage:
            triviaState.createTriviaWrongAnswerErrorMessage,
        onTriviaDomainChanged: (value) {
          TriviaDomain domain;
          if (value == 'Matemática') {
            domain = TriviaDomain.MATHEMATICS;
          } else if (value == 'Naturais') {
            domain = TriviaDomain.NATURAL_SCIENCES;
          } else if (value == 'Linguagens') {
            domain = TriviaDomain.LANGUAGES;
          } else if (value == 'Humanas') {
            domain = TriviaDomain.HUMAN_SCIENCES;
          } else {
            domain = null;
          }
          store.dispatch(SetCreateTriviaDomainFieldAction(domain));
        },
        onQuestionTextChanged: (text) {
          store.dispatch(SetCreateTriviaQuestionFieldAction(text));
        },
        onCorrectAnswerTextChanged: (text) {
          store.dispatch(SetCreateTriviaCorrectAnswerFieldAction(text));
        },
        onWrongAnswerTextChanged: (text) {
          store.dispatch(SetCreateTriviaWrongAnswerFieldAction(text));
        },
        onCreateTriviaButtonPressed: () async {
          store.dispatch(SubmitTriviaAction(
              triviaState.question,
              triviaState.correctAnswer,
              triviaState.wrongAnswer,
              triviaState.domain));
        });
  }
}
