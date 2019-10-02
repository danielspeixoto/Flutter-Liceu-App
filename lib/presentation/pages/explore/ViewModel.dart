import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/FriendActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:app/presentation/util/text.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';

class ExploreViewModel {
  final Data<User> user;
  final Data<List<PostData>> posts;
  final Function() refresh;
  final Function(String postId) onDeletePostPressed;
  final Function(String postId, String type, String text) onSharePostPressed;
  final Function(User user) onUserPressed;

  ExploreViewModel({
    this.user,
    this.onDeletePostPressed,
    this.onSharePostPressed,
    this.posts,
    this.refresh,
    this.onUserPressed,
  });

  factory ExploreViewModel.create(Store<AppState> store) {
    final userState = store.state.userState;
    final postState = store.state.postState;
    return ExploreViewModel(
      user: userState.user,
      posts: postState.posts,
      refresh: () {
        store.dispatch(FetchPostsAction());
      },
      onDeletePostPressed: (String postId) {
        store.dispatch(DeletePostAction(postId));
      },
      onSharePostPressed: (String postId, String type, String text) {
        store.dispatch(PostShareAction(postId, type));
        Share.share(summarize(text, 300) +
            "\n\nConfira mais no nosso app!\nhttps://bit.ly/BaixarLiceu");
      },
      onUserPressed: (user) {
        store.dispatch(UserClickedAction(user));
      },
    );
  }
}
