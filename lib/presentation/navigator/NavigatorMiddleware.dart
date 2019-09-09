import 'package:redux/redux.dart';

import '../../State.dart';
import '../../main.dart';
import 'package:app/presentation/navigator/NavigatorActions.dart';

List<Middleware<AppState>> navigationMiddleware() {
  return [
    TypedMiddleware<AppState, NavigateReplaceAction>(_navigateReplace),
    TypedMiddleware<AppState, NavigatePushAction>(_navigatePush),
    TypedMiddleware<AppState, NavigatePopAction>(_navigatePop),
  ];
}

_navigateReplace(Store<AppState> store, action, NextDispatcher next) {
  final routeName = (action as NavigateReplaceAction).routeName;
  if (store.state.route.last != routeName) {
    navigatorKey.currentState.pushReplacementNamed(routeName);
  }
  next(action); //This need to be after name checks
}

_navigatePush(Store<AppState> store, action, NextDispatcher next) {
  final routeName = (action as NavigatePushAction).routeName;
  if (store.state.route.last != routeName) {
    navigatorKey.currentState.pushNamed(routeName);
  }
  next(action); //This need to be after name checks
}

_navigatePop(Store<AppState> store, action, NextDispatcher next) {
  navigatorKey.currentState.pop();
  next(action); //This need to be after name checks
}