import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/redux/actions/LoginActions.dart';
import 'package:app/presentation/redux/actions/UserActions.dart';
import 'package:app/presentation/redux/app_state.dart';
import 'package:app/presentation/redux/navigator/NavigatorActions.dart';
import 'package:app/presentation/redux/reducers/Data.dart';
import 'package:redux/redux.dart';

import '../../app.dart';

class HomeViewModel {
  final Data<User> user;
  final Data<List<Post>> posts;
  final Function() onCreateButtonPressed;
  final Function() onEditProfileButtonPressed;
  final Function() onLogoutPressed;
  final Function() refresh;
  final Function(String postId) onDeletePostPressed;

  HomeViewModel({
    this.user,
    this.onCreateButtonPressed,
    this.onEditProfileButtonPressed,
    this.onLogoutPressed,
    this.onDeletePostPressed,
    this.posts,
    this.refresh,
  });

  factory HomeViewModel.create(Store<AppState> store) {
    final userState = store.state.userState;
    return HomeViewModel(
      user: userState.user,
      posts: userState.posts,
      onCreateButtonPressed: () =>
          store.dispatch(NavigatePushAction(AppRoutes.createPost)),
      refresh: () {
        store.dispatch(FetchMyInfoAction());
        store.dispatch(FetchMyPostsAction());
      },
      onEditProfileButtonPressed: () {
        store.dispatch(NavigatePushAction(AppRoutes.editProfile));
      },
      onLogoutPressed: () {
        store.dispatch(LogOutAction());
      },
      onDeletePostPressed: (String postId) {

      },
    );
  }
}
