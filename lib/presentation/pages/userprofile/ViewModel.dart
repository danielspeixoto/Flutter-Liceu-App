import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:app/presentation/util/text.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';

import '../../app.dart';

class UserProfileViewModel {
  final Data<User> user;
  final Data<List<Post>> posts;
  final Function() refresh;
  final Function(String postId) onDeletePostPressed;
  final Function(String postId, String type, String text) onSharePostPressed;
  final Function(String userId) onChallengeMePressed;

  UserProfileViewModel({
    this.user,
    this.onDeletePostPressed,
    this.onSharePostPressed,
    this.posts,
    this.refresh,
    this.onChallengeMePressed,
  });

  factory UserProfileViewModel.create(Store<AppState> store) {
    final userState = store.state.friendState;
    return UserProfileViewModel(
        user: userState.user,
        posts: userState.posts,
        refresh: () {
          store.dispatch(FetchMyInfoAction());
          store.dispatch(FetchMyPostsAction());
        },
        onDeletePostPressed: (String postId) {
          store.dispatch(DeletePostAction(postId));
        },
        onSharePostPressed: (String postId, String type, String text) {
          analytics.logShare(contentType: type, itemId: postId, method: "copy");
          Share.share(summarize(text, 300) +
              "\n\nConfira mais no nosso app!\nhttps://bit.ly/BaixarLiceu");
        },
        onChallengeMePressed: (String userId) =>
            store.dispatch(ChallengeSomeoneAction(userId)));
  }
}
