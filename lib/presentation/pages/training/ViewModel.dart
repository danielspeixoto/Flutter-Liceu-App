import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:redux/redux.dart';

class TrainingViewModel {
  final Function() refresh;
  final Data<List<ENEMQuestionData>> questions;
  final Function(String questionId, int answer) onAnswer;

  TrainingViewModel({
    this.refresh,
    this.questions,
    this.onAnswer,
  });

  factory TrainingViewModel.create(Store<AppState> store) {
    return TrainingViewModel(
      refresh: () {
        store.dispatch(FilterTrainingQuestions(store.state.enemState.domain));
      },
      questions: store.state.enemState.trainingQuestions,
      onAnswer: (String questionId, int answer) =>
          store.dispatch(AnswerTrainingQuestionAction(questionId, answer)),
    );
  }
}
