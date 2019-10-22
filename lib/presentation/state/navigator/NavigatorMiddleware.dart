import 'dart:developer' as developer;
import 'package:redux/redux.dart';
import '../../app.dart';
import '../app_state.dart';
import 'NavigatorActions.dart';

List<Middleware<AppState>> navigationMiddleware() {
  return [
    TypedMiddleware<AppState, NavigateReplaceAction>(_navigateReplace),
    TypedMiddleware<AppState, NavigatePushAction>(_navigatePush),
    TypedMiddleware<AppState, NavigatePopAction>(_navigatePop),
  ];
}

_navigateReplace(Store<AppState> store, action, NextDispatcher next) {
  developer.postEvent("navigate_replace", {"route": store.state.route});
  final routeName = (action as NavigateReplaceAction).routeName;
  if (store.state.route.last != routeName) {
    navigatorKey.currentState.pushReplacementNamed(routeName);
  }
  next(action); //This need to be after name checks
}

_navigatePush(
    Store<AppState> store, NavigatePushAction action, NextDispatcher next) {
  developer.log("navigate_push " +
      action.routeName +
      " to " +
      store.state.route.toString());
  final routeName = action.routeName;
  if (store.state.route.last != routeName) {
    navigatorKey.currentState.pushNamed(routeName);
  } 
  next(action); //This need to be after name checks
}

_navigatePop(Store<AppState> store, action, NextDispatcher next) {
  developer.log("navigate_pop " + store.state.route.toString());

  if (navigatorKey.currentState.canPop()) {
    navigatorKey.currentState.pop();
//    store.dispatch(NavigatePopStackAction());
  }
  next(action); //This need to be after name checks
}
