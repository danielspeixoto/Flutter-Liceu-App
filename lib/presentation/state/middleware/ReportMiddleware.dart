import 'package:app/domain/boundary/ReportBoundary.dart';
import 'package:app/presentation/state/actions/ReportActions.dart';
import 'package:app/presentation/state/actions/UtilActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> reportMiddleware(
    ISubmitReportUseCase submitReportUseCase) {
  void submitEnemQuestionWrongAnswerReport(Store<AppState> store,
      SubmitReportEnemQuestionWrongAnswerAction action, NextDispatcher next) async {
    next(action);
    try {
      await submitReportUseCase.run(action.message, action.tags, action.params);
      store.dispatch(SubmitReportEnemQuestionWrongAnswerSuccessAction());
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      store.dispatch(
          OnCatchDefaultErrorAction(error.toString(), stackTrace, actionName));
    }
  }

  return [
    TypedMiddleware<AppState, SubmitReportEnemQuestionWrongAnswerAction>(
        submitEnemQuestionWrongAnswerReport)
  ];
}
