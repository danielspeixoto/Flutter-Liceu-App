import 'package:redux/redux.dart';
import '../app_state.dart';
import '../../../util/sentry/sentry.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'dart:developer';

class LoggingMiddleware extends MiddlewareClass<AppState> {
  final logging = Sentry();

  LoggingMiddleware();

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    logging.log(action.name);

    next(action);
  }
}