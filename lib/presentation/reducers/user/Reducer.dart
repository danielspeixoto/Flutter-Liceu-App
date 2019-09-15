import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:redux/redux.dart';

import '../../constants.dart';
import '../Data.dart';

class UserState {
  final Data<bool> isLoggedIn;
  final Data<User> user;
  final Data<List<Post>> posts;

  UserState(this.isLoggedIn, this.user, this.posts);

  factory UserState.initial() => UserState(
        Data(),
        Data(),
        Data(),
      );

  UserState copyWith({
    Data<bool> isLoggedIn,
    Data<User> user,
    Data<List<Post>> posts,
  }) {
    final state = UserState(
      isLoggedIn ?? this.isLoggedIn,
      user ?? this.user,
      posts ?? this.posts,
    );
    return state;
  }
}

final Reducer<UserState> userReducer = combineReducers<UserState>([
//  Login
  TypedReducer<UserState, LoginSuccessAction>(loginSuccess),
  TypedReducer<UserState, LoginFailedAction>(loginFailed),
  TypedReducer<UserState, IsLoggingInAction>(login),
//  Personal Data
  TypedReducer<UserState, SetUserAction>(setProfileData),
  TypedReducer<UserState, FetchingUserAction>(fetchingUser),
  TypedReducer<UserState, FetchingUserErrorAction>(fetchingUserError),
//  Posts
  TypedReducer<UserState, SetUserPostsAction>(setUserPosts),
  TypedReducer<UserState, FetchingMyPostsAction>(fetchingMyPosts),
  TypedReducer<UserState, FetchingMyPostsErrorAction>(fetchingMyPostsError),
]);

class LoginSuccessAction {
  LoginSuccessAction();
}

UserState loginSuccess(UserState state, LoginSuccessAction action) {
  return state.copyWith(
    isLoggedIn: state.isLoggedIn.copyWith(content: true, isLoading: false),
  );
}

class LoginFailedAction {
  LoginFailedAction();
}

UserState loginFailed(UserState state, LoginFailedAction action) {
  return state.copyWith(
    isLoggedIn: state.isLoggedIn.copyWith(content: false, isLoading: false),
  );
}

class IsLoggingInAction {
  IsLoggingInAction();
}

UserState login(UserState state, IsLoggingInAction action) {
  return state.copyWith(
    isLoggedIn: Data(isLoading: true),
  );
}

class SetUserAction {
  final User user;

  SetUserAction(this.user);
}

UserState setProfileData(UserState state, SetUserAction action) {
  return state.copyWith(user: Data(content: action.user, isLoading: false));
}

class FetchingUserAction {}

UserState fetchingUser(UserState state, FetchingUserAction action) {
  final s = state.copyWith(user: Data(isLoading: true));
  return s;
}

class FetchingUserErrorAction {
  final String error;

  FetchingUserErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

UserState fetchingUserError(UserState state, FetchingUserErrorAction action) {
  final s =
      state.copyWith(user: Data(errorMessage: action.error, isLoading: false));
  return s;
}

class SetUserPostsAction {
  final List<Post> posts;

  SetUserPostsAction(this.posts);
}

UserState setUserPosts(UserState state, SetUserPostsAction action) {
  return state.copyWith(posts: Data(content: action.posts, isLoading: false));
}

class FetchingMyPostsAction {}

UserState fetchingMyPosts(UserState state, FetchingMyPostsAction action) {
  return state.copyWith(
    posts: state.posts.copyWith(isLoading: true),
  );
}

class FetchingMyPostsErrorAction {
  final String error;

  FetchingMyPostsErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

UserState fetchingMyPostsError(
    UserState state, FetchingMyPostsErrorAction action) {
  final s =
      state.copyWith(posts: Data(errorMessage: action.error, isLoading: false));
  return s;
}
