import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/util/sentry.dart';
import 'package:redux/redux.dart';
import 'package:sentry/sentry.dart';
import '../app_state.dart';

final sentry = Sentry();

List<Middleware<AppState>> sentryMiddleware() {
  
  void setUserContext(
      Store<AppState> store, SetUserAction action, NextDispatcher next) {

    sentry.client.userContext = User(
      id: action.user.id,
      username: action.user.name
    );
  }

  return [
    TypedMiddleware<AppState, SetUserAction>(setUserContext),
  ];
}
