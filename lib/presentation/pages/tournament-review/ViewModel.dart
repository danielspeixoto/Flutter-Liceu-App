import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:redux/redux.dart';

class TournamentReviewViewModel {
  final Data<List<ENEMQuestionData>> questions;
  final int timeSpent;
  final int score;

  TournamentReviewViewModel({
    this.timeSpent,
    this.score,
    this.questions,
  });

  factory TournamentReviewViewModel.create(Store<AppState> store) {
    int answers = 0;
    store.state.enemState.tournamentQuestions.content.forEach((question) {
      if (question.answer == question.selectedAnswer) {
        answers++;
      }
    });
    return TournamentReviewViewModel(
      questions: store.state.enemState.tournamentQuestions,
      score: answers,
      timeSpent: 80,
    );
  }
}
