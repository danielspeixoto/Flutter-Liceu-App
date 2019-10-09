import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:app/presentation/util/text.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class FriendViewModel {
  final Data<User> user;
  final Data<List<Post>> posts;
  final Function() refresh;
  final Function(String postId) onDeletePostPressed;
  final Function(String postId, PostType type, String text) onSharePostPressed;
  final Function(String userId) onChallengeMePressed;
  final Function() onInstagramPressed;
  final Function(Post post, User user) onSeeMorePressed;

  FriendViewModel({
    this.user,
    this.onDeletePostPressed,
    this.onSharePostPressed,
    this.posts,
    this.refresh,
    this.onChallengeMePressed,
    this.onInstagramPressed,
    this.onSeeMorePressed
  });

  factory FriendViewModel.create(Store<AppState> store) {
    final friendState = store.state.friendState;
    return FriendViewModel(
      user: friendState.user,
      posts: friendState.posts,
      refresh: () {
        store.dispatch(FetchUserInfoAction());
        store.dispatch(FetchUserPostsAction());
      },
      onDeletePostPressed: (String postId) {
        store.dispatch(DeletePostAction(postId));
      },
      onSharePostPressed: (postId, type, text) {
        store.dispatch(PostShareAction(postId, type));
        Share.share(summarize(text, 300) +
            "\n\nConfira mais no nosso app!\nhttps://bit.ly/BaixarLiceu");
      },
      onChallengeMePressed: (String userId) {
        store.dispatch(ChallengeSomeoneAction(userId));
      },
      onInstagramPressed: () {
        final instagramProfile = friendState.user.content.instagramProfile;
        store.dispatch(InstagramClickedAction(instagramProfile));
        launch("https://www.instagram.com/" + instagramProfile);
      },
      onSeeMorePressed: (post, user) {
        final postData = new PostData(post.id, user, post.type, post.text, post.imageURL);
        store.dispatch(NavigatePostAction(postData));
      }
    );
  }
}
