import 'package:app/presentation/navigator/NavigatorReducer.dart';
import 'package:app/presentation/reducers/user/Reducer.dart';

class AppState {
  final UserState userState;
  final List<String> route;

  AppState(this.userState, this.route);

  factory AppState.initial() =>
      AppState(UserState.initial(), ["/"]);
}

AppState appReducer(AppState state, action) =>
    AppState(
        userReducer(state.userState, action),
        navigationReducer(state.route, action)
    );
