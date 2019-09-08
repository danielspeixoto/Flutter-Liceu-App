import 'package:app/presentation/login/Reducer.dart';
import 'package:app/presentation/reducers/UserReducer.dart';

class AppState {
  final UserState userState;
  final LoginPageState loginScreenState;

  AppState(this.userState, this.loginScreenState);

  factory AppState.initial() =>
      AppState(UserState.initial(), LoginPageState.initial());
}

AppState appReducer(AppState state, action) =>
    AppState(userReducer(state.userState, action), loginPageReducer(state.loginScreenState, action));
