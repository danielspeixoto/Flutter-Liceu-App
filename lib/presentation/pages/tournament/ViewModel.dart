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
  

  TournamentViewModel({
    this.questions,
    this.onAnswer,
    this.submit,
  });

  factory TournamentViewModel.create(Store<AppState> store) {
    return TournamentViewModel(
        questions: store.state.enemState.tournamentQuestions,
        onAnswer: (String questionId, int answer) =>
            store.dispatch(AnswerTournamentQuestionAction(questionId, answer)),
        submit: () => store.dispatch(EndTournamentGameAction()));
        
  }
}
