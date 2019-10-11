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
  final Function(String questionId, int correctAnswer, int selectedAnswer) onReportButtonPressed;
  final String reportFeedback;
  final Function(String text) onFeedbackTextChanged;

  TrainingViewModel(
      {this.refresh,
      this.questions,
      this.onAnswer,
      this.onReportButtonPressed,
      this.reportFeedback,
      this.onFeedbackTextChanged});

  factory TrainingViewModel.create(Store<AppState> store) {
    return TrainingViewModel(
        refresh: () {
          store.dispatch(NavigateTrainingQuestionsFilterAction(
              store.state.enemState.domain));
        },
        questions: store.state.enemState.trainingQuestions,
        reportFeedback: store.state.enemState.trainingReportText,
        onAnswer: (String questionId, int answer) =>
            store.dispatch(AnswerTrainingQuestionAction(questionId, answer)),
        onFeedbackTextChanged: (text) {
          store.dispatch(SetTrainingReportFieldAction(text));
        },
        onReportButtonPressed: (String questionId, int correctAnswer, int selectedAnswer) {

          Map<String, dynamic> params = {
            "questionId": questionId,
            "correctAnswer": correctAnswer
          };

          List<String> tags = ["generated", "enem", "question", "incorrect", "answer"];
          store.dispatch(
              SubmitReportAction(store.state.enemState.trainingReportText, tags, params));
        });
  }
}
