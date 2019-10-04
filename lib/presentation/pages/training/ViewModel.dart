import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/actions/ReportActions.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:redux/redux.dart';

class TrainingViewModel {
  final Function() refresh;
  final Data<List<ENEMQuestionData>> questions;
  final Function(String questionId, int answer) onAnswer;
  final Function(String questionId, int selectedAnswer,
      int correctAnswer) onReportButtonPressed;

  TrainingViewModel(
      {this.refresh,
      this.questions,
      this.onAnswer,
      this.onReportButtonPressed});

  factory TrainingViewModel.create(Store<AppState> store) {
    return TrainingViewModel(
        refresh: () {
          store.dispatch(NavigateTrainingQuestionsFilterAction(
              store.state.enemState.domain));
        },
        questions: store.state.enemState.trainingQuestions,
        onAnswer: (String questionId, int answer) =>
            store.dispatch(AnswerTrainingQuestionAction(questionId, answer)),
        onReportButtonPressed: (String questionId,
            int selectedAnswer, int correctAnswer) {

          Map<String, dynamic> params = {
            "questionId": questionId,
            "selectedAnswer": selectedAnswer,
            "correctAnswer: ": correctAnswer
          };

          List<String> tags = ["enem", "question", "incorrect", "answer"];
          store.dispatch(
              SubmitReportEnemQuestionWrongAnswerAction("O gabarito da questão não está correto.", tags, params));
        });
  }
}
