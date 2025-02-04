import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/FriendActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
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
  final Function() refresh;
  final Function(String postId) onLikePressed;
  final Function(List<String> imageURL) onImageZoomPressed;
  final Function(String postId, String comment) onSendCommentPressed;
  final Function(String userId) onUserCommentPressed;
  final Function(String postId, String commentId) onDeleteCommentPressed;
  final bool isLoading;
  final Function(String postId) onSavePostPressed;
  final Function(String postId) onDeleteSavedPostPressed;
  final String userLoggedId;

  CompletePostViewModel(
      {this.post,
      this.onDeletePostPressed,
      this.onSharePostPressed,
      this.onUserPressed,
      this.refresh,
      this.onImageZoomPressed,
      this.onLikePressed,
      this.onSendCommentPressed,
      this.onUserCommentPressed,
      this.isLoading,
      this.onSavePostPressed,
      this.onDeleteSavedPostPressed,
      this.onDeleteCommentPressed,
      this.userLoggedId});

  factory CompletePostViewModel.create(Store<AppState> store) {
    final postState = store.state.postState;

    return CompletePostViewModel(
        post: store.state.postState.post,
        isLoading: store.state.postState.post.isLoading,
        userLoggedId: store.state.userState.user.content.id,
        onSharePostPressed: (postId, type, text) {
          store.dispatch(PostShareAction(postId, type));
          Share.share(summarize(text, 300) +
              "\n\nVeja o post que ${store.state.userState.user.content.name} compartilhou com você!\nhttp://liceu.co?postId=$postId");
        },
        refresh: () {
          store
              .dispatch(FetchPostAction(store.state.postState.post.content.id));
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
        },
        onSavePostPressed: (postId) {
          store.dispatch(SubmitUserSavePostAction(postId));
        },
        onDeleteSavedPostPressed: (postId) {
          store.dispatch(DeleteUserSavedPostAction(postId));
        },
        onDeleteCommentPressed: (postId, commentId) {
          store.dispatch(DeletePostCommentAction(postId, commentId));
        });
  }
}
