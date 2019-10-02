import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/presentation/state/actions/LiceuActions.dart';
import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:app/presentation/util/text.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel {
  final Data<User> user;
  final Data<List<Post>> posts;
  final Function() onCreateButtonPressed;
  final Function() onEditProfileButtonPressed;
  final Function() onLogoutPressed;
  final Function() refresh;
  final Function(String postId) onDeletePostPressed;
  final Function(String postId, String type, String text) onSharePostPressed;
  final Function() onInstagramPressed;
  final Function() onLiceuInstagramPressed;

  ProfileViewModel({
    this.user,
    this.onCreateButtonPressed,
    this.onEditProfileButtonPressed,
    this.onLogoutPressed,
    this.onDeletePostPressed,
    this.onSharePostPressed,
    this.onInstagramPressed,
    this.onLiceuInstagramPressed,
    this.posts,
    this.refresh,
  });

  factory ProfileViewModel.create(Store<AppState> store) {
    final userState = store.state.userState;
    return ProfileViewModel(
      user: userState.user,
      posts: userState.posts,
      onCreateButtonPressed: () => store.dispatch(NavigateCreatePostAction()),
      refresh: () {
        store.dispatch(FetchUserInfoAction());
        store.dispatch(FetchUserPostsAction());
      },
      onEditProfileButtonPressed: () {
        store.dispatch(NavigateUserEditProfileAction());
      },
      onLogoutPressed: () {
        store.dispatch(LogOutAction());
      },
      onDeletePostPressed: (String postId) {
        store.dispatch(DeletePostAction(postId));
      },
      onSharePostPressed: (String postId, String type, String text) {
        store.dispatch(PostShareAction(postId, type));
        Share.share(summarize(text, 300) +
            "\n\nConfira mais no nosso app!\nhttps://bit.ly/BaixarLiceu");
      },
      onInstagramPressed: () {
        final instagramProfile = userState.user.content.instagramProfile;
        store.dispatch(InstagramClickedAction(instagramProfile));
        launch("https://www.instagram.com/" + instagramProfile);
      },
      onLiceuInstagramPressed: () {
        store.dispatch(LiceuInstagramPageClickedAction());
        launch("https://www.instagram.com/liceu.co");
      },
    );
  }
}
