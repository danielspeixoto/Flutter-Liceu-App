import 'dart:math';

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

  ChallengeViewModel({
    this.question,
    this.answer1,
    this.answer2,
    this.author,
    this.onAnswer,
    this.isLoading,
  });

  factory ChallengeViewModel.create(Store<AppState> store) {
    final challenge = store.state.challengeState.challenge;
    final content = challenge.content;
    if (content == null) {
      return ChallengeViewModel(isLoading: challenge.isLoading);
    }
    final trivia = content.questions[store.state.challengeState.currentQuestion];
    final rand = Random().nextInt(2);
    return ChallengeViewModel(
      question: trivia.question,
      answer1: rand == 0 ? trivia.correctAnswer : trivia.wrongAnswer,
      answer2: rand == 0 ? trivia.wrongAnswer : trivia.correctAnswer,
      author: trivia.author,
      isLoading: challenge.isLoading,
      onAnswer: (String answer) => store.dispatch(AnswerTriviaAction(answer)),
    );
  }
}
