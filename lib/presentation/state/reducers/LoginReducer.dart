import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

class LoginState {
  final Data<bool> loginStatus;

  LoginState(this.loginStatus);

  factory LoginState.initial() => LoginState(
        Data(),
      );

  LoginState copyWith({
    Data<bool> isLoggedIn,
  }) {
    final state = LoginState(
      isLoggedIn ?? this.loginStatus,
    );
    return state;
  }

  bool isUserLoggedIn() {
    return loginStatus.content != null && loginStatus.content;
  }
}

final Reducer<LoginState> loginReducer = combineReducers<LoginState>([
//  Login
  TypedReducer<LoginState, LoginSuccessAction>(loginSuccess),
  TypedReducer<LoginState, NotLoggedInAction>(loginFailed),
  TypedReducer<LoginState, IsLoggingInAction>(login),
]);

LoginState loginSuccess(LoginState state, LoginSuccessAction action) {
  return state.copyWith(
    isLoggedIn: state.loginStatus.copyWith(content: true, isLoading: false),
  );
}

LoginState loginFailed(LoginState state, NotLoggedInAction action) {
  return state.copyWith(
    isLoggedIn: state.loginStatus.copyWith(content: false, isLoading: false),
  );
}

LoginState login(LoginState state, IsLoggingInAction action) {
  return state.copyWith(
    isLoggedIn: Data(isLoading: true),
  );
}
