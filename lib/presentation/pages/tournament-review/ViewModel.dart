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
    final enemState = store.state.enemState;
    return TournamentReviewViewModel(
      questions: enemState.tournamentQuestions,
      score: enemState.score,
      timeSpent: enemState.timeSpent,
    );
  }
}
