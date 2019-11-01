import 'dart:io';

import 'package:app/injection.dart';
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
  final Function(String questionId, int correctAnswer, String page, String width, String height)
      onReportButtonPressed;
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
        onReportButtonPressed:
            (String questionId, int correctAnswer, String page, String width, String height) async {
          final String version = await Information.appVersion;
          final String phoneModel = await Information.phoneModel;
          final String brand = await Information.brand;
          final String release = await Information.osRelease;
          String os;

          if (Platform.isAndroid) {
            os = "Android";
          } else if (Platform.isIOS) {
            os = "iOS";
          }
          Map<String, dynamic> params = {
            "questionId": questionId,
            "correctAnswer": correctAnswer,
            "page": page,
            "appVersion": version,
            "platform": os,
            "brand": brand,
            "model": phoneModel,
            "osRelease": release,
            "screenSize": width + " x " + height
          };

          List<String> tags = [
            "generated",
            "enem",
            "question",
            "incorrect",
            "answer"
          ];
          store.dispatch(SubmitReportAction(
              store.state.enemState.trainingReportText, tags, params));
        });
  }
}
