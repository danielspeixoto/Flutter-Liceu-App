import 'package:redux/redux.dart';

class UserState {
  final bool isLoggedIn;
  UserState(this.isLoggedIn);

  factory UserState.initial() => UserState(
    false
  );
}

final Reducer<UserState> userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UpdateLoggedStatus>(login)
]);

class UpdateLoggedStatus {
  final bool isLoggedIn;
  UpdateLoggedStatus(this.isLoggedIn); 
}

UserState login(UserState state, UpdateLoggedStatus action) {
  return UserState(
    action.isLoggedIn
  );
}