import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/actions/ReportActions.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:redux/redux.dart';

class TournamentViewModel {
  final Data<List<ENEMQuestionData>> questions;
  final Function(String questionId, int answer) onAnswer;
  final Function() submit;
  final Function(String questionId, int correctAnswer) onReportButtonPressed;

  TournamentViewModel({
    this.questions,
    this.onAnswer,
    this.submit,
    this.onReportButtonPressed
  });

  factory TournamentViewModel.create(Store<AppState> store) {
    return TournamentViewModel(
        questions: store.state.enemState.tournamentQuestions,
        onAnswer: (String questionId, int answer) =>
            store.dispatch(AnswerTournamentQuestionAction(questionId, answer)),
        submit: () => store.dispatch(EndTournamentGameAction()),
        onReportButtonPressed: (String questionId, int correctAnswer) {

          Map<String, dynamic> params = {
            "questionId": questionId,
            "correctAnswer: ": correctAnswer
          };

          List<String> tags = ["generated", "enem", "question", "incorrect", "answer"];
          store.dispatch(
              SubmitReportAction("O gabarito da questão não está correto.", tags, params));
        });
  }
}
