import 'package:app/presentation/state/actions/UtilActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/util/sentry.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

final sentry = Sentry();

List<Middleware<AppState>> sentryMiddleware() {
  void setUserContext(
      Store<AppState> store, SetUserAction action, NextDispatcher next) async {
    await sentry.setUserContext(action.user.id, action.user.name);
    next(action);
  }

  void reportError(Store<AppState> store, OnCatchDefaultErrorAction action,
      NextDispatcher next) async {
    await sentry.reportError(action.error, action.message, action.stackTrace, action.parameters);
    next(action);
  }

  void reportInfo(Store<AppState> store, dynamic action,
      NextDispatcher next) async {
    //await sentry.reportInfo(action);
    next(action);
  }

  return [
    TypedMiddleware<AppState, SetUserAction>(setUserContext),
    TypedMiddleware<AppState, OnCatchDefaultErrorAction>(reportError),
    TypedMiddleware<AppState, dynamic>(reportInfo),
  ];
}
