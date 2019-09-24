import 'package:app/domain/aggregates/Trivia.dart';
import 'package:app/presentation/state/actions/TriviaActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class CreateTriviaViewModel {
  final Function() onCreateTriviaButtonPressed;
  final Function(String text) onQuestionTextChanged;
  final Function(String text) onCorrectAnswerTextChanged;
  final Function(String text) onWrongAnswerTextChanged;
  final Function(TriviaDomain) onTriviaDomainChanged;
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final TriviaDomain domain;
  final bool isCreatingTrivia;

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
      this.isCreatingTrivia});

  factory CreateTriviaViewModel.create(Store<AppState> store) {
    final triviaState = store.state.triviaState;

    return CreateTriviaViewModel(
        isCreatingTrivia: triviaState.isCreatingTrivia,
        question: triviaState.question,
        correctAnswer: triviaState.correctAnswer,
        wrongAnswer: triviaState.wrongAnswer,
        onTriviaDomainChanged: (domain){
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
            store.dispatch(CreateTriviaAction(triviaState.question, 
              triviaState.correctAnswer, triviaState.wrongAnswer, triviaState.domain));
        } 
    
    );
  }
}
