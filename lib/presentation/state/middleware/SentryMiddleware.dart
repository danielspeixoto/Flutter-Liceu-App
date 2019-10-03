import 'package:app/presentation/state/actions/SentryActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/util/sentry.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

final sentry = Sentry();

List<Middleware<AppState>> sentryMiddleware() {
  void setUserContext(
      Store<AppState> store, SetUserAction action, NextDispatcher next) async {
    await sentry.setUserContext(action.user.id, action.user.name);
  }

  void reportError(Store<AppState> store, ReportSentryErrorAction action,
      NextDispatcher next) async {
    await sentry.reportError(action.error, action, action.stackTrace);
  }

  void reportInfo(Store<AppState> store, ReportSentryInfoAction action,
      NextDispatcher next) async {
    await sentry.reportInfo(action);
  }

  return [
    TypedMiddleware<AppState, SetUserAction>(setUserContext),
    TypedMiddleware<AppState, ReportSentryErrorAction>(reportError),
    TypedMiddleware<AppState, ReportSentryInfoAction>(reportInfo),
  ];
}
