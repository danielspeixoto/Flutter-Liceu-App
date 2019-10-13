
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
  final Function() refresh;
  final Function(String imageURL) onImageZoomPressed;

  CompletePostViewModel({
    this.post,
    this.onDeletePostPressed,
    this.onSharePostPressed,
    this.onUserPressed,
    this.refresh,
    this.onImageZoomPressed
  });

    factory CompletePostViewModel.create(Store<AppState> store) {
    final postState = store.state.postState;

    return CompletePostViewModel(
      post: postState.post,
     
      onSharePostPressed: (postId, type, text) {
        store.dispatch(PostShareAction(postId, type));
        Share.share(summarize(text, 300) +
            "\n\nConfira mais no nosso app!\nhttps://bit.ly/BaixarLiceu");
      },
      onDeletePostPressed: (String postId) {
        store.dispatch(DeletePostAction(postId));
      },
      onUserPressed: (user) {
        store.dispatch(UserClickedAction(user));
      },
      onImageZoomPressed: (imageURL) {
        store.dispatch(NavigatePostImageZoomAction(imageURL));
      }
    );
  }
}