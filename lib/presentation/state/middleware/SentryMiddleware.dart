import 'package:redux/redux.dart';
import '../app_state.dart';
import '../../../util/sentry/sentry.dart';

class SentryMiddleware extends MiddlewareClass<AppState> {
  final logging = Sentry();

  SentryMiddleware();

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {

    logging.log(action);

    next(action);
  }
}