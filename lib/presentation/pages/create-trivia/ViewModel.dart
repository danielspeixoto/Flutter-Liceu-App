import 'package:app/domain/aggregates/Trivia.dart';
import 'package:app/domain/aggregates/Trivia.dart' as prefix0;
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
  final String domain;
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
      this.domain = "Escolha uma tag",
      this.isCreatingTrivia});

  factory CreateTriviaViewModel.create(Store<AppState> store) {
    final triviaState = store.state.triviaState;
    final triviaDomain = triviaState.domain;
    String domain;

    if(triviaDomain == TriviaDomain.MATHEMATICS){
      domain = "Matemática";
    }
    else if(triviaDomain == TriviaDomain.NATURAL_SCIENCES){
      domain = "Naturais";
    }
    else if(triviaDomain == TriviaDomain.LANGUAGES){
      domain = "Linguagens";
    }
    else{
      domain = "Humanas";
    }
    
    return CreateTriviaViewModel(
        isCreatingTrivia: triviaState.isCreatingTrivia,
        domain: domain,
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
