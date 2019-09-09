import 'package:redux/redux.dart';

class UserState {
  final bool isLoggedIn;
  final String name;
  final String picURL;
  final String bio;

  UserState(this.isLoggedIn, this.name, this.picURL, this.bio);

  factory UserState.initial() => UserState(null, "", "", "");
}

final Reducer<UserState> userReducer = combineReducers<UserState>([
  TypedReducer<UserState, UpdateLoggedStatus>(login),
  TypedReducer<UserState, SetProfileData>(setProfileData)
]);

class UpdateLoggedStatus {
  final bool isLoggedIn;

  UpdateLoggedStatus(this.isLoggedIn);
}

UserState login(UserState state, UpdateLoggedStatus action) {
  return UserState(
    action.isLoggedIn,
    state.name,
    state.picURL,
    state.bio,
  );
}

class SetProfileData {
  final String name;
  final String picURL;
  final String bio;

  SetProfileData(this.name, this.picURL, this.bio);
}

UserState setProfileData(UserState state, SetProfileData action) {
  return UserState(
    state.isLoggedIn,
    action.name,
    action.picURL,
    action.bio,
  );
}
