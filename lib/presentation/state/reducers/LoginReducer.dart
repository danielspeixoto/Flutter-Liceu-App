import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

class LoginState {
  final Data<bool> isLoggedIn;

  LoginState(this.isLoggedIn);

  factory LoginState.initial() => LoginState(
    Data(),
  );

  LoginState copyWith({
    Data<bool> isLoggedIn,
  }) {
    final state = LoginState(
      isLoggedIn ?? this.isLoggedIn,
    );
    return state;
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
    isLoggedIn: state.isLoggedIn.copyWith(content: true, isLoading: false),
  );
}

LoginState loginFailed(LoginState state, NotLoggedInAction action) {
  return state.copyWith(
    isLoggedIn: state.isLoggedIn.copyWith(content: false, isLoading: false),
  );
}

LoginState login(LoginState state, IsLoggingInAction action) {
  return state.copyWith(
    isLoggedIn: Data(isLoading: true),
  );
}