import 'package:app/domain/aggregates/Post.dart';
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
  final Function(String postId, PostType type, String text) onSharePostPressed;
  final Function(User user) onUserPressed;
  final Function(String imageURL) onImageZoomPressed;
  final Function(PostData post) onSeeMorePressed;
  

  ExploreViewModel({
    this.user,
    this.onDeletePostPressed,
    this.onSharePostPressed,
    this.posts,
    this.refresh,
    this.onUserPressed,
    this.onSeeMorePressed,
    this.onImageZoomPressed
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
      onSharePostPressed: (postId, type, text) {
        store.dispatch(PostShareAction(postId, type));
        Share.share(summarize(text, 300) +
            "\n\nVeja o post que ${store.state.userState.user.content.name} compartilhou com você!\nhttp://liceu.co?postId=$postId");
      },
      onUserPressed: (user) {
        store.dispatch(UserClickedAction(user));
      },
      onSeeMorePressed: (post) {
        store.dispatch(NavigatePostAction(post));
      },
      onImageZoomPressed: (imageURL) {
        store.dispatch(NavigatePostImageZoomAction(imageURL));
      }
    );
  }
}
