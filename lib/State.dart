import 'package:app/presentation/navigator/NavigatorReducer.dart';
import 'package:app/presentation/pages/login/Reducer.dart';
import 'package:app/presentation/reducers/user/Reducer.dart';

class AppState {
  final UserState userState;
  final LoginPageState loginScreenState;
  final List<String> route;

  AppState(this.userState, this.loginScreenState, this.route);

  factory AppState.initial() =>
      AppState(UserState.initial(), LoginPageState.initial(), ["/"]);
}

AppState appReducer(AppState state, action) =>
    AppState(
        userReducer(state.userState, action),
        loginPageReducer(state.loginScreenState, action),
        navigationReducer(state.route, action)
    );
