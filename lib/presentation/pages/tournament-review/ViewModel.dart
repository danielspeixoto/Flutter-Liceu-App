import 'package:app/presentation/state/actions/ReportActions.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:redux/redux.dart';

class TournamentReviewViewModel {
  final Data<List<ENEMQuestionData>> questions;
  final int timeSpent;
  final int score;
  final Function(String questionId, int correctAnswer) onReportButtonPressed;

  TournamentReviewViewModel({
    this.timeSpent,
    this.score,
    this.questions,
    this.onReportButtonPressed
  });

  factory TournamentReviewViewModel.create(Store<AppState> store) {
    final enemState = store.state.enemState;
    return TournamentReviewViewModel(
      questions: enemState.tournamentQuestions,
      score: enemState.score,
      timeSpent: enemState.timeSpent,
      onReportButtonPressed: (String questionId, int correctAnswer) {

          Map<String, dynamic> params = {
            "questionId": questionId,
            "correctAnswer: ": correctAnswer
          };

          List<String> tags = ["generated", "enem", "question", "incorrect", "answer"];
          store.dispatch(
              SubmitReportAction("O gabarito da questão não está correto.", tags, params));
        }
    );
  }
}
