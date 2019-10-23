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

class CompletePostViewModel {
  final Data<PostData> post;
  final Function(String postId) onDeletePostPressed;
  final Function(String postId, PostType type, String text) onSharePostPressed;
  final Function(User user) onUserPressed;
  final Function(String postId) refresh;
  final Function(String postId) onLikePressed;
  final Function(List<String> imageURL) onImageZoomPressed;
  final Function(String postId, String comment) onSendCommentPressed;
  final Function(String userId) onUserCommentPressed;

  CompletePostViewModel(
      {this.post,
      this.onDeletePostPressed,
      this.onSharePostPressed,
      this.onUserPressed,
      this.refresh,
      this.onImageZoomPressed,
      this.onLikePressed,
      this.onSendCommentPressed,
      this.onUserCommentPressed,});

  factory CompletePostViewModel.create(Store<AppState> store) {
    final postState = store.state.postState;

    return CompletePostViewModel(
        post: postState.post,
        onSharePostPressed: (postId, type, text) {
          store.dispatch(PostShareAction(postId, type));
          Share.share(summarize(text, 300) +
              "\n\nVeja o post que ${store.state.userState.user.content.name} compartilhou com você!\nhttp://liceu.co?postId=$postId");
        },
        refresh: (postId) {
          store.dispatch(FetchPostAction(postId));
        },
        onDeletePostPressed: (String postId) {
          store.dispatch(DeletePostAction(postId));
        },
        onUserPressed: (user) {
          store.dispatch(UserClickedAction(user));
        },
        onImageZoomPressed: (imageURL) {
          store.dispatch(NavigatePostImageZoomAction(imageURL));
        },
        onLikePressed: (postId) {
          store.dispatch(
              SubmitPostUpdateRatingAction(postState.post.content.id));
        },
        onSendCommentPressed: (postId, comment) {
          store.dispatch(SubmitPostCommentAction(postId, comment));
        },
        onUserCommentPressed: (userId) {
          store.dispatch(FetchFriendFromCommentAction(userId));
        });
  }
}
