import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/actions/UtilActions.dart';
import 'package:app/util/StackFilter.dart';
import 'package:app/util/sentry.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';

final sentry = Sentry();

List<Middleware<AppState>> sentryMiddleware() {
  void setUserContext(
      Store<AppState> store, SetUserAction action, NextDispatcher next) async {
    await sentry.setUserContext(action.user.id, action.user.name);
    await FlutterCrashlytics()
        .setUserInfo(action.user.id, "", action.user.name);
    next(action);
  }

  void reportError(Store<AppState> store, OnCatchDefaultErrorAction action,
      NextDispatcher next) async {
    await sentry.reportError(action.error, action.message,
        filter(action.stackTrace), action.parameters);
    await FlutterCrashlytics()
        .logException(action.error, filter(action.stackTrace));
    next(action);
  }

  void reportInfo(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
//    await sentry.reportInfo(action);
    await FlutterCrashlytics().log(action.toString().substring(11));

    next(action);
  }

  return [
    TypedMiddleware<AppState, SetUserAction>(setUserContext),
    TypedMiddleware<AppState, OnCatchDefaultErrorAction>(reportError),
    TypedMiddleware<AppState, dynamic>(reportInfo),
  ];
}
