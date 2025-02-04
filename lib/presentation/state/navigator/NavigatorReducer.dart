import 'package:redux/redux.dart';

import 'NavigatorActions.dart';

final navigationReducer = combineReducers<List<String>>([
  TypedReducer<List<String>, NavigateReplaceAction>(_navigateReplace),
  TypedReducer<List<String>, NavigatePushAction>(_navigatePush),
  TypedReducer<List<String>, NavigatePopStackAction>(_navigatePop),
]);

List<String> _navigateReplace(
        List<String> route, NavigateReplaceAction action) {
  final list = List<String>.from(route);
  final result = [...list.sublist(0, list.length - 1), action.routeName];
  return result;
}

List<String> _navigatePush(List<String> route, NavigatePushAction action) {
  var result = List<String>.from(route);
  result.add(action.routeName);
  return result;
}

List<String> _navigatePop(List<String> route, NavigatePopStackAction action) {
  var result = List<String>.from(route);
  if (result.isNotEmpty) {
    result.removeLast();
  }
  return result;
}
