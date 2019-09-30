import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class ChallengeViewModel {
  final Function(String) onAnswer;
  final String question;
  final String answer1;
  final String answer2;
  final User author;
  final bool isLoading;
  final int timeLeft;
  final bool showAnswer;
  final int correctAnswer;
  final User challenger;
  final User challenged;

  ChallengeViewModel(
      {this.question,
      this.answer1,
      this.answer2,
      this.author,
      this.onAnswer,
      this.isLoading,
      this.timeLeft,
      this.showAnswer,
      this.correctAnswer,
      this.challenger,
      this.challenged});

  factory ChallengeViewModel.create(Store<AppState> store) {
    final challenge = store.state.challengeState.challenge;
    final content = challenge.content;
    if (content == null) {
      return ChallengeViewModel(isLoading: challenge.isLoading);
    }
    final trivia =
        content.questions[store.state.challengeState.currentQuestion];
    return ChallengeViewModel(
        question: trivia.question,
        answer1: store.state.challengeState.randomNum == 0
            ? trivia.correctAnswer
            : trivia.wrongAnswer,
        answer2: store.state.challengeState.randomNum == 0
            ? trivia.wrongAnswer
            : trivia.correctAnswer,
        author: trivia.author,
        isLoading: challenge.isLoading,
        onAnswer: (String answer) {
          if (store.state.challengeState.canAnswer) {
            store.dispatch(AnswerTriviaAction(answer));
          }
        },
        timeLeft: store.state.challengeState.timeLeft,
        showAnswer: !store.state.challengeState.canAnswer,
        correctAnswer: store.state.challengeState.randomNum,
        challenger: content.challenger,
        challenged: content.challenged);
  }
}
