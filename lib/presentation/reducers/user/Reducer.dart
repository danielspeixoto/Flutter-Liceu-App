import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:redux/redux.dart';

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
    return UserState(
      isLoggedIn ?? this.isLoggedIn,
      user ?? this.user,
      posts ?? this.posts,
    );
  }
}

final Reducer<UserState> userReducer = combineReducers<UserState>([
//  Login
  TypedReducer<UserState, LoginSuccessAction>(loginSuccess),
  TypedReducer<UserState, LoginAction>(attemptLogin),
//  Personal Data
  TypedReducer<UserState, SetUserAction>(setProfileData),
  TypedReducer<UserState, FetchingUserAction>(fetchingUser),
//  Posts
  TypedReducer<UserState, SetUserPostsAction>(setUserPosts),
  TypedReducer<UserState, FetchingMyPostsAction>(fetchingMyPosts),
]);

class LoginSuccessAction {
  LoginSuccessAction();
}

UserState loginSuccess(UserState state, LoginSuccessAction action) {
  return state.copyWith(
    isLoggedIn: state.isLoggedIn.copyWith(content: true, isLoading: false),
  );
}

class LoginAction {
  LoginAction();
}

UserState attemptLogin(UserState state, LoginAction action) {
  return state.copyWith(
    isLoggedIn: Data(isLoading: true),
  );
}

class SetUserAction {
  final User user;

  SetUserAction(this.user);
}

UserState setProfileData(UserState state, SetUserAction action) {
  return state.copyWith(user: Data(content: action.user));
}

class FetchingUserAction {}

UserState fetchingUser(UserState state, FetchingUserAction action) {
  return state.copyWith(user: state.user.copyWith(isLoading: true));
}

class SetUserPostsAction {
  final List<Post> posts;
  SetUserPostsAction(this.posts);
}

UserState setUserPosts(UserState state, SetUserPostsAction action) {
  return state.copyWith(posts: Data(content: action.posts));
}

class FetchingMyPostsAction {}

UserState fetchingMyPosts(UserState state, FetchingMyPostsAction action) {
  return state.copyWith(
    posts: state.posts.copyWith(isLoading: true),
  );
}
