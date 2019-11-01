import 'dart:io';

import 'package:app/injection.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/actions/ReportActions.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:redux/redux.dart';

class TournamentReviewViewModel {
  final Data<List<ENEMQuestionData>> questions;
  final int timeSpent;
  final int score;
  final Function(String questionId, int correctAnswer, String page, String width, String height)
      onReportButtonPressed;
  final String reportFeedback;
  final Function(String text) onFeedbackTextChanged;

  TournamentReviewViewModel(
      {this.timeSpent,
      this.score,
      this.questions,
      this.onReportButtonPressed,
      this.reportFeedback,
      this.onFeedbackTextChanged});

  factory TournamentReviewViewModel.create(Store<AppState> store) {
    final enemState = store.state.enemState;
    return TournamentReviewViewModel(
        questions: enemState.tournamentQuestions,
        score: enemState.score,
        timeSpent: enemState.timeSpent,
        reportFeedback: store.state.enemState.tournamentReportText,
        onFeedbackTextChanged: (text) {
          store.dispatch(SetTournamentReportFieldAction(text));
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
            "created",
            "enem",
            "question",
            "incorrect",
            "answer"
          ];
          store.dispatch(SubmitReportAction(
              store.state.enemState.tournamentReportText, tags, params));
        });
  }
}
