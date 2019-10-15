import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/injection.dart';
import 'package:app/presentation/state/actions/LiceuActions.dart';
import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/ReportActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:app/presentation/state/reducers/Data.dart';
import 'package:app/presentation/util/text.dart';
import 'package:redux/redux.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel {
  final Data<User> user;
  final Data<List<Post>> posts;
  final String reportFeedback;
  final Function() onCreateButtonPressed;
  final Function() onEditProfileButtonPressed;
  final Function() onLogoutPressed;
  final Function() refresh;
  final Function(String postId) onDeletePostPressed;
  final Function(String postId, PostType type, String text) onSharePostPressed;
  final Function() onInstagramPressed;
  final Function() onLiceuInstagramPressed;
  final Function(String page) onSendReportButtonPressed;
  final Function(String text) onFeedbackTextChanged;
  final Function onShareProfilePressed;
  final Function(Post post, User user) onSeeMorePressed;
  final Function(String imageURL) onImageZoomPressed;

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
    this.onSendReportButtonPressed,
    this.onFeedbackTextChanged,
    this.reportFeedback,
    this.onShareProfilePressed,
    this.onSeeMorePressed,
    this.onImageZoomPressed
  });

  factory ProfileViewModel.create(Store<AppState> store) {
    final userState = store.state.userState;
    return ProfileViewModel(
      user: userState.user,
      posts: userState.posts,
      reportFeedback: userState.reportFeedback,
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
      onSharePostPressed: (postId, type, text) {
        store.dispatch(PostShareAction(postId, type));
        Share.share(summarize(text, 300) +
            "\n\nVeja o post que ${store.state.userState.user.content.name} compartilhou com você!\nhttp://liceu.co?postId=$postId");
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
      onFeedbackTextChanged: (String text) {
        store.dispatch(SetUserReportFieldAction(text));
      },
      onSendReportButtonPressed: (page) async {
        final phoneModel = await Information.phoneModel;

        Map<String, dynamic> params = {
          "userId": userState.user.content.id,
          "userName": userState.user.content.name,
          "page": page,
          "phoneModel": phoneModel
        };

        List<String> tags = ["created", "feedback"];

        store.dispatch(
            SubmitReportAction(userState.reportFeedback, tags, params));
      },
      onShareProfilePressed: () {
        store.dispatch(UserProfileShareAction());
        Share.share(
            "Você já viu o que eu estou fazendo no Liceu? \nhttp://liceu.co?userId=${store.state.userState.user.content.id}");
      },
      onSeeMorePressed: (post, user) {
        final postData = new PostData(post.id, user, post.type, post.text, post.imageURL);
        store.dispatch(NavigatePostAction(postData));
      }, 
      onImageZoomPressed: (imageURL) {
        store.dispatch(NavigatePostImageZoomAction(imageURL));
      }
    );
  }
}
