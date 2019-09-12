import 'package:app/domain/aggregates/Post.dart';
import 'package:app/presentation/navigator/NavigatorActions.dart';
import 'package:app/presentation/reducers/user/Presenter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:redux/redux.dart';
import '../../../State.dart';
import '../../../main.dart';

class HomeViewModel {
  final String userName;
  final String userPic;
  final String userBio;
  final Function() onCreateButtonPressed;
  final List<Post> posts;
  final Function() refresh;

  HomeViewModel(
      {this.userName,
      this.userPic,
      this.userBio,
      this.onCreateButtonPressed,
      this.posts,
      this.refresh});

  factory HomeViewModel.create(Store<AppState> store) {
    final userState = store.state.userState;
    return HomeViewModel(
      userName: userState.name,
      userPic: userState.picURL,
      userBio: userState.bio,
      onCreateButtonPressed: () =>
          store.dispatch(NavigatePushAction(AppRoutes.createPost)),
      posts: userState.posts,
      refresh: () {
        store.dispatch(FetchMyInfoAction());
        store.dispatch(FetchMyPostsAction());
      },
    );
  }
}
