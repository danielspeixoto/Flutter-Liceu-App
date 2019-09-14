import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/navigator/NavigatorActions.dart';
import 'package:app/presentation/reducers/Data.dart';
import 'package:app/presentation/reducers/user/Presenter.dart';
import 'package:redux/redux.dart';
import '../../../redux.dart';
import '../../../main.dart';

class HomeViewModel {
  final Data<User> user;
  final Data<List<Post>> posts;
  final Function() onCreateButtonPressed;
  final Function() onEditProfileButtonPressed;
  final Function() refresh;

  HomeViewModel({
    this.user,
    this.onCreateButtonPressed,
    this.onEditProfileButtonPressed,
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
      }
    );
  }
}