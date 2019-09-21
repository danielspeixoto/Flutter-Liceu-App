import 'dart:math';
import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:redux/redux.dart';

class TrainingViewModel {
  final Function() refresh;
  final Data<List<ENEMQuestionData>> questions;
  TrainingViewModel({
    this.refresh,
    this.questions,
  });

  factory TrainingViewModel.create(Store<AppState> store) {
    return TrainingViewModel(
      refresh: () {},
      questions: store.state.enemState.trainingQuestions,
    );
  }
}
